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
        window.document.title = "LabWare Admin Console--Web Configuration Variables";
    </script>
    <table cellpadding="2" width="50%" class="admin_table_body" cellspacing="0"
           border="0" align="center">
        <tr>
            <td width="100%" valign="top" align="center" class="admin_table_header_ds" colspan="2">
                <e:div id="monitorInstMsgDiv">
                    <h:messages styleClass="admin_message" id="monitorInstMsg" showDetail="true" showSummary="false"
                                layout="table" binding="#{messagesBean.messages}"/>
                </e:div>
            </td>
        </tr>
        <tr>
            <td width="100%" align="center" class="admin_table_header" colspan="2">LIMS System Configuration</td>
        </tr>
        <tr>
            <td width="100%" align="center" class="admin_table_header" colspan="2">
                <e:fieldLayout id="monitorInstLayout" columns="4" labelStyle="required_field_label" align="center"
                               ajax="true">
                    <e:select id="serviceSelect" ajax="true" label="Select LIMS DataSource:"
                              value="#{webConfiBean.monitorDataSourceVal}"
                              data="#{webConfiBean.dataSourceList}"
                              onchange="#{webConfiBean.processDSListChangeForWebConfig}"/>
                </e:fieldLayout>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td align="center" class="admin_table_body">
                <fieldset>
                    <legend class="required_field_label">System</legend>
                    <table cellpadding="2" cellspacing="0" border="0" width="100%" align="center">
                        <tr>
                            <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">Web
                                File Path:
                            </td>
                            <td align="left" class="admin_table_body_noalign" style="padding-top:6px;"><e:span id="webFilePath" value="#{webConfiBean.webFilePath}"/></td>
                        </tr>
                        <tr>
                            <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">
                                Session
                                Timeout
                                (mins):
                            </td>
                            <td align="left" class="admin_table_body_noalign" style="padding-top:6px;">
                                <e:span id="sessionInput" value="#{webConfiBean.sessionTimeout}" style="width:61px;" ajax="true"/>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">
                                Absolute
                                Timeout
                                (mins):
                            </td>
                            <td align="left" class="admin_table_body_noalign" style="padding-top:6px;">
                                <e:span id="absTimeout" value="#{webConfiBean.absTimeout}" style="width:61px;" ajax="true"/>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">
                                Default
                                Service:
                            </td>
                            <td align="left" class="admin_table_body_noalign" style="padding-top:6px;"><e:span id="defaultService" value="#{webConfiBean.defaultService}"/></td>
                        </tr>
                        <tr>
                            <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">
                                Reference
                                JNDI:
                            </td>
                            <td align="left" class="admin_table_body_noalign" style="padding-top:6px;"><e:span id="refJNDI" value="#{webConfiBean.refJNDI}"/></td>
                        </tr>
                        <tr>
                            <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">
                                Common Files:
                            </td>
                            <td align="left" class="admin_table_body_noalign" style="padding-top:6px;"><e:span id="commonFiles" value="#{webConfiBean.commonFiles}"/></td>
                        </tr>
                        <tr>
                            <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">
                                Image Files:
                            </td>
                            <td align="left" class="admin_table_body_noalign" style="padding-top:6px;"><e:span id="imageFiles" value="#{webConfiBean.imageFiles}"/></td>
                        </tr>
                        <tr>
                            <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">
                                Autocomplete:
                            </td>
                            <td align="left" style="padding-top:6px;"><e:span id="autocomplete" value="#{webConfiBean.autocomplete}"/></td>
                        </tr>
                        <tr>
                            <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">
                                Remember Me<br>Call-WebServices
                                App:
                            </td>
                            <td align="left" style="padding-top:6px;"><e:span id="rmCallWS" value="#{webConfiBean.rmCallWS}"/></td>
                        </tr>
                        <tr>
                            <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">
                                Remember Me<br>Mainpane
                                App:
                            </td>
                            <td align="left" style="padding-top:6px;"><e:span id="rmMainpane" value="#{webConfiBean.rmMainpane}"/></td>
                        </tr>
                        <tr>
                            <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">
                                Remember Me<br>LabWare
                                App:
                            </td>
                            <td align="left" style="padding-top:6px;"><e:span id="rmLW" value="#{webConfiBean.rmLWApp}"/></td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
        <tr>
            <td align="center" class="admin_table_body">
                <fieldset>
                    <legend class="required_field_label">Enable Access</legend>
                    <table cellpadding="2" cellspacing="0" border="0" width="100%" align="center">
                        <tr>
                            <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">PDF
                                Submit:
                            </td>
                            <td align="left" style="padding-top:6px;"><e:span id="pdfSubmit" value="#{webConfiBean.pdfSubmit}"/></td>
                        </tr>
                        <tr>
                            <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">Call
                                Web Service:
                            </td>
                            <td align="left" style="padding-top:6px;"><e:span id="callWebService" value="#{webConfiBean.callWS}"/></td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
        <tr>
            <td align="center" class="admin_table_body">
                <fieldset>
                    <legend class="required_field_label">reCAPTCHA</legend>
                    <table cellpadding="2" cellspacing="0" border="0" width="100%" align="center">
                        <tr>
                            <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">
                                Enabled:
                            </td>
                            <td align="left" style="padding-top:6px;"><e:span id="rcEnabled" value="#{webConfiBean.rcEnabled}"/></td>
                        </tr>
                        <tr>
                            <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">
                                Failure Interval (min):
                            </td>
                            <td align="left" style="padding-top:6px;"><e:span id="rcFailIntv" value="#{webConfiBean.rcFailIntv}"/></td>
                        </tr>
                        <tr>
                            <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">
                                Failure Threshold:
                            </td>
                            <td align="left" style="padding-top:6px;"><e:span id="rcFailTh" value="#{webConfiBean.rcFailTh}"/></td>
                        </tr>
                        <tr>
                            <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">
                                Secret Key:
                            </td>
                            <td align="left" style="padding-top:6px;"><e:span id="rcSecretKey" value="#{webConfiBean.rcSecretKey}"/></td>
                        </tr>
                        <tr>
                            <td align="right" width="50%" class="admin_table_body_noalign" style="padding-top:6px;">Site
                                Key:
                            </td>
                            <td align="left" style="padding-top:6px;"><e:span id="rcSiteKey" value="#{webConfiBean.rcSiteKey}"/></td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
    </table>
</e:define>
