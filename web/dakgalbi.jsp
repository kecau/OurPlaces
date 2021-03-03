<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="database.*,model.*,java.util.Vector, java.util.Enumeration,java.sql.*" %>
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
        <title>Dakgalbi | Cross-Domain Recommender System</title>
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
    <body color="black">
    <div class="page">
        <div class="header py-4">
        <div class="container">
            <!--//logo-->
            <div class="d-flex"><a class="header-brand" href="home.html">
                <span class="avatar" style="background-image: url(img/dakgalbi.png)"></span> <strong style="color:#4188c9">DAKGALBI</strong></a>
                <!-- user information -->
                <div class="d-flex order-lg-2 ml-auto">
                    <div class="nav-item d-none d-md-flex"><a href="#" class="btn btn-sm btn-outline-primary">Source code</a></div>
                </div>
                <a href="#" class="header-toggler d-lg-none ml-3 ml-lg-0" data-toggle="collapse" data-target="#headerMenuCollapse"><span class="header-toggler-icon"></span></a>
            </div>
        </div>
        </div>
        <div class="header collapse d-lg-flex p-0" id="headerMenuCollapse" style="-webkit-box-shadow: 0 4px 6px rgba(0, 0, 0, 0.12);-moz-box-shadow: 0 4px 6px rgba(0, 0, 0, 0.12);box-shadow: 0 4px 6px rgba(0, 0, 0, 0.12);">
              <div class="container" >
                <div class="row align-items-center">                  
                  <div class="col-lg order-lg-first">
                    <ul class="nav nav-tabs border-0 flex-column flex-lg-row" style="color: black">
                        <li class="nav-item"><a href="#" class="nav-link"><i class="fe fe-home"></i> Home</a></li>                        
                        <li class="nav-item"><a href="#" class="nav-link"><i class="fe fe-database"></i> Data Generator</a></li>                        
                        <li class="nav-item"><a href="#" class="nav-link"><i class="fe fe-users"></i>Recommender System</a></li>                      
                    </ul>
                  </div>
                </div>
              </div>
        </div>
        <div class="page-main">
            <div class="my-3 my-md-5">
                <div class="container">                    
                    <div class="row">
                        <div class="col-md-4">
                            <div class="card">
                            <div class="card-header">
                                <h3 class="card-title"><strong>Parameter Configure</strong></h3>
                                <div class="card-options"><a href="#" class="card-options-collapse" data-toggle="card-collapse"><i class="fe fe-chevron-up"></i></a></div>
                            </div>
                            <div class="card-body">
                                <div class="form-group">
                                    <label class="form-label">Number of users</label>
                                    <input type="text" class="form-control" name="number-user" placeholder="Input the number of users" value="20000">
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Number of items</label>
                                    <input type="text" class="form-control" name="number-item" placeholder="Input the number of items" value="5000">
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Data distribution</label>
                                    <select class="form-control custom-select">
                                        <option value="Pascal Distribution">Pascal Distribution</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Data sparsity (%)</label>
                                    <input type="text" class="form-control" name="number-user" placeholder="Input the number of users" value="98.0">
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Scale</label>
                                    <input type="text" class="form-control" name="number-user" placeholder="Input the number of users" value="5">
                                </div>
                            </div>
                            </div>
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title"><strong>Common User From Dataset</strong></h3>
                                <div class="card-options"><a href="#" class="card-options-collapse" data-toggle="card-collapse"><i class="fe fe-chevron-up"></i></a></div>
                                </div>
                                <div class="card-body">
                                    <div class="form-group">
                                        <label class="form-label">Dataset selection</label>
                                        <select class="form-control custom-select">
                                            <option value="Pascal Distribution">ratings_Automotive.csv</option>
                                        </select>                                        
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Number of common user (%)</label>
                                        <div class="selectgroup selectgroup-pills">
                                            <label class="selectgroup-item">
                                                <input type="radio" name="icon-input" value="1" class="selectgroup-input">
                                                <span class="selectgroup-button selectgroup-button-icon">10</span>
                                            </label>
                                            <label class="selectgroup-item">
                                                <input type="radio" name="icon-input" value="2" class="selectgroup-input">
                                                <span class="selectgroup-button selectgroup-button-icon">20</span>
                                            </label>
                                            <label class="selectgroup-item">
                                                <input type="radio" name="icon-input" value="2" class="selectgroup-input" checked="">
                                                <span class="selectgroup-button selectgroup-button-icon">30</span>
                                            </label>
                                            <label class="selectgroup-item">
                                                <input type="radio" name="icon-input" value="2" class="selectgroup-input">
                                                <span class="selectgroup-button selectgroup-button-icon">40</span>
                                            </label>
                                            <label class="selectgroup-item">
                                                <input type="radio" name="icon-input" value="2" class="selectgroup-input">
                                                <span class="selectgroup-button selectgroup-button-icon">50</span>
                                            </label>                                            
                                            <label class="selectgroup-item">
                                                <input type="radio" name="icon-input" value="2" class="selectgroup-input">
                                                <span class="selectgroup-button selectgroup-button-icon">70</span>
                                            </label>                                           
                                            <label class="selectgroup-item">
                                                <input type="radio" name="icon-input" value="2" class="selectgroup-input">
                                                <span class="selectgroup-button selectgroup-button-icon">90</span>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <div class="card" >
                                <div class="card-header">                                    
                                    <div class="col-md-4">
                                        <label class="custom-control custom-radio">
                                            <input type="radio" class="custom-control-input" name="example-radios" value="option1" checked>
                                            <div class="custom-control-label">Using Default Parameter</div>
                                        </label>                                    
                                    </div>
                                    <div class="col-md-4">
                                        <label class="custom-control custom-radio">
                                            <input type="radio" class="custom-control-input" name="example-radios" value="option1">
                                            <div class="custom-control-label">Using Custom Parameter</div>
                                        </label>
                                    </div>
                                    <div class="col-md-4">
                                        <button type="button" class="btn btn-primary" style="width:100%">Generate Data</button>
                                    </div>                                    
                                </div>
                            </div>
                            <div class="card">                                
                                <div class="card-header">
                                    <h3 class="card-title"><strong>Output</strong></h3>
                                    <div class="card-options"><a href="#" class="card-options-collapse" data-toggle="card-collapse"><i class="fe fe-chevron-up"></i></a></div>
                                </div>
                                <div class="card-body">
                                    <table class="table table-bordered table-striped table-vcenter text-nowrap card-table">
                                        <thead>
                                          <tr>                                            
                                            <th class="text-center">User</th>
                                            <th class="text-center">Item</th>
                                            <th class="text-center">Rating</th>                                           
                                          </tr>
                                        </thead>
                                        <tbody class="text-center">
                                            <tr><td>8140</td><td>00000001</td><td> </td></tr>
                                            <tr><td>8180</td><td>00000003</td><td>3</td></tr>
                                            <tr><td>9835</td><td>00000002</td><td> </td></tr>
                                            <tr><td>8070</td><td>00000002</td><td>5</td></tr>
                                            <tr><td>9150</td><td>00000004</td><td>5</td></tr>
                                            <tr><td>8140</td><td>00000003</td><td> </td></tr>
                                            <tr><td>8070</td><td>00000003</td><td>5</td></tr>
                                            <tr><td>9140</td><td>00000004</td><td>3</td></tr>
                                            <tr><td>8140</td><td>00000004</td><td> </td></tr>
                                            <tr><td>8170</td><td>00000002</td><td>2</td></tr> 
                                        </tbody>
                                    </table>
                                </div>
                                <div class="card-footer">
                                    <button type="button" class="btn btn-primary" style="width:100%">Export Data</button>
                                </div>
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
