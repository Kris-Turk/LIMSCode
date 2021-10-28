<%--
(C)Copyright 2000-2015 by LabWare, Inc; All rights reserved

This page shows the WebLIMS Debug and Error log files and allows to download, clear and show them.

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
    window.document.title = "LabWare Admin Console--Monitor Log Files";
  </script>
  <table cellpadding="5" width="100%" class="admin_table_body" cellspacing="0" border="0">

    <tr>
      <td width="100%" valign="top" align="center" class="admin_table_header_ds" colspan="2">
        <e:div id="logViewMsgDiv">
          <h:messages styleClass="admin_message" id="logViewMsg" showDetail="true" showSummary="false"
                      layout="table" binding="#{messagesBean.messages}"/>
        </e:div>
      </td>
    </tr>
    <tr>
      <td class="admin_table_header" colspan="5">LabWare Server Log</td>
    </tr>   
    <tr>
      <td id="logFileRadioTD" align="center" class="admin_table_body" colspan="2">
        <table align="center">
          <tr>
            <td>
               <e:radio id="logFileRadio" value="#{logviewBean.logFileRadio}" onchange="#{logviewBean.logFileChange}"
                        ajax="true" horizontal="true">
                 <f:selectItem itemValue="0" id="debug_log" itemLabel="Debug Log"/>
                 <f:selectItem itemValue="1" id="error_log" itemLabel="Error Log"/>
               </e:radio>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td align="center" class="admin_table_body" colspan=5 width="100%">

        <e:button id="refresh_button" value="Refresh" onclick="#{logviewBean.retrieveLog}" ajax="true"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <e:button id="retrieve_button" value="Download Log" onclick="#{logviewBean.downloadLog}"
                  onmousedown="this.formAction = ec.dom.getParentForm(this).action"
                  onmouseup="setTimeout(ec.util.linkThis(function(){ec.submitting=false;ec.dom.getParentForm(this).action=this.formAction;}, this), 500)"
                  ajax="false"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <e:button id="delete_button" value="Clear Log"
                  onclick="if (confirmDelete('Do you really want to clear the log?',event)) #{logviewBean.deleteLog}"
                  ajax="true"/>
      </td>
    </tr>
    <tr>
      <td align="center" class="admin_table_body" colspan=5 width="70%">
        <e:textarea cols="120" rows="25" styleClass="logview_textarea" id="log_viewer" value="#{logviewBean.logContent}"
                    ajax="true"/>
      </td>
    </tr>
  </table>
  <script type="text/javascript">
     window.refreshLogPane = function() {
      var button = document.getElementById("limsAdminForm:refresh_button");
      if (button) {
        button.click();
      }
    }

    window.delayedRefreshLogPane = function() {
      setTimeout(refreshLogPane, 100);
    }

    if (window.attachEvent) {
      window.attachEvent("onload", delayedRefreshLogPane);
    } else if (window.addEventListener) {
      window.addEventListener("load", delayedRefreshLogPane, false);
    }
  </script>
</e:define>