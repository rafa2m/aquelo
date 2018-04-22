
<?
	header('Content-Type: application/json');

	$username = "root";
	$password = "";
	$hostname = "localhost";

	$dbhandle = mysql_connect($hostname, $username, $password) 
	or die("No es posible conectarse a MySQL");

	$seleccion = mysql_select_db("aquelo") 
	or die("Base de datos no disponible");

// Insertar sensores
	function add_sensor($detalle){
	$resultado = mysql_query("INSERT INTO `Sensor` (`id`, `tipo`, `marca`, `modelo`, `idestacion`, `observacion`, `tipo_comunicacion`, `canal`, `estado`, `potencia_soportada`, `idzona`) VALUES ('".$_POST['idSensor']."', 1, 'Soil Humidity Sensor', 'OBSoil-01', '.$estacion.', '".$_POST['observaciones']."', ".$_POST['canal'].", '".$_POST['comunicacion']."', ".$_POST['estado'].", '".$_POST['potencia']."', '".$_POST['zona']."');");		

		return "add"; 
	}

// Peticiones
	if( $_GET['peticion'] == 'sensor'){

		$resultados = add_sensor($_GET['detalle']);

	}else
		header('HTTP/1.1 405 Method Not Allowed');
		exit;
	
	echo json_encode( $resultados );
?>