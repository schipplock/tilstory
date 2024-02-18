<%@ page session="false" language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="settings" uri="/WEB-INF/settings.tld" %>
<!DOCTYPE html>
<html lang="de">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<link rel="icon" href="assets/images/fav-icon/fav-icon.png">
<link rel="alternate" type="application/rss+xml" href="${pageContext.request.contextPath}/rss.jsp" />
<title>${settings:name()}</title>

<header>
  <h1># <a href="${pageContext.request.contextPath}/">${settings:name()}</a>
  <h2>Kurze Texte<br>von ${settings:author()}</h2>
</header>