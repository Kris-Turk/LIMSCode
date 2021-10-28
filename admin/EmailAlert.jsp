<%--
(C)Copyright 2000-2016 by LabWare, Inc; All rights reserved

This page is to configure e-mail alerts.

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
        window.document.title = "LabWare Admin Console--Setup Email Alert";

        window.saveEmailAlertValidate = function (evt) {
            var smtpHost = document.getElementById("limsAdminForm:smtpHost");
            var toAddresses = document.getElementById("limsAdminForm:toAddresses");
            var fromAddress = document.getElementById("limsAdminForm:fromAddress");
            var e = (window.event) ? window.event : evt;
            if (smtpHost != null && smtpHost.value != undefined) {
                if (smtpHost.value.trim() == "") {
                    alert("Please Enter SMTP Host. SMTP Host can't be blank.");
                    smtpHost.style.backgroundColor = "red";
                    smtpHost.focus();
                    ec.bs.stopEvent(e);
                    return false;
                }
            } if(toAddresses != null && toAddresses.value != undefined){
                if (toAddresses.value.trim() == "") {
                    alert("Please Enter 'Email Alerts To'. 'Email Alerts To' can't be blank.");
                    toAddresses.style.backgroundColor = "red";
                    toAddresses.focus();
                    ec.bs.stopEvent(e);
                    return false;
                } else{
                    var email_to_arr = toAddresses.value.split("\n");
                    for (var i = 0; i < email_to_arr.length; i++) {
                        if (!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email_to_arr[i]))) {
                            alert("Invalid entry in 'Email Alerts To: ' "+email_to_arr[i]);
                            toAddresses.focus();
                            ec.bs.stopEvent(e);
                            return false;
                        }
                    }
                }
            }
            if (fromAddress != null && fromAddress.value != undefined) {
                if (fromAddress.value.trim() == "") {
                    alert("Please Enter 'From Address'. 'From Address' can't be blank.");
                    fromAddress.style.backgroundColor = "red";
                    fromAddress.focus();
                    ec.bs.stopEvent(e);
                    return false;
                } else {
                    var email_from = fromAddress.value;
                    if (!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email_from))) {
                        alert("Invalid entry in 'From Address: ' " + email_from);
                        fromAddress.focus();
                        ec.bs.stopEvent(e);
                        return false;
                    }
                }
            }
            return true;
        }
    </script>

    <table cellpadding="5" width="100%" class="admin_table_body" cellspacing="0" border="0">
        <tr>
            <td width="100%" valign="top" align="center" class="admin_table_header_ds">

                <e:div id="emailErrorsMsgDiv">
                    <h:messages styleClass="admin_message" id="emailErrors" binding="#{messagesBean.messages}"
                                layout="table"/>
                </e:div>
            </td>
        </tr>
        <!--Row for Email Appender-->
        <tr>
            <td width="100%" align="center" class="admin_table_header">Configure Email Alerts</td>
        </tr>
        <tr>
            <td class="admin_table_body">&nbsp;</td>
        </tr>
        <tr>
            <td width="100%">
                <table cellspacing="5" align="center" border="0">
                    <tr>
                        <td><span id="smtpHost_label" class="required_field_label">SMTP Host:</span></td>
                        <td><e:input size="25" id="smtpHost" value="#{loggingBean.smtpHost}"/></td>
                        <td>&nbsp;&nbsp;&nbsp;</td>
                        <td><span id="smtpPort_label" class="admin_table_body_right_align">SMTP Port:<br>(If other than port 25)</span>
                        </td>
                        <td><e:input size="25" id="smtpPort" value="#{loggingBean.smtpPort}" maxlength="6"/></td>
                    </tr>
                    <tr>
                        <td><span id="fromAddress_label" class="required_field_label">From Address:</span></td>
                        <td><e:input size="25" id="fromAddress" value="#{loggingBean.fromAddress}"/></td>
                        <td>&nbsp;&nbsp;&nbsp;</td>
                        <td><span id="toAddresses_label" class="required_field_label">Email Alerts To:<br>(One entry per line)</span>
                        </td>
                        <td><e:textarea rows="5" cols="30" id="toAddresses" value="#{loggingBean.toAddresses}"
                                        style="width:170px"/></td>
                    </tr>
                    <tr>
                        <td><span id="username_label" class="admin_table_body_right_align">SMTP User:</span></td>
                        <td><e:input size="25" id="username" value="#{loggingBean.smtpUserName}"/></td>
                        <td>&nbsp;&nbsp;&nbsp;</td>
                        <td><span id="password_label" class="admin_table_body_right_align">SMTP Password:</span></td>
                        <td><e:input size="25" id="password" type="password" value="#{loggingBean.smtpPassword}"/></td>
                    </tr>
                    <%--<tr>
                        <td><span id="requiresSSL_label" class="admin_table_body_right_align">Requires SSL:</span></td>
                        <td align="left"><e:checkbox id="requiresSSL" ajax="true" value="#{loggingBean.needsSSL}"/></td>
                        <td>&nbsp;&nbsp;&nbsp;</td>
                        <td><span id="disabledChk_label" class="admin_table_body_right_align">Is Enabled?</span></td>
                        <td align="left"><e:checkbox id="disabledChk" ajax="true" value="#{loggingBean.enableEmail}"
                                                     onchange="#{loggingBean.disableEmailAppender}"/></td>
                    </tr>--%>
                    <tr>
                        <td colspan="5">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="5" align="center" class="admin_table_body"><e:button id="emailSave" value="Save"
                                                                                          onclick="if(saveEmailAlertValidate(event))#{loggingBean.saveEmailAppender}"
                                                                                          ajax="true"/></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>

    </table>
</e:define>

