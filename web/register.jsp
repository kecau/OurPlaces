<%-- 
    Document   : register
    Created on : Jun 23, 2020, 6:20:31 PM
    Author     : VUONG NGUYEN
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="database.*,model.*,java.util.Vector, java.util.Enumeration,java.sql.*" %>
<%String driver = common.driver;String url = common.url;String username = common.username;String password = common.password;
    iconnectionpool connectionPool = (iconnectionpool) application.getAttribute("getPlaces");
       if (connectionPool == null) {
          try {
            Class.forName(driver);
          } catch (Exception e) {
            out.println(e);
          }
       connectionPool = new simpleconnectionpool(url, username, password);
       application.setAttribute("getPlaces", connectionPool);
       }
Connection con=null;
con=connectionPool.getConnection();
getFromDatabase getInfo = new getFromDatabase();
String ipclients = getInfo.getClientIp(request);%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <meta http-equiv="Content-Language" content="en" />
        <meta name="msapplication-TileColor" content="#2d89ef">
        <meta name="theme-color" content="#4188c9">
        <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent"/>
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="mobile-web-app-capable" content="yes">
        <meta name="HandheldFriendly" content="True">
        <meta name="MobileOptimized" content="320">
        <link href="img/oms-logo-32-32.png" rel="icon">
        <link rel="shortcut icon" type="image/x-icon" href="./favicon.ico" />
        <!-- Generated: 2018-04-16 09:29:05 +0200 -->
        <title>SIMP | SimilarPlaces</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,300i,400,400i,500,500i,600,600i,700,700i&amp;subset=latin-ext">
        <script src="./assets/js/require.min.js"></script>
        <script>
          requirejs.config({
              baseUrl: '.'
          });
        </script>
        <!-- Dashboard Core -->
        <link href="./assets/css/dashboard.css" rel="stylesheet" />
        <script src="./assets/js/dashboard.js"></script>
        <!-- c3.js Charts Plugin -->
        <link href="./assets/plugins/charts-c3/plugin.css" rel="stylesheet" />
        <script src="./assets/plugins/charts-c3/plugin.js"></script>
        <!-- Google Maps Plugin -->
        <link href="./assets/plugins/maps-google/plugin.css" rel="stylesheet" />
        <script src="./assets/plugins/maps-google/plugin.js"></script>
        <!-- Input Mask Plugin -->
        <script src="./assets/plugins/input-mask/plugin.js"></script>
    </head>
    <body>
    <div class="page">
        <div class="page-single">
            <div class="container">
                <div class="row">
                    <div class="col col-login mx-auto">
                        <div class="text-center" style="font-size:25pt">
                            <img src="img/op-logo.png" class="header-brand-img" style="width: 100px;height:100px"><br>OUR<strong style="color:#4188c9">PLACES</strong>
                        </div>
                        <%if(request.getParameter("reg").equals("emailfalse")){%>
                        <div class="alert alert-warning alert-dismissible">
                          <button type="button" class="close" data-dismiss="alert"></button>
                          Your email already registered
                        </div>
                        <%}%>
                        <form class="card" action="<%=request.getContextPath()%>/register" method="post">
                        <div class="card-body p-6">
                            <div class="card-title">Create new account</div>
                            <div class="form-group">
                                <label class="form-label">Name</label>
                                <input type="text" class="form-control" placeholder="Enter name" name="uname" required="">
                            </div>
                            <div class="form-group">
                                <label class="form-label">Email address</label>
                                <input type="email" class="form-control" placeholder="Enter email" name="email" required="">
                            </div>
                            <div class="form-group">
                                <label class="form-label">Password</label>
                                <input type="password" class="form-control" placeholder="Password" name="pass" required="">
                            </div>
                            <div class="form-group">
                                <label class="form-label">Countries</label>
                                <select name="country" id="select-countries" class="form-control custom-select">
                                    <%Vector CountryList = getInfo.get_ListCountry(connectionPool) ;
                                    Enumeration Enum_CountryList = CountryList.elements();
                                    while (Enum_CountryList.hasMoreElements()){String[] tmp_CountryList = (String[]) Enum_CountryList.nextElement();%>
                                    <option value='<%=tmp_CountryList[0]%>' data-data='{"image": "./assets/images/flags/<%=tmp_CountryList[0]%>.svg"}'><%=tmp_CountryList[1]%></option>
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
                            <div class="form-footer">
                                <button type="submit" class="btn btn-primary btn-block">Create new account</button>
                            </div>
                        </div>
                        </form>
                        <div class="text-center text-muted">
                          Already have account? <a href="login.jsp">Sign in</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
        <script>
        $(document).ready(function() {
                $("#countries").msDropdown();
        })
        </script>
    </body>
</html>
