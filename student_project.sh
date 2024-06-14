#!/bin/bash

# Define files for storing data
USER_FILE="users.txt"
COURSE_FILE="courses.txt"
ENROLLMENT_FILE="enrollments.txt"
GRADE_FILE="grades.txt"
ATTENDANCE_FILE="attendance.txt"
PAYMENT_FILE="payments.txt"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to check and create files if they do not exist
check_and_create_files() {
    touch $USER_FILE $COURSE_FILE $ENROLLMENT_FILE $GRADE_FILE $ATTENDANCE_FILE $PAYMENT_FILE
}

# Function to create demo data
create_demo_data() {
    echo "Creating demo data..."
    echo "213000000,admin,admin,admin" > $USER_FILE
    echo "213902046,Jabed,Jabed,student" >> $USER_FILE
    echo "213902047,Nazmul,Nazmul,student" >> $USER_FILE
    echo "213902048,Farhana,Farhana,student" >> $USER_FILE
    echo "213902049,Hasan,Hasan,student" >> $USER_FILE
    echo "213902050,Salma,Salma,student" >> $USER_FILE
    echo "213902051,Reza,Reza,student" >> $USER_FILE
    echo "213902052,Sumaiya,Sumaiya,student" >> $USER_FILE
    echo "213902053,Kamal,Kamal,student" >> $USER_FILE
    echo "213902054,Sadia,Sadia,student" >> $USER_FILE
    echo "213902055,Arif,Arif,student" >> $USER_FILE
    echo "2024,Akram,Akram,teacher" >> $USER_FILE
    echo "2025,Monira,Monira,teacher" >> $USER_FILE
    echo "2026,Rafiq,Rafiq,teacher" >> $USER_FILE

    echo "CSE101,Introduction to Computer Science,Spring 2024" > $COURSE_FILE
    echo "CSE102,Operating Systems,Fall 2024" >> $COURSE_FILE
    echo "CSE103,Networking,Fall 2024" >> $COURSE_FILE

    echo "CSE101,213902046" > $ENROLLMENT_FILE
    echo "CSE101,213902047" >> $ENROLLMENT_FILE
    echo "CSE102,213902048" >> $ENROLLMENT_FILE
    echo "CSE102,213902049" >> $ENROLLMENT_FILE
    echo "CSE103,213902050" >> $ENROLLMENT_FILE
    echo "CSE103,213902051" >> $ENROLLMENT_FILE
    echo "CSE101,Akram" >> $ENROLLMENT_FILE
    echo "CSE102,Monira" >> $ENROLLMENT_FILE
    echo "CSE103,Rafiq" >> $ENROLLMENT_FILE

    echo "CSE101,213902046,A" > $GRADE_FILE
    echo "CSE101,213902047,B" >> $GRADE_FILE
    echo "CSE102,213902048,A+" >> $GRADE_FILE
    echo "CSE102,213902049,B-" >> $GRADE_FILE
    echo "CSE103,213902050,A" >> $GRADE_FILE
    echo "CSE103,213902051,B+" >> $GRADE_FILE

    echo "CSE101,213902046,Present" > $ATTENDANCE_FILE
    echo "CSE101,213902047,Absent" >> $ATTENDANCE_FILE
    echo "CSE102,213902048,Present" >> $ATTENDANCE_FILE
    echo "CSE102,213902049,Present" >> $ATTENDANCE_FILE
    echo "CSE103,213902050,Absent" >> $ATTENDANCE_FILE
    echo "CSE103,213902051,Present" >> $ATTENDANCE_FILE

    echo "213902046,15000.00,2024-05-01,Tuition Fee,Online,Completed" > $PAYMENT_FILE
    echo "213902047,12000.00,2024-05-02,Tuition Fee,Bank Transfer,Completed" >> $PAYMENT_FILE
    echo "213902048,13000.00,2024-05-03,Tuition Fee,Cash,Completed" >> $PAYMENT_FILE
    echo "213902049,11000.00,2024-05-04,Tuition Fee,Online,Completed" >> $PAYMENT_FILE
    echo "213902050,14000.00,2024-05-05,Tuition Fee,Bank Transfer,Completed" >> $PAYMENT_FILE

    echo -e "${GREEN}Demo data created!${NC}"
}

# Function to display a welcoming message
welcome_message() {
    echo -e "${BLUE}########################################${NC}"
    echo -e "${BLUE}#                                      #${NC}"
    echo -e "${BLUE}#        Welcome to the System!        #${NC}"
    echo -e "${BLUE}#                                      #${NC}"
    echo -e "${BLUE}########################################${NC}"
    echo
}

# Function to authenticate user
authenticate_user() {
    read -p "Enter username: " username
    read -sp "Enter password: " password
    echo

    # Check if the user exists
    user_role=$(grep "^.*,${username},${password},.*$" $USER_FILE | cut -d, -f4)
    
    if [ -z "$user_role" ]; then
        echo -e "${RED}Invalid username or password!${NC}"
        read -p "Press [Enter] to return to the main menu..."
        main_menu
    else
        case $user_role in
            admin) admin_menu ;;
            teacher) teacher_menu "$username" ;;
            student) student_menu "$username" ;;
            *) echo -e "${RED}Invalid role!${NC}"; read -p "Press [Enter] to return to the main menu..."; main_menu ;;
        esac
    fi
}

# Function to display the main menu
main_menu() {
    clear
    welcome_message
    echo -e "${CYAN}########################################${NC}"
    echo -e "${CYAN}#            Main Menu                 #${NC}"
    echo -e "${CYAN}########################################${NC}"
    echo "1. Student login"
    echo "2. Teacher login"
    echo "3. Admin login"
    echo "4. Exit"
    echo -e "${CYAN}########################################${NC}"
    read -p "Select an option: " option

    case $option in
        1 | 2 | 3)
            read -p "Enter username: " username
            read -sp "Enter password: " password
            echo

            # Check if the user exists and authenticate
            user_role=$(grep "^.*,${username},${password},.*$" $USER_FILE | cut -d, -f4)

            if [ -z "$user_role" ]; then
                echo -e "${RED}Invalid username or password!${NC}"
                read -p "Press [Enter] to return to the main menu..."
                main_menu
            else
                case $user_role in
                    admin) admin_menu ;;
                    teacher) teacher_menu "$username" ;;
                    student) student_menu "$username" ;;
                    *) echo -e "${RED}Invalid role!${NC}"; read -p "Press [Enter] to return to the main menu..."; main_menu ;;
                esac
            fi
            ;;
        4)
            echo -e "${BLUE}Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option! Please try again.${NC}"
            read -p "Press [Enter] to return to the main menu..."
            main_menu
            ;;
    esac
}

# Function to display admin menu
admin_menu() {
    clear
    echo -e "${GREEN}----------------------------------------${NC}"
    echo -e "${GREEN}|             Admin Menu               |${NC}"
    echo -e "${GREEN}----------------------------------------${NC}"
    echo "1. Add User"
    echo "2. Delete User"
    echo "3. View All Users"
    echo "4. Modify User Details"
    echo "5. View All Courses"
    echo "6. Add Course"
    echo "7. Delete Course"
    echo "8. Assign Teacher to Course"
    echo "9. Generate Reports"
    echo "10. Back to Main Menu"
    echo -e "${GREEN}----------------------------------------${NC}"
    read -p "Select an option: " option

    case $option in
        1) add_user ;;
        2) delete_user ;;
        3) view_all_users ;;
        4) modify_user_details ;;
        5) view_all_courses ;;
        6) add_course ;;
        7) delete_course ;;
        8) assign_teacher_to_course ;;
        9) generate_reports ;;
        10) main_menu ;;
        *) echo -e "${RED}Invalid option! Please try again.${NC}"; admin_menu ;;
    esac
}

# Function to add a user
add_user() {
    read -p "Enter user ID: " user_id
    read -p "Enter username: " username
    read -sp "Enter password: " password
    echo
    read -p "Enter role (admin/teacher/student): " role
    if grep -q "^$user_id," $USER_FILE; then
        echo -e "${RED}User already exists!${NC}"
    else
        echo "$user_id,$username,$password,$role" >> $USER_FILE
        echo -e "${GREEN}User added successfully!${NC}"
    fi
    read -p "Press [Enter] to return to the admin menu..."
    admin_menu
}

# Function to delete a user
delete_user() {
    read -p "Enter user ID to delete: " user_id
    if [ "$user_id" == "213000000" ]; then
        echo -e "${RED}Admin cannot be deleted!${NC}"
    elif grep -q "^$user_id," $USER_FILE; then
        sed -i "/^$user_id,/d" $USER_FILE
        echo -e "${GREEN}User deleted successfully!${NC}"
    else
        echo -e "${RED}User not found!${NC}"
    fi
    read -p "Press [Enter] to return to the admin menu..."
    admin_menu
}

# Function to view all users
view_all_users() {
    clear
    echo -e "${CYAN}All Users:${NC}"
    awk -F, '{print NR ". " $1 " - " $2 " - " $4}' $USER_FILE
    read -p "Press [Enter] to return to the admin menu..."
    admin_menu
}

# Function to modify user details
modify_user_details() {
    read -p "Enter user ID to modify: " user_id
    if grep -q "^$user_id," $USER_FILE; then
        read -p "Enter new username: " new_username
        read -sp "Enter new password: " new_password
        echo
        read -p "Enter new role: " new_role
        sed -i "/^$user_id,/c\\$user_id,$new_username,$new_password,$new_role" $USER_FILE
        echo -e "${GREEN}User details updated successfully!${NC}"
    else
        echo -e "${RED}User not found!${NC}"
    fi
    read -p "Press [Enter] to return to the admin menu..."
    admin_menu
}

# Function to view all courses
view_all_courses() {
    clear
    echo -e "${CYAN}All Courses:${NC}"
    awk -F, '{print NR ". " $1 " - " $2 " - " $3}' $COURSE_FILE
    read -p "Press [Enter] to return to the admin menu..."
    admin_menu
}

# Function to add a course
add_course() {
    read -p "Enter course code: " course_code
    read -p "Enter course name: " course_name
    read -p "Enter course term: " course_term
    if grep -q "^$course_code," $COURSE_FILE; then
        echo -e "${RED}Course already exists!${NC}"
    else
        echo "$course_code,$course_name,$course_term" >> $COURSE_FILE
        echo -e "${GREEN}Course added successfully!${NC}"
    fi
    read -p "Press [Enter] to return to the admin menu..."
    admin_menu
}

# Function to delete a course
delete_course() {
    read -p "Enter course code to delete: " course_code
    if grep -q "^$course_code," $COURSE_FILE; then
        sed -i "/^$course_code,/d" $COURSE_FILE
        echo -e "${GREEN}Course deleted successfully!${NC}"
    else
        echo -e "${RED}Course not found!${NC}"
    fi
    read -p "Press [Enter] to return to the admin menu..."
    admin_menu
}

# Function to assign a teacher to a course
assign_teacher_to_course() {
    read -p "Enter course code: " course_code
    read -p "Enter teacher username: " teacher_username
    if grep -q "^$course_code," $COURSE_FILE && grep -q ",$teacher_username,teacher$" $USER_FILE; then
        echo "$course_code,$teacher_username" >> $ENROLLMENT_FILE
        echo -e "${GREEN}Teacher assigned to course successfully!${NC}"
    else
        echo -e "${RED}Course or teacher not found!${NC}"
    fi
    read -p "Press [Enter] to return to the admin menu..."
    admin_menu
}

# Function to generate reports
generate_reports() {
    clear
    echo -e "${CYAN}Generating reports...${NC}"
    echo -e "${CYAN}Users Report:${NC}"
    awk -F, '{print NR ". " $1 " - " $2 " - " $4}' $USER_FILE
    echo "----------------------------------------"
    echo -e "${CYAN}Courses Report:${NC}"
    awk -F, '{print NR ". " $1 " - " $2 " - " $3}' $COURSE_FILE
    echo "----------------------------------------"
    echo -e "${CYAN}Enrollments Report:${NC}"
    awk -F, '{print NR ". " $1 " - " $2}' $ENROLLMENT_FILE
    echo "----------------------------------------"
    echo -e "${CYAN}Grades Report:${NC}"
    awk -F, '{print NR ". " $1 " - " $2 " - " $3}' $GRADE_FILE
    echo "----------------------------------------"
    echo -e "${CYAN}Attendance Report:${NC}"
    awk -F, '{print NR ". " $1 " - " $2 " - " $3}' $ATTENDANCE_FILE
    read -p "Press [Enter] to return to the admin menu..."
    admin_menu
}

# Function to display teacher menu
teacher_menu() {
    local username="$1"
    clear
    echo -e "${GREEN}----------------------------------------${NC}"
    echo -e "${GREEN}|           Teacher Menu               |${NC}"
    echo -e "${GREEN}|         Welcome, $username           |${NC}"
    echo -e "${GREEN}----------------------------------------${NC}"
    echo "1. View Assigned Courses"
    echo "2. Add Student to Course"
    echo "3. Remove Student from Course"
    echo "4. View Students in Course"
    echo "5. Record Grades"
    echo "6. Update Grades"
    echo "7. View Course Attendance"
    echo "8. Back to Main Menu"
    echo -e "${GREEN}----------------------------------------${NC}"
    read -p "Select an option: " option

    case $option in
        1) view_assigned_courses "$username" ;;
        2) add_student_to_course ;;
        3) remove_student_from_course ;;
        4) view_students_in_course ;;
        5) record_grades ;;
        6) update_grades ;;
        7) view_course_attendance ;;
        8) main_menu ;;
        *) echo -e "${RED}Invalid option! Please try again.${NC}"; teacher_menu "$username" ;;
    esac
}

# Function to view assigned courses for a teacher
view_assigned_courses() {
    local username="$1"
    clear
    echo -e "${CYAN}Assigned Courses:${NC}"
    grep ",$username$" $ENROLLMENT_FILE | cut -d, -f1
    read -p "Press [Enter] to return to the teacher menu..."
    teacher_menu "$username"
}

# Function to add a student to a course
add_student_to_course() {
    read -p "Enter course code: " course_code
    read -p "Enter student ID: " student_id
    if grep -q "^$course_code," $COURSE_FILE && grep -q "^$student_id," $USER_FILE; then
        echo "$course_code,$student_id" >> $ENROLLMENT_FILE
        echo -e "${GREEN}Student added to course successfully!${NC}"
    else
        echo -e "${RED}Course or student not found!${NC}"
    fi
    read -p "Press [Enter] to return to the teacher menu..."
    teacher_menu "$username"
}

# Function to remove a student from a course
remove_student_from_course() {
    read -p "Enter course code: " course_code
    read -p "Enter student ID: " student_id
    if grep -q "^$course_code,$student_id$" $ENROLLMENT_FILE; then
        sed -i "/^$course_code,$student_id$/d" $ENROLLMENT_FILE
        echo -e "${GREEN}Student removed from course successfully!${NC}"
    else
        echo -e "${RED}Enrollment not found!${NC}"
    fi
    read -p "Press [Enter] to return to the teacher menu..."
    teacher_menu "$username"
}

# Function to view students in a course
view_students_in_course() {
    read -p "Enter course code: " course_code
    clear
    echo -e "${CYAN}Students in $course_code:${NC}"
    grep "^$course_code," $ENROLLMENT_FILE | cut -d, -f2
    read -p "Press [Enter] to return to the teacher menu..."
    teacher_menu "$username"
}

# Function to record grades
record_grades() {
    read -p "Enter course code: " course_code
    read -p "Enter student ID: " student_id
    read -p "Enter grade (e.g., A, A+, B-): " grade
    if grep -q "^$course_code,$student_id$" $ENROLLMENT_FILE; then
        echo "$course_code,$student_id,$grade" >> $GRADE_FILE
        echo -e "${GREEN}Grade recorded successfully!${NC}"
    else
        echo -e "${RED}Enrollment not found!${NC}"
    fi
    read -p "Press [Enter] to return to the teacher menu..."
    teacher_menu "$username"
}

# Function to update grades
update_grades() {
    read -p "Enter course code: " course_code
    read -p "Enter student ID: " student_id
    read -p "Enter new grade (e.g., A, A+, B-): " new_grade
    if grep -q "^$course_code,$student_id," $GRADE_FILE; then
        sed -i "/^$course_code,$student_id,/c\\$course_code,$student_id,$new_grade" $GRADE_FILE
        echo -e "${GREEN}Grade updated successfully!${NC}"
    else
        echo -e "${RED}Grade record not found!${NC}"
    fi
    read -p "Press [Enter] to return to the teacher menu..."
    teacher_menu "$username"
}

# Function to view course attendance
view_course_attendance() {
    read -p "Enter course code: " course_code
    clear
    echo -e "${CYAN}Attendance for $course_code:${NC}"
    grep "^$course_code," $ATTENDANCE_FILE
    read -p "Press [Enter] to return to the teacher menu..."
    teacher_menu "$username"
}

# Function to display student menu
student_menu() {
    local username="$1"
    student_id=$(grep ",$username,student$" $USER_FILE | cut -d, -f1)
    clear
    echo -e "${GREEN}----------------------------------------${NC}"
    echo -e "${GREEN}|            Student Menu              |${NC}"
    echo -e "${GREEN}|         Welcome, $username           |${NC}"
    echo -e "${GREEN}----------------------------------------${NC}"
    echo "1. View Enrolled Courses"
    echo "2. Enroll in Course"
    echo "3. Drop Course"
    echo "4. View Grades"
    echo "5. View Attendance"
    echo "6. Update Personal Information"
    echo "7. Back to Main Menu"
    echo -e "${GREEN}----------------------------------------${NC}"
    read -p "Select an option: " option

    case $option in
        1) view_enrolled_courses "$student_id" ;;
        2) enroll_in_course "$student_id" ;;
        3) drop_course "$student_id" ;;
        4) view_grades "$student_id" ;;
        5) view_attendance "$student_id" ;;
        6) update_personal_info "$username" ;;
        7) main_menu ;;
        *) echo -e "${RED}Invalid option! Please try again.${NC}"; student_menu "$username" ;;
    esac
}

# Function to view enrolled courses for a student
view_enrolled_courses() {
    local student_id="$1"
    clear
    echo -e "${CYAN}Enrolled Courses:${NC}"
    grep ",$student_id$" $ENROLLMENT_FILE | cut -d, -f1
    read -p "Press [Enter] to return to the student menu..."
    student_menu "$username"
}

# Function to enroll in a course
enroll_in_course() {
    local student_id="$1"
    read -p "Enter course code: " course_code
    if grep -q "^$course_code," $COURSE_FILE && grep -q "^$student_id,student$" $USER_FILE; then
        echo "$course_code,$student_id" >> $ENROLLMENT_FILE
        echo -e "${GREEN}Enrolled in course successfully!${NC}"
    else
        echo -e "${RED}Course or student not found!${NC}"
    fi
    read -p "Press [Enter] to return to the student menu..."
    student_menu "$username"
}

# Function to drop a course
drop_course() {
    local student_id="$1"
    read -p "Enter course code: " course_code
    if grep -q "^$course_code,$student_id$" $ENROLLMENT_FILE; then
        sed -i "/^$course_code,$student_id$/d" $ENROLLMENT_FILE
        echo -e "${GREEN}Dropped course successfully!${NC}"
    else
        echo -e "${RED}Enrollment not found!${NC}"
    fi
    read -p "Press [Enter] to return to the student menu..."
    student_menu "$username"
}

# Function to view grades for a student
view_grades() {
    local student_id="$1"
    clear
    echo -e "${CYAN}Grades:${NC}"
    grep ",$student_id," $GRADE_FILE
    read -p "Press [Enter] to return to the student menu..."
    student_menu "$username"
}

# Function to view attendance for a student
view_attendance() {
    local student_id="$1"
    clear
    echo -e "${CYAN}Attendance:${NC}"
    grep ",$student_id," $ATTENDANCE_FILE
    read -p "Press [Enter] to return to the student menu..."
    student_menu "$username"
}

# Function to update personal information
update_personal_info() {
    local username="$1"
    read -p "Enter your new username: " new_username
    read -sp "Enter your new password: " new_password
    echo
    if grep -q ",$username," $USER_FILE; then
        user_id=$(grep ",$username," $USER_FILE | cut -d, -f1)
        sed -i "/,$username,/c\\$user_id,$new_username,$new_password,student" $USER_FILE
        echo -e "${GREEN}Personal information updated successfully!${NC}"
    else
        echo -e "${RED}User not found!${NC}"
    fi
    read -p "Press [Enter] to return to the student menu..."
    student_menu "$username"
}

# Main script execution
check_and_create_files
create_demo_data
main_menu

