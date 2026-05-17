<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Med+ | Inventory Mgmt</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css?v=1.1' />">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body style="margin: 0; background-color: #f1f5f9;">
    <div class="admin-layout">
        <div class="sidebar">
            <div class="sidebar-brand"><i class="fas fa-capsules"></i> Med+ Admin</div>
            <a href="/admin/dashboard" class="sidebar-link"><i class="fas fa-th-large"></i> Overview</a>
            <a href="/admin/medicines" class="sidebar-link active"><i class="fas fa-pills"></i> Medicine</a>
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
                    <h1 style="margin: 0; font-size: 32px; font-weight: 800; letter-spacing: -0.5px;">Medicine Inventory</h1>
                    <p style="color: var(--text-muted); margin-top: 5px; font-size: 16px;">Track stock levels, prices, and medicine categories.</p>
                </div>
                <a href="#medicineFormCard" class="btn btn-success" style="padding: 12px 24px; border-radius: 12px; font-weight: 700; text-decoration: none;"><i class="fas fa-plus-circle"></i> Add New Stock</a>
            </div>
            
            <div class="card" style="margin-bottom: 30px; border-radius: 24px; overflow: hidden; padding: 0;">
                <div class="table-container" style="margin-top: 0; border: none; box-shadow: none;">
                    <table>
                        <thead>
                            <tr style="background-color: #f8fafc;">
                                <th style="padding: 1.5rem 2rem;">Product Details</th>
                                <th style="padding: 1.5rem 1rem;">Category</th>
                                <th style="padding: 1.5rem 1rem;">Unit Price</th>
                                <th style="padding: 1.5rem 1rem;">Inventory Status</th>
                                <th style="text-align: right; padding: 1.5rem 2rem;">Quick Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="med" items="${medicines}">
                                <tr>
                                    <td style="padding: 1.25rem 2rem;">
                                        <div style="display: flex; align-items: center; gap: 16px;">
                                            <div style="width: 48px; height: 48px; border-radius: 14px; background: linear-gradient(135deg, #f1f5f9, #e2e8f0); display: flex; align-items: center; justify-content: center; color: var(--primary-blue); font-size: 20px;">
                                                <i class="fas fa-capsules"></i>
                                            </div>
                                            <div>
                                                <div style="font-weight: 800; color: var(--text-dark); font-size: 16px;">${med.name}</div>
                                                <div style="font-size: 12px; color: var(--text-muted); margin-top: 2px;">Exp: ${med.expiryDate}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td><span class="badge" style="background: #eff6ff; color: #1e40af; border: 1px solid #dbeafe; padding: 6px 12px; border-radius: 8px;">${med.category}</span></td>
                                    <td><span style="font-weight: 800; color: var(--text-dark); font-size: 15px;">Rs. ${med.price}</span></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${med.stock > 20}">
                                                <div style="display: flex; align-items: center; gap: 8px;">
                                                    <span style="width: 10px; height: 10px; border-radius: 50%; background: #22c55e;"></span>
                                                    <span style="font-weight: 700; color: #15803d; font-size: 14px;">${med.stock} Units</span>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div style="display: flex; align-items: center; gap: 8px;">
                                                    <span style="width: 10px; height: 10px; border-radius: 50%; background: #ef4444;"></span>
                                                    <span style="font-weight: 700; color: #b91c1c; font-size: 14px;">Low: ${med.stock}</span>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="text-align: right; padding-right: 2rem;">
                                        <div style="display: inline-flex; gap: 8px;">
                                            <a href="/admin/medicines?editId=${med.id}#medicineFormCard" class="table-action-btn btn-primary" title="Edit"><i class="fas fa-edit"></i></a>
                                            <a href="/admin/medicine/delete/${med.id}" class="table-action-btn btn-danger" title="Delete" onclick="return confirm('Delete this product?')"><i class="fas fa-trash"></i></a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="card" id="medicineFormCard" style="border-radius: 24px; border-top: 6px solid ${not empty editMedicine ? 'var(--primary-blue)' : 'var(--success-green)'};">
                <h2 style="margin-bottom: 2rem; font-size: 22px; display: flex; align-items: center; gap: 12px;">
                    <i class="fas ${not empty editMedicine ? 'fa-pen-fancy' : 'fa-folder-plus'}" style="color: ${not empty editMedicine ? 'var(--primary-blue)' : 'var(--success-green)'};"></i> 
                    ${not empty editMedicine ? 'Modify Product: ' : 'Update Product Catalog'} ${editMedicine.name}
                </h2>
                <form action="/admin/medicine/save" method="post">
                    <input type="hidden" name="id" value="${editMedicine.id}">
                    <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px;">
                        <div class="form-group">
                            <label><i class="fas fa-tag"></i> Medicine Name</label>
                            <input type="text" name="name" value="${editMedicine.name}" required placeholder="e.g. Paracetamol" style="background: #f8fafc; border: 2px solid #e2e8f0; padding: 12px; border-radius: 12px;">
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-th-list"></i> Category</label>
                            <select name="category" required style="background: #f8fafc; border: 2px solid #e2e8f0; padding: 12px; border-radius: 12px;">
                                <option value="">Select a category</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.name}" ${editMedicine.category == cat.name ? 'selected' : ''}>${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-wallet"></i> Unit Price (Rs.)</label>
                            <input type="number" step="0.01" name="price" value="${editMedicine.price}" required placeholder="0.00" style="background: #f8fafc; border: 2px solid #e2e8f0; padding: 12px; border-radius: 12px;">
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-layer-group"></i> Quantity in Stock</label>
                            <input type="number" name="stock" value="${editMedicine.stock}" required placeholder="0" style="background: #f8fafc; border: 2px solid #e2e8f0; padding: 12px; border-radius: 12px;">
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-calendar-check"></i> Expiration Date</label>
                            <input type="date" name="expiryDate" value="${editMedicine.expiryDate}" required style="background: #f8fafc; border: 2px solid #e2e8f0; padding: 12px; border-radius: 12px;">
                        </div>
                        <div class="form-group" style="display: flex; align-items: center; gap: 15px; margin-top: 30px;">
                            <input type="checkbox" name="requiresPrescription" value="true" ${editMedicine.requiresPrescription ? 'checked' : ''} style="width: 20px; height: 20px; cursor: pointer;">
                            <label style="margin: 0; font-weight: 700; cursor: pointer;">Requires Prescription?</label>
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 10px;">
                        <label><i class="fas fa-info-circle"></i> Clinical Description</label>
                        <textarea name="description" rows="3" style="width: 100%; padding: 15px; border: 2px solid #e2e8f0; border-radius: 15px; background: #f8fafc; font-family: inherit;" placeholder="Describe usage, dosage, and side effects...">${editMedicine.description}</textarea>
                    </div>
                    <div style="display: flex; gap: 20px; margin-top: 30px;">
                        <button type="submit" class="btn btn-success" style="flex: 2; padding: 15px; font-size: 16px; border-radius: 14px;"><i class="fas fa-save"></i> ${not empty editMedicine ? 'Update Product Details' : 'Save Product Details'}</button>
                        <c:if test="${not empty editMedicine}">
                            <a href="/admin/medicines" class="btn btn-danger" style="flex: 1; padding: 15px; font-size: 16px; border-radius: 14px; text-align: center; text-decoration: none;">Discard Changes</a>
                        </c:if>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
