//*********************Librerías**********************
#include <Bridge.h> // Libreria del puente
#include <HttpClient.h> // Libreria de HTTP
#include <DHT.h>
#include <Adafruit_Sensor.h>
#include <DHT_U.h>
//****************************************************

//*********************Configuración del pineado entrada/salida**********************
//Pines para sensores (analogico)
#define SH1 A0
#define SH2 A1
#define SH3 A2
//Pines para reles  (digital)
#define RL1 7
#define RL2 6
#define RL3 5
//**********************************************************************************

//*********************Variables****************************************************

HttpClient client; // Iniciamos libreria

//Estado inicial de los relés
//[0]: relé activo o inactivo, 1 o 0 respectivamente
//[1]: duración de la activación en minutos, la activación puede haber sido por calendario
//     o por una regla
//[2]: estado de activación por Arduino
int rle[3][3]={{0,30,0},{0,30,0},{0,30,0}};


long int timer[3]={0,0,0}; //temporizadores de activación por relés

int retardo=500; //retardo entre operaciones

//**********************************************************************************

void setup() {
  Bridge.begin();
  SerialUSB.begin(9600);
  while (!SerialUSB); // wait for a serial connection
  
  //configuración del pineado para sensores
  pinMode(SH1, INPUT);
  pinMode(SH2, INPUT);
  pinMode(SH3, INPUT);

  //configuración del pineado para relés
  pinMode(RL1, OUTPUT);
  pinMode(RL2, OUTPUT);
  pinMode(RL3, OUTPUT);

  digitalWrite(RL1, HIGH); // Activamos

}

void loop() {
  //enviarMedidas(recogerMedidas());// Se envian las medidas de sensores

  recibeEstados("DST_RL_1"); // Reciben los estados actuales del primer relé según reglas
  delay(retardo);
  recibeEstados("DST_RL_2"); // Reciben los estados actuales del primer relé según reglas
  delay(retardo);
  recibeEstados("DST_RL_3"); // Reciben los estados actuales del primer relé según reglas
  delay(retardo);

  compruebaEstados(); // Comprobamos para activar reles
  delay(1000); // Retardo de 1 segundos
}

/**
 * Comprobamos si el estado del rele (arduino) corresponde al real (BD)
 */
void compruebaEstados(){
 for(int i=0;i<3;i++){
  if(rle[i][0]) { // Comprobamos si tenemos que activar
    SerialUSB.println("a");
    if(timer[i]<rle[i][1]){ // Si el tiempo transcurrido es menor al tiempo insertado
      if(rle[i][2]==0){ // Si no esta regando
        if(i="0"){
          digitalWrite(RL1, LOW); // Activamos
        }
        if(i="1"){
          digitalWrite(RL2, LOW); // Activamos
        }
        if(i="2"){
          digitalWrite(RL3, LOW); // Activamos
        }
        rle[i][2]=1; // Cambiamos para activarlo
      }
      timer[i]+=1;
    }else{
      timer[i]=0; // reiniciamos temporizador
      SerialUSB.println("Desactivo");
      if(i="0"){
            digitalWrite(RL1, HIGH); // Activamos
      }
      if(i="1"){
            digitalWrite(RL2, HIGH); // Activamos
      }
      if(i="2"){
            digitalWrite(RL3, HIGH); // Activamos
      }
      SerialUSB.flush(); // Liberamos 
      
      rle[i][2]=0; // cambiamos estado
    }
   }else{
          rle[i][2]=0; // cambiamos estado

   }
  }
}

/**
 * Recibimos el estado de los reles para regar o no 
 */
void recibeEstados(String rele){
  String estados;
  client.get("http://aquelo.romsanbryan.x10host.com/API/obtener/estados/"+rele); // Ruta

  // Leemos datos y vamos pintando en pantalla
  while (client.available()) {
    char c = client.read();
    estados.concat(c);
  }
  int  pos = estados.indexOf(',');
  if(pos<0) return;
  int i = -1;
  if(rele == "DST_RL_1"){
    i = 0;
  }
  if(rele == "DST_RL_2"){
    i = 1;
  }
  if(rele == "DST_RL_3"){
    i = 2;
  }

  rle[i][0]=estados.substring(0,1).toInt();
  rle[i][1]=estados.substring(2).toInt();
}

/**
 * Recogemos medidas
 * 
 * @return cadena con las medidas
 */

String recogerMedidas(){
  
  int valorHumedad = map(analogRead(SH1), 0, 1023, 100, 0);
  int valorHumedad2 = map(analogRead(SH2), 0, 1023, 100, 0);
  int valorHumedad3 = map(analogRead(SH3), 0, 1023, 100, 0);

  String medidas="SH1,";
   medidas.concat(valorHumedad);
   medidas.concat("$SH2,");
   medidas.concat(valorHumedad2);
   medidas.concat("$SH3,");
   medidas.concat(valorHumedad3);

   return medidas;
}



/**
 * Enviamos medidas recogida por los sensores
 */
void enviarMedidas(String medidas){
  
  client.get("http://aquelo.romsanbryan.x10host.com/API/registrar/"+medidas+"/a"); // Ruta: nombre de medida 2, valor 20

  while (client.available()) {   // Leemos datos y vamos pintando en pantalla
    char c = client.read();
    SerialUSB.print(c);
  }
  SerialUSB.flush(); // Liberamos 
}

