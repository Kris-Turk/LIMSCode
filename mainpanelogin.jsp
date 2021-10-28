<%--
(C)Copyright 2000-2019 by LabWare, Inc; All rights reserved

This is the first page to be rendered. This page is the login page for mainpane.

@author Avik Chatterjee
--%>

<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://www.simplica.com/jsf/ecruiser" prefix="e" %>
<%@ taglib uri="http://www.labware.com/components" prefix="lw" %>


<f:view>
  <!DOCTYPE html>
  <html>
  <head>
    <title>Welcome to LabWare 8</title>
    <link id="favicon" rel="shortcut icon" href="img/LabWare.ico"/>
    <link rel="stylesheet" type="text/css" href="css/login.css">

    <script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
    <script type="text/javascript" src="js/jquery-migrate-1.4.1.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.12.min.js"></script>

      <script type="text/javascript" src="js/jsencrypt.js"></script>

    <script language="JavaScript" type="text/javascript">
      $(document).ready(function (e) {
        var $input = $('#refresh');

        $input.val() == 'yes' ? location.reload(true) : $input.val('yes');
      });
    </script>

  </head>

  <body id="login-bg">

    <a href="http://www.labware.com" target="_blank" rel="noopener noreferrer"><img src="img/labware-logo.png" alt="LabWare Logo" id="login-logo" border="0"/></a>
    <div id="login-pane">
      <div id="login-form-bg">
        <input type="hidden" id="refresh" value="no">
        <e:form id="loginForm" onsubmit="return false;" action="#{queryStringBean.requestURI}">
          <p class="login-title" style="padding-bottom: 5px;">LabWare 8</p>
          <e:div style="padding-left:25px;padding-right:25px;text-align:-moz-center;text-align:-khtml-center;#text-align:center;color:red;font-weight:bold;"
                 value="#{messagesBean.loginError}"/>
          <br><br>
          <h:outputText escape="false" value="#{loginBean.cookieLogin}"/>
          <e:div id="mp_login" style="text-align:center;" rendered="#{loginBean.renderMainpaneLogin}" ajax="true">
            <table cellspacing="0" cellpadding="3" border="1" style="width: 100%; padding: 20px 40px 20px 20px;">
              <tr>
                <td valign="top" style="text-align:right;"><h:outputText styleClass="formLabel" value="#{loginBean.usernamelable}"/></td>
                <td valign="top" style="text-align:left;">
                  <e:input focus="true" id="mp_username" styleClass="login-input ui-widget-content ui-corner-all"
                           value="#{loginBean.username}"/></td>
              </tr>
              <tr>
                <td colspan="2" height="5"></td>
              </tr>
              <tr>
                <td valign="top" style="text-align:right;"><h:outputText styleClass="formLabel" value="#{loginBean.passwordlable}"/></td>
                <td valign="top" style="text-align:left;"><lw:encryptedPassword id="mp_password"
                                                                       styleClass="login-input ui-widget-content ui-corner-all"
                                                                       type="password"
                                                                       binding="#{loginBean.passwordComp}"
                                                                       autocomplete="off" onchange="encryptLabWarePwd_mp_password();"/>
                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td align="left" style="padding: 10px;vertical-align: middle">
                  <e:checkbox id="mp_chkRememberMe" value="#{loginBean.rememberMeMainPane}"
                              rendered="#{loginBean.renderRememberMeMainPane}" style="float:left;" ajax="true"/>
                  <e:div styleClass="formLabel" style="float:left;padding-left:5px;margin-top:0" value="#{loginBean.rememberMeLabel}"
                         rendered="#{loginBean.renderRememberMeMainPane}"/>
                </td>
              </tr>
              <tr>
                <td valign="top" style="text-align:center;" colspan="2">
                  <div><e:button id="mp_login_button" styleClass="btn btn-blue" type="submit" style="padding:8px 10px 8px 10px;font-size:1.0em;min-width:56px;"
                                 value="#{loginBean.loginlable}"
                                 onclick="#{loginBean.processLogin}" ajax="false"/></div>
                </td>
              </tr>
            </table>
          </e:div>
          </e:form>
        <e:form id="newSeesionForm" onsubmit="return false">
          <%--This div renders "Create New Session" button when attemp to login after back button click LC719NM--%>
          <e:div id="newSession" style="text-align:center;" rendered="#{loginBean.mp_renderNewSession}" ajax="true">
            <h:panelGrid style="margin:0 auto;" columns="1" id="mp_newSessionPanel">
              <e:button id="mp_newSessionButton" styleClass="btn btn-blue" type="submit"
                        style="margin-left: 8px; padding:8px 10px 8px 10px;font-size:1.0em;min-width:56px;"
                        value="#{loginBean.newSessionLable}" onclick="#{loginBean.cancelLoginInMainPane}"
                        title="#{loginBean.newSessionLable}" ajax="false"/>
            </h:panelGrid>
          </e:div>
        </e:form>
        <e:form id="roleForm" onsubmit="return false;">
          <%--This div renders the list of roles,OK button and Cancel button--%>
          <e:div id="role" style="text-align:center;" rendered="#{loginBean.renderRole}" ajax="true">
            <table cellspacing="0" cellpadding="3" border="1"
                   style="width: 100%; padding: 20px 40px 20px 20px;">
              <tr>
                <td valign="top" style="text-align:right;">
                  <e:span styleClass="formLabel" value="#{loginBean.rolelable} "/></td>
                <td valign="top" style="text-align:left;">
                  <e:select styleClass="login-input ui-widget-content ui-corner-all" id="roleOption"
                            value="#{loginBean.roleSelected}">
                    <f:selectItems value="#{loginBean.roleOptions}"/>
                  </e:select></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td style="padding: 10px;vertical-align: middle;text-align: center;">

                  <div id="roleButton"><br>
                    <e:button id="roleOK" styleClass="btn btn-blue" style="padding:8px 10px 8px 10px;font-size:1.0em;;"
                              value="#{loginBean.assignrolelable}"
                              onclick="#{loginBean.processRole}" ajax="false" type="submit"/>&nbsp;&nbsp;
                    <e:button id="roleCancel" styleClass="btn btn-blue"
                              style="padding:8px 10px 8px 10px;font-size:1.0em;;" value="#{loginBean.cancellable}"
                              onclick="#{loginBean.cancelLoginInMainPane}" ajax="false" type="submit"/>
                  </div>
                </td>
              </tr>
            </table>
          </e:div>
        </e:form>
      </div>

        <div id="login-bottom"></div>
    </div>
  </body>

  </html>
</f:view>