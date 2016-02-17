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

import gov.nasa.jpl.pma.JenkinsBuildConfig;
import gov.nasa.jpl.pma.JenkinsEngine;
import gov.nasa.jpl.view_repo.util.WorkspaceNode;

import java.util.Map;

import org.apache.log4j.*;
import org.alfresco.repo.model.Repository;
import org.alfresco.service.ServiceRegistry;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.extensions.webscripts.Cache;
import org.springframework.extensions.webscripts.Status;
import org.springframework.extensions.webscripts.WebScriptRequest;

public class JobPost extends ModelPost {
    static Logger logger = Logger.getLogger(JobPost.class);
    
    protected boolean doJenkins = false;
    
    public JobPost() {
        super();
    }

    public JobPost(Repository repositoryHelper, ServiceRegistry registry) {
        super(repositoryHelper, registry);
    }

    @Override
    protected Map<String, Object> executeImpl(WebScriptRequest req, Status status, Cache cache) {        

        JobPost instance = new JobPost(repository, services);
        instance.setServices(getServices());
        // Run without transactions since JobPost breaks them up itself.
        return instance.executeImplImpl(req, status, cache, true);
    }

    @Override
    protected void preProcessJson( JSONObject json, WorkspaceNode workspace ) {
        super.preProcessJson( json, workspace );
        processJobsJson( json, workspace );
    }

    protected void processJobsJson( JSONObject json, WorkspaceNode workspace ) {
        if ( json == null ) return;
        
        // Get "jobs" as opposed to "elements"
        JSONArray jobs = json.optJSONArray( "jobs" );
        if ( jobs == null ) {
            return;
        }
        
        // Get or create "elements" array.
        JSONArray elements = json.optJSONArray( "elements" );
        if ( elements == null ) {
            elements = new JSONArray();
            json.put( "elements", elements );
        }
        
        // Generate or update element json for each of the properties.
        for ( int i = 1; i < jobs.length(); i++ ) {
            JSONObject job = jobs.optJSONObject( i );
            processJobJson( job, elements, workspace );
        }
        
        json.remove( "jobs" );
        
    }
    
    

}
