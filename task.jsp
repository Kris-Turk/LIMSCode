<!DOCTYPE html>

<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://www.simplica.com/jsf/ecruiser" prefix="e" %>
<%@ taglib uri="http://www.labware.com/components" prefix="lw" %>

<f:view>
  <html style="height: 100%;overflow: hidden;">

  <head>
    <e:verbatim value="#{top.taskFavicon}"/>

    <title></title>

    <link rel="stylesheet" type="text/css" href="common/css/lw-theme/jquery-ui-1.12.1.custom.css">
    <link rel="stylesheet" type="text/css" href="common/css/jquery.Jcrop.css">

    <link rel="stylesheet" type="text/css" href="common/css/labware.css">
    <link rel="stylesheet" type="text/css" href="common/css/task.css">

    <script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
    <script type="text/javascript" src="js/jquery-migrate-1.4.1.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.12.min.js"></script>
    <script type="text/javascript" src="common/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="common/js/jsencrypt.js"></script>
    <script type="text/javascript" src="labware.js"></script>
  </head>

  <body style="margin:0;height: 100%;overflow: hidden;"
        onkeydown="setGlobalEventFlag();checkForLockTimeout();"
        onload="resetGlobalEventFlag();try{self.focus();}catch(e){};setAppType(false);setupModalLayer();initWindowOKCancel();registerTaskWindow();setupTaskContainerEvents();checkForLockTimeout();setLockWindowChecker();"
        onclick="checkForLockTimeout();" onmousedown="setGlobalEventFlag();">

  <div id="ec_safari_event_wrapper_div" style="width:100%;height:100%">
    <e:form id="mf" onsubmit="return false">
       <lw:keyspan id="fkey" />
      <e:input id="sessionTimeOutInput" type="hidden" value="#{loginBean.sessionTimeoutinMins}"/>
      <e:input id="isLockOnTimeout" type="hidden" value="#{loginBean.isLockOnTimeout}"/>
      <e:input id="lockTimeout" type="hidden" value="#{loginBean.lockTimeout}"/>
      <e:input id="limsActTimeout" type="hidden" value="#{loginBean.limsActivityTimeout}"/>

      <div class="top-bar">
        <div class='main-toolbar-popup-button'></div>
        <div class="main-toolbar-popup">
          <lw:mainToolbar id="mainToolbar" ajax="true"/>
        </div>

        <e:div styleClass="title-inner" id="taskTitle"/>
        <div class="search">
          <e:suggestInput id="search"
                          dataModel="#{top.searchModel}"
                          caseSensitive="false"
                          keyField="id"
                          filterFields="text"
                          labelFields="text"
                          suggestColumnIds="text,parent"
                          styleClass="search-input"
                          suggestBoxStyle="search-suggest-list"
                          suggestHoverStyle="search-suggest-list-hover"
                          suggestMatchStyle="search-suggest-match"
              >
            <e:keystroke global="false" onkeydown="#{top.search}" key="13"/>
          </e:suggestInput>
          <e:button type="button" value="" styleClass="search-button"/>
        </div>
      </div>

      <e:div id="mainTabPaneDiv" styleClass="main-bar-inner">
        <!-- This cell holds the main tab pane -->
        <lw:taskContainer id="tp" ajax="true" style="width:100%;height:100%;" immediateEvent="false"/>
      </e:div>

    </e:form>

    <e:form id="sessionTimeoutForm">
      <lw:window id="sessionTimeout" title="Session timeout"
                 width="260px" height="200px" align="center"
                 movable="true" resizable="false" modal="true" closeOnEscape="false"
                 showClose="false" showMaximize="false" showMinimize="false" ajax="true">
        <table border="0" cellpadding="4" cellspacing="4" align="center">
          <tr>
            <td align="center"><br>
              <p><e:span id="readTimeoutspan" value=""></e:span></p></td>
          </tr>
          <tr>
            <td align="center">&nbsp;</td>
          </tr>
          <tr>
            <td align="center">
              <e:button styleClass="btn btn-blue" value="#{loginBean.assignrolelable}" ajax="true" id="ok_button"
                        style="align:center" onclick="doSessionInvalidate()"/></td>
            <td align="center">
            </td>
          </tr>
        </table>
      </lw:window>
    </e:form>

    <e:div id="windowHolderDiv" ajax="false"/>
    <e:div id="lockWindowDiv" ajax="false"/>
    <e:div id="soundFieDiv" ajax="true"/>
    <e:div id="lbpDialog" ajax="true"/>
    <lw:sendfile id="sendFileDiv" ajax="true"/>
    <e:form id="fileUploadForm">
      <e:fileUpload id="fileUploadControl" style="position:absolute;top:-100px;left:-100px;"
                           onchange="#{controller.sendFileContent}"  oncancel="#{controller.cancelSendFile}" label=""></e:fileUpload>
    </e:form>
  </div>

  <e:verbatim value="#{top.taskContainerResponderUrl}"></e:verbatim>
  <script type="text/javascript" language="JavaScript">
    //This variable stores the session time out value in minutes.
    // It is declared in labware.js and initialise here
    // so that the value can be extracted from the hidden input, which is declared above.
    sessionTimeoutMins = document.getElementById('mf:sessionTimeOutInput').value;
    isLockTimeout = document.getElementById('mf:isLockOnTimeout').value;
    try {
      isLockTimeout = isLockTimeout.trim().toLowerCase();
      isLockTimeout = ('true' == isLockTimeout);
    } catch (e) {
      isLockTimeout = false;
    }
    lockTimeout = document.getElementById('mf:lockTimeout').value;
    limsActTimeout = document.getElementById('mf:limsActTimeout').value;

    //This function is written in labware.js
    setupWindowUload(window.taskContainerResponderUrl);
    resetIEOnHelp();
    remove_href();
    checkForLockTimeout()
  </script>

  </body>
  </html>
</f:view>
