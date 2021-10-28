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

  </head>

  <body id="login-bg">

  <a href="http://www.labware.com" target="_blank" rel="noopener noreferrer"><img src="img/labware-logo.png" alt="LabWare Logo" id="login-logo" border="0"/></a>

  <div id="sso-pane">
    <div id="sso-form-bg">
      <e:form id="loginForm" onsubmit="return false;" action="#{queryStringBean.requestURI}">
        <p class="login-title" style="padding-bottom: 5px;">LabWare 8 Single Sign On</p>
        <h:outputText escape="false" value="#{loginBean.ssoLogin}"/>
        <e:div style="padding-top:25px;padding-left:25px;padding-right:25px;text-align:-moz-center;text-align:-khtml-center;text-align:center;color:red;font-weight:bold;"
               value="#{messagesBean.loginError}"/>
        <e:div id="login" style="text-align:center;" rendered="#{loginBean.renderLogin}" ajax="true">
          <table cellspacing="0" cellpadding="3" border="1" style="width: 100%; padding: 20px 40px 20px 0;">
            <tr>
              <td>&nbsp;</td>
              <td valign="top" style="text-align:center;">
                <div><e:button id="logButton" styleClass="btn btn-blue" type="submit" style="margin-left: 8px; padding:8px 10px 8px 10px;font-size:1.0em;min-width:56px;"
                               value="#{loginBean.tryLogin}"
                               onclick="#{loginBean.retrySSOLogin}" ajax="false"/></div>
              </td>
            </tr>
          </table>
        </e:div>
      </e:form>
      <e:form id="roleForm" onsubmit="return false;">
        <%--This div renders the list of roles,OK button and Cancel button--%>
        <e:div id="role" style="text-align:center;" rendered="#{loginBean.renderRole}" ajax="true">
          <table cellspacing="0" cellpadding="3" border="1" style="width: 100%; padding: 0 40px 20px 20px;">
            <tr>
              <td valign="top" style="text-align:right;"><e:span styleClass="formLabel"
                                                                 value="#{loginBean.rolelable} "/></td>
              <td valign="top" style="text-align:left;"><e:select
                  styleClass="login-input ui-widget-content ui-corner-all" id="roleOption"
                  value="#{loginBean.roleSelected}">
                <f:selectItems value="#{loginBean.roleOptions}"/>
              </e:select></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td style="padding: 10px;vertical-align: middle;text-align: center;">
                <div id="roleButton">
                  <e:button id="roleOK" styleClass="btn btn-blue"
                            style="padding:8px 10px 8px 10px;font-size:1.0em;;"
                            value="#{loginBean.assignrolelable}"
                            onclick="#{loginBean.processRole}" ajax="false" type="submit"/>&nbsp;&nbsp;
                  <e:button id="roleCancel" styleClass="btn btn-blue"
                            style="padding:8px 10px 8px 10px;font-size:1.0em;;"
                            value="#{loginBean.cancellable}"
                            onclick="#{loginBean.cancelLogin}" ajax="false" type="submit"/>
                </div>
              </td>
            </tr>
          </table>
        </e:div>
      </e:form>
    </div>

  </div>
  </body>

  </html>
</f:view>