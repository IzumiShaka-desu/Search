//
//  SearchGamesPresenter.swift
//  Gemmu
//
//  Created by Akashaka on 19/02/22.
//

import SwiftUI
import Combine

public class SearchGamesPresenter<DetailView: View>: ObservableObject {

  private var cancellables: Set<AnyCancellable> = []
  let router: ((_ id: Int) -> DetailView)
  private let searchUseCase: SearchGamesUseCase

  @Published var results: [SearchItemResultEntity] = []
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  @Published var isError: Bool = false
  @Published var query = ""

 public init(searchUseCase: SearchGamesUseCase, router: @escaping ((Int) -> DetailView)) {
    self.searchUseCase = searchUseCase
    self.router = router
  }

 public  func searchGames() {
    isLoading = true
    searchUseCase.searchGames(for: query)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.isError = true
          self.isLoading = false
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { result in
        self.isError = false
        self.errorMessage = ""
        self.results=result.results
      })
      .store(in: &cancellables)
  }

  func linkBuilder<Content: View>(
    for id: Int,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
      destination: self.router(id)) { content() }
    .padding(0)
    .buttonStyle(PlainButtonStyle())
  }

}
