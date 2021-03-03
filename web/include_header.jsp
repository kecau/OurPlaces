<%-- 
    Document   : include_header
    Created on : Jan 5, 2019, 9:21:04 PM
    Author     : VUONG NGUYEN
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%if (session.getAttribute("userlogin") == null) {response.sendRedirect("login.jsp?login=false");}else{container.user user = (container.user) session.getAttribute("userlogin");%>

<!DOCTYPE html>
            <div class="header py-4">
                <div class="container">
                    <!--//logo-->
                    <div class="d-flex"><a class="header-brand" href="index.jsp?search">
                            <img src="img/op-logo.png" class="header-brand-img"> OUR<strong style="color:#4188c9">PLACES</strong></a>                        
                    <!-- user information -->
                    <div class="d-flex order-lg-2 ml-auto">
                    <div class="nav-item d-none d-md-flex"><a href="<%=request.getContextPath()%>/logout" class="btn btn-sm btn-outline-primary">Log out</a></div>
                
                    <div class="dropdown">
                    <a href="profile.jsp?edit&pages=0" class="nav-link pr-0 leading-none">
                        <span class="avatar" style="background-image: url(assets/images/flags/<%=user.getCountry_code()%>.svg)"></span>
                        <span class="ml-2 d-none d-lg-block">
                        <span class="text-default"><%=user.getUname()%></span>
                        <small class="text-muted d-block mt-1"><%=user.getEmail()%></small>
                        </span>
                    </a>
                    </div>
                    </div>
                    <a href="#" class="header-toggler d-lg-none ml-3 ml-lg-0" data-toggle="collapse" data-target="#headerMenuCollapse"><span class="header-toggler-icon"></span></a>
                    </div>
                </div>
            </div>
            
            <div class="header collapse d-lg-flex p-0" id="headerMenuCollapse" style="-webkit-box-shadow: 0 4px 6px rgba(0, 0, 0, 0.12);-moz-box-shadow: 0 4px 6px rgba(0, 0, 0, 0.12);box-shadow: 0 4px 6px rgba(0, 0, 0, 0.12);">
              <div class="container" >
                <div class="row align-items-center">                  
                  <div class="col-lg order-lg-first">
                    <ul class="nav nav-tabs border-0 flex-column flex-lg-row">
                        <li class="nav-item"><a href="index.jsp?search" class="nav-link"><i class="fe fe-home"></i> Home</a></li>                        
                        <li class="nav-item"><a href="profile.jsp?edit&pages=0" class="nav-link"><i class="fe fe-database"></i> My Activity</a></li>
                        <li class="nav-item"><a href="map.jsp" class="nav-link"><i class="fe fe-users"></i>Explore</a></li>
                        <li class="nav-item"><a href="statistic.jsp?id=0" class="nav-link"><i class="fe fe-bar-chart-2"></i>Statistic</a></li>                      
                    </ul>
                  </div>
                </div>
              </div>
            </div>   
<%}%>