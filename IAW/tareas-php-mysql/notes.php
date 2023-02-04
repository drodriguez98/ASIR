<?php include("inc/bbdd.php"); ?>

<?php

/*

CONEXIÓN A LA BASE DE DATOS

	if ($conexion) {
		
		echo "Conectado!!!";
		
	} else {
		
		echo "No conectado!!!";

	}

DATOS PARA AÑADIR CAMPOS A UNA TAREA

	$nombre = "Tarea nueva";
	$descripcion = "Acabar los deberes";
	$prioridad = "Alta";

	$id_tarea = insertar_tarea($nombre, $descripcion, $prioridad);

	if($id_tarea) {
		
		echo "Tarea $id_tarea insertada correctamente <br>";

	} else {
		
		echo "ERROR: No se ha posido insertar la tarea. Vuelva a intentarlo <br>";

	}

DATOS PARA ACTUALIZAR CAMPOS DE UNA TAREA

	$id_tarea = 3;
	$nombre = "Tarea modificada 2";
	$descripcion = "Hacer la compra";
	$prioridad = "Media";

	$filas_modificadas = actualizar_tarea($id_tarea, $nombre, $descripcion, $prioridad);

	if ($filas_modificadas) {

		echo "Tarea $id_tarea actualizada correctamente <br>";

	} else {
		
		echo "ERROR: No se ha posido actualizar la tarea. Vuelva a intentarlo <br>";

	}

DATOS PARA SELECCIONAR CAMPOS UNA TAREA EN CONCRETO

	$id_tarea = 5;
	$row = seleccionar_tarea($id_tarea);
	

	if ($row) {

		foreach($row as $clave => $valor) {

			echo "$clave : $valor <br/>";
			
		}

	} else {

		echo "No se ha podido seleccionar la tarea $id_tarea";

	}

SELECCIONAR TODAS LAS TAREAS

	$rows = seleccionar_todas_tareas();
	
	if ($rows) {

		foreach ($rows as $fila) { 

			foreach ($fila as $clave => $valor) {

				echo "$clave : $valor <br>";

			}
		}
	}

BORRAR TAREAS

	$id_tarea = 7;

	$filas_eliminadas = borrar_tarea($id_tarea);

	if ($filas_eliminadas) {

		echo "Tarea $id_tarea eliminada correctamente";

	} else {

		echo "Tarea $id_tarea no ha sido eliminada";

	}

*/

?>