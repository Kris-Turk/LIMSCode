<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://www.simplica.com/jsf/ecruiser" prefix="e" %>
<%@ taglib uri="http://www.labware.com/components" prefix="lw" %>


<f:view>
  <!DOCTYPE html>
  <html>
  <head>
    <title>Welcome to LabWare 8</title>
     <link id="favicon" rel="shortcut icon" href="../img/LabWare.ico"/>
    <link rel="stylesheet" type="text/css" href="../css/login.css">

  </head>

  <body id="login-bg">

  <a href="http://www.labware.com" target="_blank" rel="noopener noreferrer"><img src="../img/labware-logo.png" alt="LabWare Logo" id="login-logo" border="0"/></a>

  <div id="sso-pane">
    <div id="sso-form-bg">
        <p class="login-title" style="padding-bottom: 5px;">LabWare 8 OAuth Token Proccessor</p>
        <e:div id="login" style="text-align:center;"  ajax="true">
          <table cellspacing="0" cellpadding="3" border="1" style="width: 100%; padding: 20px 40px 20px 0;margin:auto">
            <tr>
              <td>Access Token :</td>
              <td valign="top" style="text-align:left;">
                <div>
                  <h:inputHidden  value="#{twsOAuthBean.oauthServerURL}"/>
                  <h:inputHidden id="oauth_token" value="#{twsOAuthBean.accessToken}"/>
                  <h:outputLabel id="oauth_token_label" value="#{twsOAuthBean.accessToken}"/>
                </div>
              </td>
            </tr>
            <tr>
              <e:div style="padding-top:25px;padding-left:25px;padding-right:25px;text-align:-moz-center;text-align:-khtml-center;text-align:center;color:red;font-weight:bold;"
                     value="#{messagesBean.loginError}"/>
            </tr>
          </table>
        </e:div>

    </div>
  </div>
  <script>
    var oauthToken = document.getElementById('oauth_token');
    // console.log('oauthToken field' + oauthToken);
    if(oauthToken && oauthToken.value !== ''){
      console.log('oauthToken value ' +oauthToken.value);
      var opener = window.opener;
      if(opener){
        opener.document.getElementById('limsAdminForm:oauth2_role').value=oauthToken.value;
        var button = opener.document.getElementById('limsAdminForm:oauthLogin');
        // console.log('button ' + button)
        if(button){
          button.click();
        }
        window.close();
      }
    }
  </script>
  </body>
  </html>
</f:view>