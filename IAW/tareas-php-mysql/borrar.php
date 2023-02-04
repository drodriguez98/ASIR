<?php session_start(); ?>

<?php include ('inc/funciones.php'); ?>
<?php include ('inc/bbdd.php'); ?>
<?php include ('inc/header.php'); ?>

<?php	

	if (!isset($_SESSION['usuario'])) {		#	Si no hay sesión de usuario redirige a página de login.
		
		header("Location: login.php");
	
	}

?>

<h1>Borrar tarea</h1>

<?php

	$id_tarea = recoge('id_tarea');
		
	$borrar = borrar_tarea ($id_tarea);
		
	if ($borrar) { 
		
?>	
			
		<div class="alert alert-success" role= "alert">
			
			<h2>Tarea <?=$id_tarea ?> borrada correctamente </h2>
			
		</div>
			
		<p><a href='listado.php' class='btn btn-success'>Volver al listado</a></p>
						
<?php

	} else {
			
?>
		
		<div class="alert alert-danger" role= "alert">
			
			<p>Tarea <?=$id_tarea ?> no borrada. Prueba otra vez.</p>
				
		</div>
<?php

	}

?>

<?php include ("inc/footer.php"); ?>