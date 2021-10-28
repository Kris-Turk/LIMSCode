<%--
(C)Copyright 2000-2015 by LabWare, Inc; All rights reserved

This page allows to invoke the Websevices functions.

@author Avik Chatterjee
--%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://www.simplica.com/jsf/ecruiser" prefix="e" %>

<e:viewInfo template="/admin/top.jsp" roles="WebAdminTest">
  <e:update id="leftMenu" prop="src" value="/admin/WSConn_SelectFxLeftPane.jsp"/>
  <e:update id="testMenuItem" prop="styleClass" value="top-menu-selected"/>
</e:viewInfo>

<e:define id="mainPane">
  <script type="text/javascript" language="JavaScript">
    window.document.title = "LabWare Admin Console--Invoke Function";
  </script>
  <table cellspacing="0" cellpadding="0" width="100%" border="0">
    <tr>
      <td align="center" valign="top" width="100%">
        <table border="0" cellspacing="0" cellpadding="0" width="100%"
               bgcolor="adb6bd">
          <tr>
            <td align="center">
             <e:div id="invokefxMsgDiv" ajax="true">
                 <h:messages infoClass="admin_message" id="fxMsg"
                             errorClass="admin_message_error" layout="table" binding="#{messagesBean.messages}"/>
             </e:div>
            </td>

          </tr>
          <tr>
            <td width="100%" align="center" valign="middle"
                style="background-color: #739eae; font-family: verdana; color: #ffffff; font-size: 20px; font-weight: bold;">
              Test for the Web Function:
              <h:outputText id="fxName" value="#{invokeFunctionBean.functionName}"/>
            </td>
          </tr>
          <tr>
            <td width="100%" align="left"
                style="background-color: #ffffff; font-family: verdana; font-size: 14px;">
              <b>Web Function Description: </b>
              <h:outputText id="fxDescription"
                            value="#{invokeFunctionBean.functionDescription}"/>
              <br>
              <br>
            </td>
          </tr>
          <tr>
            <td width="100%" align="center" bgcolor="#eff5f5">
              <!--This form gets built through the backing bean .The Panel grid component is chosen because it can render its cildren-->
              <e:fieldLayout id="functionLayout" binding="#{invokeFunctionBean.curentFunctionFieldLayout}"
                             fieldStyle="formControl" labelStyle="formLabel"
                             disabledStyle="formLabelDisabled" invalidStyle="formLabelInvalid"
                             requiredStyle="formLabelRequired" showMessages="false" ajax="true"/>
              <e:button id="invokeFXButton" onclick="#{invokeFunctionBean.submitForm}"
                        value="Invoke Function" ajax="true"/>
            </td>
          </tr>
        </table>
        <br><br>
        <br><br>
        <br><br>
        <br><br>
        <br><br>
        <br><br>
        <br><br>
      </td>
    </tr>
  </table>
</e:define>