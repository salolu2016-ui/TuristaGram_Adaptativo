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
import PhotosUI
import MapKit

/// Arreglo que contiene la lista de lugares turísticos
let lugares: [LugarTuristico] = [
    
    LugarTuristico(
        nombre: "Machu Picchu",
        pais: "Perú - Sur America",
        imagen: "machupicchu",
        latitud: -13.1631,
        longitud: -72.5450
    ),
    
    LugarTuristico(
        nombre: "Galápagos",
        pais: "Ecuador - Sur America",
        imagen: "galapagos",
        latitud: -0.9538,
        longitud: -90.9656
    ),
    
    LugarTuristico(
        nombre: "Bariloche",
        pais: "Argentina - Sur America",
        imagen: "bariloche",
        latitud: -41.1335,
        longitud: -71.3103
    )
]

/// Vista principal de la aplicación
struct ContentView: View {
    
    // Estado para manejar selección de imagen
    @State private var selectedItem: PhotosPickerItem?
    
    // Diccionario para guardar calificaciones por lugar
    @State private var calificaciones: [String: String] = [:]
    
    var body: some View {
        
        GeometryReader { geometry in
            
            let isIpad = geometry.size.width > 700
            
            VStack(spacing: 20) {
                
                // HEADER
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.15))
                    
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.cyan]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 120)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    
                    Image(systemName: "airplane")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .offset(x: 80, y: -20)
                    
                    Text("TuristaGram")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                }
                .padding()
                
                // SWIPE ENTRE LUGARES
                TabView {
                    
                    ForEach(lugares) { lugar in
                        
                        VStack {
                            
                            // Imagen
                            Image(lugar.imagen)
                                .resizable()
                                .frame(
                                    maxWidth: isIpad ? geometry.size.width * 0.6 : geometry.size.width * 0.95,
                                    maxHeight: isIpad ? geometry.size.height * 0.37 : geometry.size.height * 0.80
                                )
                                .cornerRadius(15)
                            
                            // Nombre
                            Text(lugar.nombre)
                                .font(isIpad ? .largeTitle : .largeTitle)
                                .bold()
                            
                            // País
                            Text(lugar.pais)
                                .font(isIpad ? .largeTitle : .body)
                            
                            // BOTÓN GALERÍA
                            PhotosPicker(selection: $selectedItem, matching: .images) {
                                
                                Label("Galería", systemImage: "photo.fill")
                                    .font(.system(size: 24))
                                    .frame(maxWidth: isIpad ? 250 : 150)
                                    .padding(20)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color.blue.opacity(0.2))
                                    )
                            }
                            .padding(.horizontal)
                            
                            // BOTÓN MAPA
                            Button(action: {
                                
                                abrirMapa(lat: lugar.latitud, lon: lugar.longitud)
                                
                            }) {
                                
                                Label("Mapa", systemImage: "map.fill")
                                    .font(.system(size: 24))
                                    .frame(maxWidth: isIpad ? 250 : 150)
                                    .padding(20)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color.green.opacity(0.2))
                                    )
                            }
                            .padding(.horizontal)
                            
                            // CALIFICACIÓN
                            VStack(spacing: isIpad ? 48 : 18) {
                                
                                Text("¿Cómo calificas este destino?")
                                    .font(.system(size: 24))
                                
                                HStack(spacing: 40) {
                                    
                                    ForEach([
                                        "hand.thumbsup.fill",
                                        "hand.thumbsdown.fill"
                                    ], id: \.self) { emoji in
                                        
                                        Button {
                                            
                                            // Guardar calificación del lugar actual
                                            calificaciones[lugar.nombre] = emoji
                                            
                                        } label: {
                                            
                                            VStack {
                                                
                                                // Emoji
                                                Image(systemName: emoji)
                                                    .font(.system(size: isIpad ? 50 : 26))
                                                
                                                // Indicador visual
                                                Image(
                                                    systemName:
                                                        calificaciones[lugar.nombre] == emoji
                                                    ? "circle.fill"
                                                    : "circle"
                                                )
                                                .font(.system(size: 12))
                                                .foregroundColor(.blue)
                                            }
                                        }
                                    }
                                }
                                .padding(23)
                                .background(
                                    RoundedRectangle(cornerRadius: 23)
                                        .fill(Color.cyan.opacity(0.19))
                                )
                            }
                            .padding(.top, 2)
                            .padding(.bottom)
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        .padding(.bottom, 5)
                    }
                }
                .frame(height: geometry.size.height * 0.82)
                .tabViewStyle(PageTabViewStyle())
            }
        }
    }
}

/// Función para abrir Apple Maps
func abrirMapa(lat: Double, lon: Double) {
    
    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
    
    let mapItem = MKMapItem(
        placemark: MKPlacemark(coordinate: coordinate)
    )
    
    mapItem.name = "Ubicación turística"
    
    mapItem.openInMaps()
}

/// Preview
#Preview {
    ContentView()
}
