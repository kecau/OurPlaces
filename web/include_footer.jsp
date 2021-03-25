<%-- 
    Document   : include_footer
    Created on : Jan 5, 2019, 9:49:30 PM
    Author     : VUONG NGUYEN
--%>
<%@page import="model.getFromDatabase"%>
<%@page import="java.net.URLConnection"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URL"%>
<%getFromDatabase getInfo = new getFromDatabase();
String ipclients = getInfo.getClientIp(request);%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<footer class="footer">
    <div class="container">
        <div class="row align-items-center flex-row-reverse">
            <div class="col-auto ml-lg-auto">
                <div class="row align-items-center">                
                    <div class="col-auto">                    
                        <%URL url = new URL("http://api.ipinfodb.com/v3/ip-city/?key=20b96dca8b9a5d37b0355e9461c66e76eed30a2274422fa6213d9de6ffb2b34e&ip=" + ipclients);
                        URLConnection connection = url.openConnection();
                        connection.connect();
                        InputStream is = connection.getInputStream();                        
                        BufferedReader reader = new BufferedReader(new InputStreamReader(is));
                        String data="";
                        for (String line; (line = reader.readLine()) != null;){data=line;}
                        String[] argdata = data.split(";");
                        %>
                        <small class="text-muted d-block mt-1" style="text-align: right;"><%out.print(ipclients);%><br><%=argdata[6]%>, <%=argdata[4]%> [<%=argdata[8]%> : <%=argdata[9]%>]</small>                        
                    </div>
                </div>
            </div>
            <div class="col-12 col-lg-auto mt-3 mt-lg-0">
                <a href="http://ke.cau.ac.kr" class="nav-link pr-0 leading-none"  target="_blank" >
                <span class="avatar" style="background-image: url(img/ke-cau-logo.PNG)"></span>
                    <span class="ml-2 d-none d-lg-block">
                    <span class="text-default">Knowledge Engineering Laboratory (KEL)</span>
                    <small class="text-muted d-block mt-1">Copyright © 2020 | OurPlaces</small>
                </span>                   
                </a>
            </div>
        </div>
    </div>
</footer>
