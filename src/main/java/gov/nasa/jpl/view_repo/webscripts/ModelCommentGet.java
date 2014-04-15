/*******************************************************************************
 * Copyright (c) <2013>, California Institute of Technology ("Caltech").  
 * U.S. Government sponsorship acknowledged.
 * 
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

import gov.nasa.jpl.view_repo.util.Acm;
import gov.nasa.jpl.view_repo.util.EmsScriptNode;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.alfresco.repo.model.Repository;
import org.alfresco.service.ServiceRegistry;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.extensions.webscripts.Cache;
import org.springframework.extensions.webscripts.Status;
import org.springframework.extensions.webscripts.WebScriptRequest;

/**
 * Retrieve comments that annotate the specified element
 * @author cinyoung
 * 
 */
public class ModelCommentGet extends ModelGet {
    public ModelCommentGet() {
        super();
    }
    
    
    public ModelCommentGet(Repository repositoryHelper, ServiceRegistry registry) {
        super(repositoryHelper, registry);
    }

    @Override
    protected Map<String, Object> executeImpl(WebScriptRequest req, Status status, Cache cache) {
        clearCaches();

        Map<String, Object> model = new HashMap<String, Object>();

        ModelCommentGet instance = new ModelCommentGet(repository, services);
        String elementId = req.getServiceMatch().getTemplateVars().get("id");
        EmsScriptNode element = findScriptNodeById(elementId);

        if (element == null) {
            log(LogLevel.ERROR, "Could not find element", HttpServletResponse.SC_NOT_FOUND);
            model.put("res", response);
        } else {
            JSONArray elementsJson = instance.getCommentElements(element);
            appendResponseStatusInfo(instance);
            if (elementsJson != null) {
                JSONObject top = new JSONObject();
                try {
                    top.put("elements",  elementsJson);
                    model.put("res", top.toString(4));
                } catch (JSONException e) {
                    log(LogLevel.ERROR, "Could not create the JSON response", HttpServletResponse.SC_BAD_REQUEST);
                    e.printStackTrace();
                }
            }
        }

        status.setCode(responseStatus.getCode());
        return model;
    }
    
    /**
     * Encapsulate getting the JSONArray of comments annotating the specified element
     * @param element
     * @return
     */
    private JSONArray getCommentElements(EmsScriptNode element) {
        try {
            JSONArray commentIds = element.getSourceAssocsIdsByType(Acm.ACM_ANNOTATED_ELEMENTS);
            for (int ii = 0; ii < commentIds.length(); ii++) {
                String commentId = commentIds.getString(ii);
                EmsScriptNode comment = findScriptNodeById(commentId);
                if (comment != null) {
                    elementsFound.put(commentId, comment);
                }
            }
    
            handleElements();
        
            return elements;
        } catch (JSONException e) {
            log(LogLevel.ERROR, "Could not create the JSON response", HttpServletResponse.SC_BAD_REQUEST);
            e.printStackTrace();
        }
        
        return null;
    }
}
