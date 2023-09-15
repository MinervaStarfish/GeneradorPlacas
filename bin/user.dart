import '../bin/funciones.dart';

// Mapa para los datos de la persona que registra
Map<String, dynamic> user = {
  'Nombre': preguntador('¿Cuál es su nombre?', 3),
  'Identificación': preguntador('¿Cuál es su número de identificación', 1),
  'Edad': preguntador('¿Cual es su edad?', 1),
  'Cantidad de placas' : preguntador('¿Cuantas placas desea asignar?', 1),
};

// Lista para los nombres de los propietarios 
final List<dynamic> owner = ['Julián', 'Juan', 'Ramiro', 'Sofía', 'Mariana', 'Angelica', 'Catalina'];