<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="stringescaper" uri="/WEB-INF/stringescaper.tld" %>
<%@ taglib prefix="postrenderer" uri="/WEB-INF/postrenderer.tld" %>
<%@ taglib prefix="settings" uri="/WEB-INF/settings.tld" %>

<%
    if (request.getParameter("logoff") != null) {
        session.invalidate();
        response.sendRedirect(request.getContextPath() + "/admin.jsp");
        return;
    }
%>

<sql:query var="posts" dataSource="postgres">
    select id, guid, subject, draft from posts order by id desc
</sql:query>

<c:if test="${not empty param.id}">
    <sql:query var="post" dataSource="postgres">
        select id, guid, subject, body, draft, created, updated from posts where id = ?::bigint
        <sql:param value="${param.id}" />
    </sql:query>
    <c:set var="id" value="${post.rows[0].id}" />
    <c:set var="guid" value="${post.rows[0].guid}" />
    <c:set var="subject" value="${post.rows[0].subject}" />
    <c:set var="body" value="${post.rows[0].body}" />
    <c:set var="draft" value="${post.rows[0].draft}" />
    <c:set var="created" value="${post.rows[0].created}" />
    <c:set var="updated" value="${post.rows[0].updated}" />
    <sql:query var="files" dataSource="postgres">
        select id, post_id, filename from files where post_id = ?::bigint
        <sql:param value="${param.id}" />
    </sql:query>
</c:if>

<jsp:include page="/WEB-INF/includes/admin/header.jsp" />

<section class="post">
    <form method="post" action="${pageContext.request.contextPath}/post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${id}" />
        Überschrift:<br />
        <input type="text" name="subject" value="${stringescaper:escapeHtml4(subject)}" required /><br />
        Text:<br />
        <textarea name="body" rows="20" required>${body}</textarea><br />
        <hr />
        <input type="file" name="file" id="file" multiple /><br />
        <c:if test="${not empty param.id and files.getRowCount() > 0}">
            <table style="width:100%" class="styled-table">
            <c:forEach var="file" items="${files.rows}">
                <tr>
                    <td style="width:250px">
                        <label class="checkbox">
                            <input type="checkbox" name="files" value="${file.filename}" id="file_${file.filename}" title="markieren zum löschen" />
                            <span>löschen?</span>
                        </label>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/_files/${guid}/${file.filename}" target="_blank">${file.filename}</a>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <c:set var="markdownFilePrefix" value="" />
                        <c:if test="${fn:endsWith(file.filename, '.jpg') or fn:endsWith(file.filename, '.jpeg') or fn:endsWith(file.filename, '.png')}">
                            <c:set var="markdownFilePrefix" value="!" />
                        </c:if>
                        <c:set var="markdownFileText" value="${markdownFilePrefix}[${file.filename}](&lt;${pageContext.request.contextPath}/_files/${guid}/${file.filename}&gt;)" />
                        <input type="hidden" id="copyFileMarkdown${file.filename}" value="${markdownFileText}">
                        <code onclick="copyToClipboard('copyFileMarkdown${file.filename}')">${markdownFileText}</code>
                    </td>
                </tr>
            </c:forEach>
            </table>
        </c:if>
        <hr />
        <label class="checkbox">
            <input type="checkbox" id="draft" name="draft" value="true" <c:if test="${empty param.id or draft}">checked</c:if> />
            <span>Entwurf?</span>
        </label>
        <hr />
        <input type="submit" value="speichern" />
    </form>
    <c:if test="${not empty param.id}">
        <div class="postcontent">
            <h2 class="subject">${subject}</h2>
            <postrenderer:render>
                ${body}
            </postrenderer:render>
            <p class="created">
                Autor: ${settings:author()}, Erstellt: <fmt:formatDate value="${created}" type="both" dateStyle="short" timeStyle="short" />
                <c:if test="${not empty updated}">
                    , aktualisiert: <fmt:formatDate value="${updated}" type="both" dateStyle="short" timeStyle="short" />
                </c:if>,
                <sql:query var="posthits" dataSource="postgres">
                    select count(guid) as hits from posthits where guid = ?::uuid
                    <sql:param value="${guid}" />
                </sql:query>
                Aufrufe: ${posthits.rows[0].hits}
            </p>
        </div>
    </c:if>
</section>

<c:if test="${posts.getRowCount() > 0}">
    <hr>
    <section class="post-list" id="post${post.rows[0].guid}">
        <c:forEach var="post" items="${posts.rows}">
            <form method="post" action="${pageContext.request.contextPath}/post" enctype="multipart/form-data" onsubmit="return confirm('Den Beitrag unwiderruflich löschen?')">
                <input type="hidden" name="_method" value="DELETE" />
                <input type="hidden" name="id" value="${post.id}" />
                <button type="submit" class="delete-button" title="l&ouml;schen">löschen</button>
            </form>
            <h1 class="subject">
                <c:if test="${not post.draft}"><b style="cursor:default" title="veröffentlicht, für alle sichtbar">🟢</b></c:if>
                <c:if test="${post.draft}"><b style="cursor:default" title="noch nicht veröffentlicht, für niemanden sichtbar">🔴</b></c:if>
                <a href="${pageContext.request.contextPath}/admin.jsp?id=${post.id}">#${post.id}:&nbsp;${post.subject}</a>
            </h1>
        </c:forEach>
    </section>
</c:if>

<script>
    let copyToClipboard = (id) => navigator.clipboard.writeText(document.getElementById(id).value);
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />