<%--
(C)Copyright 2000-2015 by LabWare, Inc; All rights reserved

This page shows the configured LIMS services and allows to add,edit and delete them.

@author Avik Chatterjee
--%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://www.simplica.com/jsf/ecruiser" prefix="e" %>

<%--<e:viewInfo template="/admin/top.jsp" roles="WebAdminSetup">--%>
<e:viewInfo template="/admin/top.jsp" roles="">
  <e:update id="leftMenu" prop="src" value="/admin/SetUp_LeftPane.jsp"/>
  <e:update id="setupMenuItem" prop="styleClass" value="top-menu-selected"/>
</e:viewInfo>

<e:define id="mainPane">

<script language="JavaScript" type="text/javascript">
  window.document.title = "LabWare Admin Console--Setup LIMS Services";
  function saveServiceValidate(evt) {
    var serviceNameEle = document.getElementById("limsAdminForm:serviceName");
    var e = (window.event) ? window.event : evt;
    if (serviceNameEle.value.trim() == "") {
      alert("Please Enter the Name. Service Name can't be blank.");
      serviceNameEle.style.backgroundColor = "red";
      ec.bs.stopEvent(e);
      return false;
    }
    else {
      return true;
    }
  }
</script>

<table id="instTable" border="0" cellpadding="5" cellspacing="0" width="100%">
<tr>
  <td width="100%" valign="top" align="center" class="admin_table_header_ds" colspan="2">
    <e:div id="servicesMsgDiv">
      <h:messages styleClass="admin_message" id="servicesMsg" showDetail="true" showSummary="false"
                  layout="table" binding="#{messagesBean.messages}"/>
    </e:div>
  </td>
</tr>
<tr>
  <td width="100%" align="center" class="admin_table_header" colspan="2">
    LIMS Services Configuration
  </td>
</tr>
<tr>
  <td class="admin_table_body" colspan="2">&nbsp;</td>
</tr>
<tr>
  <td align="center" class="admin_table_body">
    <span class="required_field_label">Name:&nbsp;</span>

    <e:input id="serviceName" value="#{servicesBean.servicesName}" ajax="true"/>

    <span class="admin_table_body">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
    <span class="required_field_label">Data Source:&nbsp;</span>
    <e:select id="dsSelect" value="#{servicesBean.dsSelect}" data="#{servicesBean.dsList}" ajax="true"/>
      <%--<span class="admin_table_body">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
    <span class="required_field_label">Maintenance mode:&nbsp;</span>
    <e:checkbox id="chkMaintenanceMode" value="#{servicesBean.maintenanceMode}"/>--%>
  </td>
</tr>
<tr>
  <td colspan="2" class="admin_table_body" width="100%">&nbsp;</td>
</tr>
<tr>
  <td align="center" class="admin_table_body">
    &nbsp;
      <%--<e:button id="serviceSave" type="submit" value="Save" actionListener="#{servicesBean.saveServices}"
     onclick="return saveServiceValidate();"/>--%>
    <e:button id="serviceSave" value="Save"
              onclick="if(saveServiceValidate(event))#{servicesBean.saveServices}" ajax="true"/>

  </td>
</tr>
<tr>
  <td class="admin_table_body" colspan='2' align="center">&nbsp;</td>
</tr>
<tr>
  <td class="admin_table_body" colspan='2' width='100%' align="center">
    <table class="dataTableTop" cellpadding="0" cellspacing="0" width="800px" align="center">
      <tr>
        <td width="1%"><img src="images/datatable-top-left.gif" alt="" height="24" width="15"></td>
        <td width="98%" class="dataTableTitle"
            style="background-image:url(images/datatable-top-middle.gif)">
          LIMS Services
        </td>
        <td width="1%"><img src="images/datatable-top-right.gif" alt="" height="24" width="15"></td>
      </tr>
    </table>
    <e:datatable
            id="servicesTable"
            border="0"
            dataModel="#{servicesBean.ecDM}"            
            title="LIMS Services"
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
            headerHeight="40px"
            width="800px"
            showTop="false"
            showHeader="true"
            align="center"
            showTooltip="true"
            ajax="true"
            >
      <e:dataTr>
        <e:dataTd id="name" label="Name" align="center"/>

        <e:dataTd id="dataSource" label="Data Source" align="center"/>
        <e:dataTd id="mMode" nowrap="true" label="Maintenance <br> Mode" align="center"
                  headerStyle="border:1px solid red;width:25px;white-space:normal;height:40px;text-overflow:ellipsis;">
          <e:checkbox id="chkMaintenanceMode" value="#{ROW.mMode}" ajax="true" onchange="#{servicesBean.saveMMode}"/>
        </e:dataTd>
        <e:dataTd id="remWL3" nowrap="true" label="Remember Me <br> WL3 App" align="center"
                  headerStyle="width:45px;white-space:normal;height:40px;text-overflow:ellipsis;">
          <e:checkbox id="chkremWL3" value="#{ROW.remWL3}" ajax="true" onchange="#{servicesBean.saveRemWl3}"/>
        </e:dataTd>
        <e:dataTd id="remCallWeb" nowrap="true" label="Remember Me <br> Call-WebServices App" align="center"
                  headerStyle="width:45px;white-space:normal;height:40px; text-overflow: ellipsis;">
          <e:checkbox id="chkremCallWeb" value="#{ROW.remCallWeb}" ajax="true"
                      onchange="#{servicesBean.saveRemCallWebService}"/>
        </e:dataTd>
        <e:dataTd id="remMainPane" nowrap="true" label="Remember Me <br> MainPane App " align="center"
                  headerStyle="width:45px;white-space:normal;height:40px; text-overflow: ellipsis;">
          <e:checkbox id="chkremMainPane" value="#{ROW.remMainPane}" ajax="true"
                      onchange="#{servicesBean.saveRemMainPane}"/>
        </e:dataTd>
        <e:dataTd id="encryptSoap" nowrap="true" label="Encrypt <br> SOAP" align="center"
                  headerStyle="width:25px;white-space:normal;height:40px; text-overflow: ellipsis;">
          <e:checkbox id="chkencryptSoap" value="#{ROW.encryptSoap}" ajax="true"
                      onchange="#{servicesBean.saveEncryptSoap}"/>
        </e:dataTd>
        <e:dataTd id="selectCol" label="&nbsp;" align="center" width="70" sortable="false">
          <e:a value="Select" onclick="#{servicesBean.selectService}" styleClass="underline_link" ajax="true"/>
        </e:dataTd>

        <e:dataTd id="deleteCol" label="&nbsp;" align="center" width="70" sortable="false">
          <e:a value="Delete"
               onclick="if (confirmDelete('Deletion of a LIMS Service deletes all the LIMSInstances configured in it. Do you really want to delete this LIMS Service?',event))#{servicesBean.deleteService}"
               styleClass="underline_link" ajax="true"/>
        </e:dataTd>

      </e:dataTr>
    </e:datatable>


  </td>
</tr>

</table>
</e:define>
