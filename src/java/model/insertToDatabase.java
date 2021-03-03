/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import database.iconnectionpool;
import java.sql.Connection;
import java.sql.Statement;


/**
 *
 * @author VUONG NGUYEN
 */
public class insertToDatabase {
    //Insert users
    public void InsertUsers(iconnectionpool connectionPool, String uname, String email, String pass, String country_code){
        try{
            Connection con=null;
            //get connection from Pool
            con=connectionPool.getConnection();
            Statement stmt=con.createStatement();     
            String regdate=new java.text.SimpleDateFormat("yyyy-MM-dd-hh-mm-ss").format(new java.util.Date());                        
            String img = "noavatar.jpg";
            String groupid= "1";
            String sql="insert into users(uname,email,pass,img,country_code,regdate,groupid)values(N'"+uname+"',N'"+email+"',N'"+pass+"',N'"+img+"',N'"+country_code+"',N'"+regdate+"',N'"+groupid+"')";
            stmt.executeUpdate(sql);            
        }catch(Exception e){}
    }
    
    //Insert place from user activity
    public void InsertPlace(iconnectionpool connectionPool, String id_user, String id_place, String ip){
        try{
            Connection con=null;
            //get connection from Pool
            con=connectionPool.getConnection();
            Statement stmt=con.createStatement();
            String datesubmit=new java.text.SimpleDateFormat("yyyy-MM-dd-hh-mm-ss").format(new java.util.Date());
            String sql="insert into similarplaces(id_user,id_place,ip_submit,datesubmit)values(N'"+id_user+"',N'"+id_place+"',N'"+ip+"',N'"+datesubmit+"')";
            stmt.executeUpdate(sql);
            
        }catch(Exception e){}
    }
    
    //Insert place from user activity
    public void UpdatePlace(iconnectionpool connectionPool, String id_user, String id_place, String ip, String id_similar_place){
        try{
            Connection con=null;
            //get connection from Pool
            con=connectionPool.getConnection();
            Statement stmt=con.createStatement();
            String datesubmit=new java.text.SimpleDateFormat("yyyy-MM-dd-hh-mm-ss").format(new java.util.Date());
            String sql="update similarplaces set id_similar_place='"+id_similar_place+"', dateupdate='"+datesubmit+"', ip_update='"+ip+"' where id_user='"+id_user+"' and id_place='"+id_place+"'";
            stmt.executeUpdate(sql);            
        }catch(Exception e){}
    }
    
    //Delete from user activity
    public void DeleteActivity(iconnectionpool connectionPool, String id){
        try{
            Connection con=null;
            //get connection from Pool
            con=connectionPool.getConnection();
            Statement stmt=con.createStatement();            
            String sql="delete from similarplaces where id="+id;
            stmt.executeUpdate(sql);            
        }catch(Exception e){}
    }
    
    //Delete user
    public void DeleteUser(iconnectionpool connectionPool, String id){
        try{
            Connection con=null;
            //get connection from Pool
            con=connectionPool.getConnection();
            Statement stmt=con.createStatement();            
            String sql="delete from users where id="+id;
            stmt.executeUpdate(sql);            
        }catch(Exception e){}
    }
    
    //Delete all  activities of user
    public void DeleteAllActivityUser(iconnectionpool connectionPool, String id){
        try{
            Connection con=null;
            //get connection from Pool
            con=connectionPool.getConnection();
            Statement stmt=con.createStatement();            
            String sql="delete from similarplaces where id_user="+id;
            stmt.executeUpdate(sql);            
        }catch(Exception e){}
    }
    
    //Update user information
    public void UpdateUser(iconnectionpool connectionPool, String id_user, String uname, String email, String pass, String country_code){
        try{
            Connection con=null;
            //get connection from Pool
            con=connectionPool.getConnection();
            Statement stmt=con.createStatement();            
            String sql="update users set uname='"+uname+"', email='"+email+"', pass='"+pass+"', country_code='"+country_code+"' where id='"+id_user+"'";
            stmt.executeUpdate(sql);            
        }catch(Exception e){}
    }
    
}
