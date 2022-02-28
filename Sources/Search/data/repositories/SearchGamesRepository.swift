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
 public typealias GamesInstance = (SearchRemoteDataSourceProtocol) -> SearchGamesRepository

  fileprivate let remote: SearchRemoteDataSourceProtocol
  private init( remote: SearchRemoteDataSourceProtocol) {
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
