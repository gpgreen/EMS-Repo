package gov.nasa.jpl.view_repo.webscripts;

import gov.nasa.jpl.mbee.util.TimeUtils;
import gov.nasa.jpl.mbee.util.Utils;
import gov.nasa.jpl.view_repo.util.CommitUtil;
import gov.nasa.jpl.view_repo.util.EmsScriptNode;
import gov.nasa.jpl.view_repo.util.WorkspaceDiff;
import gov.nasa.jpl.view_repo.util.WorkspaceNode;
import gov.nasa.jpl.view_repo.webscripts.AbstractJavaWebScript.LogLevel;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;
import javax.transaction.UserTransaction;

import org.alfresco.repo.model.Repository;
import org.alfresco.repo.security.authentication.AuthenticationUtil;
import org.alfresco.service.ServiceRegistry;
import org.alfresco.service.cmr.security.PermissionService;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.extensions.webscripts.Cache;
import org.springframework.extensions.webscripts.Status;
import org.springframework.extensions.webscripts.WebScriptRequest;

public class WorkspacesMerge extends AbstractJavaWebScript{

	public WorkspacesMerge(){
		super();
	}
	
	public WorkspacesMerge(Repository repositoryHelper, ServiceRegistry registry){
		super(repositoryHelper, registry);
	}
	
	protected Map<String, Object> executeImpl(WebScriptRequest req, Status status, Cache cache){
		printHeader(req);
		clearCaches();
		Map<String, Object> model = new HashMap<String, Object>();
		try{
			if(validateRequest(req, status)){
				String timeSource = req.getParameter("timestampSource");
				Date time = TimeUtils.dateFromTimestamp(timeSource);
				
				String targetId = req.getParameter("target");
				WorkspaceNode targetWS = AbstractJavaWebScript.getWorkspaceFromId(targetId, getServices(), getResponse(), status, false, null);
				
				String sourceId = req.getParameter("source");
				WorkspaceNode sourceWS = AbstractJavaWebScript.getWorkspaceFromId(sourceId,  getServices(), getResponse(), status, false, null);
				
				WorkspaceDiff workspaceDiff = new WorkspaceDiff(sourceWS, targetWS, time, time);
		/*		// Gotta merge here
				Map<String, EmsScriptNode> elements = workspaceDiff.getElements();
				Map<String, EmsScriptNode> addedElements = workspaceDiff.getAddedElements();
				Map<String, EmsScriptNode> updatedElements = workspaceDiff.getUpdatedElements();
				Map<String, EmsScriptNode> movedElements = workspaceDiff.getMovedElements();
				Map<String, EmsScriptNode> deletedElements = workspaceDiff.getDeletedElements();
				
				//Convert Maps into Sets of just values (EmsScriptNodes).
				
				Collection <EmsScriptNode> elementCollection = elements.values();
				Collection <EmsScriptNode> addedCollection = addedElements.values();
				Collection <EmsScriptNode> updatedCollection = updatedElements.values();
				Collection <EmsScriptNode> movedCollection = movedElements.values();

				
				// Add the collection into a collection of collections.
				Collection< Collection<EmsScriptNode> > collections = new ArrayList();
				collections.add(elementCollection);
				collections.add(addedCollection);
				collections.add(updatedCollection);
				collections.add(movedCollection);
				//Convert the collection of collections to a collection of nodes.
				
				Collection<EmsScriptNode> postingNodes = setsToCollection(collections);
				
				//Post em
				
				*/
				//For the nodes here, we delete them from the source
				Map<String, EmsScriptNode> deletedElements = workspaceDiff.getDeletedElements();
				Collection <EmsScriptNode> deletedCollection = deletedElements.values();
				
				
				// Prints out the differences after merging.
				JSONObject top = workspaceDiff.toJSONObject(null, time, false);
				
				// Retrieving the arrays for all the added elements
				ModelPost instance = new ModelPost(repository, services);
				EmsScriptNode projectNode = instance.getProjectNodeFromRequest(req, true);
				 Set< EmsScriptNode > elements =
	                        instance.createOrUpdateModel( top.getJSONObject("workspace2"), status,
	                                                      projectNode, targetWS );
	                    // REVIEW -- TODO -- shouldn't this be called from instance?
	                    instance.addRelationshipsToProperties( elements );
	                    if ( !Utils.isNullOrEmpty( elements ) ) {

	                        // Create JSON object of the elements to return:
	                        JSONArray elementsJson = new JSONArray();
	                        for ( EmsScriptNode element : elements ) {
	                            elementsJson.put( element.toJSONObject(null) );
	                        }
	                       //top.put( "elements", elementsJson );
	                        //model.put( "res", top.toString( 4 ) );
	                    }
	            JSONObject result = handleDelete(deletedCollection, targetWS, targetId, time, workspaceDiff); 
	            if (result != null) {
	                model.put( "res", result.toString(2) );
	            } else {
	            	model.put("res",  "");
	            }
			}
		 } catch (JSONException e) {
	           log(LogLevel.ERROR, "Could not create JSON\n", HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	           e.printStackTrace();
	        } catch (Exception e) {
	           log(LogLevel.ERROR, "Internal server error\n", HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	           e.printStackTrace();
	        }
	    status.setCode(responseStatus.getCode());
	    return model;
	}
	
	// Essentially the same executeImpl code from MmsModelDelete
	
	protected JSONObject handleDelete(Collection <EmsScriptNode> collection, WorkspaceNode workspace, String wsId, Date time, WorkspaceDiff workspaceDiff) {
		JSONObject result = null;
		MmsModelDelete deleteInstance = new MmsModelDelete(repository, services);
		long start = System.currentTimeMillis();
		for( EmsScriptNode node : collection){
			if(node != null && node.exists()){
				deleteInstance.delete(node, workspace);
				EmsScriptNode pkgnode = findScriptNodeById(node.getSysmlId() + "_pkg", workspace, time, false);
				deleteInstance.handleElementHierarchy(pkgnode, workspace, true);
			} else {
				log( LogLevel.ERROR, "Could not find node " + node.getSysmlId() + "in workspace" + wsId,
						HttpServletResponse.SC_NOT_FOUND);
				return result;
			}
		}
		//String siteName = node.getSiteName();
		long end = System.currentTimeMillis();
		try{
			result = workspaceDiff.toJSONObject(new Date(start),new Date(end), false);	
			for( EmsScriptNode node: collection) {
				// editting the JSON
				node.removeAspect( "ems:Added" );
				node.removeAspect( "ems:Updated" );
				node.removeAspect( "ems:Moved" );
				node.createOrUpdateAspect( "ems:Deleted" );
				}
		} catch (JSONException e) {
			log(LogLevel.ERROR, "Malformed JSON Object", HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}
		
		return result;
	}
	
	protected Collection<EmsScriptNode> setsToCollection(Collection< Collection <EmsScriptNode> > sets){
		Collection <EmsScriptNode> collection = new ArrayList<EmsScriptNode>();
		for(Collection <EmsScriptNode> set : sets){
			collection.addAll(set);
			}
		return collection;
	}
	
	@Override
	protected boolean validateRequest(WebScriptRequest req, Status status) {
		// TODO Auto-generated method stub
		String targetId = req.getParameter( "target" );
        String sourceId = req.getParameter( "source" );
        WorkspaceNode ws1 = getWorkspaceFromId( targetId, getServices(), response, status, false, null );
        WorkspaceNode ws2 = getWorkspaceFromId( sourceId, getServices(), response, status, false, null );
        boolean wsFound1 = ( ws1 != null || ( targetId != null && targetId.equalsIgnoreCase( "master" ) ) );
        boolean wsFound2 = ( ws2 != null || ( sourceId != null && sourceId.equalsIgnoreCase( "master" ) ) );

        if ( !wsFound1 ) {
            log( LogLevel.ERROR,
                 "Workspace 1 id , " + targetId + ", not found",
                 HttpServletResponse.SC_NOT_FOUND );
            return false;
        }
        if ( !wsFound2 ) {
            log( LogLevel.ERROR,
                 "Workspace 2 id, " + sourceId + ", not found",
                 HttpServletResponse.SC_NOT_FOUND );
            return false;
        }
        return true;
    }
}
