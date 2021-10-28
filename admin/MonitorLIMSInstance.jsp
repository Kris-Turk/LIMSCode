<%--
(C)Copyright 2000-2012 by LabWare, Inc; All rights reserved

This page is to monitor LIMS instances.

@author Avik Chatterjee
--%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://www.simplica.com/jsf/ecruiser" prefix="e" %>

<e:viewInfo template="/admin/top.jsp" roles="WebAdminSetup,WebAdminMonitor">
  <e:update id="monitorMenuItem" prop="styleClass" value="top-menu-selected"/>
  <e:update id="leftMenu" prop="src" value="/admin/Monitor_LeftPane.jsp"/>
</e:viewInfo>
<e:define id="mainPane">
<script type="text/javascript" language="JavaScript">
  window.document.title = "LabWare Admin Console--Monitor LIMS Instance";
</script>
<table cellpadding="5" width="100%" class="admin_table_body" cellspacing="0"
       border="0">
  <tr>
    <td width="100%" valign="top" align="center" class="admin_table_header_ds" colspan="2">
      <e:div id="monitorInstMsgDiv">
        <h:messages styleClass="admin_message" id="monitorInstMsg" showDetail="true" showSummary="false"
                    layout="table" binding="#{messagesBean.messages}"/>
      </e:div>
    </td>
  </tr>
  <tr>
    <td width="100%" align="center" class="admin_table_header" colspan="2">Monitor LIMS Instances
    </td>
  </tr>
  <tr>
    <td width="100%" align="center" class="admin_table_header" colspan="2">
      <e:fieldLayout id="monitorInstLayout" columns="4" labelStyle="required_field_label" align="center" ajax="true">
         <e:select id="serviceSelect" ajax="true" label="Select LIMS DataSource:"
                                             value="#{monitorConnections.monitorDataSourceVal}"
                                             data="#{monitorConnections.dataSourceList}"
                                             onchange="#{monitorConnections.processDSListChangeForInst}"/>
        <e:button id="refreshTable" label="" value="Refresh"
                  onclick="#{monitorConnections.processLIMSInstanceList}" ajax="true"/>
      </e:fieldLayout>
    </td>
  </tr>

  <tr>
    <td align="center" class="admin_table_body">
      <table class="dataTableTop" cellpadding="0" cellspacing="0" width="1020px" align="center"
              >
        <tr>
          <td width="100%" class="dataTableTitle"
              style="background-image:url(images/datatable-top-middle.gif)">
            LIMS Instances
          </td>          
        </tr>
      </table>

      <e:datatable
              id="monitorLimsInstanceTable"
              border="0"
              dataModel="#{monitorConnections.limsInstaceDataModel}"
              binding="#{monitorConnections.limsInstaceDataTable}"
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
                                                 width="1020px"
                                                 showTop="false"
                                                 showHeader="true"
                                                 align="center"
                                                 ajax="true"
                                                 resizeColumns="false"
              >

        <e:dataTr>
          <e:dataTd id="name" width="120px" label="Name" align="center" title="#{ROW.name}"/>

          <e:dataTd id="service" width="80px" label="Service" align="center" title="#{ROW.service}"/>

          <e:dataTd id="ip" width="180px" label="Host" align="center" title="#{ROW.ip}"/>

          <e:dataTd id="port"  width="80px" label="Port" align="center" title="#{ROW.port}"/>
          
          <e:dataTd id="num_users"  width="110px" label="Number Of Users" align="center" title="#{ROW.num_users}"/>

          <e:dataTd id="socketTimeout"  width="100px" label="Socket Timeout" align="center" title="#{ROW.socketTimeout}"/>

          <e:dataTd id="available" width="75px" label="Available" align="center" title="#{ROW.available}"/>

          <e:dataTd id="status" width="110px" label="Status" align="center" title="#{ROW.status}"/>

          <e:dataTd id="b_order" width="70px" label="Bind Hash" align="center" title="#{ROW.b_order}"/>

        </e:dataTr>
      </e:datatable>
    </td>
  </tr>
</table>
</e:define>