<%--
(C)Copyright 2000-2019 by LabWare, Inc; All rights reserved

This page shows the list of LIMS services to select. After selection of service control redirects to the login page.

@author Avik Chatterjee
--%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://www.simplica.com/jsf/ecruiser" prefix="e" %>
<%@ taglib uri="http://www.labware.com/components" prefix="lw" %>


<f:view>
  <!DOCTYPE html>
  <html>
  <head>
    <title></title>
    <link id="favicon" rel="shortcut icon" href="img/LabWare.ico">
    <link rel="stylesheet" type="text/css" href="css/login.css">

  </head>

  <body id="login-bg">

    <a href="http://www.labware.com" target="_blank" rel="noopener noreferrer"><img src="img/labware-logo.png" alt="LabWare Logo" id="login-logo" border="0"></a>
    <div id="login-pane">
      <div id="login-form-bg">
        <e:form id="ssf">

          <p style="padding: 20px;text-align: center;"><e:span id="header" styleClass="login-title" value="#{selectServiceBean.selectDS}"/></p>
          <e:input type="hidden" id="title_input" value="#{selectServiceBean.selectDS}"/>
         <e:div style="padding-left:25px;padding-right:25px;text-align:-moz-center;text-align:-khtml-center;#text-align:center;color:red;font-weight:bold;"><h:messages
                    styleClass="admin_message"/></e:div>
          <br><br>
          <e:div id="services" style="text-align:center;" ajax="true">
              <table cellspacing="0" cellpadding="3" border="1" style="width: 100%; padding: 20px 40px 20px 20px;">
              <tr>
                <td valign="top" style="text-align:right;"><h:outputText styleClass="formLabel" value="#{selectServiceBean.dsLabel}"/></td>
                <td valign="top" style="text-align:left;">
                  <e:select id="ds_select" ajax="true" styleClass="login-input ui-widget-content ui-corner-all"
                          style="font-size:13px"
                          value="#{selectServiceBean.datasource}"
                          data="#{selectServiceBean.dataSourceList}"
                          onchange="#{selectServiceBean.refreshServiceList}"/></td>
              </tr>
              <tr>
                <td colspan="2" height="5"></td>
              </tr>
              <tr>
                  <td valign="top" style="text-align:right;"><h:outputText
                          styleClass="formLabel" value="#{selectServiceBean.serviceLabel}"/></td>
                  <td valign="top" style="text-align:left;"><e:select id="service_select" ajax="true"
                                                                      styleClass="login-input ui-widget-content ui-corner-all"
                                                                      style="font-size:13px"
                                                                      value="#{selectServiceBean.service}"
                                                                      data="#{selectServiceBean.servicesList}"
                                                                      binding="#{selectServiceBean.serviceSelect}"/>
                </td>
              </tr>
                <tr>
                    <td colspan="2">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2">&nbsp;</td>
                </tr>
                <tr>
                  <td valign="top" style="text-align:center;" colspan="2">
                      <div>
                          <e:button styleClass="btn btn-blue"
                                    style="padding:8px 10px 8px 10px;font-size:1.0em;min-width:56px;" id="connect_wl3"
                                    value="#{selectServiceBean.connectDS}"
                                    onclick="#{selectServiceBean.submitForm}" ajax="false"/></div>
                  </td>
              </tr>
            </table>
          </e:div>
          </e:form>
    </div>
  </div>
  <script language="JavaScript" type="text/javascript">
      window.top.document.title = document.getElementById("ssf:title_input").value;
  </script>
  </body>
  </html>
</f:view>