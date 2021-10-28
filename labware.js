/**
 * (C)Copyright 2000-2020 by LabWare, Inc; All rights reserved
 *
 * The JS functions in this page are used in index.jsp
 * @author Avik Chatterjee
 */
var lw_okFlag = new Array();
var lw_cancelFlag = new Array();
var globalEventFlag = null;
var printFlag = false;
var soundFlag = false;
var closeWindowFlg = false;
var sessionTimeoutMins;
var justClicked = false;
var isMainPane = false;
var loginPageURL = '';
var isSSOLogin = "";
var appName = "";
var readTimeoutFlag = false;

var delayedEventTimers = {};

window.top.taskWindows = {};
window.top.selectedTask = null;

var isLockTimeout = false;
var lockTimeout = 0;
//setting the lims activity timeout to 1 minute by default
var limsActTimeout = 60000;

//lims activity timer
var limsActTimer = null;

//lockTimeout timer
var lockTimer = null;
var taskLocker = null;

//flag to check if lock winodw is on or not
var isLockWinOpen = false;

var browserType = navigator.userAgent.toLowerCase();

//variable to check if the browser window has been refreshed.
var isRefresh = false;
//boolean variable set to true when the logoutApp is called by server
var session_tout = false;

//Flag to check if a grid is going to be printed. This variable is controlled from function printGrid of limsgridcore.js.Fixing LD189RC.
var isPrintGrid = false;

window.ieAnchorClick = false;

//This is a generic timer class.
var Timer = function (timeout, callbackfunc) {
  /**
   * timeout value in milliseconds
   */
  this.timeout = timeout;

  //call back function to be called. The function should take no arguments.The function name should be end with empty parenthesis.
  this.callbackfunc = callbackfunc;
  this.timerId = null;
};

Timer.prototype.enableTimer = function () {
  this.timerId = setTimeout(this.callbackfunc + '()', this.timeout);
};

Timer.prototype.clearTimer = function () {
  if (this.timerId == null) return;
  if (this.timerId == "") return;
  clearTimeout(this.timerId);
};


/**
 * Object.keys is  ECMAScript 5 Object and properties features. This is not supported in IE7 . IE8. The following code adds support for 'Object.keys' in IE7, IE8
 * Taken from : http://whattheheadsaid.com/2010/10/a-safer-object-keys-compatibility-implementation
 */
Object.keys = Object.keys || (function () {
  var hasOwnProperty = Object.prototype.hasOwnProperty, hasDontEnumBug = !{toString: null}.propertyIsEnumerable("toString"), DontEnums = [
    'toString',
    'toLocaleString',
    'valueOf',
    'hasOwnProperty',
    'isPrototypeOf',
    'propertyIsEnumerable',
    'constructor'
  ], DontEnumsLength = DontEnums.length;

  return function (o) {
    if (typeof o != "object" && typeof o != "function" || o === null)
      throw new TypeError("Object.keys called on a non-object");

    var result = [];
    for (var name in o) {
      if (hasOwnProperty.call(o, name))
        result.push(name);
    }

    if (hasDontEnumBug) {
      for (var i = 0; i < DontEnumsLength; i++) {
        if (hasOwnProperty.call(o, DontEnums[i]))
          result.push(DontEnums[i]);
      }
    }

    return result;
  };
})();


/**
 * Checks if F5 has been clicked.
 * @param event object
 */
function checkRefresh(evt) {
  if (isRefresh) return;
  var keyCode = evt.keyCode;
  //ec.log.debug('checkRefresh: keyCode ' + keyCode);
  //event code for F5
  if (keyCode == 116) {
    isRefresh = true;
    return;
  }
  //event code for Cntrl + R in Mac
  if (evt.ctrlKey && keyCode == 82) {
    wasPressed = true;
  }
}

/**
 * Checks for specific keys combination and regulates event propagation.
 * @param evt  window event
 */
function checkKeyStrokeFromIframe(evt) {
  ec.evt.checkKeyStroke(evt, ec.evt.getKeyStrokeMap());
}

function checkKeyStroke(evt) {
  var result = ec.evt.getKSListFromEvt(evt, ec.evt.getKeyStrokeMap());
  var ksList = result[0];
  var keyString = result[1];

  //take grid cell popup accelerators into account
  if (!ksList) {
    if (ec.focus.focusComp) {
      var comp = ec.comp.getComponent(ec.focus.focusComp);
      if (comp && comp.getType() == "limsgrid") {
        result = ec.evt.getKSListFromEvt(evt, comp.cellPopupKSMap);
        ksList = result[0];
        keyString = result[1];
      }
    }

    if (!ksList) return;
  }


  ec.log.debug("labware.checkKeyStroke  keystroke " + keyString);
  if (isSourceInputType(evt)) {
    ec.log.debug('source is input type');
    if (!isReservedKey(keyString)) {
      ec.log.debug(keyString + ' is not a reserved key');
      ec.bs.stopEvent(evt)
    }
  }
  else {
    ec.bs.stopEvent(evt)
  }
}

/**
 * Checks if the source of the event is an input type or textarea
 * @param evt event object
 * @returns {boolean} true if the source is of type 'text' or textarea or select
 */
function isSourceInputType(evt) {
  var element;
  if (evt.target) element = evt.target;
  else if (evt.srcElement) element = evt.srcElement;
  if (!element) {
    ec.log.debug('isSourceInputType  evt.id = ' + evt.id);
    element = document.getElementById(evt.id);
  }
  if (!element)return false;
  if (element.nodeType == 3) {
    // element.nodeType==3 means textual content in an element or attribute. so taking its parent
    element = element.parentNode;
  }
  return element.tagName == 'INPUT' || element.tagName == 'TEXTAREA' || element.tagName == 'SELECT';
}

/**
 * Checks if the keystring ( or keycombination ) is a reserved key. Default browser event is allowed for a reserved key.
 * @param keyString keycombination pressed
 * @returns {boolean} true if its a resrved key
 */
function isReservedKey(keyString) {
  var resKeys = ['ctrl+c', 'ctrl+v', 'ctrl+x', 'ctrl+z', '13'];
  var i = 0;
  for (i = 0; i < resKeys.length; i++) {
    if (keyString == resKeys[i]) {
      return true;
    }
  }
  return false;
}

function onTaskWindowClose(taskId) {
  setTimeout(function () {
    ec.makeDomNodeAjaxRequest($(ec.jq.toJQueryId("mf:tp"))[0], null, null, true, true, null);
  }, 500);
}

function setupWindowUload(taskContainerResponderUrl) {
  $(document).ready(function () {

    $(window).on('beforeunload', function (evt) {
      if(isPrintGrid){
          isPrintGrid = false;
          return;
      }
      var message = '';
      ec.log.debug('isMenuItemClicked() ' + isMenuItemClicked() + ' window.ieAnchorClick ' + window.ieAnchorClick);
      if (!hasSessionTimedOut() && /*!isMenuItemClicked() &&*/ !window.ieAnchorClick) {
        $.ajaxSetup({cache: false});

        $.ajax({
          type: 'GET',
          async: false,
          dataType: "json",
          data: {"taskId": window.top.taskId, "event": "beforeclose"},
          url: taskContainerResponderUrl,
          success: function (data) {
            if (data) {
              ec.log.debug(data.message);
              message = data.message;
            }
          }
        });

        /*
         //Firefox 4 and later the returned string is not displayed to the user. See Bug 588292.
         if (/Firefox[\/\s](\d+)/.test(navigator.userAgent) && new Number(RegExp.$1) >= 4) {
         if (message && message.length > 0) {
         confirm(message);
         }
         }
         */

        /*
         setTimeout(function () {
         $.ajax({
         type: 'GET',
         async: true,
         dataType: "json",
         data: {"taskId": window.top.taskId, "event": "cancelclose"},
         url: taskContainerResponderUrl,
         success: function (data) {
         if (data && data.message) {
         ec.log.debug(data.message);
         window.confirmClose = null;

         }
         }
         });
         }, 100);
         */

        if (message && message.length > 0) {
          window.confirmClose = "true";
          return message;
        }
      }
    });

    $(window).on('unload', function (evt) {
      if (isRefresh) {
        return;
      }
      $.ajaxSetup({cache: false});
      $.ajax({
        type: 'GET',
        async: false,
        dataType: "json",
        data: {"taskId": window.top.taskId, "event": isTaskWindow() ? "close" : "systemclose", confirmClose: window.confirmClose},
        url: taskContainerResponderUrl,
        success: function (data) {
          if (data && data.message) {
            ec.log.debug(data.message);
          }
        }
      });

      if (isTaskWindow()) {
          getMainWindow().onTaskWindowClose(window.top.taskId);
      }
    });

    //this is check is to solve the bug in IE9 , where window.unload eventhandler is called onClick on any anchor.
    if (ec.util.isIE) {
      ec.evt.addGlobalListener(null, "mousedown", "IEAnchorCheckMouseDown");
      ec.evt.addGlobalListener(null, "mouseup", "IEAnchorCheckMouseUp");
    }

  });
}

/**
 * sets the window.ieAnchorClick flag to true. This is a workaround to overcome the IE9 bug, wherein the window.unload handler is called on
 * click on any anchor.
 *
 * @param evt  Event object
 */
function IEAnchorCheckMouseDown(evt) {
  ec.log.debug('IEAnchorCheckMouseDown called');
  var node = ec.bs.getEventNode(evt);
  if (ec.dom.hasParentOfType(node, 'A', true)) {
    ec.log.debug('setting the window.ieAnchorClick to true ');
    window.ieAnchorClick = true;
  }
}

/**
 * mouseup listeners which resets the window.ieAnchorClick flag to false. Rerfer to <code>IEAnchorCheckMouseDown</code> more details.
 *
 * @param evt standard Event object.
 */
function IEAnchorCheckMouseUp(evt) {
  setTimeout(function () {
    ec.log.debug('IEAnchorCheckMouseUp called');
    window.ieAnchorClick = false;
  }, 1000);
}

function onVisibilityChange(callback) {
    var visible = true;

    if (!callback) {
        throw new Error('no callback given');
    }

    function focused() {
        if (!visible) {
            callback(visible = true);
        }
    }

    function unfocused() {
        if (visible) {
            callback(visible = false);
        }
    }

    // Standards:
    if ('hidden' in document) {
        document.addEventListener('visibilitychange',
            function() {(document.hidden ? unfocused : focused)()});
    } else if ('mozHidden' in document) {
        document.addEventListener('mozvisibilitychange',
            function() {(document.mozHidden ? unfocused : focused)()});
    } else if ('webkitHidden' in document) {
        document.addEventListener('webkitvisibilitychange',
            function() {(document.webkitHidden ? unfocused : focused)()});
    } else if ('msHidden' in document) {
        document.addEventListener('msvisibilitychange',
            function() {(document.msHidden ? unfocused : focused)()});
    } else if ('onfocusin' in document) {
        // IE 9 and lower:
        document.onfocusin = focused;
        document.onfocusout = unfocused;
    } else {
        // All others:
        window.onpageshow = window.onfocus = focused;
        window.onpagehide = window.onblur = unfocused;
    }
}

function setupTaskContainerEvents() {

  //AJ264ST :marker object which indicates if the window is being focussed for first time. Need to resovled
  // IE focus being called immediately on load of index page in IE.
  var firstTime = true;

  //when we open a new window we set the selected task to it
  if (isTaskWindow()) {
      getMainWindow().top.selectedTask =  window.top.taskId;
  }
  else {
      window.top.selectedTask = "home";
  }

  $(document).ready(function () {
    function _onfocus(evt) {
      ec.log.info("Task window focused");

      var selTask = null;
      var currentTask = null;
      if (isTaskWindow()) {
        selTask = getMainWindow().top.selectedTask;
        currentTask = window.top.taskId;
      }
      else {
        selTask = window.top.selectedTask;
        currentTask = "home";
      }

      if (selTask !== currentTask) {
        if (isTaskWindow()) {
            getMainWindow().top.selectedTask = currentTask;
        }
        else {
          window.top.selectedTask = currentTask;
        }

        if (firstTime && ec.util.isIE) {
          //not firing the ontaskselect event as its very fast for the first time.
          firstTime = false;
        }
        else {
          ec.dom.fireDomEvent($(ec.jq.toJQueryId("mf:tp"))[0], "ontaskselect", evt);
        }

      }
    }

    onVisibilityChange(function (visible) {
        if (visible) {
            _onfocus({});
        }
    });

  });

  ec.evt.addGlobalListener(null, "focus", "onGlobalFocusEvent");
  ec.evt.addGlobalListener(null, "click", "selectInputValue");
  ec.evt.addGlobalListener(null, "keydown", "checkRefresh");
  ec.evt.addGlobalListener(null, "keypress", "checkRefresh");
  ec.evt.addGlobalListener(null, "keyup", "checkRefresh");
  ec.evt.addGlobalListener(null, "keydown", "checkKeyStroke");
}

function registerTaskWindow() {
    var wnd = window.top;
    var list = getMainWindow().top.taskWindows;
    var taskId = getTaskId(wnd);
    wnd.taskId = taskId;
    wnd.taskWindow = true;

    list[taskId] = window.top;
}

function getTaskId(wnd) {
  var page = wnd.location.pathname.split("/").pop();
  var taskId = page.substr(0, page.lastIndexOf('.')) || page;
  taskId = taskId.substr(4);
  return taskId;
}

function openMainPaneTaskWindow(taskId, url) {
  $(window).unbind('beforeunload').unbind('unload');
  var form = document.getElementById('mf');
  if(form){
    ec.dom.createHiddenInput(form, 'csrfToken', ec.config.csrfToken);
    form.action = url;
    form.submit();
  }
}

function openTaskWindow(taskId, url) {
  var target = '_blank';
  if(ec.util.isIPhone || ec.util.isIpad){
    target = taskId;
  }
  if (isTaskWindow()) {
      getMainWindow().openTaskWindow(taskId, url);
  }
  else {
    if (ec.util.isIE) {
      window.top.taskWindows[taskId] = window.open(url, target);
    }
    else {
      //we do this to bypass window blocker mechanism
      var a = document.createElement("A");
      a.href = url;
      a.target = target;
      a.style.visibility = "hidden";
      a.style.position = "absolute";
      document.body.appendChild(a);
      if (a.click == undefined) {
        var dispatch = document.createEvent("HTMLEvents");
        dispatch.initEvent("click", true, true);
        a.dispatchEvent(dispatch);
      }
      else {
        a.click();
      }

      document.body.removeChild(a);
      window.top.taskWindows[taskId] = taskId;
    }
  }
}

function closeTaskWindow(taskId) {
  if (isTaskWindow()) {
      getMainWindow().closeTaskWindow(taskId);
  }
  else {
    if (window.top.taskWindows[taskId]) {
      window.top.taskWindows[taskId].close();
      delete window.top.taskWindows[taskId];
    }
  }
}

function refreshTaskWindows() {
  if (isTaskWindow()) {
      getMainWindow().refreshTaskWindows();
  }
  else {
    if (window.top.taskWindows) {
      $.each(window.top.taskWindows, function( taskId, taskWindow ) {
        ec.log.info("REFRESH TASK : " + taskId + " " + typeof(taskWindow));
        try{
          if(taskWindow.frames["ec_main_frame"]){
            taskWindow.frames["ec_main_frame"].doRefreshTask();

          }else{
            taskWindow.doRefreshTask();
          }
        }catch(err){
          ec.log.error("Error accesing task window " + taskId + " for refresh");
        }
      });
    }
  }
}

var refreshTaskTimerId = null;
function doRefreshTask(){
  if(refreshTaskTimerId){
    clearTimeout(refreshTaskTimerId);
    refreshTaskTimerId = null;
  }

  refreshTaskTimerId = setTimeout(function(){
    ec.log.info("REFRESH TASK AJAX REQUEST");
    ec.makeDomNodeAjaxRequest($(ec.jq.toJQueryId("mf:tp"))[0], null, null, true, true, null);
  }, 300)
}

function blockOnClick() {
  this.blur();
  ec.dom.createModalLayer();
}

function unblockOnClick() {
  ec.dom.removeModalLayer();
}

function blockOnEnter(message) {
  this.blur();
  ec.dom.createModalLayer(null, null, message);
  ec.evt.addListener(document.body, "keydown", dingOnKeyDown);
}

function unblockOnEnter() {
  ec.dom.removeModalLayer();
  ec.evt.removeListener(document.body, "keydown", dingOnKeyDown);
}

function dingOnKeyDown(evt) {
  try {
    soundFlag = true;
    playSoundFromLIMS("sounds/DING.WAV");
  }
  catch (exp) {
    ec.log.error(exp);
  }
  if (evt != null) {
    ec.bs.stopEvent(evt);
  }
  return false;
}

function fireDelayedEvent(domNode, fct, eventDelay) {

  if (eventDelay <= 0) {
    fct.call(domNode);
  }
  else {
    var timerName = domNode.id + "Timer";
    if (delayedEventTimers[timerName]) {
      clearTimeout(delayedEventTimers[timerName]);
      delayedEventTimers[timerName] = null;
    }

    delayedEventTimers[timerName] = setTimeout(ec.util.linkThis(fct, domNode), eventDelay);
  }
}

function setGlobalEventFlag() {
  globalEventFlag = true;
}

function resetGlobalEventFlag() {
  globalEventFlag = false;
}

function initWindowOKCancel() {
  ec.evt.addKeyStroke(document.body, "13", function (evt) {
    var focusElementId = ec.focus.getFocus();
    var focusElem = document.getElementById(focusElementId);
    if (focusElem && focusElem.type && focusElem.type.toLowerCase() == "button") {
      if (focusElementId == lw_okFlag[lw_okFlag.length - 1] || focusElementId == lw_cancelFlag[lw_cancelFlag.length - 1]) {
        lw_okFlag.pop();
      }
      focusElem.click();
      return;
    }
    var button = document.getElementById(lw_okFlag[lw_okFlag.length - 1]);
    var ele;
    if (evt.srcElement)
      ele = evt.srcElement;
    else if (evt.target)
      ele = evt.target;
    if (ele.tagName.toUpperCase() == "TEXTAREA") {
      return true;
    }

    if (button) {
      lw_okFlag.pop();
      setTimeout(function () {
        button.click();
      }, 100);
    }
  }, null, null, true);
  ec.evt.addKeyStroke(document.body, "27", function (evt) {
    var button = document.getElementById(lw_cancelFlag[lw_cancelFlag.length - 1]);
    if (button) {
      var window = ec.comp.getCompByDomNode(button);
      if (window) {
        if (window.getType() == "jqlimswindow" && window.closeOnEscape == "true") {
          var windows = ec.comp.getComponents("jqlimswindow");
          if (window && windows.length > 1) {
            var hasWindowWithBiggerZIndex = false;
            for (var i = 0; i < windows.length; i++) {
              var w = windows[i];
              if (w.order > window.order) {
                hasWindowWithBiggerZIndex = true;
                break;
              }
            }
            if (!hasWindowWithBiggerZIndex) {
              lw_cancelFlag.pop();
              setTimeout(function () {
                button.click();
              }, 100);
            }
          }
          else {
            lw_cancelFlag.pop();
            setTimeout(function () {
              button.click();
            }, 100);
          }
        }
      }
    }
  }, null, null, true);
}

function requestFile(id, type, length, fileName, iframeId) {
  var url = "lims_file.htm?id=" + encodeURIComponent(id) + "&type=" + encodeURIComponent(type) +
    "&length=" + encodeURIComponent(length) + "&fileName=" + encodeURIComponent(fileName);
  //Use an iframe instead of window.open to prevent opening a new window during sendFile mechanism
    if (ec.util.isIPhone) {
        window.open(url,"_blank");
    } else {
        var iframe = document.getElementById(iframeId);
        iframe.src = url;
    }
}

/*
 This function closes the main popup window. Called from expire(boolean expire) method of Controller class via Ajax.
 */
function closeWindow() {
  if (isTaskWindow()) {
      getMainWindow().onbeforeunload = null;
      getMainWindow().closeWindow();
  }
  else {
    var loginPage = appName == "mainpane" ? "mainpanelogin" : "login";
    var redirUrl = "";
    try {
      closeTaskWindows();
      var pathName = "";


      if (isSSOLogin == "true" || loginPageURL == "" || loginPageURL == null) {
        if (isSSOLogin == "true") {
          ec.log.debug('redirecting to SSO page.');
          pathName = window.location.pathname.replace("index", "sso");
          redirUrl = window.location.protocol + "//" + window.location.host + pathName + "?logout=true";
        }
        else {
          pathName = window.location.pathname.replace("index", loginPage);
          redirUrl = window.location.protocol + "//" + window.location.host + pathName + "?logout=true";
        }
        var dsName = getUrlParameter("lims_datasource");
        var service = getUrlParameter("lims_service");
        if (redirUrl.indexOf("lims_datasource")  == -1 &&   dsName != null) redirUrl = redirUrl + "&lims_datasource=" + dsName;
        if (redirUrl.indexOf("lims_service")  == -1 &&   service != null) redirUrl = redirUrl + "&lims_service=" + service;
      }
      else {
        ec.log.debug('redirecting to the window.referrer');
        if(loginPageURL.indexOf("logout=true") == -1)   // do not keep appending "logout=true"
            redirUrl = loginPageURL.lastIndexOf("?") == -1 ? loginPageURL + "?logout=true" : loginPageURL + "&logout=true";
        else
            redirUrl = loginPageURL;
      }

      window.onbeforeunload = null;

      ec.log.debug('redirecting to URL ' + redirUrl);
      redirUrl = redirUrl.replace("expired=true&", "");
      window.location.href = redirUrl;
      closeWindowFlg = true;
    }
    catch (err) {
      ec.log.error('error in closeWindow ' + err);
      closeTaskWindows();
      ec.log.debug('after the error closed task windows , changing the location');
      window.location.href = redirUrl;
      ec.log.debug('after the error location href');
    }
  }
}

/**
 * Worker method to get the parameter value from the location URL
 * @param sParam param name
 * @returns value of the param ( if it exists) or null toher wise
 */
function getUrlParameter(sParam) {
  var paramVal = null;
  var sPageURL = window.location.search.substring(1);
  var sURLVariables = sPageURL.split('&');
  for (var i = 0; i < sURLVariables.length; i++) {
    var sParameterName = sURLVariables[i].split('=');
    if (sParameterName[0] == sParam) {
      paramVal = sParameterName[1];
      break;
    }
  }
  return paramVal;
}

/*
 This function is used in mainpane application. It returns to login page. Called from expire(boolean expire) method of Controller class via Ajax.
 */
function closeWindowForMainPane() {
  if (isTaskWindow()) {
     getMainWindow().closeWindowForMainPane();
  }
  else {
    try {
      document.getElementById("soundFieDiv").innerHTML = "";
      closeWindowFlg = true;
      self.location.href = "mainpanelogin.htm?logout=true";
    }
    catch (err) {
      self.location.href = "mainpanelogin.htm?logout=true";
    }
  }

}

function closeWindowForSessionExp_blank(){
    closeWindowForSessionExp("session");
}
/**
 * This function is called from setSessionTimeout() if the session timeout value is passed without any click or keydown.
 * It closes the main popup window and redirects the url of the opener window (login page) with a flag (expired=true) so
 * that session expire message is shown in the login page. If login page is closed the main popup window will not be closed
 * and the redirection will happen there.
 */
function closeWindowForSessionExp(type) {
    if(readTimeoutFlag == true || closeWindowFlg == true){
        return;
    }
    if (!type) {
        type = "session";
    }
    if(type == "socket" || type == "disconnected"){
        readTimeoutFlag = true;
    }
    var redirUrl = "login.htm?expired=true&type=" + type;
        document.getElementById("soundFieDiv").innerHTML = "";
        try {
        var isSSO = document.getElementById("mf:isSSO").value;
        //closing the tabs
        closeTaskWindows();
        var dsName = getUrlParameter("lims_datasource");
        var service = getUrlParameter("lims_service");
        if (redirUrl.indexOf("lims_datasource") == -1 && dsName != null) redirUrl = redirUrl + "&lims_datasource=" + dsName;
        if (redirUrl.indexOf("lims_service") == -1 && service != null) redirUrl = redirUrl + "&lims_service=" + service;

        if ("true" == isSSO) {
            redirUrl = "sso.htm?expired=true&type=" + type;
            if (redirUrl.indexOf("lims_datasource") == -1 && dsName != null) redirUrl = redirUrl + "&lims_datasource=" + dsName;
            if (redirUrl.indexOf("lims_service") == -1 && service != null) redirUrl = redirUrl + "&lims_service=" + service;
        }

        getMainWindow().onbeforeunload = null;
        window.location.href = redirUrl;

        if (isTaskWindow()) {
            getMainWindow().onbeforeunload = null;
            getMainWindow().location.href = redirUrl;
        }
        closeWindowFlg = true;
    }
    catch (err) {
        closeTaskWindows();
        self.location.href = redirUrl;
    }
}

function closeTaskWindows() {
  if (isTaskWindow()) {
      getMainWindow().closeTaskWindows();
  }
  else {
    try {
      $.each(window.top.taskWindows, function(taskId, taskWindow) {
        closeTaskWindow(taskId);
      });
    }
    catch (e) {
      throw e;
    }
  }
}

/**
 * This function is used in mainpane application.
 */
function closeWindowForSessionExpForMainPane(type) {
  document.getElementById("soundFieDiv").innerHTML = "";
  closeWindowFlg = true;
  self.location.href = "mainpanelogin.htm?expired=true&type=session";
}

/**
 * This function is called by the WebLIMS Controller to logout if it finds only newRequest being sent to LIMS
 * for the sessionTimeout period
 */
function logoutApp() {
  setSessionTimeout(true);
  if (isMainPane == 'true') {
    closeWindowForSessionExpForMainPane();
  }
  else {
      closeWindowForSessionExp_blank();
  }
}

function setSessionTimeout(sessTout) {
  if (isTaskWindow()) {
    getMainWindow().session_tout = true;
  }
  else {
    session_tout = true;
  }
}

function hasSessionTimedOut() {
  return isTaskWindow() ? getMainWindow().session_tout : session_tout;
}

/**
 * This function is called in body 'onclick' and 'onkeydown' of index.jsp. It clears sessionTimerId and calls setSessionTimeout().
 */
function setAppType(isMainPaneApp) {
  isMainPane = isMainPaneApp;
}

/**
 * This function is called in the body of 'onclick' and 'onkeydown' of mainpane.jsp and index.jsp.
 */
function checkForLockTimeout() {
  //ec.log.debug('is LockTimeout ' + isLockTimeout + 'lockTimeout ' + lockTimeout);
  if (!isLockTimeout) return;
  var timer = getLockTimer();
  if (timer != null) {
    timer.clearTimer();
    timer.enableTimer();
  }
}


function getLockTimer() {
  if (isTaskWindow()) {
    //ec.log.debug("getLockTimer : task window detected");
    return getMainWindow().getLockTimer();
  }
  else {
    //ec.log.debug('in the else block of the getLockTimer');
    if (lockTimer == null) {
      var timeoutValue = 0;
      try {
        timeoutValue = parseInt(lockTimeout);
      }
      catch (e) {
        //do nothing. just return
        return null;
      }
      if (timeoutValue > 0) {
        timeoutValue = timeoutValue * 1000;
        lockTimer = new Timer(timeoutValue, "fireLockTimeoutEvent");
      }
      else {
        return null;
      }
    }
    return lockTimer;
  }
}

/**
 * sets the lock window checker. Worker function which checks
 */
function setLockWindowChecker() {
  //tasker is just a marker variable . Setting the constant timer if taskLocker is null
  if (taskLocker == null) {
    var timeoutValue = 500;
    var init_win_state = getMainWindow().isLockWindowOpen();
    setInterval(function () {
      var currWinState = getMainWindow().isLockWindowOpen();
      //getting the current lockWindowState
      if (currWinState == init_win_state) {
        //ec.log.debug('lock window state has not changed');
        return;
      }
      init_win_state = currWinState;
      //this means that either the window state has chaned . lets fire the event
      //ec.log.debug('lock window state has changed');
      fireLockReresh();
    }, timeoutValue);
    taskLocker = "locker";
  }
}

function isLockWindowOpen() {
  if (isTaskWindow()) {
    return getMainWindow().isLockWindowOpen();
  }
  else {
    return isLockWinOpen;
  }
}

function addLockWindow() {
  if (isTaskWindow()) {
    getMainWindow().addLockWindow();
  }
  else {
    isLockWinOpen = true;
  }
}

function removeLockWindow() {
  if (isTaskWindow()) {
    getMainWindow().removeLockWindow();
  }
  else {
    isLockWinOpen = false;
    //refresh the lock. This is done for the case when lock is removed from the task window. This will remove the lock window from main page.
    fireLockReresh();
  }
}

function fireLockTimeoutEvent() {
  //firing locktimeout event. the ctrl value is just a value. no use as of now
  ec.dom.fireDomEvent($(ec.jq.toJQueryId("mf:tp"))[0], "onlocktimeout", null);
}

function fireLockReresh() {
  //firing locktimeout event. the ctrl value is just a value. no use as of now
  ec.dom.fireDomEvent($(ec.jq.toJQueryId("mf:tp"))[0], "onlockrefresh", null);
}

var availableIframes = {};
var queuedIframeScripts = {};

function IframeReady(iframe) {
  availableIframes[iframe.id] = true;

  var scripts = queuedIframeScripts[iframe.id];
  if (scripts) {
    for (var i = 0; i < scripts.length; i++) {
      IframeScriptRunner({id: iframe.id, jsCode: scripts[i]});
    }
    queuedIframeScripts[iframe.id] = [];

    ec.dom.fireDomEvent(iframe, "ondoneloading");
  }
}

function IframeScriptRunner(params) {

  if (!availableIframes[params.id]) {
    var scripts = queuedIframeScripts[params.id];
    if (!scripts) {
      scripts = queuedIframeScripts[params.id] = [];
    }
    scripts[scripts.length] = params.jsCode;

    return;
  }

  //getting the iframe;
  var webIFrame = document.getElementById(params.id);
  var x;
  if (webIFrame) {
    try {
      x = webIFrame.contentWindow.eval(params.jsCode);
    }
    catch (e) {
      ec.log.error("Error excecuting the js code: " + e);
      x = "JavaScript Error: " + e;
    }
    ec.log.debug("Script return value " + x);
    ec.dom.setHiddenInputValue(webIFrame.parentNode, params.id + ec.config.separator + "onscriptreturn", decodeURIComponent(x));
    ec.dom.fireDomEvent(webIFrame, "onscriptreturn");
  }
  else {
    x = "WebIFrame not found in client";
    ec.log.error("Iframe by Id " + params.id + " not found");
  }

}


/**
 * This timer check for inactivity with LIMS for more than a minute. If there is no communication with LIMS for a period of 1 minute, a new request is
 * sent to LIMS
 */
function setLIMSActivityTimer() {
  var timer = getLIMSActivityTimer();
  if (timer != null) {
    timer.clearTimer();
    timer.enableTimer();
  }
}

function getLIMSActivityTimer() {
  if (isTaskWindow()) {
    return getMainWindow().getLIMSActivityTimer();
  }
  else {
    if (limsActTimer == null) {
      limsActTimer = new Timer(limsActTimeout, "fireUserInactivityEvent");
    }
    return limsActTimer;
  }
}

function fireUserInactivityEvent() {
  ec.dom.fireDomEvent($(ec.jq.toJQueryId("mf:tp"))[0], "onuserinactive", null);
}

function setupModalLayer() {
  if (ec && ec.dom && ec.dom.createModalLayer && !ec.dom.ecruiserCreateModalLayer) {
    ec.dom.ecruiserCreateModalLayer = ec.dom.createModalLayer;
    ec.dom.ecruiserResizeModalLayer = ec.dom.resizeModalLayer;

    ec.dom.createModalLayer = function (zIndex, modalLayerStyleClass, message) {
      ec.dom.ecruiserCreateModalLayer(zIndex, modalLayerStyleClass, message);

      var div = ec.$(ec.dom.MODAL_LAYER_ID);
      if (div) {
        var statusTable = $(".status-table");
        if (statusTable.size() > 0) {
          $(div).height($(window).height() - statusTable.height());
        }
      }
    };

    ec.dom.resizeModalLayer = function () {
      ec.dom.ecruiserResizeModalLayer();

      var div = ec.$(ec.dom.MODAL_LAYER_ID);
      if (div) {
        var statusTable = $(".status-table");
        if (statusTable.size() > 0) {
          $(div).height($(window).height() - statusTable.height());
        }
      }
    };
  }
}


function focusNextInput(evt, inputId) {
  evt = evt || window.event;
  if (ec.evt.isReturnKey(evt) && !evt.ctrlKey) {
    ec.focus.setFocus(inputId);
    ec.bs.stopEvent(evt);
    return false;
  }
  return true;
}

function printFromLIMS() {
  if (printFlag) {
    window.print();
    printFlag = false;
  }
}

//select textarea text if we focused the component using tabbing
//textarea.lwFocused is set to true during onfocus event
function selectTextareaText(textarea, e) {
  var evt = (window.event) ? window.event : e;
  if (textarea.lwFocused && evt.keyCode == 9) {
    textarea.select();
  }
  textarea.lwFocused = false;
}

// Put focus frame when InputWithIcon is onfocus
function onFocusInputWithIcon(input) {
  ec.focus.showFocusFrame(input, input.parentNode, 2);
}

// Remove the focus frame when InputWithIcon is blurred
function onBlurInputWithIcon() {
  ec.focus.hideFocusFrame();
}

function removeBlankAfterFirstTime(input) {
  var select = input;
  if (select.options.length > 0) {
    if (select.options[0].text == "" && select.options[0].value == "") {
      select.options[0] = null;
    }
  }
}

function playSoundFromLIMS(soundFilePath) {
  try {
    if (soundFlag) {
      if (ec.util.isIE) {
        setTimeout("document.getElementById('soundFieDiv').innerHTML=\"<span>&nbsp;<bgsound src='" + soundFilePath + "'></span>\";", 10);
      }
      else {
        setTimeout("document.getElementById('soundFieDiv').innerHTML=\"<audio  autoplay='true'><source src='" + soundFilePath + "' />Audio Tag Not Supported</audio>;\"", 10);
      }
    }
    soundFlag = false;
  }
  catch (exp) {
    soundFlag = false;
  }
}
/**
 * This function can be called  as an event handler for onclick events on any html components .It blocks the default
 * behavior of double click generating two successive click events . The variable justClicked is the key here .Currently
 * the toolbar cells uses this function to block double clicks .
 */
function blockDblClick() {
  if (justClicked) {
    return false;
  }
  else {
    justClicked = true;
    setTimeout("justClicked=false", 1000);
    return true;
  }
}
/**
 * This function displays the title in the index page on Ajax request. Called from TopBean.setBrowserTitle method.
 * @param params
 */
function showTitleInIndexPage(params) {
  var title = params.title;
  window.top.document.title = title;
}

function setMainToolbarToggle(toggle) {
  var mainToolBar = ec.comp.compMap['mf:mainToolbar'];
  mainToolBar.setToggle(toggle)
}

function cutCopyAndPaste(params) {
  var id = params.clientID;
  var txtMessage = params.message;
  var operation = params.operationFlg;
  var compType = params.compType;
  var spType = params.spType;
  var ele = document.getElementById(id);
  var agt = navigator.userAgent.toLowerCase();
  if (ele != undefined) {
    if (agt.indexOf("msie") != -1) {   //IE
      var range;
      ele.focus();
      if (compType == "textArea") {
        range = document.selection.createRange();
      }
      else {
        ele.select();
        range = ele.createTextRange();
      }
      if (operation == "cut")
        range.execCommand("Cut");
      else if (operation == "copy")
        range.execCommand("Copy");
      else if (operation == "paste")
        range.execCommand("Paste");
      if (spType == "limsbasicpane") {
        ec.comp.getComponent(id).countClick();
      }

    }
    else {  //FireFox, Chrome
      this.showDialogFrmComponent(txtMessage);
    }
  }
}

function showDialogFrmComponent(txt) {
  $(document).ready(function () {
    $("#lbpDialog").html("<p><br><span class='ui-icon ui-icon-alert' style='float: left; margin: 0 7px 20px 0;'/>" + txt + "</p>");
    var dialog = $("#lbpDialog").dialog({
      resizable: false,
      height: 140,
      title: "Message",
      modal: true,
      closeOnEscape: true,
      closeText: "Close"
    });

//    $("#lbpDialog").css("z-index", "1000 !important");

    var zIndex = ec.dom.getNextZIndex() + 500;
    dialog.parent('.ui-dialog').css('zIndex', zIndex+1)
          .nextAll('.ui-widget-overlay').css('zIndex', zIndex);

  });
}

function makeNewRequest(params) {

  var browserTabId = params ? params.browserTabId : null;

  if(browserTabId === ""){//forward to home tab
    if (isTaskWindow()) {
        getMainWindow().makeNewRequest();
    }
    else {
      makeNewRequest();
    }
  }else if(browserTabId && typeof browserTabId === 'string'){//different tab
    var taskMap = null;
    if (isTaskWindow()) {
      taskMap = getMainWindow().taskWindows;
    }
    else {
      taskMap = window.top.taskWindows;
    }
    if(taskMap[browserTabId]){
      taskMap[browserTabId].makeNewRequest();
    }else{
      ec.log.error("Can't find browser tab with id " + browserTabId);
    }

  }else{//current tab
    if(ec.makeNewRequestTimer){
      clearTimeout(ec.makeNewRequestTimer);
    }
    tryMakeNewRequest();
  }
}

/**
 * Worker method which makes a LIMS initiated call to makeNewRequest. If the AJAX REQUEST QUE is full, waits for a minute
 * and then retries.
 */
function tryMakeNewRequest() {
  if(ec.ajax.REQUEST_QUEUE.length < ec.ajax.MAX_QUEUE_SIZE){
    ec.dom.fireDomEvent($(ec.jq.toJQueryId("mf:tp"))[0], "onnewrequest", null);
  }else{
    ec.makeNewRequestTimer = setTimeout(tryMakeNewRequest, 1000)
  }
}

function isMenuItemClicked() {
  var focusId = ec.util.Base64.decode(ec.util.readCookie("lw_menu_focus_"));
  var child = ec.comp.getComponent(focusId);
  if (focusId && child) {
    return true;
  }
  return false;
}

function onGlobalFocusEvent(evt) {
  // Let's save the focus id in cookie
  // Base 64 conversion is used not to crash tomcat cookie parsing mechanism
  var domNode = document.getElementById(evt.id);
  if (domNode && (domNode.tagName == "SPAN" || domNode.tagName == "INPUT" || domNode.tagName == "TEXTAREA" || domNode.tagName == "DIV")) {
    if (domNode.tagName == "DIV") {
      var comp = ec.comp.getComponent(evt.id);
      if (((comp.getType() == "menucell") && ((domNode.textContent.trim() == "Exit") || (domNode.textContent.trim() == "Print"))) || comp.getType() == "popupmenu" || comp.getType() == "layoutpane") {
        ec.util.setCookie("lw_menu_focus_", ec.util.Base64.encode(evt.id));
      }
      else {
        ec.util.eraseCookie("lw_menu_focus_");
      }
    }
    else {
      ec.util.setCookie("lw_focus_", ec.util.Base64.encode(evt.id));
      ec.util.eraseCookie("lw_menu_focus_");
    }

    //AK812BR : if an input type element is focused, lets select it
    try {
      selectInputValue(evt);
    }
    catch (e) {
      ec.log.error('error in source input type');
    }
  }
  ec.log.info("focus dom with id:" + evt.id);
}

/**
 * Records the last focus Element id for input type having class set to CSS classes  textInput, icon-input, dbEntery class
 * @type {string}
 */
var lastFocusElem = '';

/**
 * Selects any existing value of an input with selected class names on click of an input component
 *
 * @param evt Event object
 */
function selectInputValue(evt) {
  if (evt == null) return;
  if (isSourceInputType(evt)) {
    var domNode = null;
    if (evt.target) domNode = evt.target;
    else if (evt.srcElement) domNode = evt.srcElement;
    else domNode = document.getElementById(evt.id);
    if (domNode == null) {
      lastFocusElem = '';
      return;
    }
    var list = domNode.classList;
    if (list.contains("textInput") || list.contains('ui-spinner-input') || (list.contains("dbEntry") && list.contains("iconinput-input"))) {
      var node = $(domNode);
      if (node.attr('id') === lastFocusElem) {
        node.selectionStart = node.selectionEnd;
      }
      else {
        if (evt && evt.type && evt.type === 'click')lastFocusElem = node.attr('id');
        node.select();
      }
    }
  }
  else {
    lastFocusElem = '';
  }
}


function addStyleClass(params) {
  var obj_id = params.objID;
  var styleClass = params.styleClass;
  var oldClass = params.oldClass;
  var element = $("#" + obj_id);
  // if (!element.hasClass(styleClass)) {
  element.removeClass(oldClass);
  element.addClass(styleClass);
  // }
}

function changeColor(params) {
  var obj_id = params.objID;
  var color = params.color;
  var element = $("#" + obj_id);
  element.css("color", color);
}

function promptForFile() {
  var fileUploadComp = ec.comp.getComponent('fileUploadForm:fileUploadControl');
  if (fileUploadComp) {
    fileUploadComp.clear();
    fileUploadComp.oniconclick();
  }
}

function clickFileUploadIcon(params) {
  $("#" + params.fileUploadInput_id.replace(new RegExp(ec.config.separator, "g"), "\\" + ec.config.separator)).children('a').click();
}


/**
 * AJ383RC : Resets the IE's onHelp event to stop IE Help window popup on press of F1 AJ382RC
 */
function resetIEOnHelp() {
  $(document).ready(function () {
    if (ec.util.isIE) {
      document.onhelp = function () {
        return (false);
      };
      window.onhelp = function () {
        return (false);
      }
    }
  });
}

/**
 * Fires onchange event for a component whose id is passed it.
 * @param params
 */
function fireOnChange(params) {
  $(document).ready(function () {
    var compId = params.inputId;
    var inputComp = document.getElementById(compId);
    if (inputComp) {
      ec.dom.fireDomEvent(inputComp, "onchange");
    }
  });
}

function remove_href(){
  if (ec.util.isIE) {
    return false;
  }
  $(document).ready(function () {
    $('a[href]').each(function () {
      var u = $(this).attr("href").replace(/\s/g, '');
      if (u == "javascript:void(0);" || u == "javascript:void(0)") {
        $(this).removeAttr('href');
        $(this).css('cursor','pointer');
      }
    });
  });
}

window.onWebBrowserWindowUnload = function(clientId){
    ec.log.info("on browser window close " + clientId);
    ec.dom.fireDomEvent(ec.$(clientId), "onecclose");
};

function initSessionInvalidate(params){

    console.log("call initSessionInvalidate", params);

    if (isTaskWindow()) {
        getMainWindow().initSessionInvalidate(params);
    }else{

        //set flag not to display promts
        setSessionTimeout();
        closeTaskWindows();

/*
        var timeoutMessage = params && params.notifyMessage ? params.notifyMessage : "Session Timed Out. Application is about to close.";
        var timeoutTitle = params && params.notifyTitle ? params.notifyTitle : "Session Timed Out";

        console.log(timeoutMessage, timeoutTitle);
        var timeoutWindow = ec.comp.getComponent("sessionTimeoutForm:sessionTimeout");
        if(timeoutWindow != null){
            console.log("show session timeout window");
            $("#sessionTimeoutForm\\:readTimeoutspan").html(timeoutMessage);
            timeoutWindow.show(document.body, "500px", "200px");
        }else{
            console.log("show session timeout alert");
            alert(timeoutMessage);
            doSessionInvalidate();
        }
*/
        doSessionInvalidate();
    }
}

function doSessionInvalidate(){
    if (isTaskWindow()) {
        getMainWindow().doSessionInvalidate();
    }else{
        console.log("doSessionInvalidate");
        ec.makeDomNodeAjaxRequest($(ec.jq.toJQueryId("mf:tp"))[0], "invalidate_session=true", null, true, true, null);
    }
}

function sessionInvalidateDone(){
    console.log("sessionInvalidateDone");
    closeWindowForSessionExp("socket");
}

function sessionInvalidateDoneForDC() {
    console.log("sessionInvalidateDone");
    closeWindowForSessionExp("disconnected");
}

function closeWindowOnInvalidSession() {
    console.log("closeWindowOnInvalidSession");
    //if its not the home page
    if (isTaskWindow()) {
        if(getMainWindow().initSessionInvalidate){
            getMainWindow().initSessionInvalidate();
        }
        //window.close();
    }else{
        initSessionInvalidate({});
    }
}

function isTaskWindow(){
  // ec.log.debug('isTaskWindow : window.top.taskWindow ' + window.top.taskWindow );
  // ec.log.debug('isTaskWindow : window.top.opener  ' + window.top.opener  );
  if(window.top.taskWindow) {
    return true;
  }
  return window.top.opener != null || window.top.opener != undefined;
}

function getMainWindow(){
  //ec.log.debug('window.top.opener ' + window.top.opener);
  return window.top.opener;
}