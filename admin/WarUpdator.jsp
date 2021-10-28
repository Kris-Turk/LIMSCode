<%--
(C)Copyright 2000-2017 by LabWare, Inc; All rights reserved

This page is to Manage the war file.

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
    <script type="text/javascript" language="JavaScript">
        window.document.title = "LabWare Admin Console--Web War File Updater";
        window.updateWL3 = function () {
            var frm = document.forms[0];
            frm.method = "post";
            return true;
        };
        window.confirmWarUpdate = function () {
            var msg = "WARNING: This will reset the application. ";
            msg += "You may have to restart your browser and/or application server.";
            msg += "\r\n";
            msg += "Do you want to continue?";
            if (confirm(msg)) {
                var form = document.forms[0];
                form.enctype = "multipart/form-data";
                form.method = "post";
                return true;
            }
            else {
                return false;
            }
        };
    </script>

    <table cellpadding="3" width="50%" class="admin_table_body" cellspacing="3" border="0" align="center">
        <tr>
            <td colspan="2">
                <table align="center">
                    <tr>
                        <td width="100%" valign="top" align="center" class="admin_table_header_ds" colspan="2">
                            <e:div id="fileUploadMsgDiv">
                                <h:messages styleClass="admin_message" id="fileUploadMsg" showDetail="true"
                                            showSummary="false"
                                            layout="table" binding="#{messagesBean.messages}"/>
                            </e:div>
                        </td>
                    </tr>
                    <tr>
                        <td width="100%" align="center" class="admin_table_header">Manage Server Files</td>
                    </tr>
                    <tr>
                        <td class="admin_table_body">&nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="center">
                <table border="0" cellpadding="3">
                    <tr>
                        <td align="center" class="admin_table_body"><b>Current Web Application Archive (WAR)</b>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="admin_table_body">
                            Version: <e:span id="version" value="#{warUpdatorBean.version}"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="admin_table_body">Installed On: <e:span id="instDt"
                                                                                          value="#{warUpdatorBean.installDate}"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="admin_table_body">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="center" class="admin_table_body"><b>Update Server Files</b></td>
                    </tr>
                    <tr>
                        <td align="center" class="admin_table_body">
                            Select WAR File from Local System:
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="admin_table_body">
                            <table align="center">
                                <tr>
                                    <td>
                                        <e:fileUpload id="uploadFile" value="#{warUpdatorBean.warfile}" ajax="true"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="admin_table_body">

                            <e:button id="updtServer" value="Update Server"
                                      onclick="if(confirmWarUpdate())#{warUpdatorBean.uploadWarAction}"
                                      ajax="true" style="width:200px;"/>

                        </td>
                    </tr>
                    <tr>
                        <td class="admin_table_body" width="100%">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="center" class="admin_table_body">
                            <b>Backup Server Files</b>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="admin_table_body">
                            <e:button id="retrieveButt" value="Create and Retrieve"
                                      onmousedown="this.formAction = ec.dom.getParentForm(this).action"
                                      onclick="if(updateWL3())#{warUpdatorBean.backUpWarAction}"
                                      onmouseup="setTimeout(ec.util.linkThis(function(){ec.submitting=false;ec.dom.getParentForm(this).action=this.formAction;}, this), 500)"
                                      ajax="false" style="width:200px;"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="admin_table_body">&nbsp;</td>
                    </tr>
                    <%--<tr>
                        <td align="center" class="admin_table_body">
                            <b>Update Common Files</b>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="admin_table_body">
                            LIMS Server Directory Path
                        </td>
                    </tr>
                    <tr>
                        <td class="admin_table_body" align="center">
                            <table align="center">
                                <tr>
                                    <td>
                                        <e:input type="text" size="80px" style="width:200px;"
                                                 value="#{warUpdatorBean.limsCommonDirPath}"></e:input>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="admin_table_body" align="center">
                            <e:button ajax="true" id="updtCommDir" value="Update Common Directory"
                                      onclick="#{warUpdatorBean.updateCommonDirectory}" style="width:200px;"/>
                        </td>
                    </tr>--%>
                </table>

            </td>
            <td align="center">
                <table border="0" cellpadding="3">
                    <%--<tr>
                        <td align="center" class="admin_table_body">
                            <b>Update Visual Workflow</b>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="admin_table_body">
                            Visual Workflow Path
                        </td>
                    </tr>
                    <tr>
                        <td class="admin_table_body" align="center">
                            <table align="center">
                                <tr>
                                    <td>
                                        <e:input type="text" size="80px" style="width:200px;"
                                                 value="#{warUpdatorBean.vwDirPath}"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="admin_table_body" align="center">
                            <e:button ajax="true" id="updtVW" value="Update Workflow"
                                      onclick="#{warUpdatorBean.updateVisualWorkflow}"
                                      style="width:200px;"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="admin_table_body">&nbsp;</td>
                    </tr>--%>
                    <!-- visual workflow updator ends here -->
                    <%--<tr>
                        <td align="center" class="admin_table_body">
                            <b>Update Images</b>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="admin_table_body">
                            Images Directory Path
                        </td>
                    </tr>
                    <tr>
                        <td class="admin_table_body" align="center">
                            <table align="center">
                                <tr>
                                    <td>
                                        <e:input type="text" size="80px" style="width:200px;"
                                                 value="#{warUpdatorBean.limsImagesDirPath}"></e:input>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="admin_table_body" align="center">
                            <e:button ajax="true" id="updtImage" value="Update Images"
                                      onclick="#{warUpdatorBean.updateImages}" style="width:200px;"/>
                        </td>
                    </tr>--%>
                   <%-- <tr>
                        <td class="admin_table_body">&nbsp;</td>
                    </tr>--%>
                    <%--<tr>
                        <td align="center" class="admin_table_body">
                            <b>Backup Present LabWare Admin Configuration</b>
                        </td>
                    </tr>
                    <tr>
                        <td class="admin_table_body" align="center">
                            <e:button ajax="false" id="configBckup" value="Backup Configuration"
                                      onmousedown="this.formAction = ec.dom.getParentForm(this).action"
                                      onclick="if(updateWL3())#{warUpdatorBean.backupConfig}"
                                      onmouseup="setTimeout(ec.util.linkThis(function(){ec.submitting=false;ec.dom.getParentForm(this).action=this.formAction;}, this), 500)"
                                      style="width:200px;"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="admin_table_body">&nbsp;</td>
                    </tr>

                    <tr>
                        <td align="center" class="admin_table_body">
                            <b>Restore Previous LabWare Admin Configuration</b>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="admin_table_body">
                            <table align="center">
                                <tr>
                                    <td>
                                        <e:fileUpload id="uploadConfig" value="#{warUpdatorBean.configFile}" ajax="true"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="admin_table_body" align="center">
                            <e:button ajax="true" id="configRestore" value="Restore Configuration"
                                      onclick="if(confirmWarUpdate())#{warUpdatorBean.restoreConfig}" style="width:200px;"/>
                        </td>
                    </tr>--%>

                    <tr>
                        <td class="admin_table_body">&nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>

    </table>

</e:define>