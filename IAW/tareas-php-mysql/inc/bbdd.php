<?php include("configuracion.php"); ?>		

<?php

#	Función para hacer una conexión con la base de datos. Concatena los datos de acceso y con setAttribute indica que si hay algún error queremos recogerlo para lanzar excepciones y mostrar mensajes de error personalizados.
	
	function conectarBD() {
		
		try {		#	
		
			$conexion = new PDO("mysql:host=".HOST."; dbname=".DBNAME."; charset=utf8", USER, PASSWORD);	

			$conexion -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			
		} catch (PDOException $e) {		
			
			echo "Error: Error al conectarse con la base de datos: ". $e -> getMessage();

			file_put_contents("PDOErrors.txt", "\r\n".date('j F, Y, g:i a ').$e -> getMessage(), FILE_APPEND);

			exit;
	
		}
		
		return $conexion;
		
	} 
	
	
#	Función para cerrar la conexión con la base de datos. 
	
	function desconectarBD($conexion) {
		
		$conexion = NULL;
	
	}
	
	
#	Función para añadir una nueva tarea. Hace una consulta sql a la base de datos introduciendo los datos de la nueva tareay devuelve el id de la tarea insertada para confirmar la operación.
	
	function insertar_tarea($nombre, $descripcion, $prioridad) {
		
		$conexion = conectarBD();
		
		try {		
			
			$sql = "INSERT INTO tareas (nombre, descripcion, prioridad) VALUES (:nombre, :descripcion, :prioridad)";	

			$stmt = $conexion -> prepare($sql);

			$stmt -> bindParam(':nombre', $nombre);
			$stmt -> bindParam(':descripcion', $descripcion);
			$stmt -> bindParam(':prioridad', $prioridad);

			$stmt -> execute();
			
		} catch (PDOException $e) {		

			echo "Error: Error al conectarse con la base de datos: ". $e -> getMessage();

			file_put_contents("PDOErrors.txt", "\r\n".date('j F, Y, g:i a ').$e -> getMessage(), FILE_APPEND);

			exit;

		}
		
		$id_tarea = $conexion -> lastInsertId();

		desconectarBD($conexion);

		return $id_tarea;	 
		
	}
	
	
#	Función para actualizar los datos de una tarea. Hace una consulta sql a la base de datos introduciendo los nuevos datos de la tarea a actualizar y su id y devuelve el número de filas afectadas por la consulta. Si es 0 quiere decir que no se actualizó la tarea.
	
	function actualizar_tarea($id_tarea, $nombre, $descripcion, $prioridad) {

		$conexion = conectarBD();

		try {		

			$sql = "UPDATE tareas SET nombre = :nombre, descripcion = :descripcion, prioridad = :prioridad WHERE id_tarea = :id_tarea"; 	

			$stmt = $conexion -> prepare($sql);

			$stmt -> bindParam(':id_tarea', $id_tarea);
			$stmt -> bindParam(':nombre', $nombre);
			$stmt -> bindParam(':descripcion', $descripcion);
			$stmt -> bindParam(':prioridad', $prioridad);

			$stmt -> execute();

		} catch (PDOException $e) {		

			echo "Error: Error al conectarse con la base de datos: ". $e -> getMessage();

			file_put_contents("PDOErrors.txt", "\r\n".date('j F, Y, g:i a ').$e -> getMessage(), FILE_APPEND);

			exit;
				
		}

		$numfilas = $stmt -> rowCount();
		desconectarBD($conexion);

		return $numfilas;	

	} 


#	Función que selecciona una tarea en concreto para editarla o eliminarla. Hace una consulta sql a la base de datos introduciendo el id de dicha tarea y devuelve los datos de esa fila en un array.
	
	function seleccionar_tarea($id_tarea) {

		$conexion = conectarBD();

		try {		

			$sql = "SELECT * FROM tareas WHERE id_tarea = :id_tarea";  

			$stmt = $conexion -> prepare($sql);

			$stmt -> bindParam(':id_tarea', $id_tarea);

			$stmt -> execute();

			$row = $stmt -> fetch(PDO::FETCH_ASSOC);		

		} catch (PDOException $e) {		

			echo "Error: Error al conectarse con la base de datos: ". $e -> getMessage();

			file_put_contents("PDOErrors.txt", "\r\n".date('j F, Y, g:i a ').$e -> getMessage(), FILE_APPEND);

			exit;

		}

		desconectarBD($conexion);

		return $row;		

	}
	
	
#	Función que selecciona todas las tareas para mostrarlas en el listado. Hace una consulta sql a la base de datos y devuelve los datos de cada fila en un array. 

	#	*Al final no se usa porque usamos paginación y no se muestran todas las tareas en una sóla página.
	
	function seleccionar_todas_tareas() {

		$conexion = conectarBD();

		try {		

			$sql = "SELECT * FROM tareas";  

			$stmt = $conexion -> query($sql);

			$rows = $stmt -> fetchAll(PDO::FETCH_ASSOC);		

		} catch (PDOException $e) {		

			echo "Error: Error al conectarse con la base de datos: ". $e -> getMessage();

			file_put_contents("PDOErrors.txt", "\r\n".date('j F, Y, g:i a ').$e -> getMessage(), FILE_APPEND);

			exit;
				
		}
		
		desconectarBD($conexion);

		return $rows;		

	}


#	Función para borrar una tarea. Hace una consulta sql a la base de datos introduciendo el id de la tarea a borrar y devuelve el número de filas afectadas por la consulta. Si es 0 quiere decir que no se borró la tarea.
	
	function borrar_tarea($id_tarea) {
		
		$conexion = conectarBD();
		
		try {
			
			$sql = "DELETE FROM tareas WHERE id_tarea = :id_tarea";	

			$stmt = $conexion -> prepare($sql);			

			$stmt -> bindParam(':id_tarea', $id_tarea);

			$stmt -> execute();
			
		} catch (PDOException $e) {		
			
			echo "Error: Error al conectarse con la base de datos: ". $e -> getMessage();

			file_put_contents("PDOErrors.txt", "\r\n".date('j F, Y, g:i a ').$e -> getMessage(), FILE_APPEND);

			exit;
				
		}
		
		$numfilas = $stmt -> rowCount();

		desconectarBD($conexion);

		return $numfilas;	
		
	}


#	Función para iniciar sesión. Hace una consulta a la base de datos añadiendo el usuario para recoger en un array los datos del usuario introducido y con la función password verify con la función password_verify comprueba si la contraseña coincide con la de la base de datos. 

	function login ($usuario, $password) {		

		$conexion = conectarBD();

		try {			

			$sql = "SELECT * FROM usuarios WHERE usuario = :usuario";  

			$stmt = $conexion -> prepare($sql);

			$stmt -> bindParam(':usuario', $usuario);

			$stmt -> execute();

			$row = $stmt -> fetch (PDO::FETCH_ASSOC);

		} catch (PDOException $e) {		

			echo "Error: Error al conectarse con la base de datos: ". $e -> getMessage();

			file_put_contents("PDOErrors.txt", "\r\n".date('j F, Y, g:i a ').$e -> getMessage(), FILE_APPEND);

			exit;
				
		}

		return password_verify ($password, $row['password']);		

	}


#	Función para mostrar un determinado número de elementos por página. Hace una consulta sql a la base de datos introduciendo el primer elemento a mostrar y cuántos por cada página con LIMIT. Devuelve los datos de cada fila en un array.

	function paginacion ($inicio, $numelementos) {

		$conexion = conectarBD();

		try {

			$sql = "SELECT * from tareas LIMIT :inicio, :numelementos";

			$stmt = $conexion -> prepare($sql);

			$stmt -> bindParam(':inicio', $inicio, PDO::PARAM_INT);
			$stmt -> bindParam(':numelementos',  $numelementos, PDO::PARAM_INT);	

			$stmt -> execute();

			$rows = $stmt -> fetchAll(PDO::FETCH_ASSOC);		

		} catch (PDOException $e) {		

			echo "Error: Error al conectarse con la base de datos: ". $e -> getMessage();

			file_put_contents("PDOErrors.txt", "\r\n".date('j F, Y, g:i a ').$e -> getMessage(), FILE_APPEND);

			exit;
				
		}
		
		desconectarBD($conexion);

		return $rows;		
	
	}


#	Funcion para saber cuantos elementos debe tener el menú de paginación. Hace una consulta a la base de datos para saber cuántas tareas hay en total y lo divide entre el número de elementos que debe mostrar por página. El resultado se redondea con la función ceil.

	function num_paginas ($numelementos) {

		$conexion = conectarBD();

		try {	

			$sql = "SELECT count(*) FROM tareas";

			$numtareas = $conexion -> query($sql) -> fetchColumn();

		} catch (PDOException $e) {		

			echo "Error: Error al conectarse con la base de datos: ". $e -> getMessage();

			file_put_contents("PDOErrors.txt", "\r\n".date('j F, Y, g:i a ').$e -> getMessage(), FILE_APPEND);

			exit;
				
		}

		$numpaginas = ceil ($numtareas / $numelementos);

		desconectarBD($conexion);

		return $numpaginas;		

	} 


#	Función para registrar a un usuario en la aplicación. Hace una consulta sql con las credenciales introducidas por el usuario (encriptando la contraseña). Devuelve el número de filas afectadas por la consulta. Si es 0 quiere decir que no se completó el registro.

	function registro ($usuario, $password) {

		$conexion = conectarBD();

		$password = password_hash ($password, PASSWORD_BCRYPT);

		try { 

			$sql = "INSERT INTO usuarios (usuario, password) VALUES (:usuario, :password)";	

			$stmt = $conexion -> prepare($sql);

			$stmt -> bindParam(':usuario', $usuario);
			$stmt -> bindParam(':password',  $password);	

			$stmt -> execute();
		
		} catch (PDOException $e) {		

			echo "Error: Error al conectarse con la base de datos: ". $e -> getMessage();

			file_put_contents("PDOErrors.txt", "\r\n".date('j F, Y, g:i a ').$e -> getMessage(), FILE_APPEND);

			exit;
				
		}

		$numfilas = $stmt -> rowCount();

		desconectarBD ($conexion);

		return $numfilas; 

	}


#	Función que comprueba que no existe ningun usuario con el nombre introducido durante el registro. Devuelve el número de filas afectadas por la consulta. Si es 0 quiere decir que no hay ningún usuario con ese nombre.

	function seleccionar_usuario ($usuario) {

		$conexion = conectarBD();

		try { 

			$sql = "SELECT * FROM usuarios WHERE usuario = :usuario";

			$stmt = $conexion -> prepare($sql);

			$stmt -> bindParam(':usuario', $usuario);

			$stmt -> execute();
		
		} catch (PDOException $e) {		

			echo "Error: Error al conectarse con la base de datos: ". $e -> getMessage();

			file_put_contents("PDOErrors.txt", "\r\n".date('j F, Y, g:i a ').$e -> getMessage(), FILE_APPEND);

			exit;
				
		}

		$numfilas = $stmt -> rowCount();

		desconectarBD($conexion);

		return $numfilas; 

	}


	function captcha () {} ;

?>
