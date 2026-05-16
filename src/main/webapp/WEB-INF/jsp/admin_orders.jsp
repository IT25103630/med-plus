<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Med+ | Order Manage</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css?v=1.1' />">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body style="margin: 0; background-color: #f1f5f9;">
    <div class="admin-layout">
        <div class="sidebar">
            <div class="sidebar-brand"><i class="fas fa-capsules"></i> Med+ Admin</div>
            <a href="/admin/dashboard" class="sidebar-link"><i class="fas fa-th-large"></i> Overview</a>
            <a href="/admin/medicines" class="sidebar-link"><i class="fas fa-pills"></i> Medicine</a>
            <a href="/admin/orders" class="sidebar-link active"><i class="fas fa-receipt"></i> Orders</a>
            <a href="/admin/users" class="sidebar-link"><i class="fas fa-user-shield"></i> User Manage</a>
            <a href="/admin/categories" class="sidebar-link"><i class="fa fa-bars"></i> Categories</a>
            <div style="margin-top: 20px; border-top: 1px solid rgba(255,255,255,0.05); padding-top: 20px;">
                <a href="/" class="sidebar-link"><i class="fas fa-store"></i> Visit Store</a>
            </div>
            
            <div class="sidebar-footer">
                <div style="font-size: 13px; color: #94a3b8; margin-bottom: 10px;">Administrator</div>
                <div style="display: flex; align-items: center; gap: 10px;">
                    <div style="width: 36px; height: 36px; border-radius: 12px; background: var(--primary-gradient); display: flex; align-items: center; justify-content: center; font-weight: 700; color: white; font-size: 18px;">A</div>
                    <div>
                        <div style="font-weight: 600;">${sessionScope.user.username}</div>
                        <div style="font-size: 11px; color: var(--success-green); font-weight: 700;">● ONLINE</div>
                    </div>
                </div>
                <a href="/logout" style="display: block; margin-top: 25px; color: #fca5a5; text-decoration: none; font-size: 14px; font-weight: 600;"><i class="fas fa-sign-out-alt"></i> Sign Out</a>
            </div>
        </div>

        <div class="main-content">
            <div style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 2.5rem;">
                <div>
                    <h1 style="margin: 0; font-size: 32px; font-weight: 800; letter-spacing: -0.5px;">Customer Orders</h1>
                    <p style="color: var(--text-muted); margin-top: 5px; font-size: 16px;">Comprehensive list of all orders and fulfillment statuses.</p>
                </div>
                <div style="display: flex; gap: 12px;">
                    <button onclick="generatePDF()" class="btn btn-primary" style="padding: 10px 20px; border-radius: 12px; font-weight: 600;"><i class="fas fa-file-pdf"></i> Generate Report</button>
                </div>
            </div>

            <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
            <script>
                function generatePDF() {
                    const element = document.querySelector('.table-container');
                    const options = {
                        margin: 10,
                        filename: 'Order_Report_' + new Date().toLocaleDateString() + '.pdf',
                        image: { type: 'jpeg', quality: 0.98 },
                        html2canvas: { scale: 2 },
                        jsPDF: { unit: 'mm', format: 'a4', orientation: 'landscape' }
                    };
                    html2pdf().set(options).from(element).save();
                }
            </script>
            
            <div class="card" style="border-radius: 24px; border-top: 6px solid var(--warning); padding: 0; overflow: hidden;">
                <div class="table-container" style="margin-top: 0; border: none; box-shadow: none;">
                    <table>
                        <thead>
                            <tr style="background-color: #f8fafc;">
                                <th style="padding: 1.5rem 2rem;">Order ID</th>
                                <th>Customer Account</th>
                                <th>Tracking ID</th>
                                <th>Amount Total</th>
                                <th>Fulfillment</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td style="padding: 1.25rem 2rem;">
                                        <span style="font-family: 'Courier New', Courier, monospace; font-weight: 800; color: var(--primary-blue); font-size: 14px;">#${fn:substring(order.id, 0, 8).toUpperCase()}</span>
                                    </td>
                                    <td>
                                        <div style="font-weight: 700; color: var(--text-dark);">${order.userId}</div>
                                        <div style="font-size: 11px; color: var(--text-muted);">${order.date}</div>
                                    </td>
                                    <td><strong style="color: var(--text-muted);">${order.trackingId}</strong></td>
                                    <td><span style="font-weight: 800; color: var(--text-dark); font-size: 16px;">Rs. ${order.totalAmount}</span></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${order.status == 'PENDING'}">
                                                <div style="display: inline-flex; align-items: center; gap: 8px; background: #fff7ed; color: #c2410c; padding: 6px 14px; border-radius: 10px; font-size: 11px; font-weight: 800; border: 1px solid #ffedd5;">
                                                    <span style="width: 8px; height: 8px; border-radius: 50%; background: #f97316;"></span> PENDING
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div style="display: inline-flex; align-items: center; gap: 8px; background: #f0fdf4; color: #15803d; padding: 6px 14px; border-radius: 10px; font-size: 11px; font-weight: 800; border: 1px solid #dcfce7;">
                                                    <span style="width: 8px; height: 8px; border-radius: 50%; background: #22c55e;"></span> APPROVED
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty orders}">
                                <tr>
                                    <td colspan="6" style="text-align: center; padding: 60px; color: var(--text-muted);">
                                        <i class="fas fa-folder-open" style="font-size: 48px; opacity: 0.2; display: block; margin-bottom: 15px;"></i>
                                        No customer orders have been logged yet.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
