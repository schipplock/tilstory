<%@ page session="false" language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="settings" uri="/WEB-INF/settings.tld" %>
<!DOCTYPE html>
<html lang="de">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css.jsp">
<link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath}/graphics/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/graphics/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath}/graphics/favicon-16x16.png">
<link rel="manifest" href="${pageContext.request.contextPath}/site.webmanifest">
<link rel="alternate" type="application/rss+xml" href="${pageContext.request.contextPath}/rss.jsp" />
<title>${settings:name()}</title>

<main>
  <header>
    <h1># <a href="${pageContext.request.contextPath}/">${settings:name()}</a></h1>
    <h2>Kurze Texte von ${settings:author()}</h2>
    <h3>
      <a href="https://github.com/schipplock/tilstory" target="_blank">TILStory 0.0.5</a> |
      <a href="${pageContext.request.contextPath}/rss.jsp">rss</a>
    </h3>
  </header>