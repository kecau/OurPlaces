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
getFromDatabase getInfo = new getFromDatabase();
String country_code="", type_1="Hotel", type_2="Restaurants", type_3="Shop", type_4="Attractions";
String search=request.getParameter("search"); String type="";
if(search.equals("")){
    country_code=users.getCountry_code();    
}else{
    country_code=request.getParameter("code");
    type=request.getParameter("type");
    if(type.equals("1")){type_1=type_2=type_3=type_4="Hotel";}
    if(type.equals("2")){type_1=type_2=type_3=type_4="Restaurants";}
    if(type.equals("3")){type_1=type_2=type_3=type_4="Shop";}
    if(type.equals("4")){type_1=type_2=type_3=type_4="Attractions";}
}
%>
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
                    <div class="row">
                        <div class="col-sm-7">
                            <h3>Do you know any in these places?<br>
                            <small style="font-size:14pt">If you have not know any places, please click "Refresh"</small></h3>
                        </div>
                        <div class="col-sm-5">                            
                            <form action="<%=request.getContextPath()%>/index.jsp" method="post">
                            <div class="form-group" >
                                <div class="row gutters-xs">                                    
                                    <div class="col">
                                        <div class="row">
                                        <div class="col-sm-7">
                                            <select name="code" id="select-countries" class="form-control custom-select">                                                                                            
                                                <%Vector CountryList = getInfo.get_ListCountry_Collected(connectionPool);
                                                Enumeration Enum_CountryList = CountryList.elements();
                                                while (Enum_CountryList.hasMoreElements()){String[] tmp_CountryList = (String[]) Enum_CountryList.nextElement();%>
                                                <option value='<%=tmp_CountryList[0]%>' data-data='{"image": "./assets/images/flags/<%=tmp_CountryList[0]%>.svg"}' <%if(tmp_CountryList[0].equals(country_code)){out.print("selected");}%>><%=tmp_CountryList[1]%></option>
                                                <%}%>                                  
                                            </select>
                                        </div>
                                        <div class="col-sm-5">
                                            <select name="type" id="select-countries" class="form-control custom-select">
                                                <option value="0" >All places</option>
                                                <option value="1" <%if((type_1.equals("Hotel"))&&(type_1.equals(type_2))){out.print("selected");}%>>Hotels</option>
                                                <option value="2" <%if((type_1.equals("Restaurants"))&&(type_1.equals(type_2))){out.print("selected");}%>>Restaurants</option>
                                                <option value="3" <%if((type_1.equals("Shops"))&&(type_1.equals(type_2))){out.print("selected");}%>>Shops</option>
                                                <option value="4" <%if((type_1.equals("Attractions"))&&(type_1.equals(type_2))){out.print("selected");}%>>Attractions</option>                                            
                                            </select>
                                        </div>
                                        </div>
                                    </div>                                   
                                    <span class="col-auto">
                                        <button class="btn btn-secondary" type="submit"><i class="fe fe-search"></i></button>                                        
                                    </span>                                                                    
                                </div>
                            </div>
                            <input type="hidden" name="search" value="true">
                            </form>
                        </div>                        
                    </div>
                    
                    <div class="row row-cards row-deck">
                        <%Vector Hotel = getInfo.get_Random_Place(connectionPool, country_code, type_1) ;
                        Enumeration Enum_Hotel = Hotel.elements();
                        if (Enum_Hotel.hasMoreElements()){String[] tmp_Hotel = (String[]) Enum_Hotel.nextElement();%>
                        <div class="col-sm-6 col-xl-3">
                            <div class="card" onmouseover="this.style.background='#eee';" onmouseout="this.style.background='white';">
                                <a href="#"><img class="card-img-top" src="<%=tmp_Hotel[6]%>" alt="<%=tmp_Hotel[0]%>" style="height: 180px"></a>                              
                                <div class="card-body">
                                    <h5 style="width: 15em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><%=tmp_Hotel[0]%></h5>
                                    <div class="d-block text-muted" style="width: 15em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><%=tmp_Hotel[1]%></div>
                                    <div class="text-muted">
                                        <table style="width: 100%">                                        
                                            <tr><td>Rank</td><td style="text-align: right"><%=tmp_Hotel[4]%></td></tr>
                                            <tr><td>Rating</td><td style="text-align: right"><%=tmp_Hotel[3]%></td></tr>
                                            <tr><td>Overall Price</td><td style="text-align: right"><%=tmp_Hotel[7]%></td></tr>
                                            <tr><td>#Reviews</td><td style="text-align: right"><%=tmp_Hotel[5]%></td></tr>                                        
                                        </table>
                                    </div>                                    
                                    <div class="text-center mt-3">
                                        <div class="row">
                                        <div class="col-md-7">
                                        <span class="tag" style="width:100%">
                                            <span class="tag-avatar avatar" style="background-image: url(assets/images/flags/<%=tmp_Hotel[12]%>.svg)"></span>
                                            <%=tmp_Hotel[9]%>
                                        </span>
                                        </div>                                        
                                        <div class="text-center col-md-5">
                                        <span class="tag" style="width:100%">                                                                                          
                                            <%=tmp_Hotel[10]%>
                                        </span>
                                        </div>
                                        </div>                                        
                                        <a href="<%=request.getContextPath()%>/submitToDatabase?action=place&iduser=<%=users.getIduser()%>&type=Hotel&id=<%=tmp_Hotel[11]%>&code=<%=country_code%>" class="btn btn-secondary btn-block">Select place</a>
                                    </div>                                    
                                </div>
                            </div>
                        </div>
                        <%}%>
                        
                        <%Vector Restaurants = getInfo.get_Random_Place(connectionPool, country_code, type_2) ;
                        Enumeration Enum_Restaurants = Restaurants.elements();
                        if (Enum_Restaurants.hasMoreElements()){String[] tmp_Restaurants = (String[]) Enum_Restaurants.nextElement();%>
                        <div class="col-sm-6 col-xl-3">
                            <div class="card" onmouseover="this.style.background='#eee';" onmouseout="this.style.background='white';">
                                <a href="#"><img class="card-img-top" src="<%=tmp_Restaurants[6]%>" alt="<%=tmp_Restaurants[0]%>" style="height: 180px"></a>                              
                                <div class="card-body d-flex flex-column">
                                    <h5 style="width: 15em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><%=tmp_Restaurants[0]%></h5>
                                    <div class="d-block text-muted" style="width: 15em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><%=tmp_Restaurants[1]%></div>
                                    <div class="text-muted">
                                        <table style="width: 99%">                                        
                                            <tr><td>Rank</td><td style="text-align: right"><%=tmp_Restaurants[4]%></td></tr>
                                            <tr><td>Rating</td><td style="text-align: right"><%=tmp_Restaurants[3]%></td></tr>
                                            <tr><td>Overall Price</td><td style="text-align: right"><%=tmp_Restaurants[7]%></td></tr>
                                            <tr><td>#Reviews</td><td style="text-align: right"><%=tmp_Restaurants[5]%></td></tr>                                        
                                        </table>
                                    </div>
                                    <div class="text-center mt-3">
                                        <div class="row">
                                        <div class="col-md-7">
                                        <span class="tag" style="width:100%">
                                            <span class="tag-avatar avatar" style="background-image: url(assets/images/flags/<%=tmp_Restaurants[12]%>.svg)"></span>
                                            <%=tmp_Restaurants[9]%>
                                        </span>
                                        </div>                                        
                                        <div class="text-center col-md-5">
                                        <span class="tag" style="width:100%">                                                                                          
                                            <%=tmp_Restaurants[10]%>
                                        </span>
                                        </div>
                                        </div>                                        
                                        <a href="<%=request.getContextPath()%>/submitToDatabase?action=place&iduser=<%=users.getIduser()%>&type=Restaurants&id=<%=tmp_Restaurants[11]%>&code=<%=country_code%>" class="btn btn-secondary btn-block">Select place</a>
                                    </div> 
                                </div>
                            </div>
                        </div>
                        <%}%>
                        
                        <%Vector Shop = getInfo.get_Random_Place(connectionPool, country_code, type_3);
                        Enumeration Enum_Shop = Shop.elements();
                        if (Enum_Shop.hasMoreElements()){String[] tmp_Shop = (String[]) Enum_Shop.nextElement();%>
                        <div class="col-sm-6 col-xl-3">
                            <div class="card" onmouseover="this.style.background='#eee';" onmouseout="this.style.background='white';">
                                <a href="#"><img class="card-img-top" src="<%=tmp_Shop[6]%>" alt="<%=tmp_Shop[0]%>" style="height: 180px"></a>                              
                                <div class="card-body d-flex flex-column">
                                    <h5 style="width: 15em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><%=tmp_Shop[0]%></h5>
                                    <div class="d-block text-muted" style="width: 15em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><%=tmp_Shop[1]%></div>
                                    <div class="text-muted">
                                        <table style="width: 99%">                                        
                                            <tr><td>Rank</td><td style="text-align: right"><%=tmp_Shop[4]%></td></tr>
                                            <tr><td>Rating</td><td style="text-align: right"><%=tmp_Shop[3]%></td></tr>
                                            <tr><td>Overall Price</td><td style="text-align: right"><%=tmp_Shop[7]%></td></tr>
                                            <tr><td>#Reviews</td><td style="text-align: right"><%=tmp_Shop[5]%></td></tr>                                        
                                        </table>
                                    </div>
                                    <div class="text-center mt-3">
                                        <div class="row">
                                        <div class="col-md-7">
                                        <span class="tag" style="width:100%">
                                            <span class="tag-avatar avatar" style="background-image: url(assets/images/flags/<%=tmp_Shop[12]%>.svg)"></span>
                                            <%=tmp_Shop[9]%>
                                        </span>
                                        </div>                                        
                                        <div class="text-center col-md-5">
                                        <span class="tag" style="width:100%">                                                                                          
                                            <%=tmp_Shop[10]%>
                                        </span>
                                        </div>
                                        </div>                                        
                                        <a href="<%=request.getContextPath()%>/submitToDatabase?action=place&iduser=<%=users.getIduser()%>&type=Shop&id=<%=tmp_Shop[11]%>&code=<%=country_code%>" class="btn btn-secondary btn-block">Select place</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%}%>
                        
                        <%Vector Attractions = getInfo.get_Random_Place(connectionPool, country_code, type_4) ;
                        Enumeration Enum_Attractions = Attractions.elements();
                        if (Enum_Attractions.hasMoreElements()){String[] tmp_Attractions = (String[]) Enum_Attractions.nextElement();%>
                        <div class="col-sm-6 col-xl-3">
                            <div class="card" onmouseover="this.style.background='#eee';" onmouseout="this.style.background='white';">
                                <a href="#"><img class="card-img-top" src="<%=tmp_Attractions[6]%>" alt="<%=tmp_Attractions[0]%>&code=<%=country_code%>" style="height: 180px"></a>                              
                                <div class="card-body d-flex flex-column">
                                    <h5 style="width: 15em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><%=tmp_Attractions[0]%></h5>
                                    <div class="d-block text-muted" style="width: 15em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><%=tmp_Attractions[1]%></div>
                                    <div class="text-muted">
                                        <table style="width: 99%">                                        
                                            <tr><td>Rank</td><td style="text-align: right"><%=tmp_Attractions[4]%></td></tr>
                                            <tr><td>Rating</td><td style="text-align: right"><%=tmp_Attractions[3]%></td></tr>
                                            <tr><td>Overall Price</td><td style="text-align: right"><%=tmp_Attractions[7]%></td></tr>
                                            <tr><td>#Reviews</td><td style="text-align: right"><%=tmp_Attractions[5]%></td></tr>                                        
                                        </table>
                                    </div>
                                    <div class="text-center mt-3">
                                        <div class="row">
                                        <div class="col-md-7">
                                        <span class="tag" style="width:100%">
                                            <span class="tag-avatar avatar" style="background-image: url(assets/images/flags/<%=tmp_Attractions[12]%>.svg)"></span>
                                            <%=tmp_Attractions[9]%>
                                        </span>
                                        </div>                                        
                                        <div class="text-center col-md-5">
                                        <span class="tag" style="width:100%">                                                                                          
                                            <%=tmp_Attractions[10]%>
                                        </span>
                                        </div>
                                        </div>                                        
                                        <a href="<%=request.getContextPath()%>/submitToDatabase?action=place&iduser=<%=users.getIduser()%>&type=Attractions&id=<%=tmp_Attractions[11]%>&code=<%=country_code%>" class="btn btn-secondary btn-block">Select place</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%}%>
                    </div>
                    
                    <div class="row">
                        <div class="col" align="center">
                            <a href="index.jsp?search=<%=search%>&code=<%=country_code%>&type=<%=type%>" type="button" value=" Refresh " class="btn btn-primary" style="width:150px"> Refresh </a>
                        </div>                        
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="include_footer.jsp" flush="true"/>                 
    </div>
    </body>
    <script>
        require(['jquery', 'selectize'], function ($, selectize) {
            $(document).ready(function () {
                $('#select-countries').selectize({
                    render: {
                        option: function (data, escape) {
                        return '<div>' +
                        '<span class="image"><img src="' + data.image + '" alt=""></span>' +
                        '<span class="title">' + escape(data.text) + '</span>' +
                        '</div>';
                        },
                        item: function (data, escape) {
                        return '<div>' +
                        '<span class="image"><img src="' + data.image + '" alt=""></span>' +
                        escape(data.text) +
                        '</div>';
                        }
                    }
                });
            });
        });
    </script> 
</html>
<%}%>