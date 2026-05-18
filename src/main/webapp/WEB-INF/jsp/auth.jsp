<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Med+ | Authentication</title>
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

    <div class="auth-wrapper">
        <div class="auth-card">
            
            <c:if test="${not empty error}">
                <div style="background: var(--error); color: white; padding: 10px; border-radius: 8px; margin-bottom: 20px; text-align: center;">
                    ${error}
                </div>
            </c:if>
            <c:if test="${not empty success}">
                <div style="background: var(--success-green); color: white; padding: 10px; border-radius: 8px; margin-bottom: 20px; text-align: center;">
                    ${success}
                </div>
            </c:if>

            <div style="display: flex; margin-bottom: 20px; border-bottom: 2px solid #eee;">
                <a href="/auth?type=login" style="flex: 1; padding: 10px; text-align: center; text-decoration: none; font-size: 16px; font-weight: 600; color: ${param.type != 'register' ? 'var(--primary-blue)' : 'var(--text-muted)'}; border-bottom: ${param.type != 'register' ? '3px solid var(--primary-blue)' : 'none'};">Login</a>
                <a href="/auth?type=register" style="flex: 1; padding: 10px; text-align: center; text-decoration: none; font-size: 16px; font-weight: 600; color: ${param.type == 'register' ? 'var(--primary-blue)' : 'var(--text-muted)'}; border-bottom: ${param.type == 'register' ? '3px solid var(--primary-blue)' : 'none'};">Register</a>
            </div>

            <c:choose>
                <c:when test="${param.type == 'register'}">
                    <!-- Register Form -->
                    <form action="/register" method="post">
                        <div class="form-group">
                            <label>Username</label>
                            <input type="text" name="username" required>
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" name="email" required>
                        </div>
                        <div class="form-group">
                            <label>Phone</label>
                            <input type="text" name="phone" required>
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            <input type="password" name="password" required>
                        </div>
                        <button type="submit" class="btn btn-success" style="width: 100%;">Create Account</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <!-- Login Form -->
                    <form action="/login" method="post">
                        <div class="form-group">
                            <label>Username</label>
                            <input type="text" name="username" required>
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            <input type="password" name="password" required>
                        </div>
                        <button type="submit" class="btn btn-primary" style="width: 100%;">Login</button>
                    </form>
                </c:otherwise>
            </c:choose>

        </div>
    </div>
</body>
</html>
