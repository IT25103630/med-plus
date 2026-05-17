<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>${medicine.name} | Med+</title>
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
                        <a href="/profile" style="margin-left: 20px;"><i class="fas fa-user"></i> My Profile</a>
                        <a href="/logout" class="btn btn-danger" style="margin-left: 15px;">Logout</a>
                    </c:if>
                </div>
            </nav>

            <div class="container" style="margin-top: 4rem; margin-bottom: 4rem;">
                <div
                    style="display: flex; gap: 40px; background: white; padding: 40px; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); align-items: center;">
                    <div
                        style="flex: 1; background: #f1f5f9; height: 400px; border-radius: 15px; display: flex; align-items: center; justify-content: center;">
                        <i class="fas fa-pills" style="font-size: 120px; color: var(--primary-blue);"></i>
                    </div>
                    <div style="flex: 1.5;">
                        <div style="display: flex; gap: 10px; margin-bottom: 20px;">
                            <span class="badge badge-info">${medicine.category}</span>
                            <c:if test="${medicine.requiresPrescription}">
                                <span class="badge badge-warning" style="background: #FEE2E2; color: #DC2626;"><i
                                        class="fas fa-file-prescription"></i> Prescription Required</span>
                            </c:if>
                        </div>
                        <h1 style="font-size: 36px; margin-bottom: 10px;">${medicine.name}</h1>
                        <div class="card-price" style="font-size: 28px; margin-bottom: 25px;">Rs. ${medicine.price}
                        </div>

                        <h3 style="margin-bottom: 10px; color: var(--text-dark);">Product Description</h3>
                        <p style="line-height: 1.8; color: var(--text-muted); margin-bottom: 30px;">
                            ${medicine.description}
                            <br><br>
                            <strong>Expiry Date:</strong> ${not empty medicine.expiryDate ? medicine.expiryDate : 'N/A'}
                        </p>

                        <c:choose>
                            <c:when test="${medicine.expired}">
                                <div
                                    style="padding: 15px; background: #FEE2E2; color: #DC2626; border-radius: 10px; margin-bottom: 20px;">
                                    <i class="fas fa-exclamation-triangle"></i> This medicine has expired and cannot be
                                    ordered.
                                </div>
                            </c:when>
                            <c:when test="${medicine.stock > 0}">
                                <div style="margin-bottom: 20px; color: var(--success-green); font-weight: 600;">
                                    <i class="fas fa-check-circle"></i> In Stock (${medicine.stock} units available)
                                </div>
                                <form action="/cart/add" method="post"
                                    style="display: flex; gap: 15px; align-items: flex-end;">
                                    <input type="hidden" name="medicineId" value="${medicine.id}">
                                    <div class="form-group" style="margin-bottom: 0;">
                                        <label
                                            style="display: block; margin-bottom: 5px; font-size: 14px;">Quantity</label>
                                        <input type="number" name="quantity" value="1" min="1" max="${medicine.stock}"
                                            style="width: 80px; padding: 10px; border: 1px solid #ddd; border-radius: 8px;">
                                    </div>
                                    <button type="submit" class="btn btn-primary"
                                        style="padding: 12px 40px; font-size: 18px; flex: 1;">
                                        <i class="fas fa-cart-plus"></i> Add to Cart
                                    </button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <div
                                    style="padding: 15px; background: #f1f5f9; color: #64748b; border-radius: 10px; margin-bottom: 20px;">
                                    <i class="fas fa-info-circle"></i> Currently out of stock.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div style="margin-top: 4rem;">
                    <h2>Usage Information</h2>
                    <div class="card-grid" style="margin-top: 1.5rem;">
                        <div class="card" style="padding: 25px;">
                            <i class="fas fa-clock"
                                style="font-size: 24px; color: var(--primary-blue); margin-bottom: 15px;"></i>
                            <div class="card-title" style="font-size: 18px;">Dosage</div>
                            <p style="font-size: 14px; color: var(--text-muted);">Please follow your doctor's
                                instructions for the correct dosage. Usually taken as prescribed.</p>
                        </div>
                        <div class="card" style="padding: 25px;">
                            <i class="fas fa-shield-alt"
                                style="font-size: 24px; color: var(--primary-blue); margin-bottom: 15px;"></i>
                            <div class="card-title" style="font-size: 18px;">Safety Info</div>
                            <p style="font-size: 14px; color: var(--text-muted);">Keep out of reach of children. Store
                                in a cool, dry place away from direct sunlight.</p>
                        </div>
                        <div class="card" style="padding: 25px;">
                            <i class="fas fa-exclamation-circle"
                                style="font-size: 24px; color: var(--primary-blue); margin-bottom: 15px;"></i>
                            <div class="card-title" style="font-size: 18px;">Side Effects</div>
                            <p style="font-size: 14px; color: var(--text-muted);">Consult your pharmacist or doctor if
                                you experience any persistent side effects.</p>
                        </div>
                    </div>
                </div>
            </div>

            <footer class="footer">
                <div class="footer-content"
                    style="display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:20px;padding:0 40px;">
                    <div>
                        <div style="font-size:20px;font-weight:700;color:white;"><i class="fas fa-capsules"></i> Med+
                        </div>
                        <p style="color:#cbd5e1;font-size:13px;margin-top:5px;">SLIIT, Malabe, Sri Lanka</p>
                    </div>
                    <div style="color:#cbd5e1;font-size:13px;text-align:center;">
                        &copy; 2026 Med+ | SLIIT Online Medical Store
                    </div>
                    <div style="color:#cbd5e1;font-size:13px;">
                        <p><i class="fas fa-phone-alt" style="margin-right:8px;"></i> +94112000000</p>
                        <p><i class="fas fa-envelope" style="margin-right:8px;"></i> support@medplus.lk</p>
                    </div>
                </div>
            </footer>

        </body>

        </html>