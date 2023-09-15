import 'dart:io';
import 'dart:math';

import 'package:punto2_mariana_osorio/punto2_mariana_osorio.dart'
    as punto2_mariana_osorio;

import 'funciones.dart';
import 'user.dart';
import 'util.dart';
import 'vehiculo.dart';

void main(List<String> arguments) {
  int? opcion;

  do {
    print(
        '\nBienvenido a *Inserte nombre*\nPor favor seleccione la opción que más se ajuste a sus necesidades:');
    print(
        '1. Registrar una placa (Solo se pueden placas desde el siglo 17 hasta el 2021).');
    print(
        '2. Buscar información de una placa (Solo se puede buscar información de una placa ya registrada).');
    print('3. Salir.');

    opcion = int.parse(stdin.readLineSync() ?? '0');
    String? firstLetter = firstPlaca();
    String secondLetter = secondPlaca();
    String name = getRandomName();

    switch (opcion) {
      case 1:
        if (user['Edad'] < 18) {
          print('Lo siento, Solo puedes asignar placas si eres mayor de edad.');
          exit(0);
        } else {
          var cantidadPlacas = user['Cantidad de placas'];
          var maxNum = cantidadPlacas == null || cantidadPlacas > 999
              ? 999
              : cantidadPlacas;

          for (var i = 1; i <= maxNum; i++) {
            var numero = i
                .toString()
                .padLeft(3, '0'); // Me imprime números del 001 al 999
            var letraIndex = ((i - 1) ~/ 26) %
                26; // Hace la operación de seleccionar solo una letra del abcdario
            var letra = alphabet[
                letraIndex]; // Usa esa letra seleccionada en string de alfabeto
            print(
                '$firstLetter$secondLetter$letra$numero -> Registrado por ${user['Nombre']}. Propiedad de $name');

            if (letra == 'Z' && i == 999) {
              break;
            }
          }
        }

        break;

      case 2:
        print('Ingrese la placa que desea buscar:');
        String placa = stdin.readLineSync() ?? '';
        buscarPlaca(placa);
        break;

      default:
        0;
    }
  } while (opcion != 3);
  exit(0);
}
