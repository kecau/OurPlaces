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

/**
 *
 * @author VUONG NGUYEN
 */
public class getPlaceInfo {
    public String get_Name(iconnectionpool connectionPools, String id){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select name from place where id='"+id+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    public String get_Address(iconnectionpool connectionPools, String id){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select address from place where id='"+id+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    public String get_Description(iconnectionpool connectionPools, String id){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select description from place where id='"+id+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    public String get_Rank(iconnectionpool connectionPools, String id){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select rating from place where id='"+id+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    public String get_Rating(iconnectionpool connectionPools, String id){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select rank from place where id='"+id+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    public String get_Reviews(iconnectionpool connectionPools, String id){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select review_count from place where id='"+id+"'";            
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
                String sql="select img_url from place where id='"+id+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    public String get_OveralPrice(iconnectionpool connectionPools, String id){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select overall_price from place where id='"+id+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    public String get_City(iconnectionpool connectionPools, String id){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select city from place where id='"+id+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    public String get_Country(iconnectionpool connectionPools, String id){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select country from place where id='"+id+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    public String get_Type(iconnectionpool connectionPools, String id){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select place_type from place where id='"+id+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    public String get_Code(iconnectionpool connectionPools, String id){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select country_code from place where id='"+id+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
}
