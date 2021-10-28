<%--
(C)Copyright 2000-2015 by LabWare, Inc; All rights reserved

This page is to monitor LIMS connections.

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
  window.document.title = "LabWare Admin Console--Monitor LIMS Instaces";
</script>
<table cellpadding="5" width="100%" class="admin_table_body" cellspacing="0"
       border="0">
  <tr>
    <td width="100%" valign="top" align="center" class="admin_table_header_ds" colspan="2">
      <e:div id="monitorConnMsgDiv">
        <h:messages styleClass="admin_message" id="monitorConMsg" showDetail="true" showSummary="false"
                    layout="table" binding="#{messagesBean.messages}"/>
      </e:div>
    </td>
  </tr>
  <tr>
    <td width="100%" align="center" class="admin_table_header" colspan="2">Monitor Connections
    </td>
  </tr>
  <tr>
    <td width="100%" align="center" class="admin_table_header" colspan="2">
      <e:fieldLayout id="monitorInstLayout" columns="4" labelStyle="required_field_label" align="center" ajax="true">
        <e:select id="serviceSelect_conn" ajax="true" label="Select LIMS DataSource:"
                                             value="#{monitorConnections.monitorDataSourceVal}"
                                             data="#{monitorConnections.dataSourceList}"
                                             onchange="#{monitorConnections.processDSListChangeForConn}"/>
        <e:button id="refreshTable" label="" value="Refresh"
                  onclick="#{monitorConnections.processDataSourceList}" ajax="true"/>
      </e:fieldLayout>
    </td>
  </tr>

  <tr>
    <td align="center" class="admin_table_body">
      <table class="dataTableTop" cellpadding="0" cellspacing="0" width="928px" align="center"
              >
        <tr>
          <td width="100%" class="dataTableTitle"
              style="background-image:url(images/datatable-top-middle.gif)">
            Connections
          </td>
        </tr>
      </table>

      <e:datatable
              id="monitorLimsConnectionsTable"
              border="0"
              dataModel="#{monitorConnections.monitorConnectionsDataModel}"
              binding="#{monitorConnections.monitorConnectionsDataTable}"
              title="LIMS Connections"
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
                                                 width="928px"
                                                 showTop="false"
                                                 showHeader="true"
                                                 align="center"
                                                 ajax="true">

        <e:dataTr>
          <e:dataTd id="username" width="150px" label="Username" align="center" title="#{ROW.username}"/>
          <e:dataTd id="inst_name" width="150px" label="LIMS Instance Name" align="center" title="#{ROW.inst_name}"/>
<%--          <e:dataTd id="ip" label="IP" width="100px" align="center" title="#{ROW.ip}"/>
          <e:dataTd id="port" label="Port" width="150px" align="center" title="#{ROW.port}"/>--%>
          <e:dataTd id="lastTxSecs" label="Last Tx Secs" width="75px" align="center" title="#{ROW.lastTxSecs}"/>
          <e:dataTd id="lastTxTimeStamp" label="Last Tx Timestamp" width="75px" align="center" title="#{ROW.lastTxTimeStamp}"/>
          <e:dataTd id="maxTxSecs" label="Max Tx Secs" width="75px" align="center" title="#{ROW.maxTxSecs}"/>
          <e:dataTd id="lwSessionId" label="Session ID" width="350px" align="center" title="#{ROW.lwSessionId}"/>
        </e:dataTr>
      </e:datatable>
    </td>
  </tr>
</table>
</e:define>