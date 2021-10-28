<!DOCTYPE html>
<%--
(C)Copyright 2000-2018 by LabWare, Inc; All rights reserved

@author Avik Chatterjee
--%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://www.simplica.com/jsf/ecruiser" prefix="e" %>

<div class="menu-head">Functions and Routines</div>
<table bgcolor="#639BCE" width="200px" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="left" valign="top" style="padding-top:5px;">
      <table bgcolor="#639BCE" border="0" cellspacing="0" cellpadding="2" width="100%">
          <tr>
              <td height="24px">
                  <e:div id="SelectFx" rendered="#{ecLoginManager.renderSelectFxImage}">
                      <div id="SelectFx_img">
                          <img src="images/right-arrow.gif" height="20" width="24">
                      </div>
                  </e:div>
              </td>
              <td width="99%"><e:a onclick="/admin/SelectFx.jsp" styleClass="menu-link"
                                   id="SelectFx_Link">Web Functions</e:a>
              </td>
          </tr>
          <tr>
              <td height="24px">
                  <e:div id="SelectRoutine" rendered="#{ecLoginManager.renderSelectRoutineImage}">
                      <div id="SelectRoutine_img">
                          <img src="images/right-arrow.gif" height="20" width="24">
                      </div>
                  </e:div>
              </td>
              <td><e:a onclick="/admin/SelectRoutine.jsp" styleClass="menu-link"
                       id="SelectRoutine_Link">Web SubRoutines</e:a></td>
          </tr>
      </table>
    </td>
  </tr>
</table>
