<%--
(C)Copyright 2000-2018 by LabWare, Inc; All rights reserved

This is the left pane of the Setup tab.

@author Avik Chatterjee
--%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://www.simplica.com/jsf/ecruiser" prefix="e" %>

<div class="menu-head">Setup Menu</div>
<table bgcolor="#639BCE" width="200px" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="left" valign="top" style="padding-top:5px;">
            <table bgcolor="#639BCE" border="0" cellspacing="0" cellpadding="2" width="100%">
                <tr>
                    <td height="24px"><e:div id="SysConf" rendered="#{ecLoginManager.renderSysConfImage}">
                        <div id="SysConf_img"><img src="images/right-arrow.gif" height="20" width="24"></div>
                    </e:div></td>
                    <td width="99%"><e:a onclick="/admin/SysConf.jsp" styleClass="menu-link" id="SysConfLink"
                                         ajax="true">System Variables</e:a></td>
                </tr>
                <tr>
                    <td height="24px"><e:div id="WebConf" rendered="#{ecLoginManager.renderWebConfImage}">
                        <div id="WebConf_img"><img src="images/right-arrow.gif" height="20" width="24"></div>
                    </e:div></td>
                    <td width="99%"><e:a onclick="/admin/WebConf.jsp" styleClass="menu-link" id="WebConfLink"
                                         ajax="true">Web Configuration<br>Variables</e:a></td>
                </tr>

            </table>
        </td>
    </tr>
</table>