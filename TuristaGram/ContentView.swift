//
//  ContentView.swift
//  TuristaGram_Adaptativo
//
//  Created by user286595 on 5/5/26.
//
// Diana Luna
// Diplomado de Diseño y Programación de Apps
// ING2450 - Programación de Apps para IOS - (A73)
// 10/05/2026
// App TuristaGram_Adaptativo

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
    
    // Estado que almacena el emoji seleccionado por el usuario
    @State private var selectedEmoji = "😐"
    
    var body: some View {
        
        // GeometryReader permite adaptar dinámicamente la interfaz
        // según el tamaño y orientación de la pantalla
        // Contenedor adaptativo para iPhone y iPad
        GeometryReader { geometry in
            
            // Contenedor vertical principal con separación adaptable
            //entre secciones
            
            VStack(spacing: 20) {
                
                // HEADER PERSONALIZADO
                ZStack  {
                    
                    // Tarjeta visual con bordes redondeados y
                    //transparencia
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.15))
                    
                    // Fondo degradado (estilo cielo)
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.cyan]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 120)
                    
                    // Bordes redondeados y sombra para mejorar la
                    //profundidad visual
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    
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
                            
                            // Imagen adaptable según tamaño de pantalla
                            Image(lugar.imagen)
                                .resizable()
                                //.scaledToFit()
                                .frame(
                                    maxWidth: geometry.size.width * 0.88,
                                    maxHeight: geometry.size.height * 0.29
                                )
                            
                            
                                .cornerRadius(15)
                            
                            // Nombre
                            Text(lugar.nombre)
                                .font(.title)
                                .bold()
                            
                            // País
                            Text(lugar.pais)
                                .foregroundColor(.gray)
                            
                            // Botón para abrir la galería de imágenes
                            PhotosPicker(selection: $selectedItem, matching: .images) {
                                
                                Label("Galería", systemImage: "photo.fill")
                                    .font(.headline)
                                    .frame(maxWidth: 150)
                                    .padding(14)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color.blue.opacity(0.2))
                                    )
                            }
                            .padding(.horizontal)
                            
                            // Botón para abrir la ubicación en Apple Maps
                            Button(action: {
                                
                                abrirMapa(lat: lugar.latitud, lon: lugar.longitud)
                                
                            }) {
                                
                                Label("Mapa", systemImage: "map.fill")
                                    .font(.headline)
                                    .frame(maxWidth: 150)
                                    .padding(14)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color.green.opacity(0.2))
                                    )
                            }
                            .padding(.horizontal)
                            
                            // Área interactiva de satisfacción del usuario
                            VStack(spacing: 18) {
                                
                                // Título de la sección
                                Text("¿Cómo calificas este destino?")
                                    .font(.headline)
                                
                                // Contenedor horizontal de emojis
                                HStack(spacing: 25) {
                                    
                                    // Emojis interactivos
                                    ForEach([
                                        "hand.thumbsup.fill",
                                        "hand.thumbsdown.fill"
                   
                                    ], id: \.self)  { emoji in
                                        
                                        Button {
                                            
                                            // Guarda emoji seleccionado
                                            selectedEmoji = emoji
                                            
                                        } label: {
                                            
                                            VStack {
                                                
                                                // Emoji principal
                                                Image(systemName: emoji)
                                                    .font(.system(size: 24))
                                                
                                                // Indicador visual
                                                Image(
                                                    systemName:
                                                        selectedEmoji == emoji
                                                    ? "circle.fill"
                                                    : "circle"
                                                )
                                                .font(.system(size: 12))
                                                .foregroundColor(.blue)
                                            }
                                        }
                                    }
                                }
                                .padding(18)
                                .background(
                                    RoundedRectangle(cornerRadius: 18)
                                        .fill(Color.blue.opacity(0.13))
                                )
                            }
                            .padding(.top, 4)
                        }
                        
                      
                        // Espaciado inferior para evitar superposición con PageControl
                        .padding(.horizontal)
                        .padding(.top)
                        .padding(.bottom, 5)
                        
                    }
                }
                
                .frame(height: geometry.size.height * 0.83)
                .tabViewStyle(PageTabViewStyle())
            }
            
            
            
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
