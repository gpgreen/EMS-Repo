/*******************************************************************************
 * Copyright (c) <2013>, California Institute of Technology ("Caltech").  
 * 
 * U.S. Government sponsorship acknowledged.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification, are 
 * permitted provided that the following conditions are met:
 * 
 *  - Redistributions of source code must retain the above copyright notice, this list of 
 *    conditions and the following disclaimer.
 *  - Redistributions in binary form must reproduce the above copyright notice, this list 
 *    of conditions and the following disclaimer in the documentation and/or other materials 
 *    provided with the distribution.
 *  - Neither the name of Caltech nor its operating division, the Jet Propulsion Laboratory, 
 *    nor the names of its contributors may be used to endorse or promote products derived 
 *    from this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS 
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY 
 * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER  
 * OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON 
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
 * POSSIBILITY OF SUCH DAMAGE.
 ******************************************************************************/

package gov.nasa.jpl.view_repo.webscripts;

import gov.nasa.jpl.view_repo.util.EmsScriptNode;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.alfresco.service.cmr.repository.NodeRef;
import org.alfresco.service.cmr.site.SiteInfo;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.extensions.webscripts.Cache;
import org.springframework.extensions.webscripts.Status;
import org.springframework.extensions.webscripts.WebScriptRequest;

/**
 * Descriptor file: /view-repo/src/main/amp/config/alfresco/extension/templates/webscripts/gov/nasa/jpl/javawebscripts/model.post.desc.xml
 * @author cinyoung
 * 
 * TODO Need merge? and force? similar to View?
 *
 */
public class ModelPost extends AbstractJavaWebScript {
	private EmsScriptNode projectNode = null;
	
	private final String ROOTS = "roots";
	private final String ELEMENT_HIERARCHY = "elementHierarchy";
	private final String ELEMENTS = "elements";
	private final String RELATIONSHIPS = "relationships";
	
	// NOTE: Order is necessary
	private final String[] JSON_ELEMENTS = {ELEMENTS, ROOTS, ELEMENT_HIERARCHY, RELATIONSHIPS};
	private boolean createRoots = false;
	private boolean useHierarchy=true;
	private boolean useElements=true;
	private boolean useRelationshipElements=true;
	private boolean usePropertyTypes=true;
	private boolean useElementValues=true;
	private boolean useRoots=true;
	private boolean toggleChoices = false;
	
	/**
	 * Parse the URL request variables so they're globally available
	 * @param req	URL request to parse
	 */
	private void parseRequestVariables(WebScriptRequest req) {
		createRoots = jwsUtil.checkArgEquals(req, "createRoots", "true") ? true : false;
		
		toggleChoices = jwsUtil.checkArgEquals(req, "toggleChoices", "true") ? true : false;
		if (toggleChoices) {
			useHierarchy = jwsUtil.checkArgEquals(req, "hierarchy", "true") ? true : false;
			useElements = jwsUtil.checkArgEquals(req, "elements", "true") ? true : false;
			useRelationshipElements = jwsUtil.checkArgEquals(req, "relationshipElements", "true") ? true : false;
			usePropertyTypes = jwsUtil.checkArgEquals(req, "propertyTypes", "true") ? true : false;
			useElementValues = jwsUtil.checkArgEquals(req, "elementValues", "true") ? true : false;
			useRoots = jwsUtil.checkArgEquals(req, "roots", "true") ? true : false;
		}
	}
	
	@Override
	protected void clearCaches() {
		super.clearCaches();
		response = new StringBuffer();
	}
	
	/**
	 * Create or update the model as necessary based on the request
	 * @param req			Request used to create/update the model
	 * @param status		Status to be updated
	 * @throws JSONException	Parse error
	 */
	private void createOrUpdateModel(WebScriptRequest req, Status status) throws JSONException {
		// clear out the response cache first (only one instance of each webscript)
		clearCaches();

		JSONObject postJson = (JSONObject)req.parseContent();

		// cycle through all the expected JSON element top level types, this will cycle in correct order
		for (String element: JSON_ELEMENTS) {
			if (!postJson.has(element)) {
				continue;
			}

			Object object = postJson.get(element);
			long start = System.currentTimeMillis(); System.out.println("Processing " +jwsUtil.getJSONLength(object) + "  " + element);
			if (element.equals(ELEMENTS) && useElements) {
				jwsUtil.splitTransactions(new JwsFunctor() {
					@Override
					public Object execute(JSONObject jsonObject, String key,
							Boolean... flags) throws JSONException {
						updateOrCreateElement(jsonObject, key);
						return null;
					}
					@Override
					public Object execute(JSONArray jsonArray, int index, Boolean... flags) throws JSONException {
						// do nothing, not called
						return null;
					}
				}, object);
			} else if (element.equals(ROOTS) && useRoots) {
				jwsUtil.splitTransactions(new JwsFunctor() {
					@Override
					public Object execute(JSONObject jsonObject, String key,
							Boolean... flags) throws JSONException {
						// do nothing, not called
						return null;
					}
					@Override
					public Object execute(JSONArray jsonArray, int index, Boolean... flags) throws JSONException {
						updateOrCreateRoot(jsonArray, index, flags[0]);
						return null;
					}
				}, object, createRoots);
			} else if (element.equals(ELEMENT_HIERARCHY) && useHierarchy) {
				jwsUtil.splitTransactions(new JwsFunctor() {
					@Override
					public Object execute(JSONObject jsonObject, String key,
							Boolean... flags) throws JSONException {
						updateOrCreateElementHierarchy(jsonObject, key);
						return null;
					}
					@Override
					public Object execute(JSONArray jsonArray, int index, Boolean... flags) throws JSONException {
						// do nothing, not called
						return null;
					}
				}, object);
			} else if (element.equals(RELATIONSHIPS)) {
				// TODO split this out updating the separate relationships underneath
				jwsUtil.splitTransactions(new JwsFunctor() {
					@Override
					public Object execute(JSONObject jsonObject, String key,
							Boolean... flags) throws JSONException {
						updateOrCreateRelationships(jsonObject, key);
						return null;
					}
					@Override
					public Object execute(JSONArray jsonArray, int index, Boolean... flags) throws JSONException {
						// do nothing, not called
						return null;
					}
				}, object);
			}
			long end = System.currentTimeMillis(); System.out.println(element + " processed in " + (end-start) + " ms");
		}
	}
	
	/**
	 * Update or create relationships
	 * @param jsonObject	Input data to generate relationships from
	 * @param key			The relationship type (e.g., relationshipElements, projectTypes, or elementValues)
	 * @throws JSONException
	 */
	protected void updateOrCreateRelationships(JSONObject jsonObject, String key) throws JSONException {
		JSONObject object = jsonObject.getJSONObject(key);
		Iterator<?> ids = object.keys();
		while (ids.hasNext()) {
			String id = (String)ids.next();
			if (key.equals("relationshipElements") && useRelationshipElements) {
				updateOrCreateRelationship(object.getJSONObject(id), id);
			} else if (key.equals("propertyTypes") && usePropertyTypes) {
				updateOrCreatePropertyType(object.getString(id), id);
			} else if (key.equals("elementValues") && useElementValues) {
				updateOrCreateElementValues(object.getJSONArray(id), id);
			}
		}
	}

	/**
	 * Update or create element values (multiple noderefs ordered in a list)
	 * @param jsonArray		Array of the IDs that house the values for the element
	 * @param id			The ID of the element to add the values to
	 * @throws JSONException
	 */
	private void updateOrCreateElementValues(JSONArray jsonArray, String id) throws JSONException {
		EmsScriptNode element = findScriptNodeByName(id);
		
		// create an array of the values to be added in as the elementValue property
		ArrayList<NodeRef> values = new ArrayList<NodeRef>();
		for (int ii = 0; ii < jsonArray.length(); ii++) {
			EmsScriptNode value = findScriptNodeByName(jsonArray.getString(ii));
			values.add(value.getNodeRef());
		}
		
		// only change if old list is different than new
		@SuppressWarnings("unchecked")
		ArrayList<NodeRef> oldValues = (ArrayList<NodeRef>)element.getProperty("sysml:elementValue");
		if (!EmsScriptNode.checkIfListsEquivalent(values, oldValues)) {
			element.setProperty("sysml:elementValue", values);
		}
	}

	/**
	 * Update or create the property type association between an element and its type
	 * @param typeId	ID of the type
	 * @param id		ID of the element
	 */
	private void updateOrCreatePropertyType(String typeId, String id) {
		EmsScriptNode property = findScriptNodeByName(id);
		EmsScriptNode propertyType = findScriptNodeByName(typeId);
		
		property.createOrUpdateAssociation(propertyType, "sysml:type");
	}

	/**
	 * Update or create the element relationship associations 
	 * @param jsonObject	JSONObject that defines the source and target of the directed relationship
	 * @param id			Id of the directed relationship element
	 * @throws JSONException
	 */
	private void updateOrCreateRelationship(JSONObject jsonObject, String id) throws JSONException {
		String sourceId = jsonObject.getString("source");
		String targetId = jsonObject.getString("target");

		EmsScriptNode relationship = findScriptNodeByName(id);
		EmsScriptNode source = findScriptNodeByName(sourceId);
		EmsScriptNode target = findScriptNodeByName(targetId);

		relationship.createOrUpdateAssociation(source, "sysml:source");
		relationship.createOrUpdateAssociation(target, "sysml:target");
	}

	/**
	 * Create or update the element hierarchy as specified by the JSON Object. Does reification
	 * of containment
	 * @param jsonObject	Hierarchy of containment
	 * @param key			Name of the parent element
	 * @throws JSONException
	 */
	protected void updateOrCreateElementHierarchy(JSONObject jsonObject, String key) throws JSONException {
		String REIFIED_PKG_SUFFIX = "_pkg";
		String pkgName = key + REIFIED_PKG_SUFFIX;

		JSONArray array = jsonObject.getJSONArray(key);

		// only need to create reified container if it has any elements
		if (array.length() > 0) {
			// this is the element node
			EmsScriptNode node = findScriptNodeByName(key);
			
			// create reified container if it doesn't exist
			EmsScriptNode parent = findScriptNodeByName(pkgName);  // this is the reified element package
			if (parent == null) {
				parent = node.getParent().createFolder(pkgName, "sysml:ElementFolder");
				node.setProperty("sysml:id", key);
				node.setProperty("cm:name", key);
			}
			foundElements.put(pkgName, parent);
			// make sure element and reified container in same place
			// node should be accurate if hierarchy is correct
			if (!parent.getParent().equals(node.getParent())) {
				parent.move(node.getParent());
			}
			
			// move elements to reified container if not already there
			for (int ii = 0; ii < array.length(); ii++) {
				EmsScriptNode child = findScriptNodeByName(array.getString(ii));
				if (!child.getParent().equals(parent)) {
					child.move(parent);
				}
			}
			
			node.createOrUpdateChildAssociation(parent, "sysml:reifiedContainment");
		}
	}

	/**
	 * Update or create element with specified metadata
	 * @param jsonObject	Metadata to be added to element
	 * @param key			ID of element
	 * @throws JSONException
	 */
	protected void updateOrCreateElement(JSONObject jsonObject, String key) throws JSONException {
		// TODO check permissions
		long start = System.currentTimeMillis(); System.out.println("updateOrCreateElement " + key);
		JSONObject object = jsonObject.getJSONObject(key);
		
		// find node if exists, otherwise create
		EmsScriptNode node = findScriptNodeByName(key);
		if (node == null) {
			node = projectNode.createNode(key, json2acm.get(object.getString("type")));
			node.setProperty("cm:name", key);
			node.setProperty("sysml:id", key);
			// TODO temporarily set title - until we figure out how to use sysml:name in repository browser
			node.setProperty("cm:title", object.getString("name"));
		}
		foundElements.put(key, node); // cache the found value
		
		// need to add View aspect before adding any properties (so they're valid properties of the node)
		if (object.has("isView") && object.getString("isView").equals(true)) {
			node.createOrUpdateAspect("sysml:View");
		}
		
		// create or update properties of node
		Iterator<?> props = object.keys();
		while(props.hasNext()) {
			String type = (String) props.next();
			String property = object.getString(type);
			JSONArray array;
			
			if (json2acm.containsKey(type)) {
				String acmType = json2acm.get(type);
				if (type.startsWith("is")) {
					node.createOrUpdateProperty(acmType, new Boolean(property));
				} else if (type.equals("boolean")) {
					array = object.getJSONArray(type);
					node.createOrUpdatePropertyValues(acmType, array, new Boolean(true));
				} else if (type.equals("integer")) {
					array = object.getJSONArray(type);
					node.createOrUpdatePropertyValues(acmType, array, new Integer(0));
				} else if (type.equals("double")) {
					array = object.getJSONArray(type);
					node.createOrUpdatePropertyValues(acmType, array, new Double(0.0));
				} else if (type.equals("string")) {
					array = object.getJSONArray(type);
					node.createOrUpdatePropertyValues(acmType, array, new String(""));
				} else {
					node.createOrUpdateProperty(acmType, new String(property));
				}
			} else {
				// do nothing TODO: unhandled from SysML/UML profiles are owner, type (type handled above)
			}
		}
		long end = System.currentTimeMillis(); System.out.println("\tTotal: " + (end-start));
	}
	
	protected void updateOrCreateRoot(JSONArray jsonArray, int index, Boolean createRoot) {
		// TODO complete when understand functionality
	}

	/**
	 * Entry point
	 */
	@Override
	protected Map<String, Object> executeImpl(WebScriptRequest req,
			Status status, Cache cache) {
		Map<String, Object> model = new HashMap<String, Object>();
		StringBuffer response = new StringBuffer();
		
		if (validateRequest(req, status)) {
			parseRequestVariables(req);
			try {
				createOrUpdateModel(req, status);
			} catch (JSONException e) {
				e.printStackTrace();
			}
		}

		model.put("res", response.toString());
		return model;
	}
	
	
	@Override
	protected boolean validateRequest(WebScriptRequest req, Status status) {
		if (!JwsRequestUtils.validateContent(req, status, response)) {
			return false;
		}
		
		String siteName = JwsRequestUtils.getRequestVar(req, JwsRequestUtils.SITE_NAME);
		if (!JwsRequestUtils.validateRequestVariable(status, response, siteName, JwsRequestUtils.SITE_NAME)) {
			return false;
		} 

		String projectId = JwsRequestUtils.getRequestVar(req, JwsRequestUtils.PROJECT_ID);
		if (!JwsRequestUtils.validateRequestVariable(status, response, projectId, JwsRequestUtils.PROJECT_ID)) {
			return false;
		}

		SiteInfo siteInfo = services.getSiteService().getSite(siteName);
		if (!JwsRequestUtils.validateSiteExists(siteInfo, status, response)) {
			return false;
		}
				
		if (!JwsRequestUtils.validatePermissions(req, status, response, services, siteInfo.getNodeRef(), "Write")) {
			return false;
		}

		EmsScriptNode siteNode = getSiteNode(siteName);
		projectNode = siteNode.childByNamePath("/ViewEditor/" + projectId);
		if (projectNode == null) {
			return false;
		}
		
		return true;
	}
}