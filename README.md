# Med Plus (Med+)

# Work Distribution - Med+ Project

This document outlines the division of tasks for a 6 person development team based on the 6 Core Components of the Med+ project requirements. Each component contains at least 3 UIs and minimum 3 CRUD operations with using propper OOP concepts.

---

## 👥 1. User Management Component (Imasha - IT25100043 - user-management branch)
*   **Focus**: User accounts, profiles, authentication, and user administration.
*   **OOP Concepts Applied**: **Encapsulation** (User data protection), **Interface Implementation** (`UserService`).
*   **UIs Assigned (3)**: 
    *   `auth.jsp` (Login/Register)
    *   `profile.jsp` (User Profile)
    *   `admin_users.jsp` (Admin User List)
*   **Java Files Assigned**:
    *   `User.java`, `Role.java`
    *   `UserRepository.java`
    *   `UserService.java`, `UserServiceImpl.java`
    *   `AuthController.java`, `ProfileController.java`
*   **CRUD Operations (3)**:
    1.  **Create**: Register new customer/staff accounts.
    2.  **Read**: View own profile data & read all users (Admin).
    3.  **Update/Delete**: Update personal profile / Delete users from the system.

---

## 💊 2. Medicine Management Component (Jalina - IT25102248 - medicine-management branch)
*   **Focus**: Medicine catalog, detailed views, and medicine administration.
*   **OOP Concepts Applied**: **Inheritance** (`BaseFileRepository`), **Encapsulation** (`Medicine`).
*   **UIs Assigned (3)**: 
    *   `index.jsp` (Home / Medicine List)
    *   `medicine_details.jsp` (Single Product View)
    *   `admin_medicines.jsp` (Add/Edit Medicine Forms)
*   **Java Files Assigned**:
    *   `Medicine.java`
    *   `MedicineRepository.java`
    *   `MedicineService.java`, `MedicineServiceImpl.java`
    *   `HomeController.java`, `MedicineController.java`
*   **CRUD Operations (3)**:
    1.  **Create**: Admin adds new medicine entries.
    2.  **Read**: Customer browses and searches the medicine catalog.
    3.  **Update/Delete**: Admin edits medicine details/pricing or deletes items.

---

## 🛒 3. Order Management Component (Naveen - IT25103630 - order-management branch)
*   **Focus**: All order-related logic, including shopping cart, checkout, and global order views across all roles.
*   **OOP Concepts Applied**: **Composition** (`Order` contains `OrderItem`s), **Polymorphism/Strategy** (`DeliveryMethod.getFee()`).
*   **UIs Assigned (5)**: 
    *   `cart.jsp` (Shopping Cart)
    *   `checkout.jsp` (Checkout Process)
    *   `order_success.jsp` (Order Confirmation)
    *   `admin_orders.jsp` (Global Admin Orders)
    *   `pharmacist_orders.jsp` (Pharmacist Pending Orders)
*   **Java Files Assigned**:
    *   `Order.java`, `OrderItem.java`, `DeliveryMethod.java`
    *   `OrderRepository.java`
    *   `OrderService.java`, `OrderServiceImpl.java`
    *   `CartController.java`, `CheckoutController.java` (And order-related methods in other controllers)
*   **CRUD Operations (3)**:
    1.  **Create**: Add items to cart & Place final order.
    2.  **Read**: View order history (Customer) and view all orders (Admin/Pharmacist).
    3.  **Update**: Pharmacist updates order status (Pending -> Approved/Completed).

---

## 📄 4. Prescription Management Component (Kaushani - IT25100983 - prescription-managament branch)
*   **Focus**: Secure prescription uploads, customer history, and pharmacist verification.
*   **OOP Concepts Applied**: **Interface Segregation** (`PrescriptionService` handles file I/O operations).
*   **UIs Assigned (3)**: 
    *   `prescription_upload.jsp` (Upload Form)
    *   `prescription_history.jsp` (Customer History)
    *   `prescription_review.jsp` (Pharmacist Verification Panel)
*   **Java Files Assigned**:
    *   `Prescription.java`, `PrescriptionStatus.java`
    *   `PrescriptionRepository.java`
    *   `PrescriptionService.java`, `PrescriptionServiceImpl.java`
    *   `PrescriptionController.java`
*   **CRUD Operations (3)**:
    1.  **Create**: Upload digital prescription files.
    2.  **Read**: View list of uploaded prescriptions.
    3.  **Update**: Pharmacist updates prescription status (Approved/Rejected).

---

## 📊 5. Admin Dashboard & Config Component (Sandeera - IT25102662 - admin-dashboard branch)
*   **Focus**: Main admin dashboard layout, system configurations, and categories.
*   **OOP Concepts Applied**: **Dependency Inversion** (Injecting services via Constructor).
*   **UIs Assigned (3)**: 
    *   `dashboard_admin.jsp` (Main Admin Stats Panel)
    *   `category_management.jsp` (Medicine Categories)
    *   `about.jsp` (System Information)
*   **Java Files Assigned**:
    *   `Category.java`
    *   `CategoryRepository.java`, `BaseFileRepository.java`
    *   `AdminController.java`, `CategoryController.java`, `AboutController.java`
*   **CRUD Operations (3)**:
    1.  **Create**: Add new medicine categories.
    2.  **Read**: View global dashboard statistics.
    3.  **Delete**: Remove categories.

---

## 👨‍⚕️ 6. Pharmacist Panel & Communications Component (Hasmi - IT25101570 - pharmacist-dashboard branch)
*   **Focus**: Pharmacist home layout, quick stock updates, and customer communications.
*   **OOP Concepts Applied**: **Abstraction** (Interacting with complex states through simplified methods).
*   **UIs Assigned (3)**: 
    *   `dashboard_pharmacist.jsp` (Pharmacist Home)
    *   `pharmacist_stock.jsp` (Quick Stock Update View)
    *   `contact.jsp` (Customer Messaging)
*   **Java Files Assigned**:
    *   `OrderStatus.java`, `ContactMessage.java`
    *   `ContactMessageRepository.java`
    *   `PharmacistController.java`, `ContactController.java`
*   **CRUD Operations (3)**:
    1.  **Create**: Customers submit contact messages (Support inquiries).
    2.  **Read**: Pharmacist reads low-stock alerts and messages.
    3.  **Update**: Pharmacist manually updates stock levels from the stock panel.

---

# Common part
*   `MedPlusApplication.java` >> Main class
*   `BaseModel.java` >> Common class for all some model classes (Abstract class)

---

# Med+ API Documentation

This document lists the primary URL mappings and endpoints for the Med+ Online Medical Store.
(Ease access to Med+)

## 🏠 Public Endpoints

| Endpoint | Method | Description |
| :--- | :--- | :--- |
| `/` | GET | Home page / Medicine catalog (supports `search` & `category` params) |
| `/about` | GET | About Us page |
| `/contact` | GET | Contact page & Doctor Channeling info |
| `/contact/send` | POST | Send a message (Saves to `messages.json`) |
| `/medicine/{id}`| GET | View detailed information for a specific medicine |

## 🔐 Authentication Endpoints

| Endpoint | Method | Description |
| :--- | :--- | :--- |
| `/auth` | GET | Login and Registration page |
| `/login` | POST | Process user login |
| `/register` | POST | Register a new customer |
| `/logout` | GET | End user session |
| `/profile` | GET | View and edit user profile |

## 🛒 Shopping & Orders

| Endpoint | Method | Description |
| :--- | :--- | :--- |
| `/cart` | GET | View current shopping cart |
| `/cart/add` | POST | Add medicine to cart (`medicineId`, `quantity`) |
| `/cart/remove` | POST | Remove item from cart |
| `/checkout` | GET | Proceed to checkout |
| `/checkout/place`| POST | Place order (Generates Tracking ID) |

## 📋 Prescription Management

| Endpoint | Method | Description |
| :--- | :--- | :--- |
| `/prescription/upload` | GET/POST | Upload a digital prescription |
| `/prescription/history`| GET | View own prescription history |

## ⚙️ Admin Endpoints (Admin Role Only)

| Endpoint | Method | Description |
| :--- | :--- | :--- |
| `/admin/dashboard` | GET | Admin overview and statistics |
| `/admin/medicines` | GET | Manage medicine inventory |
| `/admin/medicines/add`| POST | Add a new medicine |
| `/admin/users` | GET | Manage system users |
| `/admin/orders` | GET | View and manage all system orders |

## 👨‍⚕️ Pharmacist Endpoints (Pharmacist Role Only)

| Endpoint | Method | Description |
| :--- | :--- | :--- |
| `/pharmacist/dashboard` | GET | Pharmacist work queue (Orders/Prescriptions) |
| `/pharmacist/order/status`| POST | Update status of an order |
| `/pharmacist/prescription/review`| POST | Approve/Reject a prescription |

---
## 📄 Data Models (JSON)
*   `users.json`: Stores credentials and user profiles.
*   `medicines.json`: Stores the product catalog.
*   `orders.json`: Stores customer transactions.
*   `prescriptions.json`: Stores uploaded prescription metadata.
*   `messages.json`: Stores contact form submissions.
*   `categories.json`: Stores medicine categories.
