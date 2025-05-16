# 📱 CareConnect NDIS – SwiftUI Firebase iOS App

CareConnect NDIS is a comprehensive iOS application designed to streamline support coordination for the NDIS (National Disability Insurance Scheme) sector. It features a modular approach for shift management, task tracking, client management, incident reporting, and secure document sharing between support workers and administrators.

---
Github Link: https://github.com/romanislam2000/CareConnect-NDIS-App.git

## 👥 User Roles & Access Control

The application supports two user roles with different permissions:

### 🔐 Admin Users:
- `admin@careconnect.com` — Password: `123456`
- `admin1@careconnect.com` — Password: `@Honesty1000`
- "md.roman.islam@gmail.com - Password: @Honesty1000"

### ✅ Admin Features:
- Full access to **all modules**: Clients, Shifts, Tasks, Incident Reports, and Documents.
- Can **add/edit/delete** shifts, tasks, incidents, and clients.
- View task completion and attendance status in real-time.
- Access **admin dashboard** with shared document uploads.
- View/edit all user-added records.

### 👤 Standard Users:
- Can **view and mark attendance** for shifts.
- Can **toggle task status** between “Pending” and “Completed”.
- Can **submit incident reports** but cannot edit others' entries.
- Cannot access the client list or admin dashboard.
- Cannot edit shift/task entries — view-only.

---

## ⚙️ Firebase Integration
- **Authentication** with email/password.
- **Realtime Firestore** integration for:
  - Shifts (live attendance toggle)
  - Tasks (live completion toggle)
  - Documents (shared upload by admin)
  - Incident Reports (user-submitted & admin-managed)
  - Client Profiles (admin only)

---

## ✨ Core Functionalities

### 🔁 Shared (Users & Admins)
- Firebase-authenticated login/signup  
- Role-based UI rendering  
- Shift and Task search functionality  

### 🛠 Admin Module
- Upload, list & share documents in **Admin Dashboard**  
- Add/edit clients  
- Add/edit task logs and shifts  
- Manage incident reports submitted by users  

### 👥 User Module
- Mark tasks as ✅ Completed / 🟩 Pending  
- Mark shifts as ✅ Attended / 🟧 Pending  
- Submit incident reports  
- View assigned shifts and task logs  

---

## 📦 Group Task Allocations

| Name               | Responsibilities                                                                                                                                      |
|--------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Md Roman Islam** | - **Document View Card (Admin)**<br>- **Incident Report module** (add/view/edit)<br>- **Realtime task/shift toggle** buttons for users/admin<br>- **Firebase access logic** for modules<br>- **Admin-only visibility control**<br>- **Forgot Password**|
| **Farhan**         | - **UI/UX Design** (entire app)<br>- **Login & Signup pages**<br>- **Client Module** (admin CRUD)**Firebase connectivity logic** "**<br>- **Sign up**             |
| **Ibrahim**        | - **Task Log Add/Edit Pages**<br>- **Shift Add/Edit Pages**<br>- **View structure for Task and Shift forms**<br>- **Firebase connectivity logic**     |

---

## 📂 Project Modules Overview

| Module               | Admin Access         | User Access                   | Realtime? |
|---------------------|----------------------|-------------------------------|-----------|
| Task Logs           | ✅ Add/Edit/View     | ✅ View + Toggle Status       | ✅ Yes    |
| Shifts              | ✅ Add/Edit/View     | ✅ View + Mark Attended       | ✅ Yes    |
| Clients             | ✅ Full CRUD         | 🚫 No Access                  | ❌        |
| Incident Reports    | ✅ View/Edit         | ✅ Submit                     | ✅ Yes    |
| Shared Documents    | ✅ Upload/View       | ✅ View                       | ✅ Yes    |
| Authentication      | ✅ Yes               | ✅ Yes                        | ✅ Yes    |

---

## 📅 Last Updated: May 16, 2025

---

Made with ❤️ by **Team Power Rangers** for SwiftUI iOS Capstone Project.
