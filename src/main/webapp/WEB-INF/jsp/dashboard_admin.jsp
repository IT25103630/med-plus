<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Med+ | Admin Dashboard</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css?v=1.1' />">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body style="margin: 0; background-color: #f1f5f9;">
    <div class="admin-layout">
        <div class="sidebar">
            <div class="sidebar-brand"><i class="fas fa-capsules"></i> Med+ Admin</div>
            <a href="/admin/dashboard" class="sidebar-link active"><i class="fas fa-th-large"></i> Overview</a>
            <a href="/admin/medicines" class="sidebar-link"><i class="fas fa-pills"></i> Medicine</a>
            <a href="/admin/orders" class="sidebar-link"><i class="fas fa-receipt"></i> Orders</a>
            <a href="/admin/users" class="sidebar-link"><i class="fas fa-user-shield"></i> User Manage</a>
            <a href="/admin/categories" class="sidebar-link"><i class="fa fa-bars"></i> Categories</a>
            <div style="margin-top: 20px; border-top: 1px solid rgba(255,255,255,0.05); padding-top: 20px;">
                <a href="/" class="sidebar-link"><i class="fas fa-store"></i> Visit Store</a>
            </div>
            
            <div class="sidebar-footer">
                <div style="font-size: 13px; color: #94a3b8; margin-bottom: 10px;">Administrator</div>
                <div style="display: flex; align-items: center; gap: 10px;">
                    <div style="width: 36px; height: 36px; border-radius: 12px; background: var(--primary-gradient); display: flex; align-items: center; justify-content: center; font-weight: 700; color: white; font-size: 18px;">A</div>
                    <div style="overflow: hidden;">
                        <div style="font-weight: 600; white-space: nowrap; text-overflow: ellipsis;">${sessionScope.user.username}</div>
                        <div style="font-size: 11px; color: var(--success-green); font-weight: 700;">● ONLINE</div>
                    </div>
                </div>
                <a href="/logout" style="display: flex; align-items: center; gap: 10px; margin-top: 25px; color: #fca5a5; text-decoration: none; font-size: 14px; font-weight: 600; transition: color 0.3s;"><i class="fas fa-sign-out-alt"></i> Sign Out</a>
            </div>
        </div>

        <div class="main-content">
            <div style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 2.5rem;">
                <div>
                    <h1 style="margin: 0; font-size: 32px; font-weight: 800; letter-spacing: -0.5px;">Dashboard Overview</h1>
                    <p style="color: var(--text-muted); margin-top: 5px; font-size: 16px;">Everything you need to manage your medical store.</p>
                </div>
                <div style="display: flex; gap: 15px;">
                    <div class="card" style="padding: 10px 20px; border-radius: 12px; display: flex; align-items: center; gap: 10px; box-shadow: var(--shadow-sm);">
                        <i class="far fa-calendar-alt" style="color: var(--primary-blue);"></i>
                        <span style="font-weight: 600; font-size: 14px; color: var(--text-dark);">Admin Panel</span>
                    </div>
                </div>
            </div>
            
            <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 30px; margin-bottom: 40px;">
                <div class="card stat-card" style="border-top: 6px solid var(--primary-blue);">
                    <i class="fas fa-users"></i>
                    <div class="stat-label">System Users</div>
                    <div class="stat-value">${usersCount}</div>
                </div>
                <div class="card stat-card" style="border-top: 6px solid var(--success-green);">
                    <i class="fas fa-capsules"></i>
                    <div class="stat-label">Total Medicines</div>
                    <div class="stat-value">${medicinesCount}</div>
                </div>
                <div class="card stat-card" style="border-top: 6px solid var(--warning);">
                    <i class="fas fa-shopping-bag"></i>
                    <div class="stat-label">Total Orders</div>
                    <div class="stat-value">${ordersCount}</div>
                </div>
            </div>

            <div class="card" style="border-radius: 24px;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; border-bottom: 1px solid #f1f5f9; padding-bottom: 1.5rem;">
                    <div>
                        <h2 style="margin: 0; font-size: 20px;">Recent Transactions</h2>
                        <p style="margin: 5px 0 0 0; font-size: 13px; color: var(--text-muted);">Quick view of the latest customer activity.</p>
                    </div>
                    <a href="/admin/orders" class="btn btn-primary" style="padding: 8px 18px; font-size: 13px; border-radius: 10px;">View Full History</a>
                </div>
                <div class="table-container" style="border: none; box-shadow: none; margin-top: 0;">
                    <table>
                        <thead>
                            <tr style="border-bottom: 2px solid #f8fafc;">
                                <th>Transaction ID</th>
                                <th>Tracking Reference</th>
                                <th>Amount</th>
                                <th>Current Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${recentOrders}">
                                <tr style="transition: all 0.2s;">
                                    <td><span style="font-family: 'Courier New', Courier, monospace; font-weight: 700; color: var(--primary-blue);">#${fn:substring(order.id, 0, 8).toUpperCase()}</span></td>
                                    <td><strong style="color: var(--text-dark);">${order.trackingId}</strong></td>
                                    <td><span style="font-weight: 800; color: var(--text-dark); font-size: 15px;">Rs. ${order.totalAmount}</span></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${order.status == 'PENDING'}">
                                                <div style="display: inline-flex; align-items: center; gap: 8px; background: #fff7ed; color: #c2410c; padding: 6px 14px; border-radius: 10px; font-size: 12px; font-weight: 700; border: 1px solid #ffedd5;">
                                                    <span style="width: 8px; height: 8px; border-radius: 50%; background: #f97316; box-shadow: 0 0 8px #f97316;"></span> PENDING
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div style="display: inline-flex; align-items: center; gap: 8px; background: #f0fdf4; color: #15803d; padding: 6px 14px; border-radius: 10px; font-size: 12px; font-weight: 700; border: 1px solid #dcfce7;">
                                                    <span style="width: 8px; height: 8px; border-radius: 50%; background: #22c55e; box-shadow: 0 0 8px #22c55e;"></span> APPROVED
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
