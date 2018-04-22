<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<body>
	<form action="registrar/sensor/a" method="POST">
		<input type="text" name="idSensor" placeholder="idSensor"><br>
		<textarea type="text" name="observaciones" placeholder="observacion"></textarea><br>
		<input type="text" name="comunicacion" placeholder="comunicacion: (1 Analogica, 0 digital)"><br>
		<input type="number" name="estado" placeholder="estado: (1 activo, 0 inactivo)"><br>
		<input type="number" name="canal" placeholder="canal"><br>
		<input type="text" name="potencia" placeholder="Potencia soportada"><br>
		<input type="text" name="zona" placeholder="zona"><br>

		<br>
		<input type="submit" value="registrar">
	</form>
</body>
</html>