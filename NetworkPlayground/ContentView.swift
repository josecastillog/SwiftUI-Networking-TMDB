//
//  ContentView.swift
//  NetworkPlayground
//
//  Created by Jose Castillo on 10/4/22.
//

import SwiftUI

private let url = "https://image.tmdb.org/t/p/w500/"

struct ContentView: View {
    
    @StateObject private var network = Network()

    var body: some View {
        ScrollView {
            Text("Movies")
                .font(.title)
                .bold()

            VStack(alignment: .leading) {
                ForEach(network.movies) { movie in
                    VStack() {
                        Text(movie.original_title)
                            .bold()
                            .font(.subheadline)
                            .padding()
                        AsyncImage(
                            url: URL(string: url + movie.poster_path),
                            content: { image in
                                image.resizable()
                                     .aspectRatio(contentMode: .fit)
                                     .frame(maxWidth: 500, maxHeight: 500)
                                     
                            },
                            placeholder: {
                                ProgressView()
                                    .frame(minWidth: 500, minHeight: 500)
                            }
                        )
                    }
                }
            }

        }
        .padding()
        .onAppear {
            network.getMovies()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .environmentObject(Network())
    }
}
