<%--
(C)Copyright 2000-2015 by LabWare, Inc; All rights reserved

This page is to configure WebLIMS system.

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
  <script language="JavaScript" type="text/javascript">
    window.document.title = "LabWare Admin Console--Setup System Configuration";
  </script>
  <table id="instTable" border="0" cellpadding="5" align="center" cellspacing="0" width="40%">
    <tr>
      <td width="100%" valign="top" align="center" class="admin_table_header_ds" colspan="2">
        <e:div id="sysMsgDiv">
          <h:messages styleClass="admin_message" id="sysMsg" showDetail="true" showSummary="false"
                      layout="table" binding="#{messagesBean.messages}"/>
        </e:div>
      </td>
    </tr>
    <tr>
      <td width="100%" align="center" class="admin_table_header" colspan="2">
        LIMS System Configuration
      </td>
    </tr>
    <tr>
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
      <td align="center" class="admin_table_body">
        <fieldset>
          <legend class="required_field_label">System</legend>
          <table cellpadding="2" cellspacing="0" border="0" width="100%" align="center">
            <tr>
              <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">
                Session
                Timeout
                (mins):
              </td>
              <td align="left">
                <e:numberinput id="sessionInput" value="#{limsAdminBean.sessionTimeout}" maxlength="4"
                               style="width:61px;"
                               pattern="####" minimum="1" maximum="9999" ajax="true"
                               spinButtons="false"/>
              </td>

            </tr>
            </tr>
            <tr>
              <td colspan="2" class="admin_table_body" width="100%">&nbsp;</td>
            </tr>
            <tr>
              <td colspan="2" align="center" class="admin_table_body">
                &nbsp;
                <e:button id="changeSessionTimeout" ajax="true" value="Save System Configuration"
                          onclick="#{limsAdminBean.changeConnectorTimeouts}"/>
              </td>
            </tr>
          </table>
        </fieldset>
      </td>
    </tr>
    <tr>
      <td align="center" class="admin_table_body">
        <fieldset>
          <legend class="required_field_label">Web services</legend>
          <table cellpadding="2" cellspacing="0" border="0" width="100%" align="left"
                 class="admin_metrics_items">
            <tr>
              <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">Test
                Web Services URL:

              </td>
              <td align="left">
                <e:input size="40" id="baseurl" value="#{limsAdminBean.wsUrl}" ajax="true"/>
              </td>
            </tr>
            <tr>
              <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">WS
                Security:
              </td>
              <td align="left">
                <e:checkbox value="#{limsAdminBean.wsSecurity}" ajax="true"/>
              </td>
            </tr>
             <%--<tr>
              <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">RESTful:
              </td>
              <td align="left">
                <e:checkbox value="#{limsAdminBean.restfulWebService}" ajax="true"/>
              </td>
            </tr>--%>
            <tr>
              <td colspan="3">&nbsp</td>
            </tr>
            <tr>
              <td colspan="3" align="center">
                <e:button id="saveURL" ajax="true" value="Save Web services Configuration"
                          onclick="#{limsAdminBean.saveWSUrl}"/>
              </td>
            </tr>
          </table>
        </fieldset>
      </td>
    </tr>
    <tr>
      <td align="center" class="admin_table_body">
        <fieldset>
          <legend class="required_field_label">Enable Access</legend>
          <table cellpadding="2" cellspacing="0" border="0" width="100%" align="left"
                 class="admin_metrics_items">
            <tr>
              <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">PDF
                Submit:
              </td>
              <td align="left">
                <e:checkbox value="#{limsAdminBean.pdfSubmit}" ajax="true"/>
              </td>
            </tr>
            <tr>
              <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">Call
                web service:
              </td>
              <td align="left">
                <e:checkbox value="#{limsAdminBean.callWebService}" ajax="true"/>
              </td>
            </tr>
            <tr>
              <td colspan="3">&nbsp</td>
            </tr>
            <tr>
              <td colspan="3" align="center">
                <e:button id="saveSecCon" ajax="true" value="Save Access Configuration"
                          onclick="#{limsAdminBean.saveAccessConstraints}"/>
              </td>
            </tr>
          </table>
        </fieldset>
      </td>
    </tr>
    <!--LE870CS: SAML NameId Configuration --->
    <tr>
      <td align="center" class="admin_table_body">
        <fieldset>
          <legend class="required_field_label">Single Sign On</legend>
          <table cellpadding="2" cellspacing="0" border="0" width="100%" align="left"
                 class="admin_metrics_items">
            <tr>
              <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">SAML Issuer Id</td>
              <td align="left">
                <e:input size="40" id="samlIssuerId" value="#{limsAdminBean.samlIssuerId}" ajax="true"/>
              </td>
            </tr>
            <tr>
              <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">SAML Binding</td>
              <td align="left">
                <h:selectOneMenu id="saml_bind" value="#{limsAdminBean.samlBinding}">
                  <f:selectItem itemLabel="REDIRECT" itemValue="REDIRECT"/>
                  <f:selectItem itemLabel="POST" itemValue="POST"/>
                </h:selectOneMenu>
              </td>
            </tr>
            <tr>
              <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">SAML Name Id Type</td>
              <td align="left">
                <h:selectOneMenu id="nameId" value="#{limsAdminBean.nameId}">
                  <f:selectItem itemLabel="EMAIL" itemValue="EMAIL"/>
                  <f:selectItem itemLabel="UNSPECIFIED" itemValue="UNSPECIFIED"/>
                  <%-- <f:selectItem itemLabel="X509_SUBJECT" itemValue="X509_SUBJECT"/>
                   <f:selectItem itemLabel="WIN_DOMAIN_QUALIFIED" itemValue="WIN_DOMAIN_QUALIFIED"/>
                   <f:selectItem itemLabel="KERBEROS" itemValue="KERBEROS"/>
                   <f:selectItem itemLabel="PERSISTENT" itemValue="PERSISTENT"/>--%>
                  <%--<f:selectItem itemLabel="ENTITY" itemValue="ENTITY"/>--%>
                  <%--<f:selectItem itemLabel="TRANSIENT" itemValue="TRANSIENT"/>--%>
                  <%--<f:selectItem itemLabel="ENCRYPTED" itemValue="ENCRYPTED"/>--%>
                </h:selectOneMenu>
              </td>
            </tr>
            <tr>
              <td colspan="3" align="center">
                <e:button id="saveSSOConfig" ajax="true" value="Save SSO Config"
                          onclick="#{limsAdminBean.saveSSOConfiguration}"/>
              </td>
            </tr>
          </table>
        </fieldset>
      </td>
    </tr>
    <tr>
      <td align="center" class="admin_table_body">
        <table cellpadding="2" cellspacing="0" border="0" width="100%" align="center">
          <tr>
            <td colspan="3">&nbsp</td>
          </tr>
          <tr>
            <td colspan="3">&nbsp</td>
          </tr>
          <tr>
            <td colspan="3">&nbsp</td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</e:define>