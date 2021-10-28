    <%--
(C)Copyright 2000-2019 by LabWare, Inc; All rights reserved

This page is to configure log file and configure SOAP logging.

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
    <script type="text/javascript" language="JavaScript">
        window.document.title = "LabWare Admin Console--System Variables";
    </script>
    <table cellpadding="1" width="100%" class="admin_table_body" cellspacing="2" border="0">
        <tr>
            <td width="100%" valign="top" align="center" class="admin_table_header_ds" colspan="2">
                <e:div id="loggingMsgDiv">
                    <h:messages styleClass="admin_message" id="loggingMsg" showDetail="true" showSummary="false"
                                layout="table" binding="#{messagesBean.messages}"/>
                </e:div>
            </td>
        </tr>
        <tr>
            <td width="100%" align="center" class="admin_table_header" colspan="2">Configure Server Logs</td>
        </tr>
        <%--<tr>
            <td colspan="2" width="50%" align="center">
                <table cellpadding="2" width="100%" class="admin_table_body" cellspacing="2" border="0">--%>
                    <tr>
                        <td class="admin_table_body_noalign" style="padding-top:6px;" align="right" width="50%">
                            <e:span styleClass="required_field_label" value="File Directory:"/>
                        </td>
                        <td class="admin_table_body_noalign" align="left" width="50%">
                            <e:input id="logFilePath" value="#{loggingBean.logFilePath}"
                                     label="File Path" disabled="false" ajax="tue"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="admin_table_body_noalign" style="padding-top:6px;" align="right" width="50%">
                            <e:span styleClass="required_field_label" value="Debug Log Level:"/>
                        </td>
                        <td class="admin_table_body_noalign" align="left" width="50%">
                            <h:selectOneMenu id="level" value="#{loggingBean.debugLogLevel}" disabled="false">
                                <f:selectItem itemLabel="All" itemValue="ALL"/>
                                <f:selectItem itemLabel="Debug" itemValue="DEBUG"/>
                                <f:selectItem itemLabel="Info" itemValue="INFO"/>
                                <f:selectItem itemLabel="Warn" itemValue="WARN"/>
                                <f:selectItem itemLabel="Off" itemValue="OFF"/>
                            </h:selectOneMenu>
                        </td>
                    </tr>

        <tr>
            <td align="center" class="admin_table_body" width="100%" colspan="2">

                <e:button id="fileSave" value="Save"
                          onclick="#{loggingBean.saveLogAppender}" ajax="true"
                          disabled="false"/>

            </td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td width="100%" align="center" class="admin_table_header" colspan="2">Configure SOAP Logging</td>
        </tr>
        <tr>
            <td class="admin_table_body_noalign" style="padding-top:6px;" align="right" width="50%">
                <e:span styleClass="required_field_label" value="SOAP Logging enabled:"/>
            </td>
            <td class="admin_table_body_noalign" align="left" width="50%">
                <e:checkbox id="soapEnabled" value="#{loggingBean.soapEnabledVal}"
                            label="SOAP Logging enabled:"/>
            </td>
        </tr>
        <tr>
            <td class="admin_table_body_noalign" style="padding-top:6px;" align="right" width="50%">
                <e:span styleClass="required_field_label" value="SOAP Logging Path:"/>
            </td>
            <td class="admin_table_body_noalign" align="left" width="50%">
                <e:input id="soapLogPath" value="#{loggingBean.soapLogPath}"
                         label="SOAP Logging Path:"/>
            </td>
        </tr>
        <tr>
            <td class="admin_table_body_noalign" style="padding-top:6px;" align="right" width="50%">
                <e:span styleClass="required_field_label" value="SOAP file limit:"/>
            </td>
            <td class="admin_table_body_noalign" align="left" width="50%">
                <e:numberinput style="width:85px;" minimum="0" maximum="999999" pattern="######" spinButtons="false"
                               id="soapLogFileMax" value="#{loggingBean.soapFileThreshold}"
                               label="SOAP file limit:"/>
            </td>
        </tr>
        <tr>
            <td align="center" class="admin_table_body" width="100%" colspan="2">
                <e:button id="soapFileSave" onclick="#{loggingBean.saveSoapLogging}" value="Save" ajax="true"/>
            </td>
        </tr>

        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>

        <tr>
            <td width="100%" align="center" class="admin_table_header" colspan="2">Configure Server Files</td>
        </tr>
        <tr>
            <td align="center" class="admin_table_body" width="100%" colspan="2">
                <e:button id="commonFileUpload" onclick="#{webConfiBean.uploadCommonFile}" value="Update Common Files" ajax="true" style="width:150px"/>
            </td>
        </tr>
        <tr>
            <td align="center" class="admin_table_body" width="100%" colspan="2">
                <e:button id="imageFileUpload" onclick="#{webConfiBean.uploadImageFile}" value="Update Image Files" ajax="true" style="width:150px"/>
            </td>
        </tr>

        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>

        <tr>
            <td width="100%" align="center" class="admin_table_header" colspan="2">Web Service Settings</td>
        </tr>
        <tr>
            <td class="admin_table_body_noalign" style="padding-top:6px;" align="right" width="50%">
                <e:span value="Test Webservice URL:"/>
            </td>
            <td class="admin_table_body_noalign" style="padding-top:6px;" align="left" width="50%">
                <e:span id="testWSUrl" value="#{limsAdminBean.wsUrl}"
                        label="Test Webservice URL:"/>
            </td>
        </tr>
        <tr>
            <td class="admin_table_body_noalign" style="padding-top:6px;" align="right" width="50%">
                <e:span value="WS Security:"/>
            </td>
            <td class="admin_table_body_noalign" style="padding-top:6px;" align="left" width="50%">
                <e:span id="wSSecurity" value="#{limsAdminBean.wsSecurity}"
                        label="WS Security::"/>
            </td>
        </tr>

        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>


        <tr>
            <td width="100%" align="center" class="admin_table_header" colspan="2">Database Password Encryption (Tomcat)</td>
        </tr>
        <tr>
            <td class="admin_table_body_noalign" style="padding-top:6px;" align="right" width="50%">
                <e:span id="dbPassword" value="Database Password:"/>
            </td>
            <td class="admin_table_body_noalign" align="left" width="50%">
                <e:input id="dbPwd" type="password" value="#{loggingBean.databasePwd}"/>
            </td>
        <tr>
            <td colspan="4" align="center" class="admin_table_body">
                <e:button id="encrypt_dbP"
                          value="Encrypt Database Password"
                          onclick="#{loggingBean.encryptDBPassword}"
                          ajax="true"/></td>
        </tr>

        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td width="100%" align="center" class="admin_table_header" colspan="2">
                E-Mail Alert Settings
                <e:span style="color:red;display:block;font-weight:500;margin-top:4px" value="#{loggingBean.invalidSmtpHost}" />
            </td>
        </tr>
        <tr>
            <td colspan="2" width="100%" align="center">
                <table cellspacing="4" align="center" border="0">
                    <tr>
                        <td align="right"><span id="smtpHost_label" class="required_field_label">SMTP Host:</span></td>
                        <td align="left"><e:span id="smtpHost" value="#{loggingBean.smtpHost}"/></td>
                        <td align="right"><span id="smtpPort_label">SMTP Port:</span></td>
                        <td align="left"><e:span id="smtpPort" value="#{loggingBean.smtpPort}"/></td>
                    </tr>
                    <tr>
                        <td align="right"><span id="fromAddress_label" class="required_field_label">From Address:</span>
                        </td>
                        <td align="left"><e:span id="fromAddress" value="#{loggingBean.fromAddress}"/></td>
                        <td align="right"><span id="toAddresses_label" class="required_field_label">Email Alerts To:</span>
                        </td>
                        <td align="left"><e:span id="toAddresses" value="#{loggingBean.toAddresses}" style="width:170px"/></td>
                    </tr>
                    <tr>
                        <td align="right"><span id="username_label" class="admin_table_body_right_align">SMTP User:</span>
                        </td>
                        <td align="left"><e:span id="username" value="#{loggingBean.smtpUserName}"/></td>
                        <td align="right"><span id="password_label"
                                  class="admin_table_body_right_align">SMTP Password:</span></td>
                        <td align="left"><e:span id="password" value="#{loggingBean.smtpPasswordView}"/></td>
                    </tr>
                    <tr>
                        <td align="right"><span id="disabledChk_label"
                                  class="admin_table_body_right_align">Is Enabled?</span></td>
                        <td align="left"><e:span id="disabledChk" value="#{loggingBean.enableEmail}"/></td>
                        <td align="right"><span id="protocol_label"
                                                class="admin_table_body_right_align">SMTP Protocol:</span></td>
                        <td align="left"><e:span id="protocol" value="#{loggingBean.smtpProtocol}"/></td>
                    </tr>
                    <%--<tr>
                        <td colspan="4">&nbsp;</td>
                    </tr>--%>
                    <tr>
                        <td colspan="4" align="center" class="admin_table_body"><e:button id="emailSave"
                                                                                          value="Send Test Email"
                                                                                          onclick="#{loggingBean.sendEmail}"
                                                                                          ajax="true"/></td>
                    </tr>
                </table>
            </td>
        </tr>
       <%-- <tr>
            <td colspan="2">&nbsp;</td>
        </tr>--%>

    </table>
</e:define>
