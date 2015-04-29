package gov.nasa.jpl.view_repo.connections;

import java.util.Hashtable;

import gov.nasa.jpl.view_repo.util.NodeUtil;

import javax.jms.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NameNotFoundException;
import javax.naming.NamingException;

import org.json.JSONException;
import org.json.JSONObject;
import org.apache.log4j.Logger;

/**
 * FIXME: This is only for testing and should be removed in the future
 * curl -u admin:admin -H Content-Type:application/json http://localhost:8080/alfresco/service/connection/jmswl -d '{"uri":"t3://orasoa-dev07.jpl.nasa.gov:8011"}'
 * curl -u admin:admin -H Content-Type:application/json http://localhost:8080/alfresco/service/connection/jmswl -d '{"uri":"t3s://orasoa-dev07.jpl.nasa.gov:8111"}'
 * @author cinyoung
 *
 */
public class JmsWLConnection implements ConnectionInterface {
    private static Logger logger = Logger.getLogger(JmsWLConnection.class);
    private long sequenceId = 0;
    private static String uri = null;
    private String workspace = null;
    private String projectId = null;
    
    public JmsWLConnection() {
    }

    
    public boolean publish(JSONObject json) {
        return publish(json, null);
    }
    
    @Override
    public boolean publish(JSONObject json, String topic) {
        if (uri == null) return false;
        boolean result = false;
        try {
            json.put( "sequence", sequenceId++ );
//            result = publishQueue(NodeUtil.jsonToString( json, 2 ));
            result = publishQueueFromConnection( NodeUtil.jsonToString( json, 2 ) );
        } catch ( JSONException e ) {
            e.printStackTrace();
        }
        
        return result;
    }
    
    
    private static InitialContext ctx = null;
    private static QueueConnectionFactory qcf = null;
    private static QueueConnection qc = null;
    private static QueueSession qsess = null;
    private static Queue q = null;
    private static QueueSender qsndr = null;
    private static final String QCF_NAME = "jms/JPLEuropaJMSModuleCF";
    private static final String QUEUE_NAME = "jms/MMSDistributedQueue";

    public boolean publishQueue(String msg) {
        if (initQueueConnection() == false) return false;
        
        boolean status = true;

     // create QueueSession
        try {
            qsess = qc.createQueueSession(false, 0);
        }
        catch (JMSException jmse) {
            jmse.printStackTrace(System.err);
            return false;
        }

        // lookup Queue
        try {
            q = (Queue) ctx.lookup(QUEUE_NAME);
        }
        catch (NamingException ne) {
            ne.printStackTrace(System.err);
            return false;
        }

        // create QueueSender
        try {
            qsndr = qsess.createSender(q);
        }
        catch (JMSException jmse) {
            jmse.printStackTrace(System.err);
            return false;
        }

        TextMessage message = null;
        // create TextMessage
        try {
            message = qsess.createTextMessage(msg);
        }
        catch (JMSException jmse) {
            jmse.printStackTrace(System.err);
            return false;
        }

        // set message text in TextMessage
        try {
            if (workspace != null) {
                message.setStringProperty( "workspace", workspace );
            } else {
                message.setStringProperty( "workspace", "master" );
            }
            if (projectId != null) {
                message.setStringProperty( "projectId", projectId );
            }
        }
        catch (JMSException jmse) {
            jmse.printStackTrace(System.err);
            return false;
        }

        // send message
        try {
            qsndr.send(message);
        }
        catch (JMSException jmse) {
            jmse.printStackTrace(System.err);
            return false;
        }
        if (logger.isInfoEnabled()) logger.info("Sent message ");
        // clean up
        try {
            message = null;
            qsndr.close();
            qsndr = null;
            q = null;
            qsess.close();
            qsess = null;
            qc.close();
            qc = null;
        }
        catch (JMSException jmse) {
            jmse.printStackTrace(System.err);
        }

        
        return status;
    }

    public boolean publishQueueFromConnection(String msg) {
        Connection c = initConnection();
        if (c == null) return false;
        
        boolean status = true;

     // create QueueSession
        Session sess = null;
        try {
            sess = c.createSession(false, 0);
        }
        catch (JMSException jmse) {
            jmse.printStackTrace(System.err);
            return false;
        }

        // lookup Queue
        Destination destination;
        try {
            destination = (Queue) ctx.lookup(QUEUE_NAME);
        }
        catch (NamingException ne) {
            if (ne instanceof NameNotFoundException) {
                try {
                    destination = sess.createQueue(QUEUE_NAME);
                } catch ( JMSException e ) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                    return false;
                }
            } else {
                ne.printStackTrace(System.err);
                return false;
            }
        }


        // create QueueSender
        MessageProducer producer;
        try {
            producer = sess.createProducer(destination);
        }
        catch (JMSException jmse) {
            jmse.printStackTrace(System.err);
            return false;
        }

        TextMessage message = null;
        // create TextMessage
        try {
            message = sess.createTextMessage(msg);
        }
        catch (JMSException jmse) {
            jmse.printStackTrace(System.err);
            return false;
        }

        // set message text in TextMessage
        try {
            if (workspace != null) {
                message.setStringProperty( "workspace", workspace );
            } else {
                message.setStringProperty( "workspace", "master" );
            }
            if (projectId != null) {
                message.setStringProperty( "projectId", projectId );
            }
        }
        catch (JMSException jmse) {
            jmse.printStackTrace(System.err);
            return false;
        }

        // send message
        try {
            producer.send(message);
        }
        catch (JMSException jmse) {
            jmse.printStackTrace(System.err);
            return false;
        }
        if (logger.isInfoEnabled()) logger.info("Sent message ");
        // clean up
        try {
            message = null;
            producer.close();
            producer = null;
            destination = null;
            sess.close();
            sess = null;
            c.close();
            c = null;
        }
        catch (JMSException jmse) {
            jmse.printStackTrace(System.err);
        }
        
        return status;
    }
    
    private boolean initQueueConnection() {
        Hashtable<String, String> properties = new Hashtable<String, String>();
        properties.put(Context.INITIAL_CONTEXT_FACTORY,
                       "weblogic.jndi.WLInitialContextFactory");
        // NOTE: The port number of the server is provided in the next line,
        //       followed by the userid and password on the next two lines.
        properties.put(Context.PROVIDER_URL, uri);
        properties.put(Context.SECURITY_PRINCIPAL, "mmsjmsuser");
        properties.put(Context.SECURITY_CREDENTIALS, "mm$jm$u$3r");

        try {
            ctx = new InitialContext(properties);
        } catch (Exception ne) {
//            ne.printStackTrace(System.err);
            return false;
        }
        if (ctx == null) return false;
        
        // create QueueConnectionFactory
        try {
            qcf = (QueueConnectionFactory)ctx.lookup(QCF_NAME);
        }
        catch (Exception ne) {
//            ne.printStackTrace(System.err);
            return false;
        }
        if (qcf == null) return false;
        
        // create QueueConnection
        try {
            qc = qcf.createQueueConnection();
        }
        catch (Exception jmse) {
//            jmse.printStackTrace(System.err);
            return false;
        }
        if (qc == null) return false;
        
        return true;
    }

    
    private Connection initConnection() {
        Hashtable<String, String> properties = new Hashtable<String, String>();
        properties.put(Context.INITIAL_CONTEXT_FACTORY,
                       "weblogic.jndi.WLInitialContextFactory");
        // NOTE: The port number of the server is provided in the next line,
        //       followed by the userid and password on the next two lines.
        properties.put(Context.PROVIDER_URL, uri);
        properties.put(Context.SECURITY_PRINCIPAL, "mmsjmsuser");
        properties.put(Context.SECURITY_CREDENTIALS, "mm$jm$u$3r");

        try {
            ctx = new InitialContext(properties);
        } catch (Exception ne) {
//            ne.printStackTrace(System.err);
            return null;
        }
        if (ctx == null) return null;
        
        // create ConnectionFactory
        ConnectionFactory cf = null;
        try {
            cf = (ConnectionFactory)ctx.lookup(QCF_NAME);
        }
        catch (Exception ne) {
//            ne.printStackTrace(System.err);
            return null;
        }
        if (cf == null) return null;
        
        // create Connection
        Connection c = null;
        try {
            c = cf.createConnection();
        }
        catch (Exception jmse) {
//            jmse.printStackTrace(System.err);
            return null;
        }
        if (c == null) return null;
        
        return c;
    }


    @Override
    public String getUri() {
        return uri;
    }
    
    @Override
    public void setUri( String newUri ) {
        uri = newUri;
    }

    @Override
    public void setWorkspace( String workspace ) {
        this.workspace = workspace;
    }

    @Override
    public void setProjectId( String projectId ) {
        this.projectId = projectId;
    }
    
    @Override
    public JSONObject toJson() {
        JSONObject json = new JSONObject();
        json.put( "uri", uri );
        return json;
    }
    
    @Override
    public void ingestJson(JSONObject json) {
        if (json.has( "uri" )) {
            uri = json.isNull( "uri" ) ? null : json.getString( "uri" );
        }
    }
}
