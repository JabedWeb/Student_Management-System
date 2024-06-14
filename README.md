# Student Management System

The Student Management System (SMS) is a Bash script-based application designed to streamline and simplify the management of student-related data within educational institutions. This system automates various administrative tasks such as user management, course registration, grading, and attendance tracking. It enhances the efficiency of managing student information and improves the overall workflow for administrators, teachers, and students alike.


## Features

- User management (Add, Delete, Modify Users)
- Course management (Add, Delete Courses)
- Enrollment management (Enroll, Drop Courses)
- Grade management (Record, Update Grades)
- Attendance tracking (View and Manage Attendance)
- Reporting (Generate various reports)
- User roles (Admin, Teacher, Student)

## Installation

To install and run the Student Management System, follow these steps:

1. Clone the repository:
```sh
git clone https://github.com/JabedWeb/Student_Management-System
```

2. Navigate to the project directory:
```sh
cd student-management-system
```

3. Make the script executable:
        ```sh
        chmod +x student_project.sh
        ```

4. Run the script:
        ```sh
        ./student_project.sh
        ```

## Usage

### Main Menu

When you run the script, you will be presented with the main menu. Select an option to proceed.

```
########################################
#                                      #
#        Welcome to the System!        #
#                                      #
########################################

########################################
#            Main Menu                 #
########################################
1. Student login
2. Teacher login
3. Admin login
4. Exit
########################################
Select an option:
```

### Admin Menu

Admins have access to comprehensive management options.

```
----------------------------------------
|             Admin Menu               |
----------------------------------------
1. Add User
2. Delete User
3. View All Users
4. Modify User Details
5. View All Courses
6. Add Course
7. Delete Course
8. Assign Teacher to Course
9. Generate Reports
10. Back to Main Menu
Select an option:
```

### Teacher Menu

Teachers can manage their assigned courses, enrollments, grades, and attendance records.

```
----------------------------------------
|           Teacher Menu               |
|         Welcome, [username]          |
----------------------------------------
1. View Assigned Courses
2. Add Student to Course
3. Remove Student from Course
4. View Students in Course
5. Record Grades
6. Update Grades
7. View Course Attendance
8. Back to Main Menu
Select an option:
```

### Student Menu

Students can manage their course enrollments, view grades, check attendance, and update personal information.

```
----------------------------------------
|            Student Menu              |
|         Welcome, [username]          |
----------------------------------------
1. View Enrolled Courses
2. Enroll in Course
3. Drop Course
4. View Grades
5. View Attendance
6. Update Personal Information
7. Back to Main Menu
Select an option:
```

## Files

The system utilizes the following text files to store data:

- `users.txt`: Stores user information (user ID, username, password, role).
- `courses.txt`: Contains details of the courses offered.
- `enrollments.txt`: Tracks student enrollments in various courses.
- `grades.txt`: Records the grades of students.
- `attendance.txt`: Keeps attendance records.




