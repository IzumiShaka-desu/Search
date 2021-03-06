//
//  SearchView.swift
//  gemmu
//
//  Created by Akashaka on 10/02/22.
//
#if !os(macOS)
import SwiftUI
import UIKit
import Common
public struct SearchView<DetailView: View>: View {
  @ObservedObject var presenter: SearchGamesPresenter<DetailView>
  @State private var isEditing = false
public  init(presenter: SearchGamesPresenter<DetailView>) {
    self.presenter=presenter
  }
public  var body: some View {
    ZStack(alignment: .top) {
      VStack {
        HStack(alignment: .top) {
          TextField("Search ...", text: $presenter.query )
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 10)
            .onTapGesture {
              self.isEditing = true
            }
          if isEditing {
            HStack {
              Button {
                self.presenter.searchGames()
              }
              label: {
                Image(systemName: "magnifyingglass.circle")
                  .frame(width: 40, height: 40)
              }
              Button {
                self.isEditing = false
                self.presenter.query = ""
              }
              label: {
                Text("Cancel")
              }
            }.padding(.trailing, 10)
              .transition(.move(edge: .trailing))
              .animation(.default)
          }
        }.padding(16)
        ZStack(alignment: .top) {
          Color.flatDarkBackground.ignoresSafeArea()
          VStack {
            if self.presenter.isLoading {
              ProgressView().padding(16)
            } else {
              if presenter.isError {
                Text(presenter.errorMessage)
                  .padding(16)
                  .frame( alignment: Alignment.center)
              } else {
              if let games=presenter.results {
                List(games, id: \.id) {item in
                  presenter.linkBuilder(for: item.id) {
                    ItemList(
                     title: item.name,
                     releaseDate: item.released,
                     platforms: [],
                     genres: item.genres,
                     imageUrl: item.imageUrl,
                     id: item.id
                   ).frame(
                     width: .infinity,
                     height: 150
                   )
                  }
                  .listRowBackground(Color.flatDarkBackground)

                }

              } else {
                Text("Search result empty")
              }
              }
            }
          }
        }.padding(0)
      }
    }
  }
}

#endif
