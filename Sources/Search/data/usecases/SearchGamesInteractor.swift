//
//  SearchGamesInteractor.swift
//  Gemmu
//
//  Created by Akashaka on 18/02/22.
//

import Foundation
import Combine

public protocol SearchGamesUseCase {

  func searchGames(for: String) -> AnyPublisher<GamesSearchEntity, Error>

}

public class SearchGamesInteractor: SearchGamesUseCase {

  private let repository: SearchGamesRepositoryProtocol
  
  public required init(repository: SearchGamesRepositoryProtocol) {
    self.repository = repository
  }
  
 public func searchGames(for query: String) -> AnyPublisher<GamesSearchEntity, Error> {
    return repository.searchGames(for: query)
  }

}
