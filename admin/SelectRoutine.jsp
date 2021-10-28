<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://www.simplica.com/jsf/ecruiser" prefix="e" %>

<e:viewInfo template="/admin/top.jsp" roles="WebAdminTest">
    <e:update id="leftMenu" prop="src" value="/admin/WSConn_SelectFxLeftPane.jsp"/>
    <e:update id="testMenuItem" prop="styleClass" value="top-menu-selected"/>
</e:viewInfo>

<e:define id="mainPane">
    <script type="text/javascript">
      window.document.title = "LabWare Admin Console -- Select Web Routine";
    </script>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td width="100%"  align="center">
                <e:div id="errorMessages_selectRoutineDiv">
                    <h:messages id="errorMessages_selectRoutine" layout="table" styleClass="admin_message"/>
                </e:div>
            </td>
        </tr>

        <tr>
            <td width="100%" align="center" class="admin_table_header" colspan="2">
                Select Web Routine
            </td>
        </tr>

        <tr>
            <td class="admin_table_body">&nbsp;</td>
        </tr>

        <tr>
            <td class="admin_table_body" colspan='2' width='100%' align="center">
                <e:fieldLayout fieldStyle="formControl" labelStyle="formLabel" disabledStyle="formLabelDisabled"
                               invalidStyle="formLabelInvalid" requiredStyle="formLabelRequired" showMessages="false"
                               align="center">
                    <e:input id="filterInput" ajax="true" value="#{webRoutineTableBean.filterValue}"
                             onkeyup="#{webRoutineTableBean.filterTable}" label="Search Routines:"/>
                </e:fieldLayout>
                <table class="dataTableTop" cellpadding="0" cellspacing="0" width="750px" align="center">
                    <tr>
                        <td width="1%"><img src="images/datatable-top-left.gif" alt="" height="24" width="15"></td>
                        <td width="98%" class="dataTableTitle"
                            style="background-image:url(images/datatable-top-middle.gif)">
                            Web Routines
                        </td>
                        <td width="1%"><img src="images/datatable-top-right.gif" alt="" height="24" width="15"></td>
                    </tr>
                </table>
                <e:datatable
                        id="webRoutineTable"
                        dataModel="#{webRoutineTableBean.dataModel}"
                        border="0"
                        title="Web Routine Table"
                        innerCellspacing="1"
                        innerCellpadding="4"
                        cellspacing="0"
                        cellpadding="0"
                        minRows="10"
                        height="300px"
                        sortImageColor="white"
                        bgcolor="#cccccc"
                        columnSorting="true"
                        pageSize="-1"
                        headerHeight="19px"
                        width="750px"
                        showTop="false"
                        showHeader="true"
                        align="center"
                        >
                    <e:dataTr>
                        <e:dataTd id="functionName" label="Routine Name" width="140" nowrap="true"/>
                        <e:dataTd id="testFunctionString" label="Test Function" width="140" nowrap="true"
                                  align="center">
                            <e:a id="testFunctionAnchor" onclick="#{webRoutineTableBean.testRoutine}"
                                 value="#{ROW.testFunctionString}"/>
                        </e:dataTd>
                        <e:dataTd id="showwsdlString" label="Show WSDL" width="140" nowrap="true" align="center">
                            <e:a id="showWsdlAnchor" ajax="true" value="#{ROW.showwsdlString}"
                                 onclick="#{webRoutineTableBean.wsdlURL}"/>
                        </e:dataTd>
                    </e:dataTr>
                </e:datatable>
            </td>
        </tr>
        <tr>
            <td class="admin_table_body">&nbsp;</td>
        </tr>
        <tr>
            <td class="admin_table_body" colspan='2' width='100%' align="center">
                <e:button id="rebuildRoutines" ajax="true" immediateEvent="true" onclick="#{webRoutineTableBean.refreshRoutines}"
                          value="Rebuild"/>
            </td>
        </tr>
        <tr>
            <td class="admin_table_body">&nbsp;</td>
        </tr>
    </table>
</e:define>