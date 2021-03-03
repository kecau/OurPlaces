/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import database.iconnectionpool;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import model.getFromDatabase;

/**
 *
 * @author VUONG NGUYEN
 */
public class getUserInfo {
    getFromDatabase getInfo = new getFromDatabase();
    
    public String get_Uname(iconnectionpool connectionPools, String id){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select uname from users where id='"+id+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    public String get_Email(iconnectionpool connectionPools, String id){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select email from users where id='"+id+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    public String get_Pass(iconnectionpool connectionPools, String id){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select pass from users where id='"+id+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    public String get_Img(iconnectionpool connectionPools, String id){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select img from users where id='"+id+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    public String get_Country_Code(iconnectionpool connectionPools, String id){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select country_code from users where id='"+id+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    public String get_Country_Name(iconnectionpool connectionPools, String id){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select country_code from users where id='"+id+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(getInfo.getCountry(connectionPools,rs.getString(1)));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }  
    
    public String get_Regdate(iconnectionpool connectionPools, String id){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select regdate from users where id='"+id+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(getInfo.ConvertDay(rs.getString(1)));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    public String get_Groupid(iconnectionpool connectionPools, String id){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select groupid from users where id='"+id+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    
    
}
