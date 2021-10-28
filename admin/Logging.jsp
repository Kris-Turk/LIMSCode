<%--
(C)Copyright 2000-2018 by LabWare, Inc; All rights reserved

This page is to configure log file and configure SOAP logging.

@author Avik Chatterjee
--%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://www.simplica.com/jsf/ecruiser" prefix="e" %>

<%--<e:viewInfo template="/admin/top.jsp" roles="">--%>
<e:viewInfo template="/admin/top.jsp" roles="WebAdminSetup">
  <e:update id="setupMenuItem" prop="styleClass" value="top-menu-selected"/>
  <e:update id="leftMenu" prop="src" value="/admin/SetUp_LeftPane.jsp"/>
</e:viewInfo>

<e:define id="mainPane">
<script language="JavaScript" type="text/javascript">
  window.document.title = "LabWare Admin Console--Setup Log File";

  window.saveLogFileValidate = function(evt) {
    var e = (window.event) ? window.event : evt;
    if (document.getElementById("limsAdminForm:logFilePath").value.trim() == "") {
      alert("Please enter File Path. File Path can't be blank");
      document.getElementById("limsAdminForm:logFilePath").style.backgroundColor = "red";
      ec.bs.stopEvent(e);
      return false;
    } else {
      return true;
    }
  }
</script>

<table cellpadding="2" width="100%" class="admin_table_body" cellspacing="0" border="0">
  <tr>
    <td width="100%" valign="top" align="center" class="admin_table_header_ds" colspan="2">
      <e:div id="loggingMsgDiv">
        <h:messages styleClass="admin_message" id="loggingMsg" showDetail="true" showSummary="false"
                    layout="table" binding="#{messagesBean.messages}"/>
      </e:div>
    </td>
  </tr>
  <tr>
    <td width="100%" align="center" class="admin_table_header" colspan="2">Configure Server Logs</td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" width="100%" align="center">
      <table cellpadding="2" width="100%" class="admin_table_body" cellspacing="0" border="0">
        <tr>
          <td class="admin_table_body_noalign" style="padding-top:6px;" align="right" width="35%">
            <e:span styleClass="required_field_label" value="File Directory:"/>
          </td>
          <td class="admin_table_body_noalign" align="left" width="65%">
            <e:input size="60" id="logFilePath" value="#{loggingBean.logFilePath}"
                     label="File Path" disabled="#{loggingBean.suppressLog}"/>
          </td>
        </tr>
        <tr>
          <td class="admin_table_body_noalign" style="padding-top:6px;" align="right" width="35%">
            <e:span styleClass="required_field_label" value="Debug Log Level:"/>
          </td>
          <td class="admin_table_body_noalign" align="left" width="65%">
            <h:selectOneMenu id="level" value="#{loggingBean.logLevel}" disabled="#{loggingBean.suppressLog}">
              <f:selectItem itemLabel="All" itemValue="ALL"/>
              <f:selectItem itemLabel="Debug" itemValue="DEBUG"/>
              <f:selectItem itemLabel="Info" itemValue="INFO"/>
              <f:selectItem itemLabel="Warn" itemValue="WARN"/>
              <%--<f:selectItem itemLabel="Error" itemValue="ERROR"/>
              <f:selectItem itemLabel="Fatal" itemValue="FATAL"/>--%>
              <f:selectItem itemLabel="Off" itemValue="OFF"/>
            </h:selectOneMenu>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td align="center" class="admin_table_body" width="100%" colspan="2">

      <e:button id="fileSave" value="Save"
                onclick="if(saveLogFileValidate(event))#{loggingBean.saveLogAppender}" ajax="true" disabled="#{loggingBean.suppressLog}"/>

    </td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td width="100%" align="center" class="admin_table_header" colspan="2">Configure SOAP Logging</td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td class="admin_table_body_noalign" style="padding-top:6px;" align="right" width="35%">
      <e:span styleClass="required_field_label" value="SOAP Logging enabled:"/>
    </td>
    <td class="admin_table_body_noalign" align="left" width="65%">
      <e:checkbox id="soapEnabled" value="#{loggingBean.soapEnabledVal}" label="SOAP Logging enabled:"/>
    </td>
  </tr>
  <tr>
    <td class="admin_table_body_noalign" style="padding-top:6px;" align="right" width="35%">
      <e:span styleClass="required_field_label" value="SOAP Logging Path:"/>
    </td>
    <td class="admin_table_body_noalign" align="left" width="65%">
      <e:input size="60" id="soapLogPath" value="#{loggingBean.soapLogPath}" label="SOAP Logging Path:"/>
    </td>
  </tr>
  <tr>
    <td class="admin_table_body_noalign" style="padding-top:6px;" align="right" width="35%">
      <e:span styleClass="required_field_label" value="SOAP file limit:"/>
    </td>
    <td class="admin_table_body_noalign" align="left" width="65%">
      <e:numberinput style="width:85px;" minimum="0" maximum="999999" pattern="######" id="soapLogFileMax"
                     value="#{loggingBean.soapFileThreshold}" spinButtons="false" label="SOAP file limit:"/>
    </td>
  </tr>
  <tr>
    <td align="center" class="admin_table_body" width="100%" colspan="2">
      <e:button id="soapFileSave" onclick="#{loggingBean.saveSoapLogging}" value="Save" ajax="true"/>
    </td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>

</table>
</e:define>

