<%--
(C)Copyright 2000-2015 by LabWare, Inc; All rights reserved

This page shows the configured LIMS instances and allows to add,edit and delete them.

@author Avik Chatterjee
--%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://www.simplica.com/jsf/ecruiser" prefix="e" %>

<e:viewInfo template="/admin/top.jsp" roles="WebAdminSetup">
  <e:update id="setupMenuItem" prop="styleClass" value="top-menu-selected"/>
  <e:update id="leftMenu" prop="src" value="/admin/SetUp_LeftPane.jsp"/>
</e:viewInfo>

<e:define id="mainPane">
<script language="JavaScript" type="text/javascript">
  window.document.title = "LabWare Admin Console--Setup LIMS Instances";

  function saveInstanceValidate(evt) {

    var instanceObj = document.getElementById("limsAdminForm:limsInstance");
    var ipAddrObj = document.getElementById("limsAdminForm:ipAddress");
    var portObj = document.getElementById("limsAdminForm:port");
    var serviceObj = document.getElementById("limsAdminForm:serviceSelect");
    var e = (window.event) ? window.event : evt;
    if (instanceObj.value.trim() == "") {
      alert("Please Enter the Name. LIMSInstance Name can't be blank.");
      instanceObj.style.backgroundColor = "red";
      ipAddrObj.style.backgroundColor = "";
      serviceObj.style.backgroundColor = "";
      portObj.style.backgroundColor = "";
      instanceObj.focus();
      ec.bs.stopEvent(e);
      return false;
    }
    else if (ipAddrObj.value.trim() == "") {
      alert("Please Enter the IP Address. IP Address can't be blank.");
      instanceObj.style.backgroundColor = "";
      ipAddrObj.style.backgroundColor = "red";
      serviceObj.style.backgroundColor = "";
      portObj.style.backgroundColor = "";
      ipAddrObj.focus();
      ec.bs.stopEvent(e);
      return false;
    }
    else if (serviceObj.value.trim() == "") {
      alert("Please Enter Service. Service can't be blank.");
      instanceObj.style.backgroundColor = "";
      ipAddrObj.style.backgroundColor = "";
      serviceObj.style.backgroundColor = "red";
      portObj.style.backgroundColor = "";
      serviceObj.focus();
      ec.bs.stopEvent(e);
      return false;
    }
    else if (portObj.value.trim() == "") {
      alert("Please Enter the Server Port. Server Port can't be blank.");
      instanceObj.style.backgroundColor = "";
      ipAddrObj.style.backgroundColor = "";
      serviceObj.style.backgroundColor = "";
      portObj.style.backgroundColor = "red";
      portObj.focus();
      ec.bs.stopEvent(e);
      return false;
    }
    else if (!isNumber(portObj.value) || portObj.value.length != 4) {
      alert("The field must contain a number of the format ####. Please try again.");
      portObj.select();
      ec.bs.stopEvent(e);
      return false;
    }
    else {
      return true;
    }
  }

  function isNumber(val) {
    if (isNaN(val)) {
      return false;
    }
    else {
      return true;
    }
  }
</script>

<table cellpadding="5" width="100%" class="admin_table_body" cellspacing="0" border="0">
<tr>
  <td width="100%" valign="top" align="center" class="admin_table_header_ds" colspan="2">
    <e:div id="monitorMsgDiv">
      <h:messages styleClass="admin_message" id="monitorMsg" showDetail="true" showSummary="false"
                  layout="table" binding="#{messagesBean.messages}"/>
    </e:div>
  </td>
</tr>
<tr>
  <td width="100%" align="center" class="admin_table_header">
    LIMS Instance Configuration
  </td>
</tr>
<tr>
  <td align="center">
    <table cellpadding="2" width="50%" class="admin_table_body" cellspacing="0" border="0" align="center">
      <tr>
        <td align="right">
          <span class="required_field_label">Name:</span>
        </td>
        <td align="left">
          <e:input size="25" id="limsInstance" value="#{limsInstanceBean.instanceName}" ajax="true"/>

        </td>
        <td align="right">
          <span class="required_field_label">IP Address:</span>
        </td>
        <td align="left">
          <e:input size="25" id="ipAddress" value="#{limsInstanceBean.ipAddress}" ajax="true"/>

        </td>
      </tr>
      <tr>
        <td align="right">
          <span class="required_field_label">Service:</span>
        </td>
        <td align="left">
          <e:select id="serviceSelect" value="#{limsInstanceBean.serviceVal}" data="#{limsInstanceBean.serviceList}"
                    ajax="true"/>

        </td>
        <td align="right">
          <span class="required_field_label">Server Port:</span>
        </td>
        <td align="left">
          <e:input maxlength="7" size="7" id="port" value="#{limsInstanceBean.portNum}" ajax="true"/>

        </td>
      </tr>
      <tr>
        <td colspan="4">&nbsp;</td>
      </tr>
      <tr>
        <td align="center" colspan="4">

          <e:button id="saveInstance" value="Save"
                    onclick="if(saveInstanceValidate(event))#{limsInstanceBean.saveInstance}" ajax="true"/>


        </td>
      </tr>
    </table>

  </td>
</tr>
<tr>
  <td align="center">

    <table class="dataTableTop" cellpadding="0" cellspacing="0" width="600px" align="center">
      <tr>
        <td width="1%"><img src="images/datatable-top-left.gif" alt="" height="24" width="15"></td>
        <td width="98%" class="dataTableTitle" style="background-image:url(images/datatable-top-middle.gif)">LIMS
          Instances
        </td>
        <td width="1%"><img src="images/datatable-top-right.gif" alt="" height="24" width="15"></td>
      </tr>
    </table>
    <e:datatable
            id="limsInstanceTable"
            border="0"
            dataModel="#{limsInstanceBean.limsInstanceDataModel}"
            title="LIMS Instances"
            innerCellspacing="1"
            innerCellpadding="4"
            cellspacing="0"
            cellpadding="0"
            minRows="10"
            sortImageColor="white"
            bgcolor="#cccccc"
            scrolling="none"
            columnSorting="true"
            pageSize="-1"
            headerHeight="19px"
            width="600px"
            showTop="false"
            showHeader="true"
            align="center"
            ajax="true">
      <e:dataTr>
        <e:dataTd id="name" label="Name" align="center" title="#{ROW.name}"/>

        <e:dataTd id="ip" label="IP" align="center" title="#{ROW.ip}"/>

        <e:dataTd id="service" label="Service" align="center" title="#{ROW.service}"/>

        <e:dataTd id="port" label="Port" align="center" title="#{ROW.port}"/>

        <e:dataTd id="selectCol" label="&nbsp;" align="center" width="70" sortable="false">
          <e:a value="Select" onclick="#{limsInstanceBean.selectInstance}"
               styleClass="underline_link" ajax="true"/>
        </e:dataTd>

        <e:dataTd id="deleteCol" label="&nbsp;" align="center" width="70" sortable="false">
          <e:a value="Delete"
               onclick="if (confirmDelete('Do you really want to delete this LIMS instance?',event))#{limsInstanceBean.deleteInstance}"
               styleClass="underline_link" ajax="true"/>
        </e:dataTd>

      </e:dataTr>
    </e:datatable>

  </td>
</tr>
</table>
</e:define>