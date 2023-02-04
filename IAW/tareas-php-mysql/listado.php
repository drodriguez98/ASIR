<?php session_start(); ?>

<?php include ("inc/header.php"); ?>
<?php include ("inc/bbdd.php"); ?>
<?php include ("inc/funciones.php"); ?>


<!--	Si no hay sesión de usuario redirige a página de login.		-->

<?php		

	if (!isset($_SESSION['usuario'])) {		
		
		header("Location: login.php");
	
	}

?>


<!--	Recoge el valor de la página a mostrar (-1). Si no recibe nada muestra la primera, pero si tiene un valor lo multiplica por la constante NUMELEMENTOS para saber cual debe ser el primer elemento de dicha página y llama a la función de paginación pasandole como parámetros la primera tarea a mostrar y el número de tareas por página.		-->

<?php 			

	$pagina = recoge('pagina');		

	if ($pagina == "") {

		$pagina = 1;
		
	} 

	$inicio = ($pagina - 1) * NUMELEMENTOS;	

	$tareas_pagina = paginacion ($inicio, NUMELEMENTOS);

?>


  
	<h1>Listado de tareas</h1>

	<!--	Enlaces	1	-->
	
	<div class="text-end">
	
		<a href="insertar.php" class="btn btn-success">Insertar tarea</a>
		<a href="logout.php" class="btn btn-danger">Cerrar sesión</a>

		
	</div>

	<!--	Recoge los datos de las tareas a mostrar en un array y los muestra en una tabla		-->

	<table class="table">

	<thead>

		<tr>

			<th scope="col">#</th>
			<th scope="col">Nombre</th>
			<th scope="col">Descripción</th>
			<th scope="col">Prioridad</th>
			<th scope="col">Acciones</th>

		</tr>

	</thead>

    <tbody>

		<?php

			foreach ($tareas_pagina as $tarea) {		

			  $id_tarea = $tarea['id_tarea'];
			  $nombre = $tarea['nombre'];
			  $descripcion = $tarea['descripcion'];
			  $prioridad = $tarea['prioridad'];

		?>

		<tr>		

			<th scope="row"><?= $id_tarea ?></th>
			<td><?= $nombre ?></td>
			<td><?= $descripcion ?></td>
			<td><?= $prioridad ?></td>

			<td>		<!--	Enlaces	2	-->

			  <a href="editar.php?id_tarea=<?=$id_tarea?>" class="btn btn-primary">Editar</a>
			  <a href="borrar.php?id_tarea=<?=$id_tarea ?>" class="btn btn-danger" onclick="return confirm ('Estás seguro de borrar la tarea <?=$id_tarea?>?');">Borrar</a>

			</td>

		</tr>

      <?php

        }

      ?>

    </tbody>

  </table>

  <!--		Menú de paginación. Llama a la función num_paginas para saber cuántos elementos debe tener la paginación y envía como parámetro la próxima página a mostrar a través del enlace. Los botones de anterior no se muestran si el usuario se encuentra en la primera página o en la última.		-->

  <nav aria-label="Page navigation example">	

	<ul class="pagination">

		<?php		

			$num_paginas = num_paginas(NUMELEMENTOS);

		?>

		<li class="page-item" <?php if ($pagina == 1) {print "disabled"; }?>> <a class="page-link" href="listado.php?pagina=<?=$pagina - 1; ?>">Anterior</a></li>

		<?php

			for ($i = 1; $i <= $num_paginas; $i++) {
			
		?>

				<li class="page-item"><a class="page-link" href="listado.php?pagina=<?=$i?>"><?php echo $i?></a></li>
			
		<?php } ?>

		<li class="page-item" <?php if ($pagina >= $num_paginas) {print "disabled"; }?>><a class="page-link" href="listado.php?pagina=<?=$pagina + 1; ?>">Siguiente</a></li>

	</ul>


</nav> 

<?php include("inc/footer.php"); ?>