//
//  ContentView.swift
//  TuristaGram
//
//  Created by user286595 on 4/29/26.
//
// Diana Luna
// Diplomado de Diseño y Programación de Apps
// ING2450 - Programación de Apps para IOS - (A73)
// 29/04/2026
// App TuristaGram

import SwiftUI

/// Arreglo que contiene la lista de lugares turísticos
/// Este funcionará como el "feed" de la aplicación
let lugares: [LugarTuristico] = [
    
    // Lugar turístico: Machu Picchu
    LugarTuristico(
        nombre: "Machu Picchu",          // Nombre del lugar
        pais: "Perú",                    // País
        imagen: "machupicchu",          // Nombre de la imagen en Assets
        latitud: -13.1631,               // Coordenada de latitud
        longitud: -72.5450               // Coordenada de longitud
    ),
    
    // Lugar turístico: Galápagos
    LugarTuristico(
        nombre: "Galápagos",
        pais: "Ecuador",
        imagen: "galapagos",
        latitud: -0.9538,
        longitud: -90.9656
    ),
    
    // Lugar turístico: Bariloche
    LugarTuristico(
        nombre: "Bariloche",
        pais: "Argentina",
        imagen: "bariloche",
        latitud: -41.1335,
        longitud: -71.3103
    )
]

import SwiftUI

/// Vista principal de la aplicación
struct ContentView: View {
    
    // Tomamos el primer lugar del arreglo
    let lugar = lugares[0]
    
    var body: some View {
        
        /// TabView permite navegar entre vistas con swipe (deslizamiento)
        TabView {
            
            /// Recorremos cada lugar turístico del arreglo
            ForEach(lugares) { lugar in
                
                VStack {
                    
                    // Imagen del lugar turístico
                    Image(lugar.imagen)
                        .resizable()
                        .scaledToFit()
                    
                    // Nombre del lugar
                    Text(lugar.nombre)
                        .font(.title)
                        .bold()
                    
                    // País del lugar
                    Text(lugar.pais)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
            }
        }
        .tabViewStyle(PageTabViewStyle()) // Activa el swipe tipo páginas
    }}

/// Preview para el Canvas
#Preview {
    ContentView()
}
