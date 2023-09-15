import 'dart:io';
import 'dart:math';
import 'vehiculo.dart';
import '../bin/util.dart';
import 'user.dart';

//Función para preguntar
dynamic preguntador(String? pregunta, int type) {
  print(pregunta);
  String? dato = stdin.readLineSync();

  switch (type) {
    case 1: //Espera un int
      try {
        return int.parse(dato ?? '0');
      } on FormatException {
        return 0;
      }
    case 2: //Espera un double
      return double.parse(dato ?? '0.0');
    case 3: //Espera un String de nombre
      return dato ?? 'NoName';
    case 4: //Espera un String de siglo
      return dato ?? 'XVIII';
    default: //Espera un String cualquiera
      return dato ?? '';
  }
}

// Función para sacar el siglo
int? century() {
  int siglo = (vehiculo['Año de fabricación'] / 100).ceil() + 1;
  return siglo;
}

// Función para primera letra
String? firstPlaca() {
  String firstLetter;

  if (vehiculo['Año de fabricación'] >= 2000 &&
      vehiculo['Año de fabricación'] <= 2021) {
    firstLetter = alphabet[vehiculo['Año de fabricación'] - 2000];
  } else if (vehiculo['Año de fabricación'] >= 1900 &&
      vehiculo['Año de fabricación'] <= 1999) {
    switch (century()! + 100 - vehiculo['Año de fabricación']) {
      case 17:
        firstLetter = 'W';
        break;
      case 18:
        firstLetter = 'X';
        break;
      case 19:
        firstLetter = 'Y';
        break;
      case 20:
        firstLetter = 'Z';
        break;
      default:
        firstLetter = '';
    }
  } else {
    // Si el año está fuera de rango, mostrar un error
    print('Error: el año debe estar entre 1900 y 2023.');
    return '';
  }
  return firstLetter;
}

// Función para segunda letra
String secondPlaca() {
  if (vehiculo['Potencia del vehiculo'] < 10 ||
      vehiculo['Potencia del vehiculo'] > 260) {
    throw Exception("El número debe estar entre 10 y 260");
  }

  int letterIndex = (vehiculo['Potencia del vehiculo'] - 10) ~/ 10;
  String secondLetter = String.fromCharCode(65 + letterIndex);
  return secondLetter;
}

// Función para el propietario random
String getRandomName() {
  final random = Random();
  final index = random.nextInt(owner.length);
  return owner[index];
}

// Función para buscar parámetros de la placa
void buscarPlaca(String placa) {
  // Extraer las letras y números de la placa
  String firstLetter = placa.substring(0, 1);
  String secondLetter = placa.substring(1, 2);
  String colchon = placa.substring(2, 3);
  String numero = placa.substring(3);

  // Verificar si la placa existe en el sistema
  if (firstLetter != firstPlaca() || secondLetter != secondPlaca()) {
    print('La placa $placa no se encuentra registrada en el sistema.');
    return;
  }

  // Obtener la fecha del vehículo
  int year = 0;
  if (colchon.compareTo('A') >= 0 && colchon.compareTo('V') <= 0) {
    int position = alphabet.indexOf(colchon);
    year = position + 2000;
  } else if (colchon.compareTo('W') >= 0 && colchon.compareTo('Z') <= 0) {
    switch (colchon) {
      case 'W':
        year = 1700;
        break;
      case 'X':
        year = 1800;
        break;
      case 'Y':
        year = 1900;
        break;
      case 'Z':
        year = 2000;
        break;
      default:
        throw Exception('Letra inválida.');
    }
  } else {
    throw Exception('Letra inválida.');
  }

  // Obtener la potencia del vehículo
  int letterIndex = secondLetter.codeUnitAt(0) - 65;
  int potencia = (letterIndex * 10) + 10;
  if (potencia < 10 || potencia > 260) {
    throw Exception("El número debe estar entre 10 y 260");
  }

  // Mostrar los parámetros del vehículo obtenidos
  print('Placa: $placa');
  print('Año de fabricación: $year');
  print('Potencia del vehículo: $potencia');
  print('Propietario: ${getRandomName()}');
}
