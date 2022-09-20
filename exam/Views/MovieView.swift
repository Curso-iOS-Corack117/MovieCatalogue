//
//  MovieView.swift
//  exam
//
//  Created by Sergio Ordaz Romero on 16/09/22.
//

import SwiftUI

struct MovieView: View {
    let movie: Movies.Movie
    @ObservedObject var imageManager: ImageManager
    
    init(movie: Movies.Movie) {
        self.movie = movie
        imageManager = ImageManager(imageName: self.movie.poster_path)
    }
    
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
                    Text(
                        String(
                            format: "popularity %@ of 100".localizedString,
                            movie.popularity_value
                        )
                    )
                    Text(
                        String(
                            format: "vote_average %@ of 100".localizedString,
                            movie.vote_average_value
                        )
                    )
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
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        let movie = Movies.Movie(id: 1, title: "Tìtulo", original_title: "Tìtulo", original_language: "es-MX", popularity: 10, overview: "Descripcion", poster_path: "/htuuuEwAvDVECMpb0ltLLyZyDDt.jpg", backdrop_path: "/tmU7GeKVybMWFButWEGl2M4GeiP.jpg", vote_average: 10)
        
        MovieView(movie: movie)
            .previewLayout(.sizeThatFits)
    }
}
