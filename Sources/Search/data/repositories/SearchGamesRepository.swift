//
//  File.swift
//  
//
//  Created by Akashaka on 25/02/22.
//

import Combine
import Foundation
public protocol SearchGamesRepositoryProtocol {
  func searchGames(for query: String) -> AnyPublisher<GamesSearchEntity, Error>
}
public final class SearchGamesRepository: NSObject {
  typealias GamesInstance = (SearchRemoteDataSource) -> SearchGamesRepository

  fileprivate let remote: SearchRemoteDataSource
  private init( remote: SearchRemoteDataSource) {
    self.remote = remote
  }

 public static let sharedInstance: GamesInstance = {remoteRepo in
    return SearchGamesRepository(remote: remoteRepo)
  }

}
public extension SearchGamesRepository: SearchGamesRepositoryProtocol {
  public func searchGames(for query: String) -> AnyPublisher<GamesSearchEntity, Error> {
    return self.remote
      .searchGames(for: query)
      .map({$0.toEntity()})
      .eraseToAnyPublisher()
  }
}
