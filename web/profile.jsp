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
String edit=request.getParameter("edit");
String PagesNumber = request.getParameter("pages"); String ItemPerPages="5";
getFromDatabase getInfo = new getFromDatabase();%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="include_header_head.jsp" flush="true"/> 
        <script src="assets/js/balloontip.js"></script> 
        <link href="assets/css/balloontip.css" rel="stylesheet" />
        <script language="javascript" type="text/javascript">
            function getFormPages(action){
                document.formpages.action=action;
                document.formpages.submit();}
        </script>
    </head>
    <body>
    <div class="page">
        <jsp:include page="include_header.jsp" flush="true"/>        
        <div class="page-main">
            <div class="my-3 my-md-5">
                <div class="container">
                    <div class="row">
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-body">
                                <div class="media">
                                <span class="avatar avatar-md mr-3" style="background-image: url(assets/images/flags/<%=users.getCountry_code()%>.svg)"></span>
                                <div class="media-body">
                                    <h4 class="m-0"><%=users.getUname()%></h4>
                                    <p class="text-muted mb-0"><%=users.getEmail()%></p>
                                    <p class="text-muted mb-0">Registered: <%=getInfo.ConvertDay(users.getRegdate())%></p>
                                </div>
                                <a type="button" class="btn btn-icon btn-primary" href="profile.jsp?edit=true&pages=<%=PagesNumber%>">Edit</a>
                                </div>
                            </div>
                        </div>
                        <%if(edit.equals("ok")){%>
                            <div class="alert alert-success alert-dismissible">                                
                                <a type="button" class="close" href="profile.jsp?edit&pages=<%=PagesNumber%>"></a>                                
                                Update profile successful!
                            </div>
                        <%}%>
                        <%if(edit.equals("true")){%>
                        <div class="card">
                            <div class="card-header">
                                <div class="row" style="width: 100%">
                                    <div style="width:70%">Update Profile</div>
                                    <div style="width:30%; text-align: right"><a type="button" class="close" href="profile.jsp?edit&pages=<%=PagesNumber%>"></a></div>
                                </div>
                            </div>            
                            <div class="card-body">
                                <form action="<%=request.getContextPath()%>/submitToDatabase" method="post">
                                <div class="form-group">
                                    <label class="form-label">Username</label>
                                    <input class="form-control" value="<%=users.getUname()%>" name="uname"/>                    
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Email</label>
                                    <input class="form-control" value="<%=users.getEmail()%>" name="email" />             
                                </div>
                                <div class="form-group">
                                    <div class="form-group">
                                    <label class="form-label">Countries</label>
                                    <select name="country" id="select-countries" class="form-control custom-select">
                                        <%Vector CountryList = getInfo.get_ListCountry(connectionPool) ;
                                        Enumeration Enum_CountryList = CountryList.elements();
                                        while (Enum_CountryList.hasMoreElements()){String[] tmp_CountryList = (String[]) Enum_CountryList.nextElement();%>
                                        <option value='<%=tmp_CountryList[0]%>' data-data='{"image": "./assets/images/flags/<%=tmp_CountryList[0]%>.svg"}' <%if(tmp_CountryList[0].equals(users.getCountry_code())){out.print("selected");}else{}%>><%=tmp_CountryList[1]%></option>
                                        <%}%>                                  
                                    </select>
                                </div>
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
                                </div>
                                <div class="form-footer">
                                    <input type="hidden" class="form-control" name="iduser" value="<%=users.getIduser()%>"/>
                                    <input type="hidden" class="form-control" name="country" value="<%=users.getCountry_code()%>"/>
                                    <input type="hidden" class="form-control" name="pass" value="<%=users.getPass()%>"/>
                                    <input type="hidden" class="form-control" name="action" value="updateprofile"/> 
                                    <button class="btn btn-primary btn-block">Update</button>
                                </div>
                            </form>
                            </div>            
                        </div>
                        <%}%>
                        <div class="card">
                            <div class="card-header">The cognition pattern of user</div>            
                            <div class="card-body">
                                
                            </div>            
                        </div>
                    </div>
                                    
                    <div class="col-lg-8">                        
                        <div class="row" style="height: 2.7em;">
                            <div class="col-md-8">
                                <span class="tag"><%=getInfo.countActivityofUser(connectionPool, users.getIduser())%> activities</span>                        
                                <span class="tag tag-red"><%=getInfo.countUncompleteofUser(connectionPool, users.getIduser())%> uncomplete</span>
                                <span class="tag tag-azure"><%=getInfo.countCompleteofUser(getInfo.countActivityofUser(connectionPool, users.getIduser()), getInfo.countUncompleteofUser(connectionPool, users.getIduser()))%> complete</span>
                            </div>
                            <div class="col-md-4">
                                <div class="pagination">
                                    <%
                                    int a = Integer.parseInt(getInfo.countActivityofUser(connectionPool, users.getIduser()));int b = Integer.parseInt(ItemPerPages);
                                    int totalPages = a / b + ((a % b == 0) ? 0 : 1);%>                                
                                    <a href="?edit=<%=edit%>&pages=0" class="page-link"><span class="fe fe-chevrons-left"></span></a>                                
                                    <%if(PagesNumber.equals("0")){%>
                                    <a href="?edit=<%=edit%>&pages=0" class="page-link"><span class="fe fe-chevron-left"></span></a>
                                    <%}else{%>
                                    <a href="?edit=<%=edit%>&pages=<%=Integer.parseInt(PagesNumber)-1%>" class="page-link"><span class="fe fe-chevron-left"></span></a>
                                    <%}%>                               
                                    <form action="" method="post" onchange="getFormPages('profile.jsp?edit=<%=edit%>')" name="formpages">
                                        <select name="pages" class="form-control custom-select">
                                            <%for(int k=0;k<totalPages;k++){%>
                                            <option value="<%=k%>" <%if(k==Integer.parseInt(PagesNumber)){out.print("selected");}else{}%>><%=k+1%> of <%=totalPages%></option>
                                            <%}%>
                                        </select>                            
                                    </form>                                 
                                    <%if(PagesNumber.equals((totalPages-1)+"")){%>
                                        <a href="?edit=<%=edit%>&pages=<%=totalPages-1%>" class="page-link"><span class="fe fe-chevron-right"></span></a>
                                    <%}else{%>
                                        <a href="?edit=<%=edit%>&pages=<%=Integer.parseInt(PagesNumber)+1%>" class="page-link"><span class="fe fe-chevron-right"></span></a>
                                    <%}%>
                                    <a href="?edit=<%=edit%>&pages=<%=totalPages-1%>" class="page-link"><span class="fe fe-chevrons-right"></span></a> 
                                </div>
                            </div>                            
                        </div>                        
                        <div class="card">
                            <table class="table card-table table-hover table-vcenter">
                            <%Vector ActivityList = getInfo.get_User_Activity(connectionPool, users.getIduser(), PagesNumber, ItemPerPages);
                            Enumeration Enum_ActivityList = ActivityList.elements();int i=0;
                            while (Enum_ActivityList.hasMoreElements()){String[] tmp_ActivityList = (String[]) Enum_ActivityList.nextElement();%>
                                <tr>
                                    <td style="width:20%">
                                        <a href="" rel="place1_<%=i%>"><div class="h1 m-0" style="height:120px;background-position: center;background-size: cover;background-image: url(<%=tmp_ActivityList[7]%>);"></div></a>
                                        <div id="place1_<%=i%>" class="balloonstyle">
                                            <b><%=tmp_ActivityList[1].toUpperCase()%></b><br>
                                            <p><%=tmp_ActivityList[2]%></p>                                       
                                            <b>Place type</b>: <%=tmp_ActivityList[11]%><br>
                                            <b>Country</b>: <%=tmp_ActivityList[10]%><br>
                                            <b>City</b>: <%=tmp_ActivityList[9]%><br>
                                            <b>Descriptions</b>: <p style="text-align: justify"><%=tmp_ActivityList[3]%></p>
                                        </div>
                                    </td>
                                    <td style="width:30%">
                                        <div class="text-left" style="width: 15em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><strong><%=tmp_ActivityList[1].toUpperCase()%></strong></div>
                                        <div class="text-left" style="width: 15em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><%=tmp_ActivityList[2]%></div>
                                        <div class="text-left" style="width: 15em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">Ranking: <%=tmp_ActivityList[4]%></div>
                                        <div class="text-left" style="width: 15em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">Rating: <%=tmp_ActivityList[5]%></div>
                                        <div class="text-left" style="width: 15em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">Number of reviews: <%=tmp_ActivityList[6]%></div>
                                    </td>
                                    <%if(tmp_ActivityList[13]==null){%>
                                    <td></td>
                                    <td>
                                        <form action="similarplace.jsp" method="post">
                                        <input type="hidden" name="type" value="<%=tmp_ActivityList[11]%>">                                        
                                        <input type="hidden" name="code" value="<%=tmp_ActivityList[12]%>">
                                        <input type="hidden" name="id" value="<%=tmp_ActivityList[0]%>">                                    
                                        <button type="submit" class="btn btn-primary btn-sm" style="width:145px"><i class="fe fe-eye"></i> Select similar place</button>
                                        </form>
                                        <br> 
                                        <form action="<%=request.getContextPath()%>/submitToDatabase">                                        
                                        <input type="hidden" name="action" value="deleteactivity">
                                        <input type="hidden" name="id" value="<%=tmp_ActivityList[30]%>">
                                        <input type="hidden" name="pages" value="<%=PagesNumber%>">
                                        <input type="hidden" name="edit" value="<%=request.getParameter("edit")%>">
                                        <button type="submit" class="btn btn-danger btn-sm" style="width:145px"><i class="fe fe-trash-2"></i> Delete this activity</button>
                                        </form>
                                    </td>
                                    <%}else{%>
                                    <td style="width:20%">
                                        <a href="" rel="place2_<%=i%>"><div class="h1 m-0" style="height:120px;background-position: center;background-size: cover;background-image: url(<%=tmp_ActivityList[20]%>);"></div></a>
                                        <div id="place2_<%=i%>" class="balloonstyle">
                                            <b><%=tmp_ActivityList[14].toUpperCase()%></b><br>
                                            <p><%=tmp_ActivityList[15]%></p>                                            
                                            <b>Place type</b>: <%=tmp_ActivityList[24]%><br>
                                            <b>Country</b>: <%=tmp_ActivityList[23]%><br>
                                            <b>City</b>: <%=tmp_ActivityList[22]%><br>
                                            <b>Descriptions</b>: <p style="text-align: justify"><%=tmp_ActivityList[16]%></p>
                                        </div>
                                    </td>
                                    <td style="width:30%">
                                        <div class="text-left" style="width: 15em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><strong><%=tmp_ActivityList[14].toUpperCase()%></strong></div>
                                        <div class="text-left" style="width: 15em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><%=tmp_ActivityList[15]%></div>
                                        <div class="text-left" style="width: 15em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">Ranking: <%=tmp_ActivityList[17]%></div>
                                        <div class="text-left" style="width: 15em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">Rating: <%=tmp_ActivityList[18]%></div>
                                        <div class="text-left" style="width: 15em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">Number of reviews: <%=tmp_ActivityList[19]%></div>
                                    </td>
                                    <%}%>
                                </tr>
                            <%i++;}%>
                            </table>
                        </div>
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