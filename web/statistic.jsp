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
String user_id = request.getParameter("id");
getFromDatabase getInfo = new getFromDatabase();
getUserInfo getUserInfo = new getUserInfo();
%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="include_header_head.jsp" flush="true"/>
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
                <%if(users.getGroupid().equals("0")){%>
                <div class="container">                    
                    <div class="row row-cards"> 
                        <div class="col">
                            <div class="row">
                                <div class="col-sm-6 col-lg-3">
                                    <div class="card p-3">
                                        <div class="d-flex align-items-center">
                                            <span class="stamp stamp-md bg-blue mr-3">
                                              <i class="fe fe-layers"></i>
                                            </span>
                                            <div>
                                                <h4 class="m-0"><a href="javascript:void(0)"><small>1<%=getInfo.countPlaces(connectionPool)%> Tourism Places</small></a></h4>
                                                <small class="text-muted"><%=getInfo.countPlacesToday(connectionPool)%> addition today</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6 col-lg-3">
                                    <div class="card p-3">
                                    <div class="d-flex align-items-center">
                                      <span class="stamp stamp-md bg-red mr-3">
                                        <i class="fe fe-users"></i>
                                      </span>
                                      <div>
                                          <h4 class="m-0"><a href="javascript:void(0)"><%=getInfo.countUsers(connectionPool)%> <small>Members</small></a></h4>
                                          <small class="text-muted"><%=getInfo.countUsersToday(connectionPool)%> registered today</small>
                                      </div>
                                    </div>
                                  </div>
                                </div>                                
                                <div class="col-sm-6 col-lg-3">
                                <div class="card p-3">
                                  <div class="d-flex align-items-center">
                                    <span class="stamp stamp-md bg-green mr-3">
                                      <i class="fe fe-activity"></i>
                                    </span>
                                    <div>
                                        <h4 class="m-0"><a href="javascript:void(0)"><%=getInfo.countPlaceKnowAllUser(connectionPool) %><small> Select places</small></a></h4>
                                        <small class="text-muted"><%=getInfo.countPlaceKnowAllUserToday(connectionPool) %> addition today</small>
                                    </div>
                                  </div>
                                </div>
                                </div>
                                <div class="col-sm-6 col-lg-3">
                                    <div class="card p-3">
                                      <div class="d-flex align-items-center">
                                        <span class="stamp stamp-md bg-yellow mr-3">
                                          <i class="fe fe-message-square"></i>
                                        </span>
                                        <div>
                                            <h4 class="m-0"><a href="javascript:void(0)"><%=getInfo.countSimilarPlaceAllUser(connectionPool)%> <small>Similar places</small></a></h4>
                                            <small class="text-muted"><%=getInfo.countSimilarPlaceAllUserToday(connectionPool) %> addition today</small>
                                        </div>
                                      </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                <div class="row" >
                    <div class="card">
                        <%if(user_id.equals("0")){%>
                        <div class="card-body" style="height:600px; overflow: auto" >                           
                            <table class="table table-hover table-outline table-vcenter text-nowrap card-table">
                            <thead>
                            <tr>
                                <th class="text-center w-1"><i class="icon-people"></i></th>
                                <th>User</th>
                                <th>Country</th>                                                              
                                <th>Activity</th>
                                <th>Role</th>
                                <th class="text-center"><i class="icon-settings"></i></th>
                            </tr>
                            </thead>
                            <tbody>    
                            <%Vector UserList = getInfo.get_All_Users(connectionPool);
                            Enumeration Enum_UserList = UserList.elements();
                            while (Enum_UserList.hasMoreElements()){String[] tmp_UserList = (String[]) Enum_UserList.nextElement();%>
                            <tr>
                                <td class="text-center">
                                    <div class="avatar d-block" style="background-image: url(img/profile/<%=tmp_UserList[3]%>)">
                                        <span class="avatar-status bg-green"></span>
                                    </div>
                                </td>
                                <td>
                                    <div><strong><%=tmp_UserList[1]%></strong></div>
                                    <div class="small text-muted">
                                        <%=tmp_UserList[2]%><br>
                                        Registered: <%=tmp_UserList[6]%>                                      
                                    </div>
                                </td>
                                <td class="text-left">
                                    <%=tmp_UserList[7]%><br>
                                    <span class="avatar" style="background-image: url(assets/images/flags/<%=tmp_UserList[4]%>.svg)"></span>
                                </td>                                
                                <td>
                                    <div class="clearfix">
                                    <div class="float-left">
                                        <strong><%=getInfo.countActivityofUser(connectionPool, tmp_UserList[0]) %>/ <%out.print(getInfo.getMaxActivity(connectionPool));%></strong>
                                    </div>
                                    <div class="float-right">
                                        <%float total = Float.parseFloat(getInfo.getMaxActivity(connectionPool));
                                          float user_item = Float.parseFloat(getInfo.countActivityofUser(connectionPool, tmp_UserList[0]));
                                          float percent = (user_item/total)*100;%>
                                          <small class="text-muted"><%=getInfo.getDurationofUser(connectionPool, tmp_UserList[0]) %></small>
                                    </div>
                                    </div>
                                    <div class="progress progress-xs">                                        
                                        <div class="progress-bar bg-blue" role="progressbar" style="width: <%=percent%>%" aria-valuenow="<%=user_item%>" aria-valuemin="0" aria-valuemax="<%=total%>"></div>
                                    </div>
                                </td>
                                <td class="text-left">
                                    <%if(tmp_UserList[5].equals("0")){out.print("Admin");}else{out.print("User");}%>
                                </td>
                                <td class="text-center">
                                    <div class="item-action dropdown">
                                    <a href="javascript:void(0)" data-toggle="dropdown" class="btn btn-outline-primary">Action</a>
                                    <div class="dropdown-menu dropdown-menu-right">                                        
                                        <a href="statistic.jsp?id=<%=tmp_UserList[0]%>&pages=0" class="dropdown-item"><i class="dropdown-icon fe fe-search"></i> Details </a>
                                        <%if(tmp_UserList[5].equals("0")){}else{%>
                                        <a href="javascript:void(0)" class="dropdown-item"><i class="dropdown-icon fe fe-eye"></i> Disable </a>
                                        <a href="javascript:void(0)" class="dropdown-item"><i class="dropdown-icon fe fe-edit-2"></i>Update Role</a>
                                        <div class="dropdown-divider"></div>
                                        <a href="<%=request.getContextPath()%>/submitToDatabase?id=<%=tmp_UserList[0]%>&action=deleteuser" onclick="return confirm('This action will be delete all activities and information of user. Do you want to continue?');" class="dropdown-item"><i class="dropdown-icon fe fe-trash-2"></i>Delete</a>
                                        <%}%>
                                    </div>
                                    </div>
                                </td>
                            </tr>                            
                            <%}%>
                            </tbody>
                            </table>
                        </div>                          
                        <%}else{%>
                        <div class="card-header">
                            <div class="row" style="width:100%;">                                                        
                            <div class="col-md-4">
                                <div class="nav-link pr-0 leading-none">
                                    <span class="avatar" style="background-image: url(assets/images/flags/<%=getUserInfo.get_Country_Code(connectionPool, user_id)%>.svg)"></span>&nbsp
                                    <span class="avatar" style="background-image: url(img/profile/<%=getUserInfo.get_Img(connectionPool, user_id)%>)"></span>                                   
                                    <span class="ml-2 d-none d-lg-block">
                                    <span class="text-default"><%=getUserInfo.get_Uname(connectionPool, user_id)%> (<%=getUserInfo.get_Country_Name(connectionPool, user_id)%>)</span>
                                    <small class="text-muted d-block mt-1"><%=getUserInfo.get_Email(connectionPool, user_id)%></small>
                                    </span>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div style="position: relative;float: right; vertical-align: central">
                                    <span class="tag"><%=getInfo.countActivityofUser(connectionPool, user_id)%> activities</span>                        
                                    <span class="tag tag-red"><%=getInfo.countUncompleteofUser(connectionPool, user_id)%> uncomplete</span>
                                    <span class="tag tag-azure"><%=getInfo.countCompleteofUser(getInfo.countActivityofUser(connectionPool, user_id), getInfo.countUncompleteofUser(connectionPool, user_id))%> complete</span>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card-options" style="position: relative;float: right;">
                                    <%String PagesNumber = request.getParameter("pages"); String ItemPerPages="5";
                                    int a = Integer.parseInt(getInfo.countActivityofUser(connectionPool, user_id));int b = Integer.parseInt(ItemPerPages);
                                    int totalPages = a / b + ((a % b == 0) ? 0 : 1);%>                                
                                    <a href="?id=<%=user_id%>&pages=0" class="page-link"><span class="fe fe-chevrons-left"></span></a>                                
                                    <%if(PagesNumber.equals("0")){%>
                                    <a href="?id=<%=user_id%>&pages=0" class="page-link"><span class="fe fe-chevron-left"></span></a>
                                    <%}else{%>
                                    <a href="?id=<%=user_id%>&pages=<%=Integer.parseInt(PagesNumber)-1%>" class="page-link"><span class="fe fe-chevron-left"></span></a>
                                    <%}%>&nbsp;&nbsp;                        
                                    <form action="" method="post" onchange="getFormPages('statistic.jsp?id=<%=user_id%>')" name="formpages">
                                        <select name="pages" class="form-control custom-select">
                                            <%for(int k=0;k<totalPages;k++){%>
                                            <option value="<%=k%>" <%if(k==Integer.parseInt(PagesNumber)){out.print("selected");}else{}%>><%=k+1%> of <%=totalPages%></option>
                                            <%}%>
                                        </select>                            
                                    </form>                                 
                                    <%if(PagesNumber.equals((totalPages-1)+"")){%>
                                        <a href="?id=<%=user_id%>&pages=<%=totalPages-1%>" class="page-link"><span class="fe fe-chevron-right"></span></a>
                                    <%}else{%>
                                        <a href="?id=<%=user_id%>&pages=<%=Integer.parseInt(PagesNumber)+1%>" class="page-link"><span class="fe fe-chevron-right"></span></a>
                                    <%}%>
                                    <a href="?id=<%=user_id%>&pages=<%=totalPages-1%>" class="page-link"><span class="fe fe-chevrons-right"></span></a>
                                </div>
                            </div>
                            </div>
                        </div>
                        <div class="card-body" style="height:550px; overflow: auto" >                                    
                            <table class="table card-table table-hover table-vcenter">
                            <%Vector ActivityList = getInfo.get_User_Activity(connectionPool, user_id, PagesNumber, ItemPerPages);
                            Enumeration Enum_ActivityList = ActivityList.elements();int i=0;
                            while (Enum_ActivityList.hasMoreElements()){String[] tmp_ActivityList = (String[]) Enum_ActivityList.nextElement();%>
                                <tr>
                                    <td style="width:20%">
                                        <a href="" rel="place1_<%=i%>"><div class="h1 m-0" style="height:120px;background-position: center;background-size: cover;background-image: url(<%=tmp_ActivityList[7]%>);"></div></a>
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
                                    <td></td>
                                    <%}else{%>
                                    <td style="width:20%">
                                        <a href="" rel="place2_<%=i%>"><div class="h1 m-0" style="height:120px;background-position: center;background-size: cover;background-image: url(<%=tmp_ActivityList[20]%>);"></div></a>
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
                            <%if(i==0){%>
                            <div style="text-align: center">
                            <div class="display-1 text-muted mb-5"><i class="si si-exclamation"></i> 400</div>
                            <h1 class="h2 mb-3">Oops.. You just found an error page..</h1>
                            <p class="h4 text-muted font-weight-normal mb-7">No activities found for this user</p> 
                            <a class="btn btn-primary" href="statistic.jsp?id=0">
                                <i class="fe fe-arrow-left mr-2"></i>Go back
                            </a>
                            </div>
                            <%}%>
                            <%}%>
                        </div>                        
                    </div>
                </div>                
            </div>
            <%}else{%>
            <div class="container text-center">
                <br><br><br><br><br><br>
                <div class="display-1 text-muted mb-5"><i class="si si-exclamation"></i> 401</div>
                <h1 class="h2 mb-3">Oops.. You just found an error page..</h1>
                <p class="h4 text-muted font-weight-normal mb-7">We are sorry but you are not authorized to access this page&hellip;</p>
                <a class="btn btn-primary" href="index.jsp?search">
                  <i class="fe fe-arrow-left mr-2"></i>Go back
                </a>
                <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
            </div>           
            
            <%}%>
        </div>
        <jsp:include page="include_footer.jsp" flush="true"/>                 
    </div>    
    </body>
</html>
<%}%>