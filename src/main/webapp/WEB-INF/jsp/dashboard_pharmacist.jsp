<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Med+ | Pharmacist Dashboard</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css?v=1.1' />">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="admin-layout">
        <div class="sidebar">
            <div class="sidebar-brand"><i class="fas fa-capsules"></i> Med+</div>
            <a href="/pharmacist/dashboard?tab=prescriptions" class="sidebar-link ${empty param.tab || param.tab == 'prescriptions' ? 'active' : ''}">
                <i class="fas fa-file-medical"></i> Prescription Review
            </a>
            <a href="/pharmacist/dashboard?tab=orders" class="sidebar-link ${param.tab == 'orders' ? 'active' : ''}">
                <i class="fas fa-shipping-fast"></i> Order Fulfillment
            </a>
            <div style="margin-top: 20px; border-top: 1px solid rgba(255,255,255,0.05); padding-top: 20px;">
                <a href="/" class="sidebar-link"><i class="fas fa-store"></i> Visit Store</a>
            </div>

            
            <div style="margin-top: auto; padding: 2rem; border-top: 1px solid rgba(255,255,255,0.1);">
                <div style="font-size: 12px; color: #94a3b8; margin-bottom: 8px;">Pharmacist</div>
                <div style="font-weight: 600; color: white; display: flex; align-items: center; gap: 8px;">
                    <div style="width: 8px; height: 8px; border-radius: 50%; background: #22c55e; box-shadow: 0 0 8px #22c55e;"></div>
                    ${sessionScope.user.username}
                </div>
                <a href="/logout" style="display: block; margin-top: 20px; color: #fca5a5; text-decoration: none; font-size: 14px; font-weight: 600;"><i class="fas fa-sign-out-alt"></i> Sign Out</a>
            </div>
        </div>

        <div class="main-content">
            <div style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 2.5rem;">
                <div>
                    <h1 style="margin: 0; font-size: 32px; font-weight: 800; letter-spacing: -0.5px;">
                        ${param.tab == 'orders' ? 'Order Fulfillment' : 'Prescription Review'}
                    </h1>
                    <p style="color: var(--text-muted); margin-top: 5px; font-size: 16px;">
                        ${param.tab == 'orders' ? 'Validate and process pending customer orders.' : 'Review and approve digital prescriptions.'}
                    </p>
                </div>
                <div style="font-weight: 700; color: var(--primary-blue); background: #e0f2fe; padding: 10px 20px; border-radius: 12px; font-size: 14px;">
                    <i class="fas fa-id-badge"></i> ${sessionScope.user.username}
                </div>
            </div>

            <c:choose>
                <c:when test="${empty param.tab || param.tab == 'prescriptions'}">
                    <div id="prescriptionsTab" class="tab-content active">
                        <div class="card" style="padding: 0; overflow: hidden; border-radius: 24px;">
                            <div class="table-container" style="margin-top: 0; border: none; box-shadow: none;">
                                <table>
                                    <thead>
                                        <tr style="background-color: #f8fafc;">
                                            <th style="padding: 1.5rem 2rem;">User ID</th>
                                            <th>Submission Date</th>
                                            <th>Prescription File</th>
                                            <th style="text-align: right; padding-right: 2rem;">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="rx" items="${pendingPrescriptions}">
                                            <tr>
                                                <td style="padding: 1.25rem 2rem; font-weight: 700; color: var(--text-dark);">${rx.userId}</td>
                                                <td style="color: var(--text-muted);">${rx.createdAt}</td>
                                                <td>
                                                    <a href="/uploads/${rx.filename}" target="_blank" style="display: inline-flex; align-items: center; gap: 8px; color: var(--primary-blue); text-decoration: none; font-weight: 600;">
                                                        <i class="fas fa-file-medical-alt"></i> View RX Document
                                                    </a>
                                                </td>
                                                <td style="text-align: right; padding-right: 2rem;">
                                                    <div style="display: inline-flex; gap: 10px;">
                                                        <a href="/pharmacist/prescription/${rx.id}/approve" class="table-action-btn btn-success" title="Approve"><i class="fas fa-check"></i></a>
                                                        <a href="/pharmacist/prescription/${rx.id}/reject" class="table-action-btn btn-danger" title="Reject"><i class="fas fa-times"></i></a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty pendingPrescriptions}">
                                            <tr>
                                                <td colspan="4" style="text-align: center; padding: 60px; color: var(--text-muted);">
                                                    <i class="fas fa-check-circle" style="font-size: 48px; color: var(--success-green); opacity: 0.2; display: block; margin-bottom: 15px;"></i>
                                                    All prescriptions have been cleared!
                                                </td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:when test="${param.tab == 'orders'}">
                    <div id="ordersTab" class="tab-content active">
                        <div class="card" style="padding: 0; overflow: hidden; border-radius: 24px;">
                            <div class="table-container" style="margin-top: 0; border: none; box-shadow: none;">
                                <table>
                                    <thead>
                                        <tr style="background-color: #f8fafc;">
                                            <th style="padding: 1.5rem 2rem;">Order Reference</th>
                                            <th>Amount</th>
                                            <th>Prescription</th>
                                            <th style="text-align: right; padding-right: 2rem;">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="order" items="${pendingOrders}">
                                            <tr>
                                                <td style="padding: 1.25rem 2rem;">
                                                    <span style="font-family: 'Courier New', Courier, monospace; font-weight: 800; color: var(--primary-blue);">#${fn:substring(order.id, 0, 8).toUpperCase()}</span>
                                                    <div style="font-size: 11px; color: var(--text-muted); margin-top: 4px;">${order.date}</div>
                                                </td>
                                                <td><span style="font-weight: 800; color: var(--text-dark);">Rs. ${order.totalAmount}</span></td>
                                                <td>
                                                    <c:if test="${not empty order.prescriptionId}">
                                                        <a href="/pharmacist/prescription/${order.prescriptionId}/view" target="_blank" style="color: var(--warning); text-decoration: none; font-weight: 700; font-size: 12px; display: inline-flex; align-items: center; gap: 5px;">
                                                            <i class="fas fa-file-prescription"></i> VIEW ATTACHED RX
                                                        </a>
                                                    </c:if>
                                                    <c:if test="${empty order.prescriptionId}">
                                                        <span style="color: var(--text-muted); font-size: 12px;">Not required</span>
                                                    </c:if>
                                                </td>
                                                <td style="text-align: right; padding-right: 2rem;">
                                                    <form action="/pharmacist/order/${order.id}/process" method="post" style="display: inline-flex; gap: 8px; align-items: center;">
                                                        <select name="status" style="padding: 6px 12px; border-radius: 8px; border: 1px solid #e2e8f0; font-size: 13px; font-weight: 600; background: #f8fafc; color: var(--text-dark); cursor: pointer;">
                                                            <option value="PENDING" ${order.status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                                                            <option value="APPROVED" ${order.status == 'APPROVED' ? 'selected' : ''}>APPROVED</option>
                                                            <option value="REJECTED" ${order.status == 'REJECTED' ? 'selected' : ''}>REJECTED</option>
                                                        </select>
                                                        <button type="submit" class="btn btn-primary" style="padding: 6px 16px; font-size: 13px; border-radius: 8px; font-weight: 700; cursor: pointer;">Update</button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty pendingOrders}">
                                            <tr>
                                                <td colspan="4" style="text-align: center; padding: 60px; color: var(--text-muted);">
                                                    <i class="fas fa-shopping-cart" style="font-size: 48px; opacity: 0.1; display: block; margin-bottom: 15px;"></i>
                                                    No orders waiting for processing.
                                                </td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:when>
            </c:choose>
        </div>
    </div>
</body>
</html>
