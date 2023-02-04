<?php

#	Función para recoger los datos de los formularios.
	
	function recoge($var, $m = "") {
		
		$tmp = is_array($m) ? [] : "";
		
		if (isset($_REQUEST[$var])) {
			
			if (!is_array($_REQUEST[$var]) && !is_array($m)) {
				
				$tmp = trim(htmlspecialchars($_REQUEST[$var]));
				
			} elseif (is_array($_REQUEST[$var]) && is_array($m)) {
				
				$tmp = $_REQUEST[$var];
				
				array_walk_recursive($tmp, function (&$valor) {
					
					$valor = trim(htmlspecialchars($valor));
					
				});
				
			}
			
		}
		
		return $tmp;
		
	}

?>