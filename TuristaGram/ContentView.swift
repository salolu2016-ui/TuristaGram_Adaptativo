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
        pais: "Perú - Sur America",                    // País
        imagen: "machupicchu",          // Nombre de la imagen en Assets
        latitud: -13.1631,               // Coordenada de latitud
        longitud: -72.5450               // Coordenada de longitud
    ),
    
    // Lugar turístico: Galápagos
    LugarTuristico(
        nombre: "Galápagos",
        pais: "Ecuador - Sur America",
        imagen: "galapagos",
        latitud: -0.9538,
        longitud: -90.9656
    ),
    
    // Lugar turístico: Bariloche
    LugarTuristico(
        nombre: "Bariloche",
        pais: "Argentina - Sur America",
        imagen: "bariloche",
        latitud: -41.1335,
        longitud: -71.3103
    )
]

import SwiftUI
import PhotosUI
import MapKit

/// Vista principal de la aplicación
struct ContentView: View {
    
    // Estado para manejar selección de imagen de galería
    @State private var selectedItem: PhotosPickerItem?
    
    var body: some View {
        
        VStack {
            
            // HEADER PERSONALIZADO
            ZStack {
                
                // Fondo degradado (estilo cielo)
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.cyan]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 120)
                .cornerRadius(15)
                
                // Ícono decorativo (avión)
                Image(systemName: "airplane")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .offset(x: 80, y: -20)
                
                // Título de la app
                Text("TuristaGram")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
            }
            .padding()
            
            /// Swipe entre lugares (tipo Instagram)
            TabView {
                
                /// Recorremos cada lugar turístico
                ForEach(lugares) { lugar in
                    
                    VStack {
                        
                        // Imagen del lugar
                        Image(lugar.imagen)
                            .resizable()
                            .scaledToFit()
                        
                        // Nombre
                        Text(lugar.nombre)
                            .font(.title)
                            .bold()
                        
                        // País
                        Text(lugar.pais)
                            .foregroundColor(.gray)
                        
                        // BOTÓN GALERÍA
                        PhotosPicker(selection: $selectedItem, matching: .images) {
                            Label("Abrir galería", systemImage: "photo")
                        }
                        .padding()
                        
                        // BOTÓN MAPA
                        Button(action: {
                            abrirMapa(lat: lugar.latitud, lon: lugar.longitud)
                        }) {
                            Label("Ver en mapa", systemImage: "map")
                        }
                        .padding()
                    }
                    .padding()
                }
            }
            .tabViewStyle(PageTabViewStyle()) // Activa swipe
        }
    }
}

/// Función para abrir Apple Maps (forma correcta y compatible)
func abrirMapa(lat: Double, lon: Double) {
    
    // Coordenadas del lugar
    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
    
    // Crear directamente el mapItem con placemark
    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
    
    mapItem.name = "Ubicación turística"
    
    // Abrir en Apple Maps
    mapItem.openInMaps()
}

/// Preview para el Canvas
#Preview {
    ContentView()
}
