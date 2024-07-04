import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    @State private var trackingMode: MapUserTrackingMode = .follow

    var body: some View {
        Map(coordinateRegion: $viewModel.region,
            showsUserLocation: true,
            userTrackingMode: $trackingMode,
            annotationItems: viewModel.markers) { marker in
                MapAnnotation(coordinate: marker.coordinate) {
                    VStack {
                        Image(systemName: marker.systemImage)
                            .foregroundColor(marker.color)
                        Text(marker.title)
                            .font(.caption)
                    }

                }
            }
        
            .edgesIgnoringSafeArea(.top)
            .overlay(
                Color.blue.opacity(0.2)
                .allowsHitTesting(false)
                .edgesIgnoringSafeArea(.top)
            )
        
    }
}

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    @Published var region = MKCoordinateRegion()
    @Published var markers: [Marker] = []

    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        self.locationManager!.delegate = self
        self.locationManager!.requestWhenInUseAuthorization() // Solicitar permissão imediatamente
        setupMarkers() // Inicializando marcadores
    }
    
    func setupMarkers() {
        markers = [
            Marker(title: "Aquario", systemImage: "mappin.and.ellipse.circle.fill", coordinate: CLLocationCoordinate2D(latitude: -22.893102, longitude: -43.192819), color: .blue),
            Marker(title: "Casa Marlin", systemImage: "fish.circle.fill", coordinate: CLLocationCoordinate2D(latitude: -22.957320, longitude: -43.176147), color: .orange),
            Marker(title: "Crush", systemImage: "tortoise.circle.fill", coordinate: CLLocationCoordinate2D(latitude: -22.982353, longitude: -43.216690), color: .green),
            // Adicione mais marcadores conforme necessário
        ]
    }
    
    @MainActor
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            // Implementar tratamento para quando a permissão é negada ou restrita
            break
        case .authorizedAlways, .authorizedWhenInUse:
            if let location = manager.location {
                self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            }
        @unknown default:
            break
        }
    }
}

struct Marker: Identifiable { // Definindo uma estrutura para os marcadores
    let id = UUID()
    var title: String
    var systemImage: String
    var coordinate: CLLocationCoordinate2D
    var color: Color
}


#Preview {
    MapView()
}
