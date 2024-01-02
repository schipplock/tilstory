<%@ page session="false" language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="stringescaper" uri="/WEB-INF/stringescaper.tld" %>
<%@ taglib prefix="postrenderer" uri="/WEB-INF/postrenderer.tld" %>
<%@ taglib prefix="settings" uri="/WEB-INF/settings.tld" %>

<c:if test="${empty param.postId}">
    <sql:query var="post" dataSource="postgres">
        select id, guid, subject, body, created, updated from posts where draft is not true order by id desc limit 1
    </sql:query>
</c:if>

<c:if test="${not empty param.postId}">
    <sql:query var="post" dataSource="postgres">
        select id, guid, subject, body, created, updated from posts where draft is not true and guid = ?::uuid
        <sql:param value="${param.postId}" />
    </sql:query>
</c:if>

<c:if test="${post.getRowCount() eq 0}">
    <c:redirect url="${settings:baseurl()}/no-post-for-you/" />
</c:if>

<sql:query var="postTitles" dataSource="postgres">
    select id, guid, subject from posts where draft is not true order by id desc
</sql:query>

<jsp:include page="/WEB-INF/includes/header.jsp" />

<c:forEach var="postTitleItem" items="${postTitles.rows}">
    <c:if test="${post.rows[0].guid eq postTitleItem.guid}">
        <sql:update dataSource="postgres">
            insert into posthits (guid) values (?::uuid)
            <sql:param value="${post.rows[0].guid}" />
        </sql:update>
        <section class="post" id="post${post.rows[0].guid}">
            <h1 class="subject"><a href="${pageContext.request.contextPath}/?postId=${post.rows[0].guid}#post${post.rows[0].guid}">#${post.rows[0].id}:</a>&nbsp;${post.rows[0].subject}</h1>
            <h2 class="author">ein Beitrag von ${settings:author()}</h2>
            <postrenderer:render>
                ${post.rows[0].body}
            </postrenderer:render>
            <p class="created">Erstellt: <fmt:formatDate value="${post.rows[0].created}" type="both" dateStyle="short" timeStyle="short" />
                <c:if test="${not empty post.rows[0].updated}">
                    , aktualisiert: <fmt:formatDate value="${post.rows[0].updated}" type="both" dateStyle="short" timeStyle="short" />
                </c:if>,
                <sql:query var="posthits" dataSource="postgres">
                    select count(guid) as hits from posthits where guid = ?::uuid
                    <sql:param value="${post.rows[0].guid}" />
                </sql:query>
                Aufrufe: ${posthits.rows[0].hits}
            </p>
        </section>
    </c:if>
    <c:if test="${post.rows[0].guid ne postTitleItem.guid}">
        <section class="post postcontentless">
            <h1 class="subject"><a href="${pageContext.request.contextPath}/?postId=${postTitleItem.guid}#post${postTitleItem.guid}">#${postTitleItem.id}:&nbsp;${postTitleItem.subject}</a></h1>
        </section>
    </c:if>
</c:forEach>

<jsp:include page="/WEB-INF/includes/footer.jsp" />