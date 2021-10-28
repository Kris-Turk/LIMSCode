<%--
(C)Copyright 2000-2015 by LabWare, Inc; All rights reserved

This page shows the configured Datasources and allows to add,edit and delete them.

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

  window.document.title = "LabWare Admin Console--Setup Datasource";

  window.saveDsValidate = function (evt) {
    var odbcNameEle = document.getElementById("limsAdminForm:odbcName");
    var nameEle = document.getElementById("limsAdminForm:jdbcName");
    var jdbcUrlEle = document.getElementById("limsAdminForm:jdbcUrl");
    var driverClassEle = document.getElementById("limsAdminForm:jdbcDriver");
    var userNameEle = document.getElementById("limsAdminForm:dbUsername");
    var passwordEle = document.getElementById("limsAdminForm:dbPassword");
    var e = (window.event) ? window.event : evt;
    if (odbcNameEle != null && odbcNameEle.value != undefined && odbcNameEle.style.display != "none") {
      if (odbcNameEle.value.trim() == "") {
        alert("Please Enter the ODBC Name. ODBC Name can't be blank.");
        odbcNameEle.style.backgroundColor = "red";
        odbcNameEle.focus();
        ec.bs.stopEvent(e);
        return false;
      } else if (passwordEle.value.trim() != "") {
        if (userNameEle.value.trim() == "") {
          alert("Please Enter the Username. Username can't be blank.");
          userNameEle.style.backgroundColor = "red";
          userNameEle.focus();
          ec.bs.stopEvent(e);
          return false;
        }
        return true;
      }
      else {
        return true;
      }
    }
    else if (nameEle != null && nameEle.value != undefined && nameEle.style.display != "none") {
      if (nameEle.value.trim() == "") {
        alert("Please Enter the Name. Name can't be blank.");
        nameEle.style.backgroundColor = "red";
        jdbcUrlEle.style.backgroundColor = "";
        driverClassEle.style.backgroundColor = "";
        nameEle.focus();
        ec.bs.stopEvent(e);
        return false;
      }
      else if (jdbcUrlEle.value.trim() == "") {
        alert("Please Enter the JDBC url. JDBC url can't be blank.");
        nameEle.style.backgroundColor = "";
        jdbcUrlEle.style.backgroundColor = "red";
        driverClassEle.style.backgroundColor = "";
        jdbcUrlEle.focus();
        ec.bs.stopEvent(e);
        return false;
      }
      else if (driverClassEle.value.trim() == "") {
        alert("Please Enter the Driver Class. Driver Class can't be blank.");
        nameEle.style.backgroundColor = "";
        jdbcUrlEle.style.backgroundColor = "";
        driverClassEle.style.backgroundColor = "red";
        driverClassEle.focus();
        ec.bs.stopEvent(e);
        return false;
      }
      else if (passwordEle.value.trim() != "") {
        if (userNameEle.value.trim() == "") {
          alert("Please Enter the Username. Username can't be blank.");
          userNameEle.style.backgroundColor = "red";
          userNameEle.focus();
          ec.bs.stopEvent(e);
          return false;
        }
        return true;
      }
      else {
        return true;
      }
    } else {
      return true;
    }
  }
</script>
<style type="text/css">
  .dataTableHeader span {
    font-family: Helvetica, sans-serif;
    font-size: 11px;
    font-weight: bold;
    color: #ffffff;
    text-decoration: none;
  }
</style>
<table cellpadding="5" width="100%" class="admin_table_body" cellspacing="0" border="0">
<tr>
  <td width="100%" valign="top" align="center" class="admin_table_header_ds" colspan="2">
    <e:div id="dsMsgDiv" ajax="true">
      <h:messages styleClass="admin_message" id="dsMsg" showDetail="true" showSummary="false"
                  layout="table" binding="#{messagesBean.messages}"/>
    </e:div>
  </td>
</tr>
<tr>
  <td width="100%" align="center" class="admin_table_header" colspan="2">
    <h:outputText value="#{datasourceBean.configure}"/> LIMS Web Server Data Sources
  </td>
</tr>
<tr>
  <td align="center">
    <table cellpadding="2" width="20%" align="center" class="admin_table_body" cellspacing="0" border="0">
      <tr>
        <e:td id="dsRadioParent" align="center" styleClass="admin_table_body" colspan="2">

          <table align="center">
            <tr>
              <td>
                <e:radio id="driverRadio" value="#{datasourceBean.flag}" onchange="#{datasourceBean.dataSourceChange}"
                         ajax="true" horizontal="true">
                  <f:selectItem itemValue="0" id="odbc" itemLabel="ODBC (MS Access only)"/>
                  <f:selectItem itemValue="1" id="jdbc" itemLabel="JDBC"/>
                </e:radio>
              </td>
            </tr>
          </table>

        </e:td>

      </tr>
      <e:tr id="odbcTR" rendered="#{datasourceBean.renderODBCValue}">
        <e:td id="odbcLabelParent" align="right" width="50%">
          <e:span styleClass="required_field_label" id="odbcLabel" value="ODBC Name:"
                  rendered="#{datasourceBean.renderODBCValue}"/>
        </e:td>
        <e:td id="odbcTxtboxParent" align="left" width="50%">


          <e:input style="width:315px" id="odbcName" value="#{datasourceBean.odbcName}"
                   binding="#{datasourceBean.odbcInput}"
                   rendered="#{datasourceBean.renderODBCValue}"/>

        </e:td>
      </e:tr>
      <e:tr id="jdbcTR" rendered="#{datasourceBean.renderJDBCValue}">
        <e:td id="jdbcNameLabelParent" align="right" width="50%">

          <e:span styleClass="required_field_label" value="Name:" rendered="#{datasourceBean.renderJDBCValue}"/>

        </e:td>
        <e:td id="jdbcNameTxtboxParent" align="left" width="50%">

          <e:input style="width:315px" id="jdbcName" value="#{datasourceBean.jdbcName}"
                   rendered="#{datasourceBean.renderJDBCValue}"/>

        </e:td>

      </e:tr>
      <e:tr id="jdbcUrlTR" rendered="#{datasourceBean.renderJDBCValue}">
        <e:td id="jdbcUrlLabelParent" align="right" width="50%">

          <e:span styleClass="required_field_label" value="JDBC URL:"
                  rendered="#{datasourceBean.renderJDBCValue}"/>

        </e:td>
        <e:td id="jdbcUrlTxtBoxParent" align="left" width="50%">

          <e:input style="width:315px" id="jdbcUrl" value="#{datasourceBean.jdbcUrl}"
                   rendered="#{datasourceBean.renderJDBCValue}"/>

        </e:td>

      </e:tr>
      <e:tr id="jdbcDriverTR" rendered="#{datasourceBean.renderJDBCValue}">
        <e:td id="jdbcDriverLabelParent" align="right" width="50%">

          <e:span styleClass="required_field_label" value="Driver Class:"
                  rendered="#{datasourceBean.renderJDBCValue}"/>

        </e:td>
        <e:td id="jdbcDriverTxtBoxParent" align="left" width="50%">

          <e:input style="width:315px" id="jdbcDriver" value="#{datasourceBean.jdbcDriver}"
                   rendered="#{datasourceBean.renderJDBCValue}"/>

        </e:td>
      </e:tr>
      <tr>
        <e:td id="jdbcUsernameLabelParent" align="right" width="50%">

          <e:span value="Username:"
                  rendered="true"/>

        </e:td>
        <e:td id="jdbcUsernameTxtBoxParent" align="left" width="50%">

          <e:input style="width:315px" id="dbUsername" value="#{datasourceBean.username}"
                   rendered="true"/>

        </e:td>
      </tr>
      <tr>
        <e:td id="jdbcPasswordLabelParent" align="right" width="50%">
          <e:span value="Password:" rendered="true"/>
        </e:td>
        <e:td id="jdbcPasswordTxtBoxParent" align="left" width="50%">

          <e:input type="password" style="width:315px" id="dbPassword" value="#{datasourceBean.password}"
                   rendered="true"/>
        </e:td>
      </tr>
      <tr>
        <td align="right" width="50%">
          <e:span value="Default Service:" rendered="true"/>
        </td>
        <td align="left" width="50%">
            <e:input style="width:315px" id="defService" value="#{datasourceBean.defaultService}" rendered="true"/>
        <td>
      </tr>
      <tr>
        <td colspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td align="center" colspan="2">
          <e:input id="numOfDs" type="hidden" value="#{datasourceBean.numOfDs}" ajax="true"/>
<%--          <e:button id="dsSave" value="#{datasourceBean.save}"
                    onclick="if(saveDsValidate(event))#{datasourceBean.saveDS}" ajax="true"/>--%>
          <e:button id="testCon" value="#{datasourceBean.testCon}"
                    onclick="#{datasourceBean.testConn}" ajax="true"/>

        </td>
        <td align="center" colspan="2">

        </td>
      </tr>
      <tr>
        <td colspan="2">&nbsp;</td>
      </tr>
    </table>
  </td>
</tr>
<tr>
  <td align="center" class="admin_table_body">
    <b>* NOTE:</b> The default Data Source is the first one in the table.
  </td>
</tr>
<tr>
  <td align="center" class="admin_table_body" colspan="2">
    <table border="0" align="center" cellspacing="0" cellpadding="0">
      <tr>
        <td>
          <table class="dataTableTop" cellpadding="0" cellspacing="0" align="center" width="100%">
            <tr>
              <td width="100%" class="dataTableTitle" style="background-image:url(images/datatable-top-middle.gif);">
                Data Source
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td>
          <e:datatable
              id="dataSourceTable"
              border="0"
              dataModel="#{datasourceBean.ecDM}"
              binding="#{datasourceBean.dataSourceDataTable}"
              title="Data Source"
              innerCellspacing="1"
              innerCellpadding="4"
              cellspacing="0"
              cellpadding="0"
              minRows="10"
              sortImageColor="white"
              bgcolor="#cccccc"
              scrolling="none"
              columnSorting="false"
              pageSize="-1"
              headerHeight="40px"
              showTop="false"
              showHeader="true"
              align="center"
              resizeColumns="false"
              ajax="true"
              >
            <e:dataTr>
              <e:dataTd id="name" label="Name" align="center" title="#{ROW.name}"/>

              <e:dataTd id="url" label="URL" align="center" title="#{ROW.url}"/>

              <e:dataTd id="driver" label="Driver Class" align="center" title="#{ROW.driver}"/>

              <e:dataTd id="defaultService" label="Default Service" align="center" title="#{ROW.defaultService}"/>

              <e:dataTd id="remWL3" nowrap="true" label="Remember Me<br>LabWare App" align="center"
                        headerStyle="width:45px;white-space:normal;height:40px;text-overflow:ellipsis;">
                <e:checkbox id="chkremWL3" value="#{ROW.remWL3}" ajax="true" onchange="#{datasourceBean.saveRemMeWL3}"/>
              </e:dataTd>
              <e:dataTd id="remCallWeb" nowrap="true" label="Remember Me<br>Call-WebServices App" align="center"
                        headerStyle="width:45px;white-space:normal;height:40px; text-overflow: ellipsis;">
                <e:checkbox id="chkremCallWeb" value="#{ROW.remCallWeb}" ajax="true"
                            onchange="#{datasourceBean.saveRemMeCallWeb}"/>
              </e:dataTd>
              <e:dataTd id="remMainPane" nowrap="true" label="Remember Me<br>MainPane App " align="center"
                        headerStyle="width:45px;white-space:normal;height:40px; text-overflow: ellipsis;">
                <e:checkbox id="chkremMainPane" value="#{ROW.remMainPane}" ajax="true"
                            onchange="#{datasourceBean.saveRemMeMainPane}"/>
              </e:dataTd>
              <e:dataTd id="encryptSoap" nowrap="true" label="Encrypt<br>SOAP" align="center"
                        headerStyle="width:25px;white-space:normal;height:40px; text-overflow: ellipsis;">
                <e:checkbox id="chkencryptSoap" value="#{ROW.encryptSoap}" ajax="true"
                            onchange="#{datasourceBean.saveEncryptSOAP}"/>
              </e:dataTd>
              <e:dataTd id="autocomplete" nowrap="true" label="Autocomplete" align="center"
                        headerStyle="width:25px;white-space:normal;height:40px; text-overflow: ellipsis;">
                <e:checkbox id="chkautocomplete" value="#{ROW.autocomplete}" ajax="true"
                            onchange="#{datasourceBean.saveAutoComplete}"/>
              </e:dataTd>
              <%--<e:dataTd id="adminDS" nowrap="true" label="Admin DataSource" align="center"
                        headerStyle="width:45px;white-space:normal;height:40px; text-overflow: ellipsis;">
                <e:checkbox id="chkadminds" value="#{ROW.adminDS}" ajax="true" onchange="#{datasourceBean.saveSetAdminDatasource}"/>
              </e:dataTd>--%>
              <e:dataTd id="selectCol" label="&nbsp;" align="center" width="50" sortable="false">
                <e:a value="Select" onclick="#{datasourceBean.selectDataSource}"
                     styleClass="underline_link" ajax="true"/>
              </e:dataTd>

<%--              <e:dataTd id="deleteCol" label="&nbsp;" align="center" width="50" sortable="false">
                <e:a value="Delete" styleClass="underline_link"
                     onclick="if (confirmDelete('Do you really want to delete this datasource?',event))#{datasourceBean.deleteDS}"
                     ajax="true"/>
              </e:dataTd>--%>

            </e:dataTr>
          </e:datatable>
        </td>
      </tr>
    </table>
  </td>
</tr>
</table>
</e:define>

