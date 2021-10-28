<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://www.simplica.com/jsf/ecruiser" prefix="e" %>
<div class="menu-head">Test Menu</div>
<table bgcolor="#639BCE" width="200px" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="left" valign="top" style="padding-top:5px;">
      <table bgcolor="#639BCE" border="0" cellspacing="0" cellpadding="2" width="100%">
        <tr>
          <td height="24px"><e:div id="wslogin" rendered="#{ecLoginManager.renderWSLoginImage}"><div id="right_arrow_div"><img src="images/right-arrow.gif" height="20" width="24"></div></e:div></td>
          <td width="99%"><e:a onclick="#{wsConnLoginBean.authenticateWsdl}" ajax="true"
                                       value=" Authenticate WSDL"
                                       styleClass="menu-link"/>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td align="left" valign="top" style="padding-top:5px;">
      <table bgcolor="#639BCE" border="0" cellspacing="0" cellpadding="2" width="100%">
        <tr>
          <td height="24px"><e:div id="right_arraw_close" rendered="#{ecLoginManager.renderWSLoginImage}"><div id="right_arrow_div"><img src="images/right-arrow.gif" height="20" width="24"></div></e:div></td>
          <td width="99%"><e:a onclick="#{wsConnLoginBean.closeWsdlURL}" ajax="true"
                                       value=" Close WSDL"
                                       styleClass="menu-link"/>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
