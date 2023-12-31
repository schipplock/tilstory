<%@ page session="false" language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="settings" uri="/WEB-INF/settings.tld" %>
<footer id="kontakt">
  <h2>Impressum und ViSdP</h2>
  <p>${settings:imprint()}</p>
  <br />
  <p>
    <strong>Telefon:</strong> ${settings:phone()}<br />
    <strong>E-Mail:</strong> <span class="email" id="email">${settings:reversedEmail()}</span>
  </p>
  <br />
  <h2>Datenschutzerklärung</h2>
  <p>
    ${settings:privacyPolicy()}
  </p>
</footer>
</main>

<script>
  (function() {
    document.getElementById("email").innerHTML = '<a href="mailto:' + "${settings:reversedEmail()}".split("").reverse().join("") + '">${settings:reversedEmail()}</a>'
  })();
</script>