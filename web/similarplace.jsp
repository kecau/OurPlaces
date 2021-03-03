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
String idplace = request.getParameter("id");
String typeplace = request.getParameter("type");
String country_code=request.getParameter("code");
con=connectionPool.getConnection();
getFromDatabase getInfo = new getFromDatabase();%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="include_header_head.jsp" flush="true"/>       
    </head>
    <body>
    <div class="page">
        <jsp:include page="include_header.jsp" flush="true"/>        
        <div class="page-main">
            <div class="my-3 my-md-5">
                <div class="container">
                    <div class="page-header">
                        <h1 class="page-title">
                            Select the place which you think similar to your choice?
                        </h1>
                    </div>
                    <form action="<%=request.getContextPath()%>/submitToDatabase" method="post">
                    <div class="row row-cards row-deck">
                        <%Vector Place = getInfo.get_Place_Information(connectionPool, idplace) ;
                        Enumeration Enum_Place = Place.elements();
                        if (Enum_Place.hasMoreElements()){String[] tmp_Place = (String[]) Enum_Place.nextElement();%>
                            <div class="col-lg-12">
                            <div class="card card-aside">
                              <a href="#" class="card-aside-column" style="background-image: url(<%=tmp_Place[6]%>)"></a>
                              <div class="card-body d-flex flex-column">
                                  <div class="row" >
                                    <div class="col-lg-6">
                                        <h4><a href="#"><%=tmp_Place[0]%></a></h4>
                                        <div class="text-muted"><%=tmp_Place[1]%>
                                            <table style="width: 99%">                                        
                                                <tr>
                                                    <td>Rank</td><td style="text-align: right"><%=tmp_Place[4]%></td>
                                                    <td>Overall Price</td><td style="text-align: right"><%=tmp_Place[7]%></td>
                                                </tr>
                                                <tr>
                                                    <td>Rating</td><td style="text-align: right"><%=tmp_Place[3]%></td>
                                                    <td>#Reviews</td><td style="text-align: right"><%=tmp_Place[5]%></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="d-flex align-items-center pt-5 mt-auto">                                        
                                            <div>
                                                <strong><%=tmp_Place[8].toUpperCase()%></strong>
                                                <small class="d-block text-muted"><%=tmp_Place[9]%></small>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <h5><%=tmp_Place[10]%> description</h5>
                                        <small class="d-block text-muted" style="height:155px; overflow: auto; text-align: justify"><%=tmp_Place[2]%></small>
                                    </div>
                                  </div>
                              </div>
                            </div>
                        </div>
                        <%}%>
                        <%Vector PlacesList = getInfo.get_4_Similar_Places(connectionPool, idplace, country_code, typeplace);
                        Enumeration Enum_PlacesList = PlacesList.elements();
                        while (Enum_PlacesList.hasMoreElements()){String[] tmp_PlacesList = (String[]) Enum_PlacesList.nextElement();%>
                        <div class="col-sm-6 col-xl-3">
                            <div class="card" onmouseover="this.style.background='#eee';" onmouseout="this.style.background='white';">
                                <a href="#"><img class="card-img-top" src="<%=tmp_PlacesList[6]%>" alt="<%=tmp_PlacesList[0]%>" style="height: 170px"></a>                              
                                <div class="card-body d-flex flex-column">
                                    <h5><a href="#"><%=tmp_PlacesList[0]%></a></h5>
                                    <small class="d-block text-muted"><%=tmp_PlacesList[1]%></small>                                    
                                    <div class="d-flex align-items-center pt-5 mt-auto">
                                        <div class="avatar avatar-sm mr-3" style="background-image: url(assets/images/flags/<%=tmp_PlacesList[12]%>.svg)"></div>
                                        <div>
                                            <strong><%=tmp_PlacesList[10].toUpperCase()%></strong>
                                            <small class="d-block text-muted"><%=tmp_PlacesList[9]%></small>
                                        </div>
                                        <div class="ml-auto text-muted">
                                            <label class="colorinput">
                                                <input name="idsimilarplace" type="radio" value="<%=tmp_PlacesList[11]%>" class="colorinput-input" required="required"/>
                                                <span class="colorinput-color bg-azure"></span>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%}%>
                    </div>
                    
                    <div class="row">
                        <div class="col" align="center">
                            <a href="similarplace.jsp?type=<%=typeplace%>&id=<%=idplace%>&code=<%=country_code%>" type="button" class="btn btn-outline-info" style="width:150px"> Refresh </a>
                            <input type="hidden" value="similarplace" name="action">
                            <input type="hidden" value="<%=users.getIduser()%>" name="iduser">
                            <input type="hidden" value="<%=idplace%>" name="idplace">       
                            <input type="submit" class="btn btn-primary" style="width:150px" value="Submit">
                        </div>                        
                    </div>
                    </form>
                </div>
            </div>
        </div>
        <jsp:include page="include_footer.jsp" flush="true"/>                 
    </div>
    </body>
</html>
<%}%>