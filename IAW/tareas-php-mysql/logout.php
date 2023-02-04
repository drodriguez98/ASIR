<?php session_start(); ?>

<?php include ('inc/bbdd.php'); ?>
<?php include ("inc/header.php"); ?>

<h1>Sesión finalizada</h1>

<?php 

    echo "Hasta la próxima ".$_SESSION['usuario'];

    echo "<br><br>";

    unset($_SESSION['usuario']);

?>

<a href="login.php" class="btn btn-success">Iniciar sesión</a>

