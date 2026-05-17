<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Categories | Admin Panel</title>
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
            <a href="/admin/users" class="sidebar-link"><i class="fas fa-user-shield"></i> User Manage</a>
            <a href="/admin/categories" class="sidebar-link active"><i class="fa fa-bars"></i> Categories</a>
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
                    <h1 style="margin: 0; font-size: 32px; font-weight: 800; letter-spacing: -0.5px;">Manage Categories</h1>
                    <p style="color: var(--text-muted); margin-top: 5px; font-size: 16px;">Organize medicine categories in the store.</p>
                </div>
            </div>

            <div style="display: flex; gap: 30px; align-items: flex-start;">
                <!-- Category List -->
                <div style="flex: 2;">
                    <div class="card" style="border-radius: 24px; overflow: hidden; padding: 0; border-top: 6px solid var(--primary-blue);">
                        <div style="padding: 24px 30px; border-bottom: 1px solid #e2e8f0; background: #fff;">
                            <h2 style="margin: 0; font-size: 22px; display: flex; align-items: center; gap: 12px;">
                                <i class="fas fa-list" style="color: var(--primary-blue);"></i> Existing Categories
                            </h2>
                        </div>
                        <div class="table-container" style="margin-top: 0; border: none; box-shadow: none;">
                            <table>
                                <thead>
                                    <tr style="background-color: #f8fafc;">
                                        <th style="padding: 1.5rem 2rem;">Category Name</th>
                                        <th style="padding: 1.5rem 1rem;">Description</th>
                                        <th style="text-align: right; padding: 1.5rem 2rem;">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="cat" items="${categories}">
                                        <tr style="border-bottom: 1px solid #f1f5f9;">
                                            <td style="padding: 1.25rem 2rem; font-weight: 800; color: var(--text-dark); font-size: 16px;">
                                                <div style="display: flex; align-items: center; gap: 16px;">
                                                    <div style="width: 48px; height: 48px; border-radius: 14px; background: linear-gradient(135deg, #eff6ff, #dbeafe); display: flex; align-items: center; justify-content: center; color: var(--primary-blue); font-size: 20px;">
                                                        <i class="fas fa-tag"></i>
                                                    </div>
                                                    ${cat.name}
                                                </div>
                                            </td>
                                            <td style="padding: 1.5rem 1rem; color: #64748b; font-size: 14px;">${cat.description}</td>
                                            <td style="text-align: right; padding-right: 2rem; padding-top: 1.5rem; padding-bottom: 1.5rem;">
                                                <a href="/admin/categories/delete/${cat.id}" class="table-action-btn btn-danger" title="Delete" onclick="return confirm('Delete this category?')" style="display: inline-flex;"><i class="fas fa-trash"></i></a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty categories}">
                                        <tr>
                                            <td colspan="3" style="padding: 40px; text-align: center; color: #94a3b8; font-weight: 600;">No categories added yet.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Add Category Form -->
                <div style="flex: 1;">
                    <div class="card" style="border-radius: 24px; position: sticky; top: 100px; border-top: 6px solid var(--success-green);">
                        <h2 style="margin-bottom: 2rem; font-size: 22px; display: flex; align-items: center; gap: 12px;">
                            <i class="fas fa-folder-plus" style="color: var(--success-green);"></i> 
                            Add New Category
                        </h2>
                        <form action="/admin/categories/add" method="post">
                            <div class="form-group">
                                <label><i class="fas fa-tag"></i> Category Name</label>
                                <input type="text" name="name" required placeholder="e.g., Painkillers" style="background: #f8fafc; border: 2px solid #e2e8f0; padding: 12px; border-radius: 12px; width: 100%; box-sizing: border-box;">
                            </div>
                            <div class="form-group" style="margin-top: 20px;">
                                <label><i class="fas fa-info-circle"></i> Description</label>
                                <textarea name="description" style="width: 100%; padding: 15px; border: 2px solid #e2e8f0; border-radius: 15px; background: #f8fafc; font-family: inherit; min-height: 120px; box-sizing: border-box;" placeholder="Brief description of this category..."></textarea>
                            </div>
                            <button type="submit" class="btn btn-success" style="width: 100%; padding: 15px; font-size: 16px; border-radius: 14px; margin-top: 10px;"><i class="fas fa-plus-circle"></i> Create Category</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>