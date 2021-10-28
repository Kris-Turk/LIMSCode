<%--
(C)Copyright 2000-2019 by LabWare, Inc; All rights reserved

@author Avik Chatterjee
--%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://www.simplica.com/jsf/ecruiser" prefix="e" %>
<f:view>
    <html>

    <head>
        <title>Call Web Service</title>
        <link id="favicon" rel="shortcut icon" href="img/LabWare.ico"/>
        <link rel="stylesheet" type="text/css" href="common/css/lw-theme/jquery-ui-1.12.1.custom.css">
        <link rel="stylesheet" type="text/css" href="admin/stylesheet/labware_admin.css">
        <link rel="stylesheet" type="text/css" href="admin/stylesheet/styles.css">
        <link rel="stylesheet" type="text/css" href="common/css/button.css">

        <script type="text/javascript">
            String.prototype.trim = function () {
                var x = this;
                x = x.replace(/^\s*(.*)/, "$1");
                x = x.replace(/(.*?)\s*$/, "$1");
                return x;
            };
            function validateUserNameAndPassword() {
                var userName = document.getElementById("loginForm:loginLayout:username");
                var password = document.getElementById("loginForm:loginLayout:password");
                if (userName.value.trim() == "") {
                    alert("Please enter the User Name. User Name can't be blank.");
                    userName.style.backgroundColor = "red";
                    userName.focus();
                    return false;
                }
                else if (password.value.trim() == "") {
                    alert("Please enter the Password. Password can't be blank.");
                    password.style.backgroundColor = "red";
                    password.focus();
                    return false;
                } else {
                    return true;
                }
            }

            function checkFocus() {
                if (document.forms[0].elements[0].type != "hidden") {
                    document.forms[0].elements[0].focus();
                }
            }
            if (window.attachEvent) {
                window.attachEvent("onload", checkFocus);
            } else if (window.addEventListener) {
                window.addEventListener("load", checkFocus, false);
            }
        </script>
        <style type="text/css">
            .input-style {
                border: 1px solid #89a5bd;
                color: #444;
                font-family: Verdana;
                font-size: 12px;
                height: 24px;
                line-height: 24px;
                margin-left: 8px;
                padding-left: 3px;
                width: 100%;
            }

            .formLabel, .formLabelDisabled, .formLabelRequired, .formLabelInvalid {
                text-align: right;
                color: #000000;
                font-size: 13px;
                white-space: nowrap;
                height: 20px;
                margin-top: 10px;
            }

            .formLabelDisabled {
                color: gray;
            }

            .formLabel span {
                color: #000000;
            }

            .formLabelRequired {
                color: blue;
            }

            .formLabelInvalid {
                color: red;
            }
        </style>

    </head>

    <body style="margin:0;padding:0;height: 100%;overflow: hidden;background-color: azure;">

    <e:form id="loginForm" style="display:block;margin:0;padding:0;width:100%;height:100%">

        <e:div id="notRenderDiv" styleClass="admin_message_error" rendered="#{!callWebServiceBean.callWSEnable}">Access disabled for this page.</e:div>

        <e:div id="renderDiv" rendered="#{callWebServiceBean.callWSEnable}">
            <!-- Header table -->
            <table cellpadding="0" width="100%" height="75px" cellspacing="0">

                <!-- Header row -->
                <tr>
                    <td width="1%" height="75"><img src="admin/images/logo.gif" alt="LabWare" height="75" width="200">
                    </td>
                    <td width="99%" class="admin_header" valign="middle">
                        Call Webservice
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <table cellspacing="0" cellpadding="0" height="100%" width="100%">
                            <tr>
                                <td class="top-menu">&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

            <table width="100%" cellspacing="0" cellpadding="0" class="miniapp_table_body">
                <tr>
                    <td align="center">
                        <h:messages showDetail="true" showSummary="false" infoClass="admin_message"
                                    errorClass="admin_message_error" layout="table"/>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <e:a styleClass="admin_message" id="originalRequestAnchor"
                             href="#{callWebServiceBean.originalRequest}"
                             value="#{callWebServiceBean.originalRequest}" rendered="#{callWebServiceBean.renderLink}"
                             target="_self"/>
                    </td>
                </tr>
            </table>

            <!-- Main table -->
            <table width="100%" cellspacing="0" cellpadding="0" style="height: 80%" class="miniapp_table_body">

                <tr>
                    <!-- This is the main pane -->
                    <td valign="top">
                        <table width="100%" border="0" style="height: 80%" cellspacing="0" cellpadding="0"
                               align="center"
                               class="miniapp_table_body">

                            <tr>
                                <td>
                                    <e:fieldLayout id="loginLayout" fieldStyle="formControl" labelStyle="formLabel"
                                                   disabledStyle="formLabelDisabled"
                                                   invalidStyle="formLabelInvalid" requiredStyle="formLabelRequired"
                                                   headingStyle="fieldLayoutHeading"
                                                   showMessages="false" align="center" heading="Login Required"
                                                   rendered="#{callWebServiceBean.renderLoginFieldLayout}">
                                        <e:input value="#{callWebServiceBean.userName}" focus="true" id="username"
                                                 label="User Name: "
                                                 styleClass="input-style ui-widget-content ui-corner-all"/>
                                        <e:input type="password"
                                                 value="#{callWebServiceBean.password}"
                                                 id="password"
                                                 label="Password: "
                                                 styleClass="input-style ui-widget-content ui-corner-all"/>
                                        <e:checkbox id="chkRememberMe" value="#{callWebServiceBean.rememberMe}"
                                                    style="align:center;"
                                                    label="#{callWebServiceBean.rememberMeLabel}"
                                                    rendered="#{callWebServiceBean.renderRememberMe}"/>
                                        <e:button value="#{loginBean.loginlable}" id="loginButton" ajax="false"
                                                  styleClass="btn btn-blue"
                                                  style="margin-left: 8px; padding:8px 10px 8px 10px;font-size:1.0em;min-width:56px;"
                                                  onclick="if(validateUserNameAndPassword())#{callWebServiceBean.callWebService}"
                                                  label=""/>
                                    </e:fieldLayout>
                                </td>
                            </tr>

                        </table>
                    </td>
                </tr>
            </table>

            <!-- Footer table -->
            <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#626162">
                <tr>
                    <td width="100%" align="left" valign="middle" bgcolor="#000099" class="footer">
                        <br>&nbsp;&nbsp;Copyright &copy; 2019 LabWare, Inc. All rights reserved.<br><br>
                    </td>
                </tr>
            </table>
        </e:div>
    </e:form>
    </body>

    </html>
</f:view>