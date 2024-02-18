<%@ page session="false" language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="settings" uri="/WEB-INF/settings.tld" %>
<footer>
  <section id="impressum">
    <h2>Impressum und ViSdP</h2>
    <p>${settings:imprint()}</p>
    <p>
      <strong>Telefon:</strong> 0163-17(2*3)-11-18<br>
      <strong>E-Mail:</strong> <span class="email" id="email">ed.kcolppihcs@saerdna</span>
    </p>
  </section>

  <section id="datenschutz">
    <h2>Datenschutzerkl&auml;rung</h2>
    <p>
      ${settings:privacyPolicy()}
    </p>
  </section>
</footer>

<script>
  (() => {
    document.getElementById("email").innerHTML = '<a href="mailto:' + "${settings:reversedEmail()}".split("").reverse().join("") + '">${settings:reversedEmail()}</a>'
  })();
</script>