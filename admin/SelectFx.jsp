<%--
(C)Copyright 2000-2015 by LabWare, Inc; All rights reserved

This page shows the Websevices functions.

@author Avik Chatterjee
--%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://www.simplica.com/jsf/ecruiser" prefix="e" %>

<e:viewInfo template="/admin/top.jsp" roles="WebAdminTest">
  <e:update id="testMenuItem" prop="styleClass" value="top-menu-selected"/>
  <e:update id="leftMenu" prop="src" value="/admin/WSConn_SelectFxLeftPane.jsp"/>
</e:viewInfo>

<e:define id="mainPane">

  <script type="text/javascript" language="JavaScript">
    window.document.title = "LabWare Admin Console -- Select Web Function";
    setSessionTimeout();
  </script>

  <table cellspacing="0" cellpadding="0" width="100%" border="0">
    <tr>
      <td width="100%" align="center">
        <h:messages id="errorMessages_selectFx" layout="table" styleClass="admin_message"/>
      </td>
    </tr>

    <tr>
      <td width="100%" align="center" class="admin_table_header" colspan="2">
        Select Web Function
      </td>
    </tr>

    <tr>
      <td class="admin_table_body">&nbsp;</td>
    </tr>

    <tr>
      <td class="admin_table_body" colspan='2' width='100%' align="center">
        <e:fieldLayout fieldStyle="formControl" labelStyle="formLabel" disabledStyle="formLabelDisabled"
                       invalidStyle="formLabelInvalid" requiredStyle="formLabelRequired" showMessages="false"
                       align="center">
          <e:input id="filterInput" ajax="true" value="#{webFunctionTableBean.filterValue}"
                   onkeyup="#{webFunctionTableBean.filterTable}" label="Search Functions:"/>
        </e:fieldLayout>
        <table class="dataTableTop" cellpadding="0" cellspacing="0" width="750px" align="center">
          <tr>
            <td width="1%"><img src="images/datatable-top-left.gif" alt="" height="24" width="15"></td>
            <td width="98%" class="dataTableTitle"
                style="background-image:url(images/datatable-top-middle.gif)">
              Web Functions
            </td>
            <td width="1%"><img src="images/datatable-top-right.gif" alt="" height="24" width="15"></td>
          </tr>
        </table>
        <e:datatable
                id="webFunctionTable"
                dataModel="#{webFunctionTableBean.dataModel}"
                border="0"
                height="300px"
                title="Web Function Table"
                innerCellspacing="1"
                innerCellpadding="4"
                cellspacing="0"
                cellpadding="0"
                minRows="10"
                sortImageColor="white"
                bgcolor="#cccccc"
                columnSorting="true"
                pageSize="-1"
                ajaxLoading="true"
                headerHeight="19px"
                width="750px"
                showTop="false"
                showHeader="true"
                align="center"
                >
          <e:dataTr>
            <e:dataTd id="functionName" label="Function Name" width="140" nowrap="true"/>
            <e:dataTd id="testFunctionString" label="Test Function" width="140" nowrap="true"
                      align="center">
              <e:a id="testFunctionAnchor" onclick="#{webFunctionTableBean.testFunction}"
                   value="#{ROW.testFunctionString}" ajax="true"/>
            </e:dataTd>
            <e:dataTd id="showwsdlString" label="Show WSDL" width="140" nowrap="true" align="center">
              <e:a id="showWsdlAnchor" value="#{ROW.showwsdlString}"
                   onclick="#{webFunctionTableBean.wsdlURL}"/>
            </e:dataTd>
          </e:dataTr>
        </e:datatable>
      </td>
    </tr>
    <tr>
      <td class="admin_table_body">&nbsp;</td>
    </tr>
    <tr>
      <td class="admin_table_body" colspan='2' width='100%' align="center">
        <e:button id="rebuildFunctions" ajax="true" immediateEvent="true"
                  onclick="#{webFunctionTableBean.refreshFunctions}"
                  value="Rebuild"/>
      </td>
    </tr>
    <tr>
      <td class="admin_table_body">&nbsp;</td>
    </tr>
  </table>
</e:define>