<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Med+ | Online Medical Store</title>
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
                            class="badge badge-warning" id="cartBadge"
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

                <!-- Hero Section -->
                <div class="hero">
                    <h1>Your Health, Delivered.</h1>
                    <p>Order authentic medicines and healthcare products online. Fast, safe, and reliable delivery right
                        to your doorstep.</p>
                    <a href="#shopByCategory" class="btn btn-primary"
                        style="background: white; color: var(--primary-blue); font-weight: 700; font-size: 18px; padding: 12px 30px; border: 2px solid white; text-decoration: none; border-radius: 8px;">Shop
                        Medicines</a>
                    <a href="/contact" class="btn btn-outline"
                        style="margin-left: 15px; font-size: 18px; padding: 12px 30px; border: 2px solid white; background: rgba(255,255,255,0.1); color: white; text-decoration: none; border-radius: 8px; font-weight: 700;">Consult
                        a Doctor</a>
                </div>

                <!-- Categories Section -->
                <h2 style="text-align: center; margin-bottom: 2rem;" id="shopByCategory">Shop by Category</h2>

                <c:if test="${not empty param.category || not empty param.search}">
                    <script>
                        window.addEventListener('DOMContentLoaded', (event) => {
                            document.getElementById('shopByCategory').scrollIntoView({ behavior: 'smooth' });
                        });
                    </script>
                </c:if>
                <div class="categories">
                    <a href="/?category=Painkillers#shopByCategory" class="category-card">
                        <i class="fas fa-pills category-icon"></i>
                        <div>Painkillers</div>
                    </a>
                    <a href="/?category=Antibiotics#shopByCategory" class="category-card">
                        <i class="fas fa-capsules category-icon"></i>
                        <div>Antibiotics</div>
                    </a>
                    <a href="/?category=Vitamins#shopByCategory" class="category-card">
                        <i class="fas fa-apple-alt category-icon"></i>
                        <div>Vitamins</div>
                    </a>
                    <a href="/?category=First Aid#shopByCategory" class="category-card">
                        <i class="fas fa-medkit category-icon"></i>
                        <div>First Aid</div>
                    </a>
                    <a href="/#shopByCategory" class="category-card">
                        <i class="fas fa-list category-icon"></i>
                        <div>View All</div>
                    </a>
                </div>

                <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 4rem;"
                    id="medicines">
                    <h2>Featured Medicines</h2>
                    <form action="/" method="get" style="display: flex; gap: 10px;">
                        <input type="text" name="search" placeholder="Search medicines..." value="${param.search}"
                            style="width: 250px; padding: 10px; border: 1px solid #ddd; border-radius: 8px;">
                        <button type="submit" class="btn btn-primary">Search</button>
                    </form>
                </div>

                <div class="card-grid">
                    <c:forEach var="medicine" items="${medicines}">
                        <div class="card">
                            <div
                                style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 15px;">
                                <span class="badge badge-info">${medicine.category}</span>
                                <c:if test="${medicine.requiresPrescription}">
                                    <span class="badge badge-warning" style="background: #FEE2E2; color: #DC2626;"><i
                                            class="fas fa-file-prescription"></i> Prescription Required</span>
                                </c:if>
                            </div>
                            <div class="card-title">
                                <a href="/medicine/${medicine.id}"
                                    style="color: inherit; text-decoration: none; hover: color: var(--primary-blue);">${medicine.name}</a>
                            </div>
                            <p
                                style="color: var(--text-muted); font-size: 14px; margin-bottom: 15px; height: 40px; overflow: hidden;">
                                ${medicine.description}</p>
                            <div class="card-price">Rs. ${medicine.price}</div>

                            <c:choose>
                                <c:when test="${medicine.expired}">
                                    <p style="color: var(--error); font-size: 14px; margin-bottom: 15px;">Expired</p>
                                    <button class="btn btn-danger"
                                        style="width: 100%; opacity: 0.5; cursor: not-allowed;" disabled>Cannot
                                        Order</button>
                                </c:when>
                                <c:when test="${medicine.stock > 0}">
                                    <p style="color: var(--success-green); font-size: 14px; margin-bottom: 15px;">In
                                        Stock (${medicine.stock})</p>
                                    <form action="/cart/add" method="post" style="display: flex; gap: 10px;">
                                        <input type="hidden" name="medicineId" value="${medicine.id}">
                                        <input type="number" name="quantity" value="1" min="1" max="${medicine.stock}"
                                            style="width: 60px; padding: 5px; border-radius: 5px; border: 1px solid #ccc;">
                                        <button type="submit" class="btn btn-primary" style="flex: 1;">Add to
                                            Cart</button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <p style="color: var(--error); font-size: 14px; margin-bottom: 15px;">Out of Stock
                                    </p>
                                    <button class="btn btn-danger"
                                        style="width: 100%; opacity: 0.5; cursor: not-allowed;"
                                        disabled>Unavailable</button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Footer -->
            <footer class="footer">
                <div class="footer-content">
                    <div class="footer-col">
                        <div style="font-size: 24px; font-weight: 700; color: white; margin-bottom: 15px;"><i
                                class="fas fa-capsules"></i> Med+</div>
                        <p style="color: #cbd5e1; margin-bottom: 20px; font-size: 14px; line-height: 1.8;">Your trusted
                            online medical store. We ensure the delivery of high-quality medicines directly to your home
                            with safety and reliability.</p>
                        <div style="display: flex; gap: 15px;">
                            <a href="#" style="font-size: 20px;"><i class="fab fa-facebook"></i></a>
                            <a href="#" style="font-size: 20px;"><i class="fab fa-twitter"></i></a>
                            <a href="#" style="font-size: 20px;"><i class="fab fa-instagram"></i></a>
                        </div>
                    </div>
                    <div class="footer-col">
                        <h3>Quick Links</h3>
                        <a href="/">Home</a>
                        <a href="/about">About Us</a>
                    </div>
                    <div class="footer-col">
                        <h3>Contact</h3>
                        <p style="margin-bottom: 10px;"><i class="fas fa-map-marker-alt"
                                style="margin-right: 10px;"></i> SLIIT, Malabe, Sri Lanka</p>
                        <p style="margin-bottom: 10px;"><i class="fas fa-phone-alt" style="margin-right: 10px;"></i> +94
                            11 2000000</p>
                        <p><i class="fas fa-envelope" style="margin-right: 10px;"></i> support@medplus.lk</p>
                    </div>
                </div>
                <div class="footer-bottom">
                    &copy; 2026 Med+ Online Medical Store. All rights reserved.
                </div>
            </footer>

        </body>

        </html>