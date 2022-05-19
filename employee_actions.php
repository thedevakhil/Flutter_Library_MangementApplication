        <?php
        include 'config.php';

            $table = "Books"; // lets create a table named Employees.

            // we will get actions from the app to do operations in the database...
            $action = $_POST["action"];
            if("CREATE_TABLE" == $action){
                $sql = "CREATE TABLE IF NOT EXISTS $table ( 
                id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                first_name VARCHAR(30) NOT NULL,
                last_name VARCHAR(30) NOT NULL
            )";

            if($conn->query($sql) === TRUE){
                    // send back success message
                echo "success";
            }else{
                echo "error";
            }
            $conn->close();
            return;
        }

            // Get all employee records from the database
        if("GET_ALL" == $action){
            $adno = $_POST["adno"];
            $db_data = array();
            $sql = "SELECT * FROM books where STATUS ='available' and title not in (SELECT title from books,mybooking where books.bino = mybooking.bino and mybooking.Student_id='$adno') group by title";
            $result = $conn->query($sql);
            if($result->num_rows > 0){
                while($row = $result->fetch_assoc()){
                    $db_data[] = $row;
                }
                    // Send back the complete records as a json
                echo json_encode($db_data);
            }else{
                echo "Error in ".$sql."<br>".$conn->error;
            }
            $conn->close();
            return;
        }
            //login
      
     if("LOGINALL" == $action){
        $email = $_POST["email"];
        $pass = $_POST["pass"];
         $type = $_POST["type"];
         if(($email=='Admin')&&($pass=='1234'))
         {
            echo "Admin";
            return;
         }
         else if($type=='2')
         {
         $sql4 = ("SELECT * FROM teacher WHERE email='$email' and pass='$pass'");
            $result = mysqli_query($conn, $sql4) or die(mysqli_error($conn));
            $fetchRow = mysqli_fetch_assoc($result);
            $count = mysqli_num_rows($result);
                if($count==1){
                    echo"Teacher";
                    return;
                            }
                        else
                            {
                             echo "Error";
                             return;
                            }
     }
     else if($type=='1')
     {
            $sql4 = ("SELECT * FROM student WHERE adno='$email' and pass='$pass'");
            $result = mysqli_query($conn, $sql4) or die(mysqli_error($conn));
            $fetchRow = mysqli_fetch_assoc($result);
            $count = mysqli_num_rows($result);
                if($count==1){
                    echo"Student";
                            }
                        else
                            {
                             echo "Error";
                            }
    }
     else{
        echo "error";
     }
     }
            //issue book
            // Get all employee records from the database
     if("ISSUE" == $action){
        $bino = $_POST["bino"];
        $adno = $_POST["adno"];
        $result = $conn->query("SELECT COUNT(*) FROM issued WHERE adno='$adno'");
$row = mysqli_fetch_array($result);

$total = $row[0];      

        $db_data = array();
        $sql = "SELECT title,name,status FROM books,student WHERE bino='$bino' and adno='$adno'";
        $result = $conn->query($sql);
        if($result->num_rows > 0){


            $fetchRow = mysqli_fetch_assoc($result);
            $a=$fetchRow['title'];
            $b=$fetchRow['name'];
            $c=$fetchRow['status'];
            if($c=='unavailable')
            {
                echo "case1";
            }
            else{
                echo $a.':'.$b.':'.$total;

            }

        }else{
           echo "Error in ".$sql."<br>".$conn->error;
        }
        $conn->close();
        return;
    }



            // Add an Employee
    


    if("BOOK" == $action){
                // App will be posting these values to this server
        $emp_id = $_POST['emp_id'];
        $first_name = $_POST["studentid"];
        $last_name = $_POST["last_name"];
        $sql = "INSERT INTO mybooking (Student_id, bdate, bino) VALUES ('$first_name', NOW(), '$emp_id')";
        $sql2= "UPDATE books set status='unavailable' where bino='$last_name'";
               // $result = $conn->query($sql);
        if(($conn->query($sql) === TRUE)&&($conn->query($sql2) === TRUE)){
            echo "success";
            exit;
            die();
        }else{
            echo "Error: " . $sql . "
            " . mysqli_error($conn);
        }
    }

            // Remember - this is the server file.
            // I am updating the server file.
            // Update an Employee
    if("UPDATE_EMP" == $action){
                // App will be posting these values to this server
        $emp_id = $_POST['emp_id'];
        $first_name = $_POST["first_name"];
        $last_name = $_POST["last_name"];
        $sql = "UPDATE $table SET first_name = '$first_name', last_name = '$last_name' WHERE id = $emp_id";
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

            // Delete an Employee
    if('DELETE_EMP' == $action){
        $emp_id = $_POST['emp_id'];
                $sql = "DELETE FROM $table WHERE id = $emp_id"; // don't need quotes since id is an integer.
                if($conn->query($sql) === TRUE){
                    echo "success";
                }else{
                    echo "error";
                }
                $conn->close();
                return;
            }
            if("GETBOOKING" == $action){
                $emp_id = $_POST['emp_id'];
                $db_data = array();
                $sql = "SELECT * FROM mybooking,books where mybooking.Student_id='$emp_id' and mybooking.bino=books.bino";
                $result = $conn->query($sql);
                if($result->num_rows > 0){
                    while($row = $result->fetch_assoc()){
                        $db_data[] = $row;
                    }
                    // Send back the complete records as a json
                    echo json_encode($db_data);
                }else{
                    echo "Error in ".$sql."<br>".$conn->error;
                }
                $conn->close();
                return;
            }
            ///get all books for admin
             if("GETALLBOOKS" == $action){
                
                $db_data = array();
                $sql = "SELECT * FROM books order by title";
                $result = $conn->query($sql);
                if($result->num_rows > 0){
                    while($row = $result->fetch_assoc()){
                        $db_data[] = $row;
                    }
                    // Send back the complete records as a json
                    echo json_encode($db_data);
                }else{
                    echo "Error in ".$sql."<br>".$conn->error;
                }
                $conn->close();
                return;
            }
            //VIEW ALL STUDENTS
            if("VIEWALLSTUDENTS" == $action){
                
                $db_data = array();
                $sql = "SELECT * FROM student";
                $result = $conn->query($sql);
                if($result->num_rows > 0){
                    while($row = $result->fetch_assoc()){
                        $db_data[] = $row;
                    }
                    // Send back the complete records as a json
                    echo json_encode($db_data);
                }else{
                    echo "Error in ".$sql."<br>".$conn->error;
                }
                $conn->close();
                return;
            }
            //view all boocking
            if("ALLBOOKINGS" == $action){
                
                $db_data = array();
                $sql = "SELECT * FROM mybooking,student,books where mybooking.bino=books.bino and mybooking.Student_id=student.adno";
                $result = $conn->query($sql);
                if($result->num_rows > 0){
                    while($row = $result->fetch_assoc()){
                        $db_data[] = $row;
                    }
                    // Send back the complete records as a json
                    echo json_encode($db_data);
                }else{
                    echo "Error in ".$sql."<br>".$conn->error;
                }
                $conn->close();
                return;
            }
            // view all isuued books for admin
            if("VIEWALLISSUED" == $action){
                
                $db_data = array();
                $sql = "SELECT * from issued,books,student WHERE issued.bino=books.bino and issued.adno=student.adno";
                $result = $conn->query($sql);
                if($result->num_rows > 0){
                    while($row = $result->fetch_assoc()){
                        $db_data[] = $row;
                    }
                    // Send back the complete records as a json
                    echo json_encode($db_data);
                }else{
                    echo "Error in ".$sql."<br>".$conn->error;
                }
                $conn->close();
                return;
            }
            




      
   if("VISSUE" == $action){
            $adno = $_POST['adno'];
        $bino = $_POST["bino"];
       
        $sql = "INSERT INTO `issued`(`bino`, `adno`, `issuedate`) VALUES ('$bino','$adno',NOW())";
        $sql2 ="UPDATE books set status='unavailable' where bino='$bino'";
        if(($conn->query($sql) === TRUE)&&($conn->query($sql2) === TRUE)){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
         }
           if("VISSUEB" == $action){
            $adno = $_POST['adno'];
        $bino = $_POST["bino"];
       
        $sql = "INSERT INTO `issued`(`bino`, `adno`, `issuedate`) VALUES ('$bino','$adno',NOW())";
        $sql2 ="UPDATE books set status='unavailable' where bino='$bino'";
         $sql3 ="DELETE from mybooking where Student_id='$adno' and bino='$bino'";
        if(($conn->query($sql) === TRUE)&&($conn->query($sql2) === TRUE)&&($conn->query($sql3) === TRUE)){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
         }
         

if("VIEWISSUE" == $action){

         //view issued book
          $adno = $_POST["emp_id"];
         
// Creating SQL command to fetch all records from Fruits Table.
$sql = "SELECT * FROM issued,books where issued.adno='$adno' and issued.bino=books.bino";
 
$result = $conn->query($sql);
 
if ($result->num_rows >0) {
 
 
 while($row[] = $result->fetch_assoc()) {
 
 $item = $row;
 
 $json = json_encode($item);
 
 }
 
} else {
 echo "No Data Found.";
}
 echo $json;
$conn->close();
}

       

         //end view issued book
 //method for return Book
if("RETURN" == $action){
        $bino = $_POST["bino"];
        
    //$result = $conn->query("SELECT COUNT(*) FROM issued WHERE adno='$adno'");
//
//$total = $row[0];      

        //$db_data = array();
        $sql = "SELECT title,name,issuedate FROM issued,books,student WHERE issued.bino='$bino' and student.adno=(SELECT issued.adno from issued WHERE issued.bino='$bino') and books.bino=issued.bino";
        $result = $conn->query($sql);
        if($result->num_rows > 0){


            $fetchRow = mysqli_fetch_assoc($result);
            $a=$fetchRow['title'];
            $b=$fetchRow['name'];
            $c=$fetchRow['issuedate'];
         
     
                echo $a.':'.$b.':'.$c;
   

        }else{
            echo "error";
                        //echo "Error in ".$sql."<br>".$conn->error;
        }
        $conn->close();
        return;
    }
 //end of return book
    //verify return
     if("VRETURN" == $action){
                // App will be posting these values to this server
      
        $bino = $_POST["bino"];
        $sql = "UPDATE books SET status='available' WHERE bino = '$bino'";
        $sql2="DELETE FROM `issued` WHERE bino='$bino'";
        if(($conn->query($sql) === TRUE)&&($conn->query($sql2) === TRUE)){
            echo "success";
        }else{
             echo "Error in ".$sql."<br>".$conn->error;
              echo "Error in ".$sql2."<br>".$conn->error;
            //echo "error";
        }
        $conn->close();
        return;
    }
    //verify return end here

    //Add teacher
    if("ADDTEACHER" == $action){
            $tname = $_POST['tname'];
        $email = $_POST["email"];
        $phn = $_POST["phn"];
        $des = $_POST["des"];
        $pass = $_POST["pass"];
       
        $sql = "INSERT INTO `teacher`(`name`, `des`, `email`, `phn`, `pass`) VALUES ('$tname','$des','$email','$phn','$pass')";
       
        if(($conn->query($sql) === TRUE)){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
         }

          if("ADDBOOK" == $action){
            $bookname = $_POST['bookname'];
        $author = $_POST["author"];
        $rate = $_POST["rate"];
        $category = $_POST["category"];
        $booknum = $_POST["booknum"];
        $edition = $_POST["edition"];
       
        $sql = "INSERT INTO `books`(`bino`, `title`, `author`, `edition`, `rate`, `category`) VALUES ('$booknum','$bookname','$author','$edition','$rate','$category')";
       
        if(($conn->query($sql) === TRUE)){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
         }

          if("ADDSTUDENT" == $action){
            $name = $_POST['name'];
        $dept = $_POST["dept"];
        $batch = $_POST["batch"];
        $email = $_POST["email"];
        $phn = $_POST["phn"];
        $admno = $_POST["admno"];
        $gen = $_POST["gen"];
       
        $sql = "INSERT INTO `student`(`adno`, `name`, `dept`, `bach`, `gen`,`email`,`phn`) VALUES ('$admno','$name','$dept','$batch','$gen','$email','$phn')";
       
        if(($conn->query($sql) === TRUE)){
            echo "success";
        }else{
           echo "Error in ".$sql."<br>".$conn->error;
        }
        $conn->close();
        return;
         }
         ?>
