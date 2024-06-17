//
//  ContentView.swift
//  MyMovies
//
//  Created by Paul Hudson on 12/05/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var movieResults = MovieResults(results: [])
    
    var body: some View {
        Text("Hello World")
    }
    
    func getMovies() {
        URLSession.shared.get(path: "movie/popular", queryItems: [:], defaultValue: MovieResults(results: []), completion: { results in
            movieResults = results
        })
    }
}

#Preview {
    ContentView()
}

