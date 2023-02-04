<?php session_start(); ?>

<?php include ('inc/bbdd.php'); ?>
<?php include ("inc/header.php"); ?>

<h1>Cuenta creada con éxito</h1>

<?php 

    echo "Bienvenido ".$_SESSION['usuario'];

    echo '<br><br>';

?>

<a href="listado.php" class="btn btn-success">Acceder a la aplicación</a>