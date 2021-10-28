<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://www.simplica.com/jsf/ecruiser" prefix="e" %>

<e:viewInfo template="/admin/top.jsp" roles="WebAdminTest">
  <e:update id="leftMenu" prop="src" value="/admin/WSConn_LeftPane.jsp"/>
  <e:update id="testMenuItem" prop="styleClass" value="top-menu-selected"/>
</e:viewInfo>
<e:define id="mainPane">
<script type="text/javascript" language="JavaScript">
  window.document.title = "LabWare Admin Console--WSConnection Log In";
</script>
<table cellspacing="0" cellpadding="0" width="100%" border="0">
<tr>
    <td align="center">
        <e:div id="WsConnMsgDiv" ajax="true">
            <h:messages infoClass="admin_message" id="WsConnMsg"
                        errorClass="admin_message_error" layout="table" binding="#{messagesBean.messages}"/>
        </e:div>
    </td>
</tr>

<tr>
  <td width="100%" align="center" class="admin_table_header" colspan="2">
    &nbsp;LabWare Web Services Client
  </td>
</tr>

<tr>
  <td class="admin_table_body">&nbsp;</td>
</tr>

<%--<tr>
  <td width="100%" valign="top" align="center">
    <div class="login-text">
      Please log in using a valid LIMS username and password
    </div>
  </td>
</tr>--%>

<tr>
  <td class="admin_table_body">&nbsp;</td>
</tr>
  <%--<h:messages style="font-size: 20px; font-weight: bold; color:#FF0000"/>--%>
<!-- This table is actually the table that contains the login screen-->
<tr>
  <td align="center">
    <table border="0" cellspacing="0" cellpadding="0" width="468">
      <!--This row contains the login-header.jpg-->
      <tr>
        <td width="568" align="center" valign="middle"><img src="images/login-header.jpg" width="568"
                                                            height="24">
        </td>
      </tr>
      <tr>
        <td width="568">
          <!--This table actually contains the LoginForm-->
          <e:table border="0" cellspacing="2" cellpadding="0" bgcolor="#FEC06D" width="568" rendered="#{wsConnLoginBean.renderNonSSOTable}">
            <tr>
              <td width="568" align="center" valign="middle" bgcolor="#FDDBAE" class="login-text">
                <br>
                <br>
                <b>Authentication Required</b><br>
                <div class="login-text">(Please log in using a valid LIMS username and password)</div>
                <br>

                <table border="0" cellspacing="0" cellpadding="4">
                  <tr>
                    <td width="50%" align="right" class="login-text">User Name:</td>
                    <td width="50%">
                      <h:inputText id="username" value="#{wsConnLoginBean.userName}" style="width:155px;" onkeydown="fireOnclickForWSLogin(event);"/>
                    </td>
                  </tr>
                  <tr>
                    <td width="50%" align="right" class="login-text">Password:</td>
                    <td width="50%">
                      <h:inputSecret id="password" value="#{wsConnLoginBean.passWord}" style="width:155px;" onkeydown="fireOnclickForWSLogin(event);"/>
                    </td>
                  </tr>
                  <tr>
                    <td width="50%" align="right" class="login-text">Role:</td>
                    <td width="50%">
                      <h:inputText id="role" value="#{wsConnLoginBean.role}" style="width:155px;" onkeydown="fireOnclickForWSLogin(event);"/>
                    </td>
                  </tr>
                </table>
                <br><br>
                <e:button id="loginButton" ajax="true"
                          onclick="if(validateUserNameAndPasswordForWSLogin(event))#{wsConnLoginBean.connect}"
                          value="Connect"/>&nbsp;&nbsp;
                <e:button id="cancelButton" ajax="true"
                          onclick="#{wsConnLoginBean.cancel}"
                          value="Cancel"/>
              </td>
            </tr>
          </e:table>
          <!-- This means that SSO is enabled so lets first first prompt for selection of datasource and service -->
          <e:table border="0" cellspacing="2" cellpadding="0" bgcolor="#FEC06D" width="568" rendered="#{wsConnLoginBean.renderServicesSelect}">
            <tr>
              <td width="568" align="center" valign="middle" bgcolor="#FDDBAE" class="login-text">
                <br>
                <br>
                <b>Please select a LabWare Datasource and Service</b><br>
                <br>

                <table border="0" cellspacing="0" cellpadding="4">
                  <tr>
                    <td width="50%" align="right" class="login-text">LIMS Datasource:</td>
                    <td width="50%">
                      <e:select id="sso_dss" ajax="true" style="width:155px;" onkeydown="fireOnclickForWSLogin(event);"
                                             value="#{wsConnLoginBean.dataSource}"
                                             data="#{monitorConnections.dataSourceList}"
                                             onchange="#{monitorConnections.refreshServiceList}"/>
                    </td>
                  </tr>
                  <tr>
                    <td width="50%" align="right" class="login-text">LIMS Service:</td>
                    <td width="50%">
                      <e:select id="sso_services" ajax="true" style="width:155px;" onkeydown="fireOnclickForWSLogin(event);"
                                value="#{wsConnLoginBean.service}"
                                data="#{monitorConnections.servicesList}"
                                binding="#{monitorConnections.serviceSelect}"/>
                    </td>
                  </tr>
                </table>
                <br><br>
                <e:button id="sso_sel_ds" ajax="true"
                          onclick="#{wsConnLoginBean.processSelection}"
                          value="Connect"/>
              </td>
            </tr>
          </e:table>
          <!-- the STS details form -->
         <e:table border="0" cellspacing="2" cellpadding="0" bgcolor="#FEC06D" width="568" rendered="#{wsConnLoginBean.STS}">
           <tr>
             <td width="568" align="center" valign="middle" bgcolor="#FDDBAE" class="login-text">
            <br>
            <br>
            <span style="font-weight: 800;font-size: larger">Secure Token Service Login</span><br>
            <span style="font-weight: 400">Please enter your federation server credentials</span><br>
            <br>
            <table border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td width="50%" align="right" class="login-text">User Name:</td>
                <td width="50%">
                  <h:inputText id="sts_username" value="#{wsConnLoginBean.userName}" style="width:155px;" onkeydown="fireOnclickForWSLogin(event);"/>
                </td>
              </tr>
              <tr>
                <td width="50%" align="right" class="login-text">Password:</td>
                <td width="50%">
                  <h:inputSecret id="sts_password" value="#{wsConnLoginBean.passWord}" style="width:155px;" onkeydown="fireOnclickForWSLogin(event);"/>
                </td>
              </tr>
            </table>


            <br><br>
            <e:button id="stsLogin" ajax="true"
                      onclick="#{wsConnLoginBean.stsLogin}"
                      value="STS Login"/>
          </td>
            </tr>
         </e:table>
          <!-- OAuth2 config form --->
          <e:table border="0" cellspacing="2" cellpadding="0" bgcolor="#FEC06D" width="568" rendered="#{wsConnLoginBean.oauth2}">
            <tr>
              <td width="568" align="center" valign="middle" bgcolor="#FDDBAE" class="login-text">
                <br>
                <br>
                <b>LIMS Service <e:label  value="#{wsConnLoginBean.service}" /> Requires OAuth2 Token.<br><br>
                  <a href="#" onclick="openOAuthLogin(event)">Click here</a>
                   to get OAuth2 Token.<br><br><span style="color:#788394">If you already have a valid token,
                    you can paste the token in the input field <br>and click on submit button. </span></b>
                <br>
                <table border="0" cellspacing="0" cellpadding="4">
                  <tr>
                    <td width="50%" align="right" class="login-text">&nbsp;</td>
                    <td width="50%">
                      <h:inputHidden id="oauthurl" value="#{wsConnLoginBean.oauthServerURL}" />
                    </td>
                  </tr>
                  <tr>
                    <td width="50%" align="right" class="login-text" style="font-weight: 800">OAuth2 Token:</td>
                    <td width="50%">
                      <h:inputText id="oauth2_role" value="#{wsConnLoginBean.oauth2Token}" style="width:155px;"/>
                    </td>
                  </tr>
                  <tr>

                  </tr>
                </table>
                <br>
                <e:button id="oauthLogin" ajax="true"
                          onclick="#{wsConnLoginBean.oauth2Login}" value="Submit"/>
                <br/>
              </td>
            </tr>
          </e:table>
          <!-- end of table containing the login form -->
         </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
      </tr>
    </table>
  </td>
</tr>
</table>
<script type="text/javascript">
  function checkFocus() {
    try {
      document.getElementById('limsAdminForm:username').focus();
    }catch(e){}
  }
  if (window.attachEvent) {
    window.attachEvent("onload", checkFocus);
  } else if (window.addEventListener) {
    window.addEventListener("load", checkFocus, false);
  }

  function openOAuthLogin(){
    var url = document.getElementById('limsAdminForm:oauthurl').value;
    window.open(url, 'oauthwin', 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width=700,height=600,top=50,left=50');
  }
</script>
</e:define>