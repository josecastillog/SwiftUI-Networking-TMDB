//
//  Network.swift
//  NetworkPlayground
//
//  Created by Jose Castillo on 10/4/22.
//

import SwiftUI

private let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=9b7e6dd0b1cfe55ebf02965286facb77"

class Network: ObservableObject {
    
    @Published var movies: [Movie] = []

    func getMovies() {
        
        guard let url = URL(string: url) else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedMovies = try JSONDecoder().decode(Root.self, from: data)
                        self.movies = decodedMovies.results
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
}
