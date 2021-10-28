<%--
(C)Copyright 2000-2015 by LabWare, Inc; All rights reserved

@author Avik Chatterjee
--%>
<!DOCTYPE html>

<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://www.simplica.com/jsf/ecruiser" prefix="e" %>
<%@ taglib uri="http://www.labware.com/components" prefix="lw" %>

<f:view>
  <html style="height: 100%;overflow: hidden;">

  <head>
    <title><e:verbatim value="#{top.browserTitle}"></e:verbatim></title>
    <link id="favicon" rel="shortcut icon" href="img/LabWare.ico"/>
    <link rel="stylesheet" type="text/css" href="common/css/lw-theme/jquery-ui-1.12.1.custom.css">
    <link rel="stylesheet" type="text/css" href="common/css/jquery.Jcrop.css">

    <link rel="stylesheet" type="text/css" href="common/css/labware.css">
    <link rel="stylesheet" type="text/css" href="common/css/home.css">

    <script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
    <script type="text/javascript" src="js/jquery-migrate-1.4.1.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.12.min.js"></script>
    <script language="JavaScript" src="labware.js" type="text/javascript"></script>
    <script type="text/javascript" src="common/js/jsencrypt.js"></script>
    <style type="text/css">

    </style>


  </head>

  <body style="margin:0;padding:0;height: 100%;overflow: hidden;" id="bgcolor-inner"
        onkeydown="setGlobalEventFlag();checkForLockTimeout()"
        onload="resetGlobalEventFlag();try{self.focus();}catch(e){};setAppType('true');checkForLockTimeout();setupModalLayer();initWindowOKCancel();setupTaskContainerEvents();setLIMSActivityTimer()"
        onclick="checkForLockTimeout()" onmousedown="setGlobalEventFlag();">

  <div id="ec_safari_event_wrapper_div" style="width:100%;height:100%">
    <e:form id="mf" onsubmit="return false" style="display:block;margin:0;padding:0;width:100%;height:100%">
      <e:input id="sessionTimeOutInput" type="hidden" value="#{loginBean.sessionTimeoutinMins}"/>
      <e:input id="isLockOnTimeout" type="hidden" value="#{loginBean.isLockOnTimeout}"/>
      <e:input id="lockTimeout" type="hidden" value="#{loginBean.lockTimeout}"/>
      <e:input id="limsActTimeout" type="hidden" value="#{loginBean.limsActivityTimeout}"/>
      <e:input id="isSSO" type="hidden" value="#{loginBean.isSSO}"/>
      <e:input id="appName" type="hidden" value="#{loginBean.applicationName}"/>

      <div class="top-bar clearfix" style="display:none;">
        <div id="home-tb-toggle" class="home-tb-toggle-expanded"></div>
        <lw:mainMenuBar id="mainMenu" ajax="true" styleClass="homeMenuBar"
                        binding="#{commonTaskBean.mainMenuBar}"
                        mnemonicModifier="alt-shift"
                        topCellStyle="tc,tcl,tct,tcs,tcr"
                        topCellActiveStyle="tca"
                        topCellDisabledStyle="tcd"
                        topCellHoverStyle="tch"
                        subMenuStyle="sub"
                        menuCellStyle="mc,mcl,mct,mcs,mcr"
                        menuCellDisabledStyle="mcd"
                        menuCellHoverStyle="mch"
                        separatorStyle="sep"

        />
      </div>
      <div id="container_mp">
        <div class="home-left-mp" style="display:none;">
          <div style="width: 196px; display: block; margin: 14px 14px 0 24px">
            <img src="img/labware-logo.png" alt="" id="home-logo"/>
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
              <e:button type="button" value="" styleClass="search-button" onclick="#{top.search}"/>
            </div>
          </div>

          <!-- Start left menu-->
          <div class="home-main-toolbar-parent">
            <lw:mainToolbar id="mainToolbar" ajax="true"/>
          </div>
          <!-- End Start left menu-->

        </div>
        <!-- Start Right Box-->
        <div class="home-right-mp">
          <e:tabpane binding="#{top.wfTabPane}"/>
        </div>
        <!-- End Right Box-->
      </div>

      <lw:taskContainer id="tp" ajax="true" style=" " immediateEvent="false"/>

      <e:div id="soundFileScriptHolderDiv" ajax="true"/>

      <e:div id="scrollArea"></e:div>
      <e:div id="errorBox"></e:div>

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
    <lw:sendfile id="sendFileDiv" ajax="true"/>
    <e:form id="fileUploadForm">
      <e:fileUpload id="fileUploadControl" style="position:absolute;top:-100px;left:-100px;"
                    onchange="#{controller.sendFileContent}" oncancel="#{controller.cancelSendFile}"
                    label=""></e:fileUpload>
    </e:form>
  </div>
  <script type="text/javascript" language="JavaScript">
    //This variable stores the session time out value in minutes.
    // It is declared in labware.js and initialise here
    // so that the value can be extracted from the hidden input, which is declared above.
    sessionTimeoutMins = document.getElementById('mf:sessionTimeOutInput').value;
    //This function is written in labware.js
    isLockTimeout = document.getElementById('mf:isLockOnTimeout').value;
    try {
      isLockTimeout = isLockTimeout.trim().toLowerCase();
      isLockTimeout = ('true' == isLockTimeout);
    } catch (e) {
      isLockTimeout = false;
    }
    lockTimeout = document.getElementById('mf:lockTimeout').value;
    limsActTimeout = document.getElementById('mf:limsActTimeout').value;
    isSSOLogin = document.getElementById('mf:isSSO').value;
    appName = document.getElementById('mf:appName').value;

    $(document).ready(function () {
      ec.config.ajaxTimeout = (parseInt(sessionTimeoutMins) * 60000) + 10000;
      loginPageURL = document.referrer;
    });
    resetIEOnHelp();

    //Added to fix LC515BL.
    $(document).unbind('keydown').bind('keydown', function (event) {
      var doPrevent = false;
      if (event.keyCode === 8) {
        var d = event.srcElement || event.target;
        if ((d.tagName.toUpperCase() === 'INPUT' && (d.type.toUpperCase() === 'TEXT' || d.type.toUpperCase() === 'PASSWORD'))
          || d.tagName.toUpperCase() === 'TEXTAREA') {
          doPrevent = d.readOnly || d.disabled;
        }
        else {
          doPrevent = true;
        }
      }
      if (doPrevent) {
        event.preventDefault();
      }
    });
    remove_href();
  </script>

  </body>
  </html>
</f:view>
