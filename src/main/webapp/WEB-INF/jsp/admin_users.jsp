<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Med+ | User Manage</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css?v=1.1' />">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body style="margin: 0; background-color: #f1f5f9;">
    <div class="admin-layout">
        <div class="sidebar">
            <div class="sidebar-brand"><i class="fas fa-capsules"></i> Med+ Admin</div>
            <a href="/admin/dashboard" class="sidebar-link"><i class="fas fa-th-large"></i> Overview</a>
            <a href="/admin/medicines" class="sidebar-link"><i class="fas fa-pills"></i> Medicine</a>
            <a href="/admin/orders" class="sidebar-link"><i class="fas fa-receipt"></i> Orders</a>
            <a href="/admin/users" class="sidebar-link active"><i class="fas fa-user-shield"></i> User Manage</a>
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
                    <h1 style="margin: 0; font-size: 32px; font-weight: 800; letter-spacing: -0.5px;">User Management</h1>
                    <p style="color: var(--text-muted); margin-top: 5px; font-size: 16px;">Monitor active accounts and manage staff permissions.</p>
                </div>
                <a href="#pharmacistFormCard" class="btn btn-primary" style="padding: 12px 24px; border-radius: 12px; font-weight: 700; text-decoration: none;"><i class="fas fa-user-plus"></i> New Pharmacist</a>
            </div>
            
            <div class="card" style="margin-bottom: 40px; border-radius: 24px; border-left: 6px solid var(--primary-blue); padding: 0; overflow: hidden;">
                <div class="table-container" style="margin-top: 0; border: none; box-shadow: none;">
                    <table>
                        <thead>
                            <tr style="background-color: #f8fafc;">
                                <th style="padding: 1.5rem 2rem;">User Profile</th>
                                <th>Contact Information</th>
                                <th>Account Role</th>
                                <th>System Status</th>
                                <th style="text-align: right; padding-right: 2rem;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="u" items="${users}">
                                <tr>
                                    <td style="padding: 1.25rem 2rem;">
                                        <div style="display: flex; align-items: center; gap: 16px;">
                                            <div style="width: 44px; height: 44px; border-radius: 14px; background: #eff6ff; display: flex; align-items: center; justify-content: center; font-weight: 800; color: var(--primary-blue); font-size: 18px;">
                                                ${fn:substring(u.username, 0, 1).toUpperCase()}
                                            </div>
                                            <div style="font-weight: 800; color: var(--text-dark); font-size: 16px;">${u.username}</div>
                                        </div>
                                    </td>
                                    <td>
                                        <div style="font-size: 13px; color: var(--text-dark); font-weight: 500;"><i class="fas fa-envelope" style="width: 20px; color: var(--text-muted);"></i> ${u.email}</div>
                                        <div style="font-size: 13px; color: var(--text-dark); font-weight: 500; margin-top: 6px;"><i class="fas fa-phone" style="width: 20px; color: var(--text-muted);"></i> ${u.phone}</div>
                                    </td>
                                    <td>
                                        <span class="badge" style="
                                            background: ${u.role == 'ADMIN' ? '#fff7ed' : (u.role == 'PHARMACIST' ? '#f0fdf4' : '#f0f9ff')}; 
                                            color: ${u.role == 'ADMIN' ? '#c2410c' : (u.role == 'PHARMACIST' ? '#15803d' : '#0369a1')};
                                            border: 1px solid ${u.role == 'ADMIN' ? '#ffedd5' : (u.role == 'PHARMACIST' ? '#dcfce7' : '#bae6fd')};
                                            padding: 6px 14px; border-radius: 10px; font-weight: 700;
                                        ">
                                            ${u.role}
                                        </span>
                                    </td>
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 8px;">
                                            <span style="width: 8px; height: 8px; border-radius: 50%; background: #22c55e; box-shadow: 0 0 8px #22c55e;"></span>
                                            <span style="font-size: 13px; font-weight: 700; color: #15803d;">ACTIVE</span>
                                        </div>
                                    </td>
                                    <td style="text-align: right; padding-right: 2rem;">
                                        <c:if test="${sessionScope.user.id != u.id}">
                                            <a href="/admin/user/delete/${u.id}" class="table-action-btn btn-danger" title="Delete User" onclick="return confirm('Are you sure you want to delete this user? This action cannot be undone.')">
                                                <i class="fas fa-user-times"></i>
                                            </a>
                                        </c:if>
                                        <c:if test="${sessionScope.user.id == u.id}">
                                            <span style="font-size: 11px; color: var(--text-muted); font-weight: 600;">(You)</span>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="card" id="pharmacistFormCard" style="max-width: 700px; border-radius: 24px; border-top: 6px solid var(--primary-blue);">
                <h2 style="margin-bottom: 2rem; font-size: 22px; display: flex; align-items: center; gap: 12px;">
                    <i class="fas fa-id-card-alt" style="color: var(--primary-blue);"></i> Register Pharmacist Account
                </h2>
                <form action="/admin/pharmacist/add" method="post">
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 25px;">
                        <div class="form-group">
                            <label><i class="fas fa-user-circle"></i> Username</label>
                            <input type="text" name="username" required placeholder="e.g. staff_member" style="background: #f8fafc; border: 2px solid #e2e8f0; padding: 12px; border-radius: 12px;">
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-envelope-open-text"></i> Email Address</label>
                            <input type="email" name="email" required placeholder="name@medplus.lk" style="background: #f8fafc; border: 2px solid #e2e8f0; padding: 12px; border-radius: 12px;">
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-mobile-alt"></i> Mobile Number</label>
                            <input type="text" name="phone" required placeholder="07XXXXXXXX" style="background: #f8fafc; border: 2px solid #e2e8f0; padding: 12px; border-radius: 12px;">
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-key"></i> Initial Password</label>
                            <input type="password" name="password" required placeholder="••••••••" style="background: #f8fafc; border: 2px solid #e2e8f0; padding: 12px; border-radius: 12px;">
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 30px; padding: 15px; font-size: 16px; border-radius: 14px; font-weight: 700;"><i class="fas fa-user-shield"></i> Activate Staff Account</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
