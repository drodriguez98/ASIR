<?php session_start(); ?>

<?php include ('inc/funciones.php'); ?>
<?php include ('inc/bbdd.php'); ?>
<?php include ('inc/header.php'); ?>


<!--		Función para mostrar el formulario de registro		-->

<?php function mostrarFormulario ($usuario, $password) { ?>

	<form method="get">

		<div class="mb-3">

		<label for="usuario" class="form-label">Introduce un nombre de usuario </label>
		<input type="text" class="form-control" id="usuario" name="usuario" value="<?=$usuario ?>"/>

		</div>
		
		<div class="mb-3">

		<label for="password" class="form-label">Introduce una contraseña </label>
		<input type="password" class="form-control" id="password" name="password" value="<?=$password ?>">

		</div>

		<br>

		<!--	<input type="hidden" name="recaptcha_response" id="recaptcha_response"/>	-->

		<button type="submit" class="btn btn-primary" name="btn-enviar">Enviar</button>

	</form>

<?php } ?>

<h1 class="mt-3 text-center">Página de registro</h1>


<!--	Recogida de datos	-->

<?php

    if (!isset($_REQUEST['btn-enviar'])) {
		
		$usuario = "";	
		$password = "";
		
        mostrarFormulario ($usuario, $password);
	
	} else {		

		$usuario = recoge('usuario');	
		$password = recoge('password');

		$errores = "";	

		#	Validación recaptcha 

		/*if ($recaptcha-> score < 0.7) {

			$errores.= "<li>No podemos confirmar que seas un humano</li>";
		}*/

		if ($usuario == "") {
	
			$errores.= "<li>Debes introducir un usuario</li>";
	
		} else {

			$repetido = seleccionar_usuario ($usuario);

			if ($repetido) {

				$errores.= "<li>Ya existe un usuario con ese nombre</li>";
			}
		}
	
		if ($password == "")  {
	
			$errores.= "<li>Debes introducir una contraseña</li>";
	
		}

		if ($errores != "") {		
			
			echo "<div class='alert alert-danger' role='alert'>";
			
				echo "<ul>$errores</ul>";
				echo "</hr>";
			
			echo "</div>";

			mostrarFormulario ($usuario, $password);
        
        } 

		else {				#	NO HACE EL REGISTRO

			$registro = registro ($usuario, $password);

			if ($registro == 0) {	

				echo "<p>No se ha podido realizar la operación</p>";

			} else {	

				$_SESSION['usuario'] = $usuario;

				header("Location: registroOK.php");

			}

		}

	}

?>

	</body>

</html>

<!--	Scripts para recaptcha	-->

	<!--	<script src=.../>

<?php include("inc/footer.php"); ?>