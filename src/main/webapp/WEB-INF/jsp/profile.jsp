<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Med+ | My Profile</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css?v=1.1' />">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <nav class="navbar">
        <a href="/" class="logo"><i class="fas fa-capsules"></i> Med+</a>
        <div class="nav-links">
            <a href="/">Home</a>
            <a href="/about">About Us</a>
            
            <a href="/cart" style="margin-left: 20px;"><i class="fas fa-shopping-cart"></i> Cart <span class="badge badge-warning" style="border-radius: 50%; padding: 2px 6px; font-size: 10px;">${not empty sessionScope.cart ? sessionScope.cart.size() : 0}</span></a>
            
            <c:if test="${empty sessionScope.user}">
                <a href="/auth" class="btn btn-primary" style="margin-left: 20px;">Login / Register</a>
            </c:if>
            <c:if test="${not empty sessionScope.user}">
                <c:choose>
                    <c:when test="${sessionScope.user.role == 'ADMIN'}">
                        <a href="/admin/dashboard" style="margin-left: 20px;"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                    </c:when>
                    <c:when test="${sessionScope.user.role == 'PHARMACIST'}">
                        <a href="/pharmacist/dashboard" style="margin-left: 20px;"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                    </c:when>
                    <c:otherwise>
                        <a href="/profile" style="margin-left: 20px;"><i class="fas fa-user"></i> My Profile</a>
                    </c:otherwise>
                </c:choose>
                <a href="/logout" class="btn btn-danger" style="margin-left: 15px;">Logout</a>
            </c:if>
        </div>
    </nav>

    <div class="container">
        <h1>My Profile</h1>
        <div class="card" style="margin-bottom: 30px;">
            <p>Welcome, <strong>${sessionScope.user.username}</strong></p>
            <form action="/profile/update" method="post" style="display: flex; gap: 15px; margin-top: 15px; max-width: 600px;">
                <div class="form-group" style="flex: 1;">
                    <label>Email</label>
                    <input type="email" name="email" value="${sessionScope.user.email}" required>
                </div>
                <div class="form-group" style="flex: 1;">
                    <label>Phone</label>
                    <input type="text" name="phone" value="${sessionScope.user.phone}" required>
                </div>
                <div class="form-group" style="display: flex; align-items: flex-end;">
                    <button type="submit" class="btn btn-primary" style="height: 48px;">Update Profile</button>
                </div>
            </form>
        </div>

        <h2>My Orders</h2>
        <div class="table-container" style="margin-bottom: 40px;">
            <table>
                <thead>
                    <tr>
                        <th>Tracking ID</th>
                        <th>Amount</th>
                        <th>Delivery</th>
                        <th>Status</th>
                        <th>Items</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${myOrders}">
                        <tr>
                            <td><strong>${order.trackingId}</strong></td>
                            <td>Rs. ${order.totalAmount}</td>
                            <td><span class="badge ${order.deliveryMethod == 'URGENT' ? 'badge-error' : 'badge-info'}">${order.deliveryMethod}</span></td>
                            <td><span class="badge badge-warning">${order.status}</span></td>
                            <td>${fn:length(order.items)} item(s)</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty myOrders}">
                        <tr><td colspan="5" style="text-align: center; color: #888;">You have no orders.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <h2>My Prescriptions</h2>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Document</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="rx" items="${myPrescriptions}">
                        <tr>
                            <td>...${fn:substring(rx.id, rx.id.length() - 8, rx.id.length())}</td>
                            <td><a href="/uploads/${rx.filename}" target="_blank" style="color: var(--primary-blue); text-decoration: none;"><i class="fas fa-file-image"></i> View File</a></td>
                            <td><span class="badge badge-warning">${rx.status}</span></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty myPrescriptions}">
                        <tr><td colspan="3" style="text-align: center; color: #888;">No uploaded prescriptions.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>

    </div>
</body>
</html>
