<?php 

require_once '../includes/DbOperations.php';

$response = array(); 

if($_SERVER['REQUEST_METHOD']=='POST'){

	if(isset($_POST['level'])){

	$file = '../includes/DbOperations_level_'+ $_POST['level']}+'.php'
	require_once $file;

	//Request to add a Subject and Teacher
		if(isset($_POST['subjectName']) and 
				isset($_POST['subjectTeacher']) and
					!isset($_POST['delete'])
			)
		{
			//operate the data further 
			$db = new DbOperations(); 

			$result = $db->createSubject( $_POST['subjectName'],
										$_POST['subjectTeacher']
									);
			if($result == 1){
				$response['error'] = false; 
				$response['message'] = "Subject successfully added";
			}elseif($result == 2){
				$response['error'] = true; 
				$response['message'] = "Some error occurred at database please try again";			
			}elseif($result == 0){
				$response['error'] = true; 
				$response['message'] = "Subject already exists";					
			}

		}

		//Request to display the entries in database
		if(isset($_POST['displaySubject']) 
			)
		{
			$db = new DbOperations(); 

			$result = $db->showSubjects($_POST['displaySubject']);
			if($result != NULL)
			{
				$response['error'] = false;
				$response['data'] = $result;
			}
			else
			{
				$response['error'] = true;
				$response['message'] = "Nothing to show in database";
				$response['data'] = $result;
			}

		}

	}else{
		$response['error'] = true; 
		$response['message'] = "No Level Selection";
	}

}else{
	$response['error'] = true; 
	$response['message'] = "Invalid Request";
}

echo json_encode($response);
