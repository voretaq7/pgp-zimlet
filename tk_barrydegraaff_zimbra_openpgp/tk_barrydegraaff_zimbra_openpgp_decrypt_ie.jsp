<%/*
This file is part of the Zimbra OpenPGP Zimlet project.
Copyright (C) 2014  Barry de Graaff

Bugs and feedback: https://github.com/barrydegraaff/pgp-zimlet/issues

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see http://www.gnu.org/licenses/.

Zimbra caches jsp files that will persist until you issue:
zmmailboxdctl restart
Normal cache flush does NOT work
*/
%><!DOCTYPE html>
<html><head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Zimbra OpenPGP Zimlet</title>
<script src="/service/zimlet/_dev/tk_barrydegraaff_zimbra_openpgp/openpgp.js"></script>
</head>
<body style="font-family:sans-serif"><b>Decrypted result</b>
<textarea style="display:none" readonly id="message" rows="20" cols="100"><%= request.getParameter("message")%></textarea>
<textarea style="display:none" readonly id="privateKey" rows="20" cols="100"><%= request.getParameter("privateKey")%></textarea>
<textarea style="display:none" readonly id="passphrase" rows="20" cols="100"><%= request.getParameter("passphrase")%></textarea>
<script type="text/javascript">
var openpgp = window.openpgp;

function decrypt () {
   var passphrase = document.getElementById('passphrase').value;
   try {
      var privKeys = openpgp.key.readArmored(document.getElementById('privateKey').value);
      var privKey = privKeys.keys[0];
      var success = privKey.decrypt(passphrase);
   }
   catch (err) {
      document.write('<br><br>Could not parse private key!');
      return;
   }

   if (success) {
      try {
         var message = openpgp.message.readArmored(document.getElementById('message').value);
         var decrypted = openpgp.decryptMessage(privKey, message);
         document.write('<pre>' + decrypted + '</pre>');
      } catch (err) {
         document.write('<br><br>Decryption failed!');
      }
   }
   else {
      document.write('<br><br>Wrong passphrase!');
   }
}
decrypt();
</script>
<br><br><small>Tip: CTRL+W to close this tab.</small>
</body>
</html>
