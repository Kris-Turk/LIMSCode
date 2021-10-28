<!DOCTYPE html>
<%--
(C)Copyright 2000-2019 by LabWare, Inc; All rights reserved

This is the main JSP page of Admin Console. It is used by the template mechanism.

@author Avik Chatterjee
--%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://www.simplica.com/jsf/ecruiser" prefix="e" %>

<f:view>
<html>

<head>
  <link id="favicon" rel="shortcut icon" href="../img/LabWare.ico"/>
    <link rel="stylesheet" type="text/css" href="stylesheet/styles.css">
    <link rel="stylesheet" type="text/css" href="stylesheet/datatable.css">
    <link rel="stylesheet" type="text/css" href="common/css/lw-theme/jquery-ui-1.12.1.custom.css">
    <link rel="stylesheet" type="text/css" href="stylesheet/fileuploader.css">
    <link rel="stylesheet" type="text/css" href="stylesheet/iconinput.css">
    <link rel="stylesheet" type="text/css" href="stylesheet/inputs.css">
    <link rel="stylesheet" type="text/css" href="stylesheet/labware_admin.css">

    <script type="text/javascript" src="../js/jquery-2.2.4.min.js"></script>
    <script type="text/javascript" src="../js/jquery-ui-1.8.22.custom.min.js"></script>

    <script language="JavaScript">
    String.prototype.trim = function() {
      var x = this;
      x = x.replace(/^\s*(.*)/, "$1");
      x = x.replace(/(.*?)\s*$/, "$1");
      return x;
    };
    window.confirmDelete = function(msg, evt) {
      var e = (window.event) ? window.event : evt;
      var obj = document.getElementById("limsAdminForm:numOfDs");
      if (obj && obj.value == 1) {
        msg += " This is the last datasource. Authentication will change to local.";
      }
      if (confirm(msg)) {
        return true;
      }
      else {
        ec.bs.stopEvent(e);
        return false;
      }
    };
    window.validatePasswordChange = function (evt) {
      var currPassword = document.getElementById("limsAdminForm:passwdlayout:curr_passwd");
      var newPassword = document.getElementById("limsAdminForm:passwdlayout:new_passwd");
      var confPassword = document.getElementById("limsAdminForm:passwdlayout:conf_passwd");
      var e = (window.event) ? window.event : evt;

      if (currPassword != null) {
        if (currPassword.value.trim() == "") {
          alert("Please Enter the Current Password");
          currPassword.style.backgroundColor = "red";
          newPassword.style.backgroundColor = "";
          confPassword.style.backgroundColor = "";
          currPassword.focus();
          ec.bs.stopEvent(e);
          return false;
        }
      }
      if (newPassword != null) {
        if (newPassword.value.trim() == "") {
          alert("Please Enter the New Password");
          currPassword.style.backgroundColor = "";
          newPassword.style.backgroundColor = "red";
          confPassword.style.backgroundColor = "";
          newPassword.focus();
          ec.bs.stopEvent(e);
          return false;
        }
      }
      if (confPassword != null) {
        if (confPassword.value.trim() == "") {
          alert("Please Enter the Confirm Password");
          currPassword.style.backgroundColor = "";
          newPassword.style.backgroundColor = "";
          confPassword.style.backgroundColor = "red";
          confPassword.focus();
          ec.bs.stopEvent(e);
          return false;
        }
      }
      if (newPassword.value != confPassword.value) {
        alert("Can not confirm the new password or it is invalid - try again");
        ec.bs.stopEvent(e);
        return false;
      }
      return true;
    };

    window.validateUserNameAndPasswordForWSLogin = function(evt) {
      var userName = document.getElementById("limsAdminForm:username");
      var password = document.getElementById("limsAdminForm:password");
      var e = (window.event) ? window.event : evt;
      if (userName.value.trim() == "") {
        alert("Please enter the User Name. User Name can't be blank.");
        userName.style.backgroundColor = "red";
        password.style.backgroundColor = "";
        userName.focus();
        ec.bs.stopEvent(e);
        return false;
      }
      else if (password.value.trim() == "") {
        alert("Please enter the Password. Password can't be blank.");
        userName.style.backgroundColor = "";
        password.style.backgroundColor = "red";
        password.focus();
        ec.bs.stopEvent(e);
        return false;
      } else {
        return true;
      }
    };

    function fireOnclickForWSLogin(evt) {
      var connectButton = document.getElementById("limsAdminForm:loginButton");
      var e = (window.event) ? window.event : evt;
      if (e.keyCode == 13) {
        connectButton.click();
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

    function showWSDL(URL) {
      window.open(URL, 'wsdlwin', 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width=700,height=600,top=50,left=50');
    }
  </script>

</head>

<body bgcolor="#FFFFFF" style="margin: 0" onclick="checkForSessionTimeout();"
      onkeydown="checkForSessionTimeout();" onload="setSessionTimeout();">
<e:form id="limsAdminForm">
  <!-- Header table -->
  <div id="header_top" style="height: 105px;width: 100%">
    <table cellpadding="0" cellspacing="0">
      <tr class="header_row" >
        <td ><div id="logo"></div></td>
        <td id="header_version">
          LabWare Admin Console
          <table width="100%">
            <tr>
              <td class="admin_header_warInfo" valign="middle">War Version: <e:span id="war_version"
                                                                                    value="#{warUpdatorBean.version}"/>
                <%--(Installed On: <e:span id="war_instDt"
                                       value="#{warUpdatorBean.installDate}"/>)--%>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td colspan="2">
          <e:table cellspacing="0" cellpadding="0" height="100%" width="100%">
            <e:tr>
              <e:td styleClass="top-menu" width="250px">&nbsp;</e:td>
              <e:td styleClass="top-menu" rendered="#{ecLoginManager.renderMonitorMenu}">
                <e:div width="90px" id="monitorMenuItem" ajax="true"><e:a onclick="/admin/MonitorLIMSInstance.jsp"
                                                                          styleClass="nav-link" ajax="true"
                                                                          value="Monitor"/></e:div>
              </e:td>
              <e:td styleClass="top-menu" rendered="#{ecLoginManager.renderSetupMenu}">
                <e:div width="90px" id="setupMenuItem" ajax="true"><e:a onclick="/admin/SysConf.jsp"
                                                                        styleClass="nav-link"
                                                                        ajax="true" value="Setup"/></e:div>
              </e:td>
              <e:td styleClass="top-menu" rendered="#{ecLoginManager.renderTestMenu}">
                <e:div width="190px" styleClass="align-center" id="testMenuItem" ajax="true">
                  <e:a onclick="#{wsConnLoginBean.returnWSTestURL}" styleClass="nav-link" ajax="false"
                       value="Test Web Services"/>
                </e:div>
              </e:td>
              <e:td styleClass="top-menu" width="250px">&nbsp;</e:td>
            </e:tr>
          </e:table>
        </td>
      </tr>
    </table>
  </div>
  <!-- Main Div -->
  <div id="mainTable_top" style="bottom:42px;position:fixed;width:100%;top:105px;overflow:hidden;"
       class="admin_table_body">
    <div id="sub_menu"
         style="width: 200px;top:105px;position:fixed;height: 100%;float: left;background-color: #639BCE;vertical-align: top">
      <br> <e:include id="leftMenu"/>
      <e:window id="changePasswd" title="Change Admin Console Password"
                width="500px" height="250px" top="10px" left="200px" align="center"
                movable="true" resizable="true" modal="true" closeOnEscape="true"
                onclose="#{adminLoginBean.resetPwd}"
                showClose="false" showMaximize="false" showMinimize="false" ajax="true">
        <e:fieldLayout id="passwdlayout" columns="1" labelStyle="required_field_label_right"
                       heading="Change Password" headingStyle="password_heading" showMessages="false"
                       align="center">
          <e:span id="myAlertMsg" styleClass="password_message" rendered="true"
                  value="#{adminLoginBean.passwdMsg}"
                  label=""/>
          <e:input type="password" size="15" id="curr_passwd" label="Current Password:"
                   value="#{adminLoginBean.currentPwd}"/>
          <e:input type="password" size="15" id="new_passwd" label="New Password:"
                   value="#{adminLoginBean.newPwd}"/>
          <e:input type="password" size="15" id="conf_passwd" label="Confirm Password:"
                   value="#{adminLoginBean.confPwd}"/>
        </e:fieldLayout>
        <e:fieldLayout columns="2" ajax="true" showMessages="false" align="center" idsForLabels="false">
          <e:button value="Save" onclick="if(validatePasswordChange(event))#{adminLoginBean.changePassword}"
                    ajax="true"
                    id="passwd_change"/>
          <e:button value="Cancel" type="reset" ajax="true" immediateEvent="true"
                    onclick="#{adminLoginBean.closePwdWin}"/>
        </e:fieldLayout>
      </e:window>

      <div style="vertical-align:middle;width:200px;padding:5px;margin-top:30px;text-align: left">
<%--        <e:div style="cursor:pointer;" popupComponent="changePasswd">
          <img src="images/logout-icon.gif" border="0" width="22" height="22" align="middle"
               alt="Change Password">&nbsp;<e:a
              styleClass="menu-link">Change Password</e:a>
        </e:div>--%>
      </div>

      <div style="vertical-align:middle;width:200px;padding:5px;text-align: left">
        <img src="images/help-icon.gif" border="0" width="22" height="22" align="middle" alt="Logout">&nbsp;
        <e:a onclick="#{adminLoginBean.adminlogOut}" styleClass="menu-link" ajax="false"
             immediateEvent="true">Logout</e:a>
      </div>
    </div>
    <div id="mainpane" style="overflow-y: auto;height: 100%;margin-left: 200px">
      <e:input type="hidden" id="uniqueID" value="#{guidGeneratorBean.uniqueGUID}"/>
      <e:insert id="mainPane"/>
      <e:input type="hidden" id="timeoutMins" value="#{adminLoginBean.sessionTimeoutMins}" ajax="true"/>
      <e:input type="hidden" id="expMsg" value="#{adminLoginBean.sessionExpMsg}"/>
    </div>
  </div>
  <!-- Footer Div-->
  <div class="footer">&nbsp;&nbsp;Copyright &copy; 2019 LabWare, Inc. All rights reserved.</div>
</e:form>
<script type="text/javascript">


  var sessionExpMsg = document.getElementById("limsAdminForm:expMsg").value;
  var sessionTimerId = 0;
  function checkForSessionTimeout() {
    clearTimeout(sessionTimerId);
    setSessionTimeout();
  }

  function setSessionTimeout() {
    var sessionTimeoutMins = document.getElementById("limsAdminForm:timeoutMins").value;
    if (sessionTimeoutMins != null) {
      var timeoutValue = ((sessionTimeoutMins * 60) + 10) * 1000;
      sessionTimerId = setTimeout("redirectToLogin()", timeoutValue);
    }
  }
  function redirectToLogin() {
    alert(sessionExpMsg);
    self.location.href = "login.htm";
  }

</script>
</body>

</html>
</f:view>