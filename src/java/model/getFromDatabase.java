package model;

import database.iconnectionpool;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author VUONG NGUYEN
 */
public class getFromDatabase {  
    getPlaceInfo place_info = new getPlaceInfo();  
    
    public String getClientIp(HttpServletRequest request) {
        String remoteAddr = "";
        if (request != null) {
            remoteAddr = request.getHeader("X-FORWARDED-FOR");
            if (remoteAddr == null || "".equals(remoteAddr)) {
                remoteAddr = request.getRemoteAddr();
            }
        }
        return remoteAddr;
    }
    
    //Convert day
    public String ConvertDay(String day){        
        try{
            String[] arg_day = day.split("-");
            String month="";
            if(arg_day[1].equals("01")){month="Jan";}if(arg_day[1].equals("02")){month="Feb";}if(arg_day[1].equals("03")){month="Mar";}
            if(arg_day[1].equals("04")){month="Apr";}if(arg_day[1].equals("05")){month="May";}if(arg_day[1].equals("06")){month="June";}
            if(arg_day[1].equals("07")){month="July";}if(arg_day[1].equals("08")){month="Aug";}if(arg_day[1].equals("09")){month="Sept";}
            if(arg_day[1].equals("10")){month="Oct";}if(arg_day[1].equals("11")){month="Nov";}if(arg_day[1].equals("12")){month="Dec";}         
            
            String newday=month+" "+arg_day[2]+", "+arg_day[0];        
            return newday;
        }catch(Exception e){return "null";}
    }

    //Check login and set Attribute to user; param: email, pass
    public container.user checkLogin(iconnectionpool connectionPools,String email,String pass) {
        Connection con=null;
        try{
            con=connectionPools.getConnection();
            Statement stmt=con.createStatement();
            String sql="select id,uname,img,country_code,regdate,groupid from users where email='"+email+"' and pass='"+pass+"'";
            ResultSet rs=stmt.executeQuery(sql);
            container.user newuser=null;
            if(rs.next()){
                String id=rs.getString(1);
                String uname=rs.getString(2);
                String img=rs.getString(3);
                String country_code=rs.getString(4);
                String regdate=rs.getString(5);
                String groupid=rs.getString(6);                
                
                newuser=new container.user();
                
                newuser.setIduser(id);               
                newuser.setUname(uname);
                newuser.setEmail(email);
                newuser.setPass(pass);
                newuser.setImg(img);
                newuser.setCountry_code(country_code);
                newuser.setRegdate(regdate);
                newuser.setGroupid(groupid);
            }            
            connectionPools.releaseConnection(con);
            return newuser;
        }catch(Exception e){
            return null;
        }
    }
    
    //Check email registered; param: email
    public String Check_Email(iconnectionpool connectionPools, String email){
        try{
            Connection con=null;
            con=connectionPools.getConnection();
            String sql="select * from users where email='"+email+"'";            
            Statement stmt=con.createStatement();
            ResultSet rs = stmt.executeQuery(sql);                
            StringBuffer check_email = new StringBuffer();               
            if(rs.next()){check_email.append("true");}else{check_email.append("false");}
            connectionPools.releaseConnection(con);
            return check_email.toString();
        }catch(Exception e){return " ";}
    }
    
    //Check place of user
    public String Check_Place(iconnectionpool connectionPools, String id_user, String id_place){
        try{
            Connection con=null;
            con=connectionPools.getConnection();
            String sql = "select * from similarplaces where id_user='"+id_user+"' and id_place='"+id_place+"'";           
            Statement stmt=con.createStatement();
            ResultSet rs = stmt.executeQuery(sql);                
            StringBuffer check= new StringBuffer();               
            if(rs.next()){check.append("true");}else{check.append("false");}
                connectionPools.releaseConnection(con);
            return check.toString();
        }catch(Exception e){return " ";}
    }
    
    //Check similar place of user
    public String Check_Similar_Place(iconnectionpool connectionPools, String id_user, String id_place, String id_similar_place){
        try{
            Connection con=null;
            con=connectionPools.getConnection();
            String sql = "select * from similarplaces where id_user='"+id_user+"' and id_place='"+id_place+"' and id_similar_place is not null";           
            Statement stmt=con.createStatement();
            ResultSet rs = stmt.executeQuery(sql);                
            StringBuffer check= new StringBuffer();               
            if(rs.next()){check.append("true");}else{check.append("false");}
            connectionPools.releaseConnection(con);
            return check.toString();
        }catch(Exception e){return " ";}
    }            
    
    //Get list of countries
    public Vector get_ListCountry(iconnectionpool connectionPools){
        Vector VecResult=new Vector();
        try{
            Connection con=null;
            con=connectionPools.getConnection();
            Statement stmt=con.createStatement();
            String sql="select country_code,country_name from countries";
            ResultSet rs=stmt.executeQuery(sql);
            VecResult.clear();
            String country_code,country_name;
            while(rs.next()){
                country_code=rs.getString(1);
                country_name=rs.getString(2);                
                
                String[] sql_result={country_code,country_name};
                VecResult.addElement(sql_result);
            }
            connectionPools.releaseConnection(con);
        }catch(Exception e){
            System.out.println(e);
        }
        return VecResult;
    }
    
    //Get list of countries
    public Vector get_ListCountry_Collected(iconnectionpool connectionPools){
        Vector VecResult=new Vector();
        try{
            Connection con=null;
            con=connectionPools.getConnection();
            Statement stmt=con.createStatement();
            String sql="select country_code,country_name from countries where collect=1";
            ResultSet rs=stmt.executeQuery(sql);
            VecResult.clear();
            String country_code,country_name;
            while(rs.next()){
                country_code=rs.getString(1);
                country_name=rs.getString(2);                
                
                String[] sql_result={country_code,country_name};
                VecResult.addElement(sql_result);
            }
            connectionPools.releaseConnection(con);
        }catch(Exception e){
            System.out.println(e);
        }
        return VecResult;
    }
    
    //Get random 4 places depend on country
    public Vector get_Random_Place(iconnectionpool connectionPools, String country_code, String type){
        Vector VecResult=new Vector();
        try{
            Connection con=null;
            con=connectionPools.getConnection();
            Statement stmt=con.createStatement();
            String sql="select name,address,description,rank,rating,review_count,img_url,overall_price,city,country,place_type,id,country_code from place where country_code='"+country_code+"' and place_type='"+type+"' order by rand() limit 1";
            ResultSet rs=stmt.executeQuery(sql);
            VecResult.clear();
            String name,address,description,rank,rating,review_count,img_url,overall_price,city,country,place_type,idplace,code;
            if(rs.next()){
                name=rs.getString(1);
                address=rs.getString(2);
                description=rs.getString(3);                
                rank=rs.getString(4);
                rating=rs.getString(5);
                review_count=rs.getString(6);
                img_url=rs.getString(7);                
                overall_price=rs.getString(8);
                city=rs.getString(9);
                country=rs.getString(10);
                place_type=rs.getString(11);
                idplace=rs.getString(12);
                code=rs.getString(13);
                
                String[] sql_result={name,address,description,rank,rating,review_count,img_url,overall_price,city,country,place_type,idplace,code};
                VecResult.addElement(sql_result);
            }
            connectionPools.releaseConnection(con);
        }catch(Exception e){
            System.out.println(e);
        }
        return VecResult;
    }
    
    //Get 4 similar places
    public Vector get_4_Similar_Places(iconnectionpool connectionPools, String id_place, String country_code, String typeplace){
        Vector VecResult=new Vector();
        try{
            Connection con=null;
            con=connectionPools.getConnection();
            Statement stmt=con.createStatement();
            String sql="select distinct name,address,description,rank,rating,review_count,img_url,overall_price,city,country,place_type,id,country_code from place where id!='"+id_place+"' and country_code!='"+country_code+"' and place_type='"+typeplace+"' order by rand() limit 4";
            ResultSet rs=stmt.executeQuery(sql);
            VecResult.clear();
            String name,address,description,rank,rating,review_count,img_url,overall_price,city,country,place_type,idplace,code;
            while(rs.next()){
                name=rs.getString(1);
                address=rs.getString(2);
                description=rs.getString(3);                
                rank=rs.getString(4);
                rating=rs.getString(5);
                review_count=rs.getString(6);
                img_url=rs.getString(7);                
                overall_price=rs.getString(8);
                city=rs.getString(9);
                country=rs.getString(10);
                place_type=rs.getString(11);
                idplace=rs.getString(12);
                code=rs.getString(13);
                
                String[] sql_result={name,address,description,rank,rating,review_count,img_url,overall_price,city,country,place_type,idplace,code};
                VecResult.addElement(sql_result);
            }
            connectionPools.releaseConnection(con);
        }catch(Exception e){
            System.out.println(e);
        }
        return VecResult;
    }
    
    //Get places information
    public Vector get_Place_Information(iconnectionpool connectionPools, String id_place){
        Vector VecResult=new Vector();
        try{
            Connection con=null;
            con=connectionPools.getConnection();            
            Statement stmt=con.createStatement();
            String sql="select name,address,description,rank,rating,review_count,img_url,overall_price,city,country,place_type,id from place where id='"+id_place+"'";
            ResultSet rs=stmt.executeQuery(sql);
            VecResult.clear();
            String name,address,description,rank,rating,review_count,img_url,overall_price,city,country,place_type,idplace;
            if(rs.next()){
                name=rs.getString(1);
                address=rs.getString(2);
                description=rs.getString(3);                
                rank=rs.getString(4);
                rating=rs.getString(5);
                review_count=rs.getString(6);
                img_url=rs.getString(7);                
                overall_price=rs.getString(8);
                city=rs.getString(9);
                country=rs.getString(10);
                place_type=rs.getString(11);
                idplace=rs.getString(12);
                
                String[] sql_result={name,address,description,rank,rating,review_count,img_url,overall_price,city,country,place_type,idplace};
                VecResult.addElement(sql_result);
            }
            connectionPools.releaseConnection(con);
        }catch(Exception e){
            System.out.println(e);
        }
        return VecResult;
    }
    
    //Get activity of user
    public Vector get_User_Activity(iconnectionpool connectionPools, String id_user, String PagesNumber, String ItemsPerPages){
        Vector VecResult=new Vector();
        try{
            Connection con=null;
            con=connectionPools.getConnection();
            Statement stmt=con.createStatement(); 
            int p=Integer.parseInt(PagesNumber)*Integer.parseInt(ItemsPerPages);
            
            String sql="select id_place,id_similar_place,ip_submit,ip_update,datesubmit,dateupdate,id from similarplaces where id_user='"+id_user+"' order by datesubmit desc limit "+p+ ","+ItemsPerPages;
            ResultSet rs=stmt.executeQuery(sql);
            VecResult.clear();
            String id_place,id_similar_place,ip_submit,ip_update,datesubmit,dateupdate,id;
            String name,address,description,rank,rating,review_count,img_url,overall_price,city,country,place_type,code,sm_name,sm_address,sm_description,sm_rank,sm_rating,sm_review_count,sm_img_url,sm_overall_price,sm_city,sm_country,sm_place_type,sm_code;
            while(rs.next()){
                id_place = rs.getString(1);
                    name=place_info.get_Name(connectionPools, id_place);
                    address=place_info.get_Address(connectionPools, id_place);
                    description=place_info.get_Description(connectionPools, id_place);                
                    rank=place_info.get_Rank(connectionPools, id_place);
                    rating=place_info.get_Rating(connectionPools, id_place);
                    review_count=place_info.get_Reviews(connectionPools, id_place);
                    img_url=place_info.get_Img(connectionPools, id_place);               
                    overall_price=place_info.get_OveralPrice(connectionPools, id_place);
                    city=place_info.get_City(connectionPools, id_place);
                    country=place_info.get_Country(connectionPools, id_place);
                    place_type=place_info.get_Type(connectionPools, id_place);                    
                    code=place_info.get_Code(connectionPools, id_place);
                id_similar_place = rs.getString(2);
                    sm_name=place_info.get_Name(connectionPools, id_similar_place);
                    sm_address=place_info.get_Address(connectionPools, id_similar_place);
                    sm_description=place_info.get_Description(connectionPools, id_similar_place);                
                    sm_rank=place_info.get_Rank(connectionPools, id_similar_place);
                    sm_rating=place_info.get_Rating(connectionPools, id_similar_place);
                    sm_review_count=place_info.get_Reviews(connectionPools, id_similar_place);
                    sm_img_url=place_info.get_Img(connectionPools, id_similar_place);               
                    sm_overall_price=place_info.get_OveralPrice(connectionPools, id_similar_place);
                    sm_city=place_info.get_City(connectionPools, id_similar_place);
                    sm_country=place_info.get_Country(connectionPools, id_similar_place);
                    sm_place_type=place_info.get_Type(connectionPools, id_similar_place);                    
                    sm_code=place_info.get_Code(connectionPools, id_similar_place);                
                ip_submit = rs.getString(3);
                ip_update= rs.getString(4);
                datesubmit = rs.getString(5);
                dateupdate = rs.getString(6);
                id = rs.getString(7);
                                                                              //5                                             10                                                15                                                          20                                                          25
                String[] sql_result={id_place,name,address,description,rank,rating,review_count,img_url,overall_price,city,country,place_type,code,id_similar_place,sm_name,sm_address,sm_description,sm_rank,sm_rating,sm_review_count,sm_img_url,sm_overall_price,sm_city,sm_country,sm_place_type,sm_code,ip_submit,ip_update,datesubmit,dateupdate,id};
                VecResult.addElement(sql_result);
            }
            connectionPools.releaseConnection(con);
        }catch(Exception e){
            System.out.println(e);
        }
        return VecResult;
    }
    
    //Count number of activity from users
    public String getMaxActivity(iconnectionpool connectionPools){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select id_user, count(*) as numberofitem from similarplaces group by id_user order by numberofitem desc";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer count = new StringBuffer();               
                if(rs.next()){count.append(rs.getString(2));}
                connectionPools.releaseConnection(con);
            return count.toString();
            }catch(Exception e){return "0";}
    }

    //Count number of activity from users
    public String getDurationofUser(iconnectionpool connectionPools, String id_user){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select min(datesubmit), max(datesubmit) from similarplaces where id_user='"+id_user+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer count = new StringBuffer();               
                if(rs.next()){
                    String first = ConvertDay(rs.getString(1));
                    String last = ConvertDay(rs.getString(2));
                    if(first.equals(last)){
                        if(first.equals("null")){
                            count.append("No activities");
                        }else{
                            count.append(ConvertDay(rs.getString(1)));
                        }
                    }
                    else{
                        count.append(ConvertDay(rs.getString(1))+" - "+ ConvertDay(rs.getString(2)));
                    }
                }
                connectionPools.releaseConnection(con);
            return count.toString();
            }catch(Exception e){return "0";}
    }

    //Count number of activity from users
    public String countActivityofUser(iconnectionpool connectionPools, String id_user){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select count(id) from similarplaces where id_user='"+id_user+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer count = new StringBuffer();               
                if(rs.next()){count.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return count.toString();
            }catch(Exception e){return "0";}
    }
    
    //Count number of activity uncomplete from users
    public String countUncompleteofUser(iconnectionpool connectionPools, String id_user){
            try{
                Connection con=null;
                con=connectionPools.getConnection(); 
                String sql="select count(id) from similarplaces where id_user='"+id_user+"' and id_similar_place is null";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer count = new StringBuffer();               
                if(rs.next()){count.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return count.toString();
            }catch(Exception e){return "0";}
    }
    
    //Count number of activity complete from users
    public String countCompleteofUser(String total, String uncomplete){
            try{
            StringBuffer count = new StringBuffer();
            int a = Integer.parseInt(total);
            int b = Integer.parseInt(uncomplete);
            count.append((a-b)+"");        
            return count.toString();
            }catch(Exception e){return "0";}
    }
    
    //Count number of tourism places in Database
    public String countPlaces(iconnectionpool connectionPools){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select count(id) from place";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer count = new StringBuffer();               
                if(rs.next()){count.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return count.toString();
            }catch(Exception e){return " ";}
    }
    
    //Count number of places in Database today
    public String countPlacesToday(iconnectionpool connectionPools){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String today=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());  
                String sql="select count(id) from place where dateadd like '%"+today+"%'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer count = new StringBuffer();               
                if(rs.next()){count.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return count.toString();
            }catch(Exception e){return "0";}
    }
    
    //Count number of users in Database
    public String countUsers(iconnectionpool connectionPools){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select count(id) from users";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer count = new StringBuffer();               
                if(rs.next()){count.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return count.toString();
            }catch(Exception e){return " ";}
    }
    
    //Count number of users register today
    public String countUsersToday(iconnectionpool connectionPools){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String today=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());                           
                //String today = "2019-04-08";
                String sql="select count(id) from users where regdate like '%"+today+"%'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer count = new StringBuffer();               
                if(rs.next()){count.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return count.toString();
            }catch(Exception e){return "0";}
    }
    
    //Get places all users known or visited
    public String countPlaceKnowAllUser(iconnectionpool connectionPools){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select count(id) from similarplaces";
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer count = new StringBuffer();               
                if(rs.next()){count.append(rs.getString(1));}else{count.append("0");}
                connectionPools.releaseConnection(con);
            return count.toString();
            }catch(Exception e){return "0";}
    }
    
    //Count places all users known or visited today
    public String countPlaceKnowAllUserToday(iconnectionpool connectionPools){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String today=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());                           
                //String today = "2019-04-08";
                String sql="select count(id) from similarplaces where datesubmit like '%"+today+"%'";
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer count = new StringBuffer();               
                if(rs.next()){count.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return count.toString();
            }catch(Exception e){return "0";}
    }
    
    //Get similar places all users k
    public String countSimilarPlaceAllUser(iconnectionpool connectionPools){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select count(id) from similarplaces where id_similar_place is not null";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer count = new StringBuffer();               
                if(rs.next()){count.append(rs.getString(1));}else{count.append("0");}
                connectionPools.releaseConnection(con);
            return count.toString();
            }catch(Exception e){return "0";}
    }
    
    //Count places all users known or visited today
    public String countSimilarPlaceAllUserToday(iconnectionpool connectionPools){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String today=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());                           
                //String today = "2019-04-08";
                String sql="select count(id) from similarplaces where id_similar_place is not null and dateupdate like '%"+today+"%'";
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer count = new StringBuffer();               
                if(rs.next()){count.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return count.toString();
            }catch(Exception e){return "0";}
    }
    
    //Get country by code
    public String getCountry(iconnectionpool connectionPools, String code){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select country_name from countries where country_code='"+code+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer getinfo = new StringBuffer();               
                if(rs.next()){getinfo.append(rs.getString(1));}else{getinfo.append("0");}
                connectionPools.releaseConnection(con);
            return getinfo.toString();
            }catch(Exception e){return " ";}
    }
    
    //Get all users
    public Vector get_All_Users(iconnectionpool connectionPools){
        Vector thongtin=new Vector();
        try{
            Connection con=null;
            con=connectionPools.getConnection();
            Statement stmt=con.createStatement();
            String sql="select id,uname,email,img,country_code,groupid,regdate from users";
            ResultSet rs=stmt.executeQuery(sql);
            thongtin.clear();
            String id,uname,email,img,country_code,groupid,regdate;
            while(rs.next()){
                id=rs.getString(1);
                uname=rs.getString(2);
                email=rs.getString(3);
                img=rs.getString(4);
                country_code=rs.getString(5);                
                String country = getCountry(connectionPools, country_code);
                groupid=rs.getString(6);
                regdate=ConvertDay(rs.getString(7));                
                
                String[] movie_info={id,uname,email,img,country_code,groupid,regdate, country};
                thongtin.addElement(movie_info);
            }
            connectionPools.releaseConnection(con);
        }catch(Exception e){
            System.out.println(e);
        }
        return thongtin;
    }
}
