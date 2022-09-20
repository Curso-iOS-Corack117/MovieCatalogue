//
//  SwiftUIView.swift
//  exam
//
//  Created by Sergio Ordaz Romero on 19/09/22.
//

import SwiftUI

struct MoviewDetailView: View {
    @State var movie: Movies.Movie
    @State private var didTap:Bool = false
    @ObservedObject var imageManager: ImageManager
    @EnvironmentObject var movieManager: MovieManager
    
    init(movie: Movies.Movie) {
        self.movie = movie
        self.imageManager = ImageManager(imageName: movie.poster_path, backdropName: movie.backdrop_path)
    }
    
    var body: some View {
        ZStack {
            Color(.gray)
                .ignoresSafeArea()
            VStack {
                Image(uiImage: imageManager.backdrop ?? UIImage())
                    .resizable()
                    .frame(minWidth:300, maxWidth: 1200, minHeight: 200, maxHeight: 1000)
                    .scaledToFit()
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .frame(width: nil, height: 4, alignment: .top)
                            .foregroundColor(.orange)
                    }
                    .shadow(radius: 7, y: 7)
                Image(uiImage: imageManager.image ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150, alignment: .top)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.orange, lineWidth: 4)
                    }
                    .shadow(radius: 10)
                    .offset(y: -50)
                VStack(alignment: .leading) {
                    HStack {
                        Text(movieManager.currentMovie?.title ?? movie.title)
                            .font(.title)
                        Spacer()
                        HStack(spacing: 0) {
                            Group {
                                Button("en") {
                                    movieManager.fetchMovie(
                                        withLanguage: MovieManager.MovieLanguage.english.tag,
                                        movieID: movie.id
                                    )
                                }
                                Button("es") {
                                    movieManager.fetchMovie(
                                        withLanguage: MovieManager.MovieLanguage.español.tag,
                                        movieID: movie.id
                                    )
                                }
                                Button("fr") {
                                    movieManager.fetchMovie(
                                        withLanguage: MovieManager.MovieLanguage.français.tag,
                                        movieID: movie.id
                                    )
                                }
                            }
                            .frame(width: 20)
                            .padding(7)
                            .background(.orange)
                        }
                        .cornerRadius(5)
                    }
                    Divider()
                        .frame(height: 2)
                        .overlay(.orange)
                    JustifiedText(movieManager.currentMovie?.overview ?? movie.overview)
                        
                }
                .foregroundColor(Color("movieForegroundColor"))
                .offset(y: -30)
                .padding([.leading, .trailing])
            }
            .padding(.bottom)
            .frame(maxWidth: 800)
        .ignoresSafeArea()
        }
        .onAppear {
            movieManager.currentMovie = movie
        }
    }
}

struct ContentLengthPreference: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        let movie: Movies.Movie = .init(id: 1, title: "El padrino", original_title: "Tìtulo", original_language: "es-MX", popularity: 10, overview: "Don Vito Corleone, conocido dentro de los círculos del hampa como 'El Padrino', es el patriarca de una de las cinco familias que ejercen el mando de la Cosa Nostra en Nueva York en los años cuarenta. Don Corleone tiene cuatro hijos: una chica, Connie, y tres varones; Sonny, Michael y Fredo. Cuando el Padrino reclina intervenir en el negocio de estupefacientes, empieza una cruenta lucha de violentos episodios entre las distintas familias del crimen organizado.", poster_path: "/ppd84D2i9W8jXmsyInGyihiSyqz.jpg", backdrop_path: "/tmU7GeKVybMWFButWEGl2M4GeiP.jpg", vote_average: 10)
        
        let _: UserSettings = UserSettings()
        let movieManager: MovieManager = MovieManager(loadFetchData: true)
        MoviewDetailView(movie: movie)
            .environmentObject(movieManager)
    }
}
