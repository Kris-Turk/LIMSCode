<%@ page import="labware.web.control.WebLIMSUtil" %><%--
(C)Copyright 2000-2015 by LabWare, Inc; All rights reserved

Error Page for LabWare web interface.

@author Vishwanath Washimkar
--%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://www.simplica.com/jsf/ecruiser" prefix="e" %>
<%@ taglib uri="http://www.labware.com/components" prefix="lw" %>


<f:view>
  <!DOCTYPE html>
  <html>
  <head>
    <title>LabWare 8 - Error</title>
    <link id="favicon" rel="shortcut icon" href="img/LabWare.ico"/>
    <lw:base/>
    <style type="text/css">
      html, body, div, h1, h2, h3, h4, h5, h6, p {
        margin: 0;
        padding: 0;
        border: 0;
        outline: 0;
        font-size: 12px;
        font-weight: 400;
        vertical-align: baseline;
        background: transparent;
        color: #0d4f91
      }

      body {
        margin: 0 auto;
        font: 1em Verdana, Geneva, sans-serif;
        color: #0d4f91;
        background: #196995 url(img/bg-inner.jpg) top left repeat-x;
      }

      fieldset {
        height: 100%;
        width: 100%;
        border: 1px solid #ccc
      }

      legend {
        margin-left: 10px;
        padding: 0 3px
      }

      a {
        text-decoration: none
      }

      input {
        font-size: 13px
      }

      ::-ms-clear {
        display: none;
      }

      /** from login.css **/
      #login-bg {
        background: #006699 url('img/bg-elements.png') 0 40px no-repeat;
      }

      #login-logo {
        position: absolute;
        top: 70px;
        left: 75px;
      }

      #login-pane {
        position: absolute;
        height: 450px;
        width: 354px;
        top: 50%;
        margin-top: -225px;
        left: 50%;
        margin-left: -177px;
      }

      .login-title {
        font: 1.9em Geneva, sans-serif;
        font-weight: bold;
        color: #004a8e;
        text-align: center;
        margin: 0;
        padding-bottom: 23px;
        padding-top: 15px;
        padding-left: 8px;
      }

      #login-form-bg {
        width: 450px;
        min-height: 430px;
        margin: 0 auto;
        display: block;
        border: 1px solid #c6c6c6;
        outline: none;
        -webkit-box-shadow: 0 3px 9px rgba(0, 0, 0, 0.5);
        box-shadow: 0 3px 9px rgba(0, 0, 0, 0.5);
        background-clip: padding-box;
        color: #000;
        background: #d8e2fb url(img/world-map-labware.jpg) no-repeat center bottom;
        border-radius: 6px;
        -moz-border-radius: 6px;
        -webkit-border-radius: 6px;
        position: absolute;
      }

      #loginForm td {
        font-size: 1.2em;
        padding: 1px;
        color: rgb(13, 79, 145);
      }

      #loginForm select {
        font-size: 1.2em;
      }


    </style>
  </head>

  <body id="login-bg">

  <a href="http://www.labware.com" target="_blank" rel="noopener noreferrer">
    <img src="img/labware-logo.png" alt="LabWare Logo" id="login-logo" border="0"/></a>
  <div id="login-pane">
    <div id="login-form-bg">
      <p class="login-title" style="padding-bottom: 5px;color:red">LabWare 8 - Error</p>
      <p style="padding: 20px;text-align: center;margin-top: 25%">
        <e:span id="header" styleClass="login-title" style="color:red;font-weight:light"
                value="#{errorBean.header}"/></p>
      <e:input type="hidden" id="baseURL" value="#{errorBean.baseURL}"/>
      <e:input type="hidden" id="pageTitle" value="#{errorBean.pageTitle}"/>
    </div>
  </div>
  </body>
  <script type="application/javascript">
    window.top.document.title = document.getElementById("pageTitle").value;
  </script>
  </html>
</f:view>
