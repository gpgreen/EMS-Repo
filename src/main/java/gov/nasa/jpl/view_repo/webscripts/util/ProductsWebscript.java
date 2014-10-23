package gov.nasa.jpl.view_repo.webscripts.util;

import gov.nasa.jpl.mbee.util.TimeUtils;
import gov.nasa.jpl.view_repo.sysml.View;
import gov.nasa.jpl.view_repo.util.Acm;
import gov.nasa.jpl.view_repo.util.NodeUtil;
import gov.nasa.jpl.view_repo.util.Acm.JSON_TYPE_FILTER;
import gov.nasa.jpl.view_repo.util.EmsScriptNode;
import gov.nasa.jpl.view_repo.util.WorkspaceNode;
import gov.nasa.jpl.view_repo.webscripts.AbstractJavaWebScript;
import gov.nasa.jpl.view_repo.webscripts.SnapshotGet;
import gov.nasa.jpl.view_repo.webscripts.WebScriptUtil;

import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map.Entry;
import java.util.Set;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.alfresco.repo.model.Repository;
import org.alfresco.service.ServiceRegistry;
import org.alfresco.service.cmr.repository.NodeRef;
import org.alfresco.service.cmr.security.PermissionService;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.extensions.webscripts.Status;
import org.springframework.extensions.webscripts.WebScriptRequest;

/**
 * Library class for manipulating products
 * 
 * Pattern is handle does the retrieval.
 * 
 * @author cinyoung
 * 
 */
public class ProductsWebscript extends AbstractJavaWebScript {

    public boolean simpleJson = false;

    public ProductsWebscript( Repository repository, ServiceRegistry services,
                              StringBuffer response ) {
        super( repository, services, response );
    }

    public JSONArray handleProducts( WebScriptRequest req )
                                                           throws JSONException {
        JSONArray productsJson = new JSONArray();

        EmsScriptNode siteNode = getSiteNodeFromRequest( req );
        if (siteNode == null) {
            log(LogLevel.WARNING, "Could not find site", HttpServletResponse.SC_NOT_FOUND);
            return productsJson;
        }

        String configurationId = req.getServiceMatch().getTemplateVars().get( "configurationId" );
        if (configurationId == null) {
            // if no configuration id, get all products for site/context
            return handleContextProducts(req, siteNode);
        } else {
            // if configuration exists, get products for configuration
            NodeRef configNodeRef = NodeUtil.getNodeRefFromNodeId( configurationId );
            if (configNodeRef != null) {
                EmsScriptNode configNode = new EmsScriptNode(configNodeRef, services);
                return handleConfigurationProducts(req, configNode);
            } else {
                log(LogLevel.WARNING, "Could not find configuration with id " + configurationId, HttpServletResponse.SC_NOT_FOUND);
                return productsJson;
            }
        }
    }
    
    
    public JSONArray handleConfigurationProducts( WebScriptRequest req, EmsScriptNode config) throws JSONException {
        String timestamp = req.getParameter( "timestamp" );
        Date dateTime = TimeUtils.dateFromTimestamp( timestamp );

        WorkspaceNode workspace = getWorkspace( req );
        
        ConfigurationsWebscript configWs = new ConfigurationsWebscript( repository, services, response );
        return configWs.getProducts( config, workspace, dateTime );
    }
    
    public JSONArray handleContextProducts( WebScriptRequest req, EmsScriptNode siteNode) throws JSONException {
        JSONArray productsJson = new JSONArray();
        
        // get timestamp if specified
        String timestamp = req.getParameter( "timestamp" );
        Date dateTime = TimeUtils.dateFromTimestamp( timestamp );
        WorkspaceNode workspace = getWorkspace( req );
        
//        Set< EmsScriptNode > productSet =
//                WebScriptUtil.getAllNodesInPath( context.getQnamePath(),
//                                                 "ASPECT", Acm.ACM_PRODUCT,
//                                                 workspace,
//                                                 dateTime, services,
//                                                 response );
        List<EmsScriptNode> nodeList = searchForElementsForSite(NodeUtil.SearchType.ASPECT.prefix, 
                                                                Acm.ACM_PRODUCT, false,
                                                                workspace, dateTime, 
                                                                siteNode.getSiteName());
        for ( EmsScriptNode node : nodeList) {
            if (node != null) {
                productsJson.put( node.toJSONObject( null ) );
            }
        }
        
        return productsJson;
    }

    public JSONArray
            getProductSnapshots( String productId, String contextPath,
                                 WorkspaceNode workspace, Date dateTime ) throws JSONException {
        EmsScriptNode product = findScriptNodeById( productId, workspace,
                                                    dateTime, false );

        JSONArray snapshotsJson = new JSONArray();
        List< EmsScriptNode > snapshotsList =
                product.getTargetAssocsNodesByType( "view2:snapshots",
                                                    workspace, dateTime );
        // lets add products from node refs
        List<NodeRef> productSnapshots = product.getPropertyNodeRefs( "view2:productSnapshots" );
        for (NodeRef productSnapshotNodeRef: productSnapshots) {
            EmsScriptNode productSnapshot = new EmsScriptNode(productSnapshotNodeRef, services, response);
            snapshotsList.add( productSnapshot );
        }

        Collections.sort( snapshotsList,
                          new EmsScriptNode.EmsScriptNodeComparator() );
        for ( EmsScriptNode snapshot : snapshotsList ) {
            if (!snapshot.isDeleted()) {
                String id = (String)snapshot.getProperty( Acm.ACM_ID );
                Date date = (Date)snapshot.getLastModified( dateTime );
    
                JSONObject jsonObject = new JSONObject();
                jsonObject.put( "id", id );
                jsonObject.put( "created", EmsScriptNode.getIsoTime( date ) );
                jsonObject.put( "creator",
                                (String)snapshot.getProperty( "cm:modifier" ) );
                jsonObject.put( "url", contextPath + "/service/snapshots/"
                                       + snapshot.getProperty( Acm.ACM_ID ) );
                jsonObject.put( "tag", (String)SnapshotGet.getConfigurationSet( snapshot,
                                                                                workspace,
                                                                                dateTime ) );
                snapshotsJson.put( jsonObject );
            }
        }

        return snapshotsJson;
    }

    @Override
    protected boolean validateRequest( WebScriptRequest req, Status status ) {
        // TODO Auto-generated method stub
        return false;
    }

    public JSONArray handleProduct( String productId, boolean recurse,
                                    WorkspaceNode workspace,
                                    Date dateTime,
                                    boolean gettingDisplayedElements,
                                    boolean gettingContainedViews ) {
        JSONArray productsJson = new JSONArray();
        EmsScriptNode product = findScriptNodeById( productId, workspace, dateTime, false );

        if ( product == null ) {
            log( LogLevel.ERROR, "Product not found with ID: " + productId,
                 HttpServletResponse.SC_NOT_FOUND );
        }

        if ( checkPermissions( product, PermissionService.READ ) ) {
            try {
                View v = new View( product );
                if ( gettingDisplayedElements ) {
                    Collection< EmsScriptNode > elems =
                            v.getDisplayedElements();
                    elems = NodeUtil.getVersionAtTime( elems, dateTime );
                    for ( EmsScriptNode n : elems ) {
                        if ( simpleJson ) {
                            productsJson.put( n.toSimpleJSONObject( dateTime ) );
                        } else {
                            productsJson.put( n.toJSONObject( dateTime ) );
                        }
                    }
                } else if ( gettingContainedViews ) {
                    Collection< EmsScriptNode > elems =
                            v.getContainedViews( recurse, workspace, dateTime, null );
                    elems.add( product );
                    for ( EmsScriptNode n : elems ) {
                        if ( simpleJson ) {
                            productsJson.put( n.toSimpleJSONObject( dateTime ) );
                        } else {
                            productsJson.put( n.toJSONObject( dateTime ) );
                        }
                    }
                } else {
                    productsJson.put( product.toJSONObject( dateTime ) );
                }
            } catch ( JSONException e ) {
                log( LogLevel.ERROR, "Could not create JSON for product",
                     HttpServletResponse.SC_INTERNAL_SERVER_ERROR );
                e.printStackTrace();
            }
        }

        return productsJson;
    }
}
