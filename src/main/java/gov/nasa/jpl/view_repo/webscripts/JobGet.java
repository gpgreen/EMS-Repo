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

import gov.nasa.jpl.mbee.util.Timer;
import gov.nasa.jpl.mbee.util.Utils;
import gov.nasa.jpl.view_repo.util.EmsScriptNode;
import gov.nasa.jpl.view_repo.util.WorkspaceNode;
import gov.nasa.jpl.view_repo.webscripts.ModelGet;
import gov.nasa.jpl.view_repo.util.NodeUtil;
import gov.nasa.jpl.pma.JenkinsEngine;

import java.net.URI;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.log4j.*;
import org.alfresco.repo.model.Repository;
import org.alfresco.repo.security.authentication.AuthenticationUtil;
import org.alfresco.service.ServiceRegistry;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.extensions.webscripts.Cache;
import org.springframework.extensions.webscripts.Status;
import org.springframework.extensions.webscripts.WebScriptRequest;
import org.xml.sax.SAXException;

//import com.offbytwo.jenkins.JenkinsServer;

public class JobGet extends ModelGet {
    static Logger logger = Logger.getLogger(JobGet.class);
    
    public static final String jobStereotypeId = "_18_0_2_6620226_1453944322658_194833_14413";
    
    public JobGet() {
        super();
    }

    public JobGet(Repository repositoryHelper, ServiceRegistry registry) {
        super(repositoryHelper, registry);
    }

    protected JSONArray jobs = new JSONArray();
    protected Map<String, EmsScriptNode> jobsFound = new HashMap<String, EmsScriptNode>();
    protected Map<String, List<EmsScriptNode>> jobProperties = new HashMap<String, List<EmsScriptNode>>();

    @Override
    protected Map<String, Object> executeImpl(WebScriptRequest req, Status status, Cache cache) {        
        JobGet instance = new JobGet(repository, getServices());
        return instance.executeImplImpl(req, status, cache,
                runWithoutTransactions);
    }
    
    @Override
    protected Map<String, Object> executeImplImpl(WebScriptRequest req, 
            Status status, Cache cache) {
        if (logger.isDebugEnabled()) {
            String user = AuthenticationUtil.getFullyAuthenticatedUser();
            logger.debug(user + " " + req.getURL());
        }
        
        JenkinsEngine jenkins = new JenkinsEngine();     
        
        Timer timer = new Timer();
        printHeader(req);

        Map<String, Object> model = new HashMap<String, Object>();
        // make sure to pass down view request flag to instance
        setIsViewRequest(isViewRequest);

        JSONObject top = NodeUtil.newJsonObject();
        JSONArray res = handleRequest(req, top, NodeUtil.doGraphDb);

        // This is used to get the URLs of every job to get data easier
        JSONArray Urls = jenkins.getJobUrls();
        
        try {
            for(int i = 0; i < res.length(); i++) {
                JSONObject element = (JSONObject)res.get(i);
                if (element.has( "specialization" )) 
                    element.remove( "specialization" ); 
 
                JSONObject jobsJson = jenkins.getAllJobs();
                JSONArray jobs = jobsJson.getJSONArray( "jobs" );
                
                for(int ii = 0; ii < jobs.length(); ii++) {
                    JSONObject job = (JSONObject)jobs.get( ii );
                    job.put( "status", job.get( "color" ) );
                    job.remove( "color" );
                     
                    // if the job has not run yet
                    if(job.isNull( "lastCompletedBuild" )) {                       
                        job.put( "duration", JSONObject.NULL );
                        job.put( "estimatedDuration", JSONObject.NULL );
                        job.put( "startTime", JSONObject.NULL );
                        job.remove( "lastCompletedBuild");
                    }
                    else {
                        JSONObject o = (JSONObject)job.get( "lastCompletedBuild" );                     
                        job.put( "duration", o.get( "duration" ) );
                        job.put( "estimatedDuration", o.get( "estimatedDuration" ) );
                        job.put( "startTime", o.get( "timestamp" ));
                        job.remove( "timestamp" );
                        job.remove( "lastCompletedBuild" );
                    }
                    
                    JSONObject schedule = jenkins.configXmlToJson( 
                                                                  Urls.getJSONObject( ii )
                                                                  .get( "url" ).toString() );     
                    
                    job.put( "schedule", schedule.get( "schedule" ) );                    
                    job.put( "sysmlid", element.get( "sysmlid" ));
                    job.put( "owner", element.get( "owner" ));
                    
                    // TODO: Create a property "ics" which will be populated by schedule? 
                }
                
                element.put( "jobs", jobsJson.get( "jobs" ) );
            }
            
            if (res.length() > 0) {
                top.put("elements", res);
            }

            if (!Utils.isNullOrEmpty(response.toString()))
                top.put("message", response.toString());
            else {
                model.put("res", NodeUtil.jsonToString(top));
            }
        } catch (JSONException e) {
            log(Level.ERROR, HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Could not create JSONObject");
            model.put("res", createResponseJson());
            e.printStackTrace(); 
        } catch ( SAXException e ) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch ( ParserConfigurationException e ) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } 

        status.setCode(responseStatus.getCode());

        printFooter();

        if (logger.isInfoEnabled()) {
            log(Level.INFO, "JobGet: %s", timer);
        }

        return model;
    }
    
    public void updateJob( ) {
        
    }
    
    public JSONObject parseJob( JSONObject job ) {
        job.remove( "concurrentBuild" );
        job.remove( "keepDependencies" );
        job.remove( "buildable" );
        job.remove( "lastUnstableBuild" );
        job.remove( "lastSuccessfulBuild" );
        job.remove( "lastCompletedBuild" );
        job.remove( "nextBuildNumber" );
        job.remove( "upstreamProjects" );
        job.remove( "builds" );
        job.remove( "firstBuild" );
        job.remove( "inQueue" );
        job.remove( "property" );
        job.remove( "healthReport" );
        job.remove( "downstreamProjects" );
        job.remove( "lastBuild" );
        job.remove( "lastUnsuccessfulBuild" );
        job.remove( "displayNameOrNull" );
        job.remove( "lastStableBuild" );
        job.remove( "lastFailedBuild" );
        job.remove( "displayName" );
        job.remove( "actions" );
        job.remove( "scm" );
        job.remove( "modules" );
        job.remove( "queueItem" );
        return job;
    }
    
    public boolean isJob( EmsScriptNode node ) {
        if ( node.hasAspect( "HasMetatype" ) ) {
            Object stereotypes = 
                    node.getProperty("sysml:appliedMetatypes", true);
            // stereotypes should be a List< String >
            if ( stereotypes instanceof Collection ) {
                Collection<?> c = (Collection< ? >)stereotypes;
                for ( Object o : c ) {
                    if ( o instanceof String ) {
                        String s = (String)o;
                        if ( jobStereotypeId.equals( s ) ) {
                            return true;
                        }
                    }
                }
            }
        }  
        return false;
    }
    
    @Override
    protected JSONObject jobOrEle(EmsScriptNode job, WorkspaceNode ws, Date dateTime, String id,
                             boolean includeQualified, boolean isIncludeDocument ) {
        if  ( isJob( job ) ) {
            return new JSONObject();  
            //return job.toJSONObject( ws,  dateTime, includeQualified, isIncludeDocument, jobProperties.get(id) );
        }
        return job.toJSONObject( ws,  dateTime, includeQualified, isIncludeDocument, jobProperties.get(id) );
    }

}
