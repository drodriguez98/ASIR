<?php session_start(); ?>

<?php include ('inc/funciones.php'); ?>
<?php include ('inc/bbdd.php'); ?>
<?php include ('inc/header.php'); ?>

<?php	

	if (!isset($_SESSION['usuario'])) {		#	Si no hay sesión de usuario redirige a página de login.
		
		header("Location: login.php");
	
	}

?>

<!-- Mostramos el formulario para que el usuario introduzca los datos -->

<?php function mostrarFormulario ($id_tarea, $nombre, $descripcion, $prioridad) { ?>

    <form method="get">

        <div class="mb-3">

        <label for="id_tarea" class="form-label">ID</label>
        <input type="text" class="form-control" id="id_tarea" name="id_tarea" value="<?=$id_tarea ?>" readonly="readonly" />

        </div>
		
		<div class="mb-3">

        <label for="nombre" class="form-label">Nombre</label>
        <input type="text" class="form-control" id="nombre" name="nombre" value="">

        </div>

        <div class="mb-3">

        <label for="descripcion" class="form-label">Descripción</label>
        <input type="text" class="form-control" id="descripcion" name="descripcion" value="">

        </div>

        <div class="mb3">Prioridad</br>

            <div class="form-check form-check-inline">

                <input class="form-check-input" type="radio" name="prioridad" id="baja" value="baja" <?php if ($prioridad=="baja") {echo "checked='checked'";} ?>>
                <label class="form-check-label">Baja</label>
                
            </div>

            <div class="form-check form-check-inline">

                <input class="form-check-input" type="radio" name="prioridad" id="media" value="media" <?php if ($prioridad=="media") {echo "checked='checked'";} ?>>
                <label class="form-check-label">Media</label>
    
            </div>

                <div class="form-check form-check-inline">

                <input class="form-check-input" type="radio" name="prioridad" id="alta" value="alta" <?php if ($prioridad=="alta") {echo "checked='checked'";} ?>>
                <label class="form-check-label">Alta</label>

            </div>

        </div>

        <br>
        
        <button type="submit" class="btn btn-primary" name="btn-enviar">Enviar</button>

    </form>
	
<?php } ?>

<h1>Actualizar tarea</h1>

<?php

    if (!isset($_REQUEST['btn-enviar'])) {
		
		$id_tarea= recoge('id_tarea');
		
		#	Si alguien intenta acceder directamente a la página sin el enlace de listado.php redirigimos a listado.php.
		
		if ($id_tarea == "") {
			
			header('Location: listado.php');
			exit;
		
		}
		
		#	Pasamos el id que recogemos a la función seleccionar_tarea para obtener un array con los campos de la tarea con ese id. Si el array está vació redirigimos a listado.php. Si recibimos los datos en el array los recogemos.
		
		$tarea = seleccionar_tarea($id_tarea);
		
		if (empty($tarea)) {
			
			header('Location: listado.php');
			exit;
		
		} 
		
		$nombre = $tarea['nombre'];
        $descripcion = $tarea['descripcion'];
        $prioridad = $tarea['prioridad'];

        mostrarFormulario ($id_tarea, $nombre, $descripcion, $prioridad);
	
	#	Una vez tenemos los datos antiguos, validamos los nuevos datos introducidos por el usuario.
	
    } else {
		
		$id_tarea= recoge('id_tarea');
        $nombre = recoge('nombre');
        $descripcion = recoge('descripcion');
        $prioridad = recoge('prioridad');

        $errores = "";

        if ($nombre == "") {

            $errores.= "<li>Debes introducir un nombre</li>";

        }

        if ($descripcion == "") {

            $errores.= "<li>Debes introducir una descripción</li>";

        }

        if ($prioridad == "") {

            $errores.= "<li>Debes introducir una prioridad</li>";

        }
		
		#	Comprobamos si hay errores y le damos estilo para mostrarlos.
		
        if ($errores != "") {
			
			echo "<div class='alert alert-danger' role= 'alert'>";
			
				echo "<ul>$errores</ul>";
				echo "</hr>";
			
			echo "</div>";

            mostrarFormulario ($id_tarea, $nombre, $descripcion, $prioridad);
        
        } 
		
		#	Si no hay ningún error intentamos hacer el update y mostramos un alert u otro en función de si la tarea se actualiza correctamente o no.
		
        else {

            $actualizar = actualizar_tarea ($id_tarea, $nombre, $descripcion, $prioridad);
			
			if ($actualizar) { 
			
?>	
				
				<div class="alert alert-success" role= "alert">
				
					<h2>Tarea <?=$id_tarea ?> actualizada correctamente </h2>
				
				</div>
				
				<p><a href='listado.php' class='btn btn-success'>Volver al listado</a></p>
							
<?php
	
			} else {
				
?>
			
				<div class="alert alert-danger" role= "alert">
				
					<p>Tarea <?=$id_tarea ?> no actualizada. Prueba otra vez.</p>
					
				</div>
<?php
				
				mostrarFormulario ($id_tarea, $nombre, $descripcion, $prioridad);

			}

		}
		
	}

?>

<?php include ("inc/footer.php"); ?>