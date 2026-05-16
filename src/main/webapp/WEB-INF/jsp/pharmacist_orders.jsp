<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>All Orders | Pharmacist Panel</title>
            <link rel="stylesheet" href="<c:url value='/css/style.css?v=1.1' />">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        </head>

        <body style="background: #f1f5f9;">
            <nav class="navbar">
                <a href="/" class="logo"><i class="fas fa-capsules"></i> Med+ Pharmacist</a>
                <div class="nav-links">
                    <a href="/pharmacist/dashboard">Dashboard</a>
                    <a href="/pharmacist/orders" style="font-weight: 600;">Manage Orders</a>
                    <a href="/pharmacist/stock">Inventory</a>
                    <a href="/logout" class="btn btn-danger" style="margin-left: 15px;">Logout</a>
                </div>
            </nav>

            <div class="container" style="margin-top: 4rem; margin-bottom: 4rem;">
                <h1 style="margin-bottom: 2rem;">Order Management</h1>

                <div class="card" style="padding: 0; overflow: hidden;">
                    <table style="width: 100%; border-collapse: collapse; text-align: left;">
                        <thead style="background: #f8fafc; border-bottom: 1px solid #e2e8f0;">
                            <tr>
                                <th style="padding: 20px;">Order ID</th>
                                <th style="padding: 20px;">Customer</th>
                                <th style="padding: 20px;">Method</th>
                                <th style="padding: 20px;">Total</th>
                                <th style="padding: 20px;">Status</th>
                                <th style="padding: 20px;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr style="border-bottom: 1px solid #f1f5f9;">
                                    <td style="padding: 20px;">
                                        <div style="font-weight: 600;">#${order.id.substring(0, 8)}</div>
                                        <div style="font-size: 12px; color: #64748b;">${order.date}</div>
                                    </td>
                                    <td style="padding: 20px;">${order.userId}</td>
                                    <td style="padding: 20px;">
                                        <c:choose>
                                            <c:when test="${order.deliveryMethod == 'URGENT'}">
                                                <span class="badge badge-warning"
                                                    style="background: #FEF3C7; color: #D97706;">Urgent</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-info">Normal</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="padding: 20px; font-weight: 600;">Rs. ${order.totalAmount}</td>
                                    <td style="padding: 20px;">
                                        <span class="badge" style="background:
                                    <c:choose>
                                        <c:when test=" ${order.status=='PENDING' }">#FEF3C7; color: #D97706</c:when>
                                            <c:when test="${order.status == 'APPROVED'}">#DBEAFE; color: #2563EB
                                            </c:when>
                                            <c:otherwise>#FEE2E2; color: #DC2626</c:otherwise>
                                            </c:choose>;">${order.status}
                                        </span>
                                    </td>
                                    <td style="padding: 20px;">
                                        <form action="/pharmacist/order/${order.id}/process" method="post"
                                            style="display: inline-flex; gap: 8px; align-items: center;">
                                            <select name="status"
                                                style="padding: 6px 12px; border-radius: 8px; border: 1px solid #e2e8f0; font-size: 13px; font-weight: 600; background: #f8fafc; color: var(--text-dark); cursor: pointer;">
                                                <option value="PENDING" ${order.status=='PENDING' ? 'selected' : '' }>
                                                    PENDING</option>
                                                <option value="APPROVED" ${order.status=='APPROVED' ? 'selected' : '' }>
                                                    APPROVED</option>
                                                <option value="REJECTED" ${order.status=='REJECTED' ? 'selected' : '' }>
                                                    REJECTED</option>
                                            </select>
                                            <button type="submit" class="btn btn-primary"
                                                style="padding: 6px 16px; font-size: 13px; border-radius: 8px; font-weight: 700; cursor: pointer;">Update</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
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
                        <p><i class="fas fa-phone-alt" style="margin-right:8px;"></i> +94 11 2000000</p>
                        <p><i class="fas fa-envelope" style="margin-right:8px;"></i> support@medplus.lk</p>
                    </div>
                </div>
            </footer>
        </body>

        </html>