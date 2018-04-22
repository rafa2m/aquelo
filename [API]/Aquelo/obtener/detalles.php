
<?
	header('Content-Type: application/json');

	$username = "root";
	$password = "";
	$hostname = "localhost";

	$dbhandle = mysql_connect($hostname, $username, $password) 
	or die("No es posible conectarse a MySQL");

	$seleccion = mysql_select_db("aquelo") 
	or die("Base de datos no disponible");


// Mostramos los actuadores: Reles
	function mostrar_actuador($detalle){		
		if($detalle == "lista"){
			$resultado = mysql_query("SELECT id FROM Actuador");
		}else{
			$resultado = mysql_query("SELECT id FROM Actuador WHERE id='" . $detalle."'	");
			//$resultado = mysql_query("SELECT tipo,id,modelo,marca,canal FROM Sensor WHERE id=" . $detalle);
		}
		while ($fila = mysql_fetch_array($resultado)) {
			$todosLosID[] = $fila;
		}
		return $todosLosID; 
	}

// Mostramos los activador: valvula
	function mostrar_activador($detalle){		
		if($detalle == "lista"){
			$resultado = mysql_query("SELECT id FROM Activador");
		}else{
			$resultado = mysql_query("SELECT id FROM Activador WHERE id='" . $detalle."'	");
			//$resultado = mysql_query("SELECT tipo,id,modelo,marca,canal FROM Sensor WHERE id=" . $detalle);
		}
		while ($fila = mysql_fetch_array($resultado)) {
			$todosLosID[] = $fila;
		}
		return $todosLosID; 
	}

// Mostramos calendario
	function mostrar_calendario($detalle){
		if($detalle == "lista"){
			$resultado = mysql_query(" SELECT fecha_inicio FROM Calendario ");
		}else{
			$resultado = mysql_query("SELECT fecha_inicio FROM Calendario WHERE id='".$detalle."'");
			//$resultado = mysql_query("SELECT marca FROM Sensor WHERE id=".$detalle);
		}
		while ($fila = mysql_fetch_array($resultado)) {
			$todosLosModelos[] = $fila;
			//echo $fila;
		}
		return $todosLosModelos; 
	}



// Mostramos sensores
	function mostrar_Sensor($detalle){
		if($detalle == "lista"){
			$resultado = mysql_query(" SELECT id FROM Sensor ");
		}else{
			$resultado = mysql_query("SELECT id FROM Sensor WHERE id='".$detalle."'");
			//$resultado = mysql_query("SELECT marca FROM Sensor WHERE id=".$detalle);
		}
		while ($fila = mysql_fetch_array($resultado)) {
			$todosLosModelos[] = $fila;
			//echo $fila;
		}
		return $todosLosModelos; 
	}

// Peticiones
	if( $_GET['peticion'] == 'sensor'){

		$resultados = mostrar_Sensor($_GET['detalle'] );

	}else if($_GET['peticion'] == 'actuador'){

		 $resultados = mostrar_actuador( $_GET['detalle'] );
	}else if($_GET['peticion'] == 'activador'){

		 $resultados = mostrar_activador( $_GET['detalle'] );
	}else if($_GET['peticion'] == 'calendario'){

		 $resultados = mostrar_calendario( $_GET['detalle'] );
	}else{
		header('HTTP/1.1 405 Method Not Allowed');
		exit;
	}




	echo json_encode( $resultados );
?>