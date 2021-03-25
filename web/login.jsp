<%-- 
    Document   : register
    Created on : Jun 23, 2020, 6:20:31 PM
    Author     : VUONG NGUYEN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="include_header_head.jsp" flush="true"/>
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
                        <form class="card" action="<%=request.getContextPath()%>/login" method="post">
                            <div class="card-body p-6">
                                <div class="card-title">Login to your account</div>
                                <div class="form-group">
                                    <label class="form-label">Email address</label>
                                    <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email" name="email">
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Password</label>
                                    <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password" name="pass">
                                </div>
                                <div class="form-group">
                                    <label class="custom-control custom-checkbox">
                                        <input type="checkbox" class="custom-control-input" />
                                        <span class="custom-control-label">Remember me</span>
                                    </label>
                                </div>
                                <div class="form-footer">
                                    <button type="submit" class="btn btn-primary btn-block">Sign in</button>
                                </div>
                            </div>
                        </form>
                        <div class="text-center text-muted">
                            Don't have account yet? <a href="register.jsp?reg">Sign up</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </body>
</html>
