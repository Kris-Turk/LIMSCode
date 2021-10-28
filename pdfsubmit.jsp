<%--
(C)Copyright 2000-2018 by LabWare, Inc; All rights reserved

@author Avik Chatterjee

Request param names must be as follows:

username
password
role
lims_datasource
LIMSservice
websubroutinename
submit
--%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://www.simplica.com/jsf/ecruiser" prefix="e" %>
<f:view>
  <html>
  <head>
    <title>Pdf Submit</title>
    <link id="favicon" rel="shortcut icon" href="img/LabWare.ico"/>
    <link rel="stylesheet" type="text/css" href="admin/stylesheet/labware_admin.css">
  </head>
  <body>
  <e:div id="notRenderDiv" styleClass="admin_message_error" rendered="#{!pdfsubmitBean.pdfSubmitEnable}">Access disabled for this page.</e:div>
  <e:div id="renderDiv" rendered="#{pdfsubmitBean.pdfSubmitEnable}">
    <table width="100%" cellspacing="0" cellpadding="0">
      <tr>
        <td>
          <h:outputText escape="false" value="#{pdfsubmitBean.retVal}"/>
        </td>
      </tr>
    </table>
  </e:div>
  </body>
  </html>
</f:view>