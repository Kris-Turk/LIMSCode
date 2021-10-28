<!DOCTYPE html>
<%--
(C)Copyright 2000-2019 by LabWare, Inc; All rights reserved

This is the first page to be rendered. This page is the login page.

@author Avik Chatterjee
--%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://www.simplica.com/jsf/ecruiser" prefix="e" %>
<%@ taglib uri="http://www.labware.com/components" prefix="lw" %>
<f:view>
  <html>

  <head>
    <title>LabWare Admin Console Log In</title>
    <link id="favicon" rel="shortcut icon" href="../img/LabWare.ico"/>
    <link rel="stylesheet" type="text/css" href="stylesheet/labware_admin.css">
    <script type="text/javascript" src="../common/js/jsencrypt.js"></script>
    <script language="JavaScript" src="../labware.js" type="text/javascript"></script>
    <script type="text/javascript">
      function validateUserNameAndPassword() {
        var userName = document.getElementById("loginForm:username");
        var password = document.getElementById("loginForm:password");
        if (password.style.display == "none") {
          password = document.getElementById("loginForm:enc_password");
        }
        var msg = "";
        if (userName.value.trim() == "") {
          msg = document.getElementById("loginForm:invalidusernamemsg").value;
          alert(msg);
          userName.style.backgroundColor = "red";
          userName.focus();
          return false;
        }
        else if (password.value.trim() == "") {
          msg = document.getElementById("loginForm:invalidpasswordmsg").value;
          alert(msg);
          password.style.backgroundColor = "red";
          password.focus();
          return false;
        } else {
          return true;
        }
      }
      /**
       * This function is here to fix a JSF bug of commandButton component.
       * It should be a temporary hack.
       * http://bugs.sun.com/bugdatabase/view_bug.do?bug_id=6241750
       * @param curFormName
       */
      function clearFormHiddenParams(curFormName) {
        var curForm = document.forms[curFormName];
      }

      function checkFocus() {
        document.forms[0].elements[0].focus();
      }
      if (window.attachEvent) {
        window.attachEvent("onload", checkFocus);
      } else if (window.addEventListener) {
        window.addEventListener("load", checkFocus, false);
      }
    </script>

  </head>

  <body bgcolor="#FFFFFF" style="margin: 0">
  <e:form id="loginForm">
    <!-- Header -->
    <div id="header_wrapper" style="width:100%;height: 105px; overflow: hidden;">
      <div id="header1" style="width: 100%;height: 55px;padding-top: 20px;" class="admin_header">LabWare Admin
        Console</div>
        <div id="header2" style="width: 200px;top:0;position:fixed;height: 75px;background-image: url('images/logo.gif');float: left;"
             title="LabWare"></div>
      <div id="menubar" class="top-menu" style="width:100%"></div>
    </div>

      <e:div id="messageDiv" style="position:fixed;width:100%;height:65px;top:105px;padding-top:10px;z-index:5"
             rendered="true" align="center" styleClass="admin_table_body">
          <table border="0" cellspacing="0" cellpadding="0" align="center">
              <tr>
                  <td><h:messages styleClass="admin_message_error" layout="table" binding="#{messagesBean.messages}"
                                  id="admin_login_error"/></td>
              </tr>
          </table>
      </e:div>
    <e:div id="authDisableTable" style="bottom:42px;position:fixed;width:100%;top:120px"
           rendered="#{adminLoginBean.renderDisableAdminAuth}" styleClass="admin_table_body" ajax="true">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
      <tr>
        <td width="100%" height="400px" valign="top">
          <div style="padding:100px;vertical-align:top;height:100%;" align="left">
            <table width="550px" border="0" cellspacing="2" cellpadding="0" align="center">
              <tr>
                <td colspan="2" class="admin_table_header"><br>

                  <h:outputText id="authDisableMsg1" styleClass="admin_message_error" style="font-style: normal" value="#{adminLoginBean.authDisableMsg1}"/><br>
                  <h:outputText id="authDisableMsg2" styleClass="admin_message_error" style="font-style: normal" value="#{adminLoginBean.authDisableMsg2}"/>
                </td>
              </tr>
              <tr class="admin_table_body">
                <td valign="top" colspan="2" align="center"><br>
                  <h:commandButton value="#{adminLoginBean.openlable}" id="authDisableButton" actionListener="#{adminLoginBean.loginWithoutAuthenticate}"/>
                </td>
              </tr>
            </table>
          </div>
        </td>
      </tr>
    </table>
    </e:div>
              <!-- Main table -->
    <e:div id="mainTable" style="bottom:42px;position:fixed;width:100%;top:120px" rendered="#{adminLoginBean.renderLogin}" styleClass="admin_table_body" ajax="true">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
          <td width="100%" height="400px" valign="top">
            <div style="padding:20px;vertical-align:top;height:100%;" align="left">
              <table width="550px" border="0" cellspacing="2" cellpadding="0" align="center">
                <tr>
                  <td colspan="2" class="admin_table_header"><br>

                    <H4><h:outputText id="loginrequired" value="#{adminLoginBean.loginrequired}"/></H4>
                  </td>
                </tr>
                <tr class="admin_table_body">
                  <td align="right" style="text-align:right;"><h:outputText styleClass="required_field_label"
                                                                            value="#{adminLoginBean.usernamelable}"/>&nbsp;
                  </td>
                  <td valign="top" align="left">
                    <e:input autocomplete="off" value="#{adminLoginBean.userName}" focus="true" id="username"
                             style="width:155px;"/>
                  </td>
                </tr>
                <tr class="admin_table_body">
                  <td align="right" style="text-align:right;"><h:outputText styleClass="required_field_label"
                                                                            value="#{adminLoginBean.passwordlable}"/>&nbsp;</td>
                  <td valign="top" align="left">
                    <e:input autocomplete="off" type="password" value="#{adminLoginBean.password}" id="password"
                             style="width:155px;" rendered="#{adminLoginBean.renderPwd}"/>
                    <lw:encryptedPassword id="enc_password"
                                          style="width:155px;"
                                          type="password"
                                          binding="#{adminLoginBean.passwordComp}"
                                          autocomplete="off"
                                          onchange="encryptLabWarePwd_enc_password();"
                                          rendered="#{adminLoginBean.renderEncryptedPwd}"/>
                  </td>
                </tr>

                <!-- adding the LIMS Datasource -->
                <tr class="admin_table_body">
                  <td align="right" style="text-align:right;">
                    <h:outputText styleClass="required_field_label" value="Datasource: "
                                  rendered="#{adminLoginBean.renderDSSelect}"/>
                  </td>
                  <td valign="top" align="left">
                    <e:select id="ds_select" ajax="true" style="width:160px;"
                              value="#{adminLoginBean.datasource}"
                              data="#{adminLoginBean.dataSourceList}"
                              rendered="#{adminLoginBean.renderDSSelect}"/>
                  </td>
                </tr>

                <tr class="admin_table_body">
                  <td valign="top" colspan="2" align="center"><br>
                    <h:commandButton value="#{adminLoginBean.loginlable}" id="loginButton"
                                     onclick="return validateUserNameAndPassword();"
                                     actionListener="#{adminLoginBean.authenticate}"/>
                    <e:input type="hidden" id="invalidusernamemsg" value="#{adminLoginBean.invalidusername}"/>
                    <e:input type="hidden" id="invalidpasswordmsg" value="#{adminLoginBean.invalidpassword}"/>
                  </td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
      </table>
    </e:div>
    <%--This div renders the list of roles,OK button and Cancel button--%>
    <e:div id="role" style="bottom:42px;position:fixed;width:100%;top:120px" styleClass="admin_table_body" rendered="#{adminLoginBean.renderRole}" ajax="true">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
          <td width="100%" height="400px" valign="top">
            <div style="padding:20px;vertical-align:top;height:100%;" align="left">
              <table width="300px" border="0" cellspacing="2" cellpadding="0" align="center">
                <tr>
                  <td colspan="2" class="admin_table_header"><br>
                    <H4><h:outputText id="rolerequired" value="#{adminLoginBean.rolerequired}" style="text-align: left;"/></H4>
                  </td>
                </tr>
                <tr class="admin_table_body">
                  <td style="text-align:right;width:30%">
                    <e:span styleClass="required_field_label" value="#{adminLoginBean.roleLabel} "/>&nbsp;
                  </td>
                  <td style="text-align: left;width:70%">
                    <e:select style="width:160px;" id="roleOption" value="#{adminLoginBean.roleSelected}">
                      <f:selectItems value="#{adminLoginBean.roleOptions}"/>
                    </e:select>
                  </td>
                </tr>

                <tr class="admin_table_body">
                  <td valign="top" align="right" style="width: 50%"><br>
                    <e:button id="roleOK" styleClass="btn btn-blue" value="#{adminLoginBean.assignRoleLabel}" onclick="#{adminLoginBean.processRole}" ajax="false" type="submit"/>
                  </td>
                  <td valign="top" align="left" style="width: 50%"><br>
                    <e:button id="roleCancel" styleClass="btn btn-blue" value="#{adminLoginBean.cancelLabel}" onclick="#{adminLoginBean.cancelLogin}" ajax="false" type="submit"/>
                  </td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
      </table>
    </e:div>
    <!-- Footer div -->
    <div class="footer">&nbsp;&nbsp;Copyright &copy; 2019 LabWare, Inc. All rights reserved.</div>
  </e:form>
  </body>

  </html>
</f:view>