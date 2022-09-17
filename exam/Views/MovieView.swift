//
//  MovieView.swift
//  exam
//
//  Created by Sergio Ordaz Romero on 16/09/22.
//

import SwiftUI

struct MovieView: View {
    let movie: Movies.Movie
    @ObservedObject var imageManager = ImageManager()
    
    var body: some View {
        HStack {
            Image(uiImage: imageManager.image ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.orange, lineWidth: 1)
                }
            VStack {
                Group {
                    Text(movie.title)
                        .font(.headline)
                    Text("Popularidad \(movie.popularity_value) / 100")
                    Text("Promedio de votos \(movie.vote_average_value) / 100")
                }
                .font(.subheadline)
                .foregroundColor(Color("movieForegroundColor"))
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding()
            .background(Color("movieCardColor"))
            .cornerRadius(5)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.orange, lineWidth: 1)
            }
        }
        .frame(height: 100)
        .onAppear {
            imageManager.loadImage(imageName: movie.poster_path)
        }
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        let movie = Movies.Movie(id: 1, title: "Tìtulo", original_title: "Tìtulo", original_language: "es-MX", popularity: 10, overview: "Descripcion", poster_path: "/htuuuEwAvDVECMpb0ltLLyZyDDt.jpg", vote_average: 10)
        
        MovieView(movie: movie)
            .previewLayout(.sizeThatFits)
    }
}
