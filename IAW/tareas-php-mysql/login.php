<?php session_start(); ?>

<?php include ('inc/funciones.php'); ?>
<?php include ('inc/bbdd.php'); ?>
<?php include ('inc/header.php'); ?>


<!--		Función para mostrar el formulario de login		-->

<?php function mostrarFormulario ($usuario, $password) { ?>

	<form method="get">

		<div class="mb-3">

		<label for="usuario" class="form-label">Introduce tu usuario</label>
		<input type="text" class="form-control" id="usuario" name="usuario" value="<?=$usuario ?>"/>

		</div>
		
		<div class="mb-3">

		<label for="password" class="form-label">Introduce tu contraseña</label>
		<input type="password" class="form-control" id="password" name="password" value="<?=$password ?>">

		<br>

		<button type="submit" class="btn btn-primary" name="btn-enviar">Enviar</button>

		<a href="registro.php" class="btn btn-success">No tengo una cuenta de usuario</a>

	</form>

<?php } ?>

<h1 class="mt-3 text-center">Iniciar sesión</h1>


<!--	Recogida de datos. Si no hay errores llama a la función de login. Si la operación no devuelve ninguna fila muestra un error	pero si devuelve alguna se inicia la sesión con el usuario introducido y redirige a la página confirmación.		-->

<?php

    if (!isset($_REQUEST['btn-enviar'])) {		

		$usuario = "";	
		$password = "";
		
        mostrarFormulario ($usuario, $password);
	
	} else {		

		$usuario = recoge('usuario');	
		$password = recoge('password');

		$errores = "";	

		if ($usuario == "") {
	
			$errores.= "<li>Debes introducir un usuario</li>";
	
		}
	
		if ($password == "") {
	
			$errores.= "<li>Debes introducir una contraseña</li>";
	
		}

		if ($errores != "") {		
			
			echo "<div class='alert alert-danger' role='alert'>";
			
				echo "<ul>$errores</ul>";
				echo "</hr>";
			
			echo "</div>";

			mostrarFormulario ($usuario, $password);
        
        } 
		
		else {		

			$login = login ($usuario, $password);	

			if ($login == 0) {	

				echo "<p>Usuario y/o password incorrectos</p>";

			} else {	

				$_SESSION['usuario'] = $usuario;
				
				header("Location: listado.php");

			}

		}

	}

?>

	</body>

</html>

<?php include("inc/footer.php"); ?>