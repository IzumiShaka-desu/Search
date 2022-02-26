//
//  File.swift
//  
//
//  Created by Akashaka on 25/02/22.
//

protocol RemoteDataSourceProtocol: AnyObject {
  func searchGames(for query: String) -> AnyPublisher<GamesSearchResponse, Error>
}
