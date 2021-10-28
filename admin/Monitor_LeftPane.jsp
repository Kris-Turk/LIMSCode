<%--
(C)Copyright 2000-2015 by LabWare, Inc; All rights reserved

This is the left pane of the Monitor tab.

@author Avik Chatterjee
--%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://www.simplica.com/jsf/ecruiser" prefix="e" %>

<div class="menu-head">Monitor Menu</div>
<table bgcolor="#639BCE" width="200px" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="left" valign="top" style="padding-top:5px;">
      <table bgcolor="#639BCE" border="0" cellspacing="0" cellpadding="2" width="100%">
        <tr>
          <td height="24px"><e:div id="MonitorLIMSInstance" rendered="#{ecLoginManager.renderMonitorLIMSInstanceImage}">
            <div id="MonitorLIMSInstance_img"><img src="images/right-arrow.gif" height="20" width="24"></div>
          </e:div></td>
          <td><e:a onclick="/admin/MonitorLIMSInstance.jsp" styleClass="menu-link"
                   id="MonitorLIMSInstance_Link">LIMS Instances</e:a></td>
        </tr>
        <tr>
          <td height="24px"><e:div id="MonitorConnections"
                                   rendered="#{ecLoginManager.renderMonitorConnectionsImage}">
            <div id="MonitorConnections_img"><img src="images/right-arrow.gif" height="20" width="24"></div>
          </e:div></td>
          <td><e:a onclick="/admin/MonitorConnections.jsp" styleClass="menu-link"
                   id="MonitorConnections_Link">LIMS Connections</e:a></td>
        </tr>
        <tr>
          <td height="24px"><e:div id="Logview" rendered="#{ecLoginManager.renderLogViewImage}">
            <div id="Logview_img"><img src="images/right-arrow.gif" height="20" width="24"></div>
          </e:div></td>
          <td width="99%"><e:a onclick="/admin/Logview.jsp" styleClass="menu-link" id="Logview_Link">Server Log</e:a>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>