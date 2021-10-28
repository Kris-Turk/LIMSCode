<%--
(C)Copyright 2000-2018 by LabWare, Inc; All rights reserved

This allows to download SSO meta data.

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

    window.document.title = "LabWare Admin Console--SSO Meta Data";

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
          <h:messages styleClass="admin_message" id="ssoMetaMsg" showDetail="true" showSummary="false"
                      layout="table" binding="#{messagesBean.messages}"/>
        </e:div>
      </td>
    </tr>
    <tr>
      <td width="100%" align="center" class="admin_table_header" colspan="2">
        LIMS SSO Meta Data
      </td>
    </tr>
    <tr>
      <td align="center">
        <table cellpadding="2" width="20%" align="center" class="admin_table_body" cellspacing="0" border="0">
          <tr>

          </tr>

        </table>
      </td>
    </tr>
  </table>
</e:define>

