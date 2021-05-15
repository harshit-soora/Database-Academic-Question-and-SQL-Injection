<?php 

	class DbOperations{

		private $con; 

		function __construct(){

			require_once dirname(__FILE__).'/DbConnect.php';

			$db = new DbConnect();

			$this->con = $db->connect();

		}

		
		//Register related queries
		public function createUser($username, $pass, $email){
			if($this->isUserExist($username,$email)){
				return 0; 
			}else{
				$password = md5($pass);
				$stmt = $this->con->prepare("INSERT INTO `users` (`id`, `username`, `password`, `email`) VALUES (NULL, ?, ?, ?);");
				$stmt->bind_param("sss",$username,$password,$email);

				if($stmt->execute()){
					return 1; 
				}else{
					return 2; 
				}
			}
		}

		private function isUserExist($username, $email){
			$stmt = $this->con->prepare("SELECT id FROM users WHERE username = ? OR email = ?");
			$stmt->bind_param("ss", $username, $email);
			$stmt->execute(); 
			$stmt->store_result(); 
			return $stmt->num_rows > 0; 
		}


		//User Login related queries
		public function userLogin($username, $pass){
			$password = md5($pass);
			$stmt = $this->con->prepare("SELECT id FROM users WHERE username = ? AND password = ?");
			$stmt->bind_param("ss",$username,$password);
			$stmt->execute();
			$stmt->store_result(); 
			return $stmt->num_rows > 0; 
		}

		public function getUserByUsername($username){
			$stmt = $this->con->prepare("SELECT * FROM users WHERE username = ?");
			$stmt->bind_param("s",$username);
			$stmt->execute();
			return $stmt->get_result()->fetch_assoc();
		}



		//Subject related queries
		public function createSubject($subjectname, $subjectTeacher){
			if($this->isSubjectExist($subjectname, $subjectTeacher)){
				return 0; 
			}else{
				$stmt = $this->con->prepare("INSERT INTO `subject` (`sid`, `sname`, `steacher`) VALUES (NULL, ?, ?);");
				$stmt->bind_param("ss",$subjectname,$subjectTeacher);

				if($stmt->execute()){
					return 1; 
				}else{
					return 2; 
				}
			}
		}

		public function showSubjects($display){
			if($display == 'true'){
				$stmt = $this->con->prepare("SELECT sname as Subject , steacher as Teacher FROM subject");
				$stmt->execute();
				$result = $stmt->get_result();

				if($result->num_rows >0)
				{
					$result_array = array();
					$result_array["length"] = $result->num_rows;

					$i = 1;
					while($data = $result->fetch_assoc())
					{
						$result_array[$i] = $data;
						$i = $i + 1;
					}
					return $result_array;
				}
				else
				{
					return NULL;
				}
			}
			else{
				return NULL;
			}
		}

	}