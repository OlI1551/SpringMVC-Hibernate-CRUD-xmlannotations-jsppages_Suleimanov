<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ page session="false" %>
<html>
<head>
    <title>Books Page</title>
    <meta charset="UTF-8">

    <style>
        .tg {
            border-collapse: collapse;
            border-spacing: 0;
            border-color: #ccc;
        }
        .tg td {
            font-family: Arial, sans-serif;
            font-size: 14px;
            padding: 10px 5px;
            border-style: solid;
            border-width: 1px;
            overflow: hidden;
            word-break: normal;
            border-color: #ccc;
            color: #333;
            background-color: #fff;
        }
        .tg th {
            font-family: Arial, sans-serif;
            font-size: 14px;
            font-weight: normal;
            padding: 10px 5px;
            border-style: solid;
            border-width: 1px;
            overflow: hidden;
            word-break: normal;
            border-color: #ccc;
            color: #333;
            background-color: #f0f0f0;
        }
    </style>
</head>
<body>
<a href="../index.jsp">Back to main menu</a>

<br/>
<br/>

<h1>Books List</h1>
<p>listBooks</p>
<!-- чтобы вывести атрибут -->
<%= request.getAttribute("listBooks") %>
<%= request.getAttribute("book")%>
<c:out value="${listBooks}"/>
<ul>
    <c:forEach items="${listBooks}" var="item">
        <li>${item}</li>
    </c:forEach>
</ul>

<table style="border:1px">
    <tr>
        <th>Title</th>
        <th>Author</th>
    </tr>
    <c:forEach items="${listBooks}" var="book">
        <tr>
            <td>${book.bookTitle}</td>
            <td>${book.bookAuthor}</td>
        </tr>
    </c:forEach>
</table>


<c:choose>
    <c:when test="${empty listBooks}">
        <p>The list is empty</p>
<%--        <table class="tg">--%>
<%--            <tr>--%>
<%--                <th style="width:80px">ID</th>--%>
<%--                <th style="width:120px">Title</th>--%>
<%--                <th style="width:120px">Autor</th>--%>
<%--                <th style="width:120px">Price</th>--%>
<%--                <th style="width:60px">Edit</th>--%>
<%--                <th style="width:60px">Delete</th>--%>
<%--            </tr>--%>
<%--            <c:forEach items="${listBooks}" var="book">--%>
<%--            <tr>--%>
<%--                <td style="width:80px">${book.id}</td>--%>
<%--                <td style="width:120px">${book.bookTitle}</td>--%>
<%--                <td style="width:120px">${book.bookAuthor}</td>--%>
<%--                <td style="width:120px">${book.price/100}${book.price%100}</td>--%>
<%--                <td style="width:60px"><a href="edit/${book.id}">Edit</a></td>--%>
<%--                <td style="width:60px"><a href="remove/${book.id}">Delete</a></td>--%>
<%--            </tr>--%>
<%--            </c:forEach>--%>
<%--        </table>--%>
    </c:when>
    <c:otherwise>
        <p>The list is not empty</p>
        <c:forEach items="bookList" var="book">
            <p>book.bookTitle</p>
        </c:forEach>
    </c:otherwise>
</c:choose>


<h1>Add a Book</h1>

<%--@elvariable id="book" type=""--%>
<form:form action="/books/add" modelAttribute="book" method="post">
    <table>
        <c:if test="${!empty book.bookTitle}">
            <tr>
                <td>
                    <form:label path="id">
                        <spring:message text="ID"/>
                    </form:label>
                </td>
                <td>
                    <form:input path="id" readonly="true" size="8" disabled="true"/>
<%--                    <form:hidden path="id"/>--%>
                </td>
            </tr>
        </c:if>
        <tr>
            <td>
                <form:label path="bookTitle">
                    <spring:message text="Title"/>
                </form:label>
            </td>
            <td>
                <form:input path="bookTitle"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="bookAuthor">
                    <spring:message text="Author"/>
                </form:label>
            </td>
            <td>
                <form:input path="bookAuthor"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="price">
                    <spring:message text="Price"/>
                </form:label>
            </td>
            <td>
                <form:input path="price"/>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <c:choose>
                    <c:when test="${not empty book.bookTitle}">
                        <form:button>Edit Book</form:button>
                    </c:when>
                    <c:otherwise>
                        <form:button>Add Book</form:button>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </table>
</form:form>
</body>
</html>
