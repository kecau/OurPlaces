package database;

import java.sql.*;
import java.util.*;
/**
 * SimpleConnectionPool class automatic create connection
 */
public class simpleconnectionpool implements iconnectionpool{
    protected Stack pool;
    protected String connectionURL;
    protected String userName;
    protected String password;
    /**
     * Create connection to Pool
     */
    public simpleconnectionpool(String aConnectionURL,String aUserName,String aPassword){
        connectionURL=aConnectionURL;
        userName=aUserName;
        password=aPassword;
        //tao Stack luu tru cac phan tu Pool
        pool=new Stack();
    }
    /**
     * Get connection from Pool or create new Pool (if Pool is null)
     */
    public synchronized Connection getConnection()throws SQLException{
        //neu pool khong rong lay ket noi tu pool  va tra ve cho noi goi
        if(!pool.empty()){
            return (Connection) pool.pop();
        }else{
            //neu pool rong tao moi ket noi
            return DriverManager.getConnection(connectionURL,userName, password);
        }
    }
    /**
     * return connection to Pool
     */
    public synchronized void releaseConnection(Connection con)throws SQLException{
        pool.push(con);
    }
}
