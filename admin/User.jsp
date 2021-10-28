<%--
(C)Copyright 2000-2015 by LabWare, Inc; All rights reserved

This page is to configure WebLIMS Admin Console user.

@author Avik Chatterjee
--%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://www.simplica.com/jsf/ecruiser" prefix="e" %>

<%--<e:viewInfo template="/admin/top.jsp" roles="WebAdminSetup">--%>
<e:viewInfo template="/admin/top.jsp" roles="">
  <e:update id="setupMenuItem" prop="styleClass" value="top-menu-selected"/>
  <e:update id="leftMenu" prop="src" value="/admin/SetUp_LeftPane.jsp"/>
</e:viewInfo>

<e:define id="mainPane">
<script type="text/javascript" language="JavaScript">
  window.document.title = "LabWare Admin Console--Setup User";
  window.saveUserValidate = function (evt) {
    var e = (window.event) ? window.event : evt;
    var paaswdFld = document.getElementById("limsAdminForm:userLayout:adminPassword");
    var confPaaswdFld = document.getElementById("limsAdminForm:userLayout:adminConfPassword");
    var userNane = document.getElementById("limsAdminForm:userLayout:adminUser");
    if (userNane.value.trim() == "") {
      alert("Please enter user name. User name can't be blank.");
      paaswdFld.style.backgroundColor = "";
      userNane.style.backgroundColor = "red";
      userNane.focus();
      ec.bs.stopEvent(e);
      return false;
    }
    if (paaswdFld != null) {
      if (paaswdFld.value.trim() == "" && paaswdFld.style.display != "none") {
        alert("Please enter password. Password can't be blank.");
        paaswdFld.style.backgroundColor = "red";
        userNane.style.backgroundColor = "";
        paaswdFld.focus();
        ec.bs.stopEvent(e);
        return false;
      }
    }
    if (confPaaswdFld != null) {
      if (confPaaswdFld.style.display != "none") {
        if (confPaaswdFld.value.trim() == "") {
          alert("Please enter confirm password. Confirm password can't be blank.");
          confPaaswdFld.style.backgroundColor = "red";
          paaswdFld.style.backgroundColor = "";
          confPaaswdFld.focus();
          ec.bs.stopEvent(e);
          return false;
        } else if (paaswdFld.value != confPaaswdFld.value) {
          alert("Can not confirm the password or it is invalid - try again.");
          ec.bs.stopEvent(e);
          return false;
        }
      }
    }

    return true;
  }
  window.validatePasswordChangeForUser = function (evt) {
    var currPassword = document.getElementById("limsAdminForm:userPasswdlayout:curr_passwd");
    var newPassword = document.getElementById("limsAdminForm:userPasswdlayout:new_passwd");
    var confPassword = document.getElementById("limsAdminForm:userPasswdlayout:conf_passwd");
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
  }

</script>

<table cellpadding="5" width="100%" class="admin_table_body" cellspacing="0" border="0">
  <tr>
    <td width="100%" valign="top" align="center" class="admin_table_header_ds" colspan="2">
      <e:div id="userMsgDiv">
        <h:messages styleClass="admin_message" id="userMsg" showDetail="true" showSummary="false"
                    layout="table" binding="#{messagesBean.messages}"/>
      </e:div>
    </td>
  </tr>
  <tr>
    <td width="100%" align="center" class="admin_table_header">
      Admin Console User Configuration
    </td>
  </tr>
  <!-- adding the authentication mode  checkbox -->
  <tr>
    <td colspan="4">
      <fieldset style="margin:auto;width: 50%">
        <legend class="required_field_label">Authentication Mode</legend>
        <table align="center">
          <tr>
            <td align="right" class="admin_table_body_noalign" colspan="2" width="40%">
              <span class="required_field_label">LIMS Authentication</span>
            </td>
            <td align="left" colspan="2" class="admin_table_body_noalign" width="60%">
              <e:checkbox id="limsAuthentication" title="LIMS Authentication"
                          value="#{limsAdminUserBean.limsAuthentication}" disabled="#{limsAdminUserBean.dsListEmpty}"
                          onchange="#{limsAdminUserBean.saveLIMSAuthentication}" label="LIMS Authentication"
                          ajax="true"/>&nbsp;&nbsp;
            </td>
          </tr>
        </table>
      </fieldset>
    </td>
  </tr>

  <tr>
    <td width="100%" align="center" class="admin_table_header">
      &nbsp;
    </td>
  </tr>
  <tr>
    <td align="center" class="admin_table_body">
      <fieldset style="margin:auto;width: 70%">
        <legend class="required_field_label">Local Users Setup</legend>
        <table cellpadding="5" width="50%" class="admin_table_body" cellspacing="0" border="0" align="center">
          <tr>
            <td colspan="4">
              <e:fieldLayout id="userLayout" columns="5" disabledStyle="required_field_label"
                             labelStyle="required_field_label" showMessages="false" border="0" align="center">
                <e:input size="15" id="adminUser" value="#{limsAdminUserBean.userName}" label="User Name:" ajax="true"
                         readonly="#{!limsAdminUserBean.renderedPasswd}"/>
                <e:input type="password" size="15" id="adminPassword" value="#{limsAdminUserBean.password}"
                         rendered="#{limsAdminUserBean.renderedPasswd}" label="Password:"/>
                <e:input type="password" size="15" id="adminConfPassword" value="#{limsAdminUserBean.password}"
                         rendered="#{limsAdminUserBean.renderedPasswd}" label="Confirm Password:"/>
              </e:fieldLayout>

            </td>
          </tr>
          <tr>
            <td colspan="4">
              <table align="center">
                <tr>
                  <td align="right" class="admin_table_body_noalign" colspan="2" width="15%">
                    <span class="required_field_label">Roles:</span>
                  </td>
                  <td align="left" colspan="2" class="admin_table_body_noalign" width="60%">
                    <span class="admin_table_body">WebAdminSetup</span>
                    <e:checkbox id="setupRole" title="Setup" value="#{limsAdminUserBean.setupValue}"
                                label="Setup" ajax="true"/> &nbsp;&nbsp;
                    <span class="admin_table_body">WebAdminMonitor</span>
                    <e:checkbox id="monitorRole" title="Monitor" value="#{limsAdminUserBean.monitorValue}"
                                label="Monitor" ajax="true"/> &nbsp;&nbsp;
                    <span class="admin_table_body">WebAdminTest</span>
                    <e:checkbox id="testRole" title="Test" value="#{limsAdminUserBean.testValue}"
                                label="Test" ajax="true"/>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td align="center" class="admin_table_body" colspan="4">
              <e:button id="saveUser" value="Save"
                        onclick="if(saveUserValidate(event))#{limsAdminUserBean.saveUser}" ajax="true"/>
              <e:button id="newUser" type="reset" value="New" ajax="false" onclick="#{limsAdminUserBean.newUser}"/>
            </td>
          </tr>
          <tr>
            <td class="admin_table_body" colspan="4">&nbsp;</td>
          </tr>
          <tr>
            <td align="center" class="admin_table_body" colspan="4">

              <table class="dataTableTop" cellpadding="0" cellspacing="0" width="700px" align="center">
                <tr>
                  <td width="100%" class="dataTableTitle"
                      style="background-image:url(images/datatable-top-middle.gif)">LIMS Users
                  </td>
                </tr>
              </table>
              <e:window id="changeUserPasswd" title="Change Admin Console Password"
                        width="500px" height="250px" top="300px" left="100px" align="center" ajaxLoading="true"
                        movable="true" resizable="true" modal="true" closeOnEscape="true" showClose="false"
                        showMaximize="false"
                        showMinimize="false" onclose="#{limsAdminUserBean.resetWindow}">
                <e:fieldLayout id="userPasswdlayout" columns="1" labelStyle="required_field_label_right"
                               heading="Change Password for User '#{limsAdminUserBean.showUserName}'"
                               headingStyle="password_heading" showMessages="false" align="center" ajax="true">
                  <e:span id="myAlertMsg" styleClass="password_message" rendered="true" label="" ajax="true"
                          value="#{limsAdminUserBean.passwordMsg}"/>
                  <e:input type="password" size="15" id="new_passwd" label="New Password:"
                           value="#{limsAdminUserBean.newPasswd}"/>
                  <e:input type="password" size="15" id="conf_passwd" label="Confirm Password:"
                           value="#{limsAdminUserBean.confPasswd}"/>
                </e:fieldLayout>
                <e:fieldLayout columns="2" showMessages="false" align="center">
                  <e:button value="Save" ajax="false"
                            id="passwd_change" label=""
                            onclick="if(validatePasswordChangeForUser(event))#{limsAdminUserBean.changePassword}"/>
                  <e:button value="Cancel" id="passwd_cancel" label="" type="reset" ajax="true"
                            onclick="#{limsAdminUserBean.closePwdWin}"
                            immediateEvent="true"/>
                </e:fieldLayout>
              </e:window>

              <e:datatable
                    id="limsUserTable"
                    border="0"
                    dataModel="#{limsAdminUserBean.ecDM}"
                    binding="#{limsAdminUserBean.adminUserDataTable}"
                    title="LIMS Users"
                    innerCellspacing="1"
                    innerCellpadding="4"
                    cellspacing="0"
                    cellpadding="0"
                    minRows="3"
                    sortImageColor="white"
                    bgcolor="#cccccc"
                    scrolling="none"
                    columnSorting="true"
                    pageSize="-1"
                    headerHeight="19px"
                    width="700px"
                    showTop="false"
                    showHeader="true"
                    align="center"
                    ajax="true">
                <e:dataTr>
                  <e:dataTd id="name" label="User Name" align="center" title="#{ROW.name}" width="100"/>
                  <e:dataTd id="role" label="Role(s)" align="center" title="#{ROW.role}" width="250"/>
                  <e:dataTd id="lock" nowrap="true" label="Is Locked?" align="center"
                            headerStyle="width:45px;white-space:normal;height:40px;text-overflow:ellipsis;">
                    <e:checkbox id="chkLocked" value="#{ROW.lock}" ajax="true"
                                onchange="#{limsAdminUserBean.saveLockUser}"/>
                  </e:dataTd>
                  <e:dataTd id="selectCol" label="&nbsp;" align="center" width="70"
                            sortable="false">
                    <e:a value="Change Roles" styleClass="underline_link" onclick="#{limsAdminUserBean.selectUser}"
                         ajax="true"/>
                  </e:dataTd>
                  <e:dataTd id="deleteCol" label="&nbsp;" align="center" width="70"
                            sortable="false">
                    <e:a value="Delete" styleClass="underline_link"
                         onclick="if (confirmDelete('Do you really want to delete this user?',event))#{limsAdminUserBean.deleteUser}"
                         ajax="true"/>
                  </e:dataTd>
                  <e:dataTd id="passwordCol" label="&nbsp;" align="center" width="90" sortable="false">
                    <e:a value="Reset Password" styleClass="underline_link"
                         popupComponent="changeUserPasswd"
                         onclick="#{limsAdminUserBean.changePasswordForUser}"
                         ajax="true"/>
                  </e:dataTd>
                </e:dataTr>
              </e:datatable>
            </td>
          </tr>
        </table>
      </fieldset>
    </td>
  </tr>
  <h:outputText escape="false" value="#{limsAdminUserBean.openAlert}"/>
</table>
</e:define>