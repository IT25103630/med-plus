<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Med+ | Checkout</title>
            <link rel="stylesheet" href="<c:url value='/css/style.css?v=1.1' />">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        </head>

        <body>
            <nav class="navbar">
                <a href="/" class="logo"><i class="fas fa-capsules"></i> Med+</a>
                <div class="nav-links">
                    <a href="/">Home</a>
                    <a href="/about">About Us</a>

                    <a href="/cart" style="margin-left: 20px;"><i class="fas fa-shopping-cart"></i> Cart <span
                            class="badge badge-warning"
                            style="border-radius: 50%; padding: 2px 6px; font-size: 10px;">${not empty sessionScope.cart
                            ? sessionScope.cart.size() : 0}</span></a>

                    <c:if test="${empty sessionScope.user}">
                        <a href="/auth" class="btn btn-primary" style="margin-left: 20px;">Login / Register</a>
                    </c:if>
                    <c:if test="${not empty sessionScope.user}">
                        <c:choose>
                            <c:when test="${sessionScope.user.role == 'ADMIN'}">
                                <a href="/admin/dashboard" style="margin-left: 20px;"><i
                                        class="fas fa-tachometer-alt"></i> Dashboard</a>
                            </c:when>
                            <c:when test="${sessionScope.user.role == 'PHARMACIST'}">
                                <a href="/pharmacist/dashboard" style="margin-left: 20px;"><i
                                        class="fas fa-tachometer-alt"></i> Dashboard</a>
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
                <h1>Checkout</h1>

                <div style="display: flex; gap: 40px;">
                    <div style="flex: 2;">
                        <div class="card">
                            <c:if test="${not empty error}">
                                <div
                                    style="background: var(--error); color: white; padding: 10px; border-radius: 8px; margin-bottom: 20px;">
                                    ${error}
                                </div>
                            </c:if>

                            <form action="/checkout" method="post" enctype="multipart/form-data">

                                <h3>1. Delivery Method</h3>
                                <div style="margin: 15px 0 30px 0;">
                                    <label style="display: block; margin-bottom: 10px; cursor: pointer;">
                                        <input type="radio" name="deliveryMethod" value="NORMAL" checked>
                                        <strong>Normal Delivery</strong> (Rs. 200) - Delivery within 3 days.
                                    </label>
                                    <label style="display: block; cursor: pointer;">
                                        <input type="radio" name="deliveryMethod" value="URGENT">
                                        <strong>Urgent Delivery</strong> (Rs. 500) - Same day delivery.
                                    </label>
                                </div>

                                <c:if test="${requiresPrescription}">
                                    <h3>2. Upload Prescription</h3>
                                    <div
                                        style="margin: 15px 0 30px 0; background: #FFFBEB; padding: 15px; border-left: 4px solid var(--warning); border-radius: 4px;">
                                        <p style="color: #B45309; margin-bottom: 10px;"><strong><i
                                                    class="fas fa-exclamation-triangle"></i> Prescription
                                                Required</strong></p>
                                        <p style="font-size: 14px; margin-bottom: 15px;">One or more items in your cart
                                            require a valid medical prescription.</p>
                                        <input type="file" name="prescriptionFile" accept=".jpg,.jpeg,.png,.pdf"
                                            required class="form-group"
                                            style="border: 1px solid #ccc; padding: 10px; width: 100%; background: white;">
                                    </div>
                                </c:if>

                                <button type="submit" class="btn btn-success"
                                    style="width: 100%; font-size: 18px; padding: 12px;">Confirm Order</button>
                            </form>
                        </div>
                    </div>

                </div>
            </div>
</body>
</html>
