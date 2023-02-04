<?php session_start(); ?>

<?php include ('inc/bbdd.php'); ?>
<?php include ('inc/funciones.php'); ?>

<?php	

	if (!isset($_SESSION['usuario'])) {		#	Si no hay sesión de usuario redirige a página de login.
		
		header("Location: login.php");
	
	}

?>

<?php function mostrarFormulario ($nombre, $descripcion, $prioridad) { ?>

    <form method="get">

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

<?php include ('inc/header.php'); ?>

<h1>Insertar tarea</h1>

<?php
	
	#	Si no pulsó el botón de enviar mostramos el formulario.
	
    if (!isset($_REQUEST['btn-enviar'])) {

        $nombre = "";
        $descripcion = "";
        $prioridad = "";

        mostrarFormulario ($nombre, $descripcion, $prioridad);
		
	#	Si pulsó el botón de enviar recogemos los datos. Lanzamos errores con estilos si hay algún campo vacío.

    } else {

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

        if ($errores != "") {
			
			echo "<div class='alert alert-danger' role= 'alert'>";
			
				echo "<ul>$errores</ul>";
				echo "</hr>";
			
			echo "</div>";

            mostrarFormulario ($nombre, $descripcion, $prioridad);
        
        } 
		
		#	Si no hay ningún error intentamos hacer el insert y mostramos un alert u otro en función de si la tarea se inserta correctamente o no.
		
        else {

            $id_tarea = insertar_tarea ($nombre, $descripcion, $prioridad);
			
			if ($id_tarea) { 
			
?>	
				
				<div class="alert alert-s" role= "alert">
				
					<h2>Tarea <?=$id_tarea ?> insertada correctamente </h2>
					<p><a href='listado.php' class='btn btn-success'>Volver al listado</a></p>
				
				</div>
				
<?php
			
			} else {
				
?>
			
				<div class="alert alert-danger" role= "alert">
				
					<h2>Errores</h2>
					<p>Tarea no insertada</p>
					
				</div>
			
<?php
			
				mostrarFormulario ($nombre, $descripcion, $prioridad);
			
			}
		
		}
	
	}
				
?>
				
<!--<a href="listado.php"><button type="button" class="btn btn-outline-info">Listado de tareas</button></a> -->

<?php include ("inc/footer.php"); ?>
