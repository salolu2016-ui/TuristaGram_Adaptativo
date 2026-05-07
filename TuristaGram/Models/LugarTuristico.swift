//
//  LugarTuristico.swift
//  TuristaGram_Adaptativo
//
//  Created by user286595 on 5/5/26.
//
// Diana Luna
// Diplomado de Diseño y Programación de Apps
// ING2450 - Programación de Apps para IOS - (A73)
// 10/05/2026
// App TuristaGram_Adaptativo

import Foundation // Importa funcionalidades básicas del sistema

// Estructura que representa un lugar turístico dentro de la aplicación
struct LugarTuristico: Identifiable {
    
    // Identificador único para cada lugar (necesario para listas en SwiftUI)
    let id = UUID()
    
    // Nombre del lugar turístico (ej: Machu Picchu)
    let nombre: String
    
    // País donde se encuentra el lugar turístico
    let pais: String
    
    // Nombre de la imagen almacenada en Assets
    let imagen: String
    
    // Coordenada de latitud del lugar (para usar en mapas)
    let latitud: Double
    
    // Coordenada de longitud del lugar (para usar en mapas)
    let longitud: Double
}
