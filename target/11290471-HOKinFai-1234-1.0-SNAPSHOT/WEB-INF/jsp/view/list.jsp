<!DOCTYPE html>
<html>
    <head>
        <title>List | 380</title>
    </head>
    <body>
        <c:url var="logoutUrl" value="/logout"/>
        <form action="${logoutUrl}" method="post">
            <input type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

        <div style="text-align: left; background-color: #DCDCDC; color: black;">    
            <h2>Tickets</h2>
        </div>
        <a href="<c:url value="/ticket/create" />">Create a Ticket</a><br /><br />
        <c:choose>
            <c:when test="${fn:length(ticketDatabase) == 0}">
                <i>There are no tickets in the system.</i>
            </c:when>
            <c:otherwise>
                <c:forEach items="${ticketDatabase}" var="entry">
                    Ticket ${entry.key}:
                    <a href="<c:url value="/ticket/view/${entry.key}" />">
                        <c:out value="${entry.value.subject}" /></a>
                    (customer: <c:out value="${entry.value.customerName}" />)
                    <security:authorize access="hasRole('ADMIN') or principal.username=='${entry.value.customerName}'">            
                        [<a href="<c:url value="/ticket/edit/${entry.key}" />">Edit</a>]
                    </security:authorize>
                    <security:authorize access="hasRole('ADMIN')">            
                        [<a href="<c:url value="/ticket/delete/${entry.key}" />">Delete</a>]
                    </security:authorize>
                    <br /><br />
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </body>
</html>