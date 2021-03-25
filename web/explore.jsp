<%response.setDateHeader("Expires", 0);response.setHeader("Pragma", "no-cache");if (request.getProtocol().equals("HTTP/1.1")) {response.setHeader("Cache-Control", "no-cache");}%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="database.*,model.*,java.util.Vector, java.util.Enumeration,java.sql.*" %>
<%if (session.getAttribute("userlogin") == null) {response.sendRedirect("login.jsp?login=false");}else{container.user users = (container.user) session.getAttribute("userlogin");
String driver = common.driver;
String url = common.url;
String username = common.username;
String password = common.password;
    iconnectionpool connectionPool = (iconnectionpool) application.getAttribute("getTourism");
       if (connectionPool == null) {
          try {
            Class.forName(driver);
          } catch (Exception e) {
            out.println(e);
          }
       connectionPool = new simpleconnectionpool(url, username, password);
       application.setAttribute("getTourism", connectionPool);
       }
Connection con=null;
con=connectionPool.getConnection();
String country_code=request.getParameter("countrycode");
getFromDatabase getInfo = new getFromDatabase();%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="include_header_head.jsp" flush="true"/>       
    </head>
    <body>
    <div class="page">
        <jsp:include page="include_header.jsp" flush="true"/>
        <div class="loader"></div>
        <div class="page-main">
            <div class="my-3 my-md-5">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-8">
                            <h3>Do you know any in these places? Please select "Yes" if you know.<br>
                            <small style="font-size:14pt">If you have not know any places, please click "Refresh"</small></h3>
                        </div>
                        <div class="col-sm-4">
                            <form class="input-icon my-3 my-lg-0" action="<%=request.getContextPath()%>/searchmovie" method="post">
                            <div class="form-group" >
                                <div class="row gutters-xs">                                    
                                    <div class="col">
                                        <input type="text" class="form-control" placeholder="Search from other countries" name="titlesearch" id="autosearch" required="">
                                    </div>
                                    <span class="col-auto">
                                        <button class="btn btn-secondary" type="submit"><i class="fe fe-search"></i></button>                                        
                                    </span>
                                    <input type="hidden" name="typeofsearch" value="newmovie">                                    
                                </div>
                            </div>
                            </form>
                        </div>                        
                    </div>
                    
                    <div class="row row-cards row-deck">
                        <%Vector Hotel = getInfo.get_Random_Place(connectionPool, country_code, "Hotel") ;
                        Enumeration Enum_Hotel = Hotel.elements();
                        if (Enum_Hotel.hasMoreElements()){String[] tmp_Hotel = (String[]) Enum_Hotel.nextElement();%>
                        <div class="col-sm-6 col-xl-3">
                            <div class="card">
                                <a href="#"><img class="card-img-top" src="<%=tmp_Hotel[6]%>" alt="<%=tmp_Hotel[0]%>" style="height: 180px"></a>                              
                                <div class="card-body d-flex flex-column">
                                    <h5><a href="#"><%=tmp_Hotel[0]%></a></h5>
                                    <small class="d-block text-muted"><%=tmp_Hotel[1]%></small>
                                    <div class="text-muted">
                                        <table style="width: 99%">                                        
                                            <tr><td>Rank</td><td style="text-align: right"><%=tmp_Hotel[4]%></td></tr>
                                            <tr><td>Rating</td><td style="text-align: right"><%=tmp_Hotel[3]%></td></tr>
                                            <tr><td>Overall Price</td><td style="text-align: right"><%=tmp_Hotel[7]%></td></tr>
                                            <tr><td>#Reviews</td><td style="text-align: right"><%=tmp_Hotel[5]%></td></tr>                                        
                                        </table>
                                    </div>
                                    <div class="d-flex align-items-center pt-5 mt-auto">                                  
                                        <div>
                                            <strong><%=tmp_Hotel[10].toUpperCase()%></strong>
                                            <small class="d-block text-muted"><%=tmp_Hotel[9]%></small>
                                        </div>
                                        <div class="ml-auto text-muted"><a href="similarplace.jsp?type=Hotel&id=<%=tmp_Hotel[11]%>" class="btn btn-pill btn-primary">Yes</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%}%>
                        
                        <%Vector Restaurants = getInfo.get_Random_Place(connectionPool, country_code, "Restaurants") ;
                        Enumeration Enum_Restaurants = Restaurants.elements();
                        if (Enum_Restaurants.hasMoreElements()){String[] tmp_Restaurants = (String[]) Enum_Restaurants.nextElement();%>
                        <div class="col-sm-6 col-xl-3">
                            <div class="card">
                                <a href="#"><img class="card-img-top" src="<%=tmp_Restaurants[6]%>" alt="<%=tmp_Restaurants[0]%>" style="height: 180px"></a>                              
                                <div class="card-body d-flex flex-column">
                                    <h5><a href="#"><%=tmp_Restaurants[0]%></a></h5>
                                    <small class="d-block text-muted"><%=tmp_Restaurants[1]%></small>
                                    <div class="text-muted">
                                        <table style="width: 99%">                                        
                                            <tr><td>Rank</td><td style="text-align: right"><%=tmp_Restaurants[4]%></td></tr>
                                            <tr><td>Rating</td><td style="text-align: right"><%=tmp_Restaurants[3]%></td></tr>
                                            <tr><td>Overall Price</td><td style="text-align: right"><%=tmp_Restaurants[7]%></td></tr>
                                            <tr><td>#Reviews</td><td style="text-align: right"><%=tmp_Restaurants[5]%></td></tr>                                        
                                        </table>
                                    </div>
                                    <div class="d-flex align-items-center pt-5 mt-auto">                                  
                                        <div>
                                            <strong><%=tmp_Restaurants[10].toUpperCase()%></strong>
                                            <small class="d-block text-muted"><%=tmp_Restaurants[9]%></small>
                                        </div>
                                        <div class="ml-auto text-muted"><a href="similarplace.jsp?type=Restaurants&id=<%=tmp_Restaurants[11]%>" class="btn btn-pill btn-primary">Yes</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%}%>
                        
                        <%Vector Shop = getInfo.get_Random_Place(connectionPool, country_code, "Shop") ;
                        Enumeration Enum_Shop = Shop.elements();
                        if (Enum_Shop.hasMoreElements()){String[] tmp_Shop = (String[]) Enum_Shop.nextElement();%>
                        <div class="col-sm-6 col-xl-3">
                            <div class="card">
                                <a href="#"><img class="card-img-top" src="<%=tmp_Shop[6]%>" alt="<%=tmp_Shop[0]%>" style="height: 180px"></a>                              
                                <div class="card-body d-flex flex-column">
                                    <h5><a href="#"><%=tmp_Shop[0]%></a></h5>
                                    <small class="d-block text-muted"><%=tmp_Shop[1]%></small>
                                    <div class="text-muted">
                                        <table style="width: 99%">                                        
                                            <tr><td>Rank</td><td style="text-align: right"><%=tmp_Shop[4]%></td></tr>
                                            <tr><td>Rating</td><td style="text-align: right"><%=tmp_Shop[3]%></td></tr>
                                            <tr><td>Overall Price</td><td style="text-align: right"><%=tmp_Shop[7]%></td></tr>
                                            <tr><td>#Reviews</td><td style="text-align: right"><%=tmp_Shop[5]%></td></tr>                                        
                                        </table>
                                    </div>
                                    <div class="d-flex align-items-center pt-5 mt-auto">                                  
                                        <div>
                                            <strong><%=tmp_Shop[10].toUpperCase()%></strong>
                                            <small class="d-block text-muted"><%=tmp_Shop[9]%></small>
                                        </div>
                                        <div class="ml-auto text-muted"><a href="similarplace.jsp?type=Shop&id=<%=tmp_Shop[11]%>" class="btn btn-pill btn-primary">Yes</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%}%>
                        
                        <%Vector Attractions = getInfo.get_Random_Place(connectionPool, country_code, "Attractions") ;
                        Enumeration Enum_Attractions = Attractions.elements();
                        if (Enum_Attractions.hasMoreElements()){String[] tmp_Attractions = (String[]) Enum_Attractions.nextElement();%>
                        <div class="col-sm-6 col-xl-3">
                            <div class="card">
                                <a href="#"><img class="card-img-top" src="<%=tmp_Attractions[6]%>" alt="<%=tmp_Attractions[0]%>" style="height: 180px"></a>                              
                                <div class="card-body d-flex flex-column">
                                    <h5><a href="#"><%=tmp_Attractions[0]%></a></h5>
                                    <small class="d-block text-muted"><%=tmp_Attractions[1]%></small>
                                    <div class="text-muted">
                                        <table style="width: 99%">                                        
                                            <tr><td>Rank</td><td style="text-align: right"><%=tmp_Attractions[4]%></td></tr>
                                            <tr><td>Rating</td><td style="text-align: right"><%=tmp_Attractions[3]%></td></tr>
                                            <tr><td>Overall Price</td><td style="text-align: right"><%=tmp_Attractions[7]%></td></tr>
                                            <tr><td>#Reviews</td><td style="text-align: right"><%=tmp_Attractions[5]%></td></tr>                                        
                                        </table>
                                    </div>
                                    <div class="d-flex align-items-center pt-5 mt-auto">                                  
                                        <div>
                                            <strong><%=tmp_Attractions[10].toUpperCase()%></strong>
                                            <small class="d-block text-muted"><%=tmp_Attractions[9]%></small>
                                        </div>
                                        <div class="ml-auto text-muted"><a href="similarplace.jsp?type=Attractions&id=<%=tmp_Attractions[11]%>" class="btn btn-pill btn-primary">Yes</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%}%>
                    </div>
                    
                    <div class="row">
                        <div class="col" align="center">
                            <a href="index.jsp?search" type="button" value=" Refresh " class="btn btn-primary" style="width:150px"> Refresh </a>
                        </div>                        
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="include_footer.jsp" flush="true"/>                 
    </div>
    </body>
</html>
<%}%>