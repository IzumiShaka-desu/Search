//
//  File.swift
//  
//
//  Created by Akashaka on 25/02/22.
//
import Combine
import Alamofire
import Foundation
import Common
public protocol SearchRemoteDataSourceProtocol: AnyObject {
  func searchGames(for query: String) -> AnyPublisher<GamesSearchResponse, Error>
}
public final class SearchRemoteDataSource: NSObject {

  private override init() { }
 public static let sharedInstance: SearchRemoteDataSource =  SearchRemoteDataSource()

}
extension SearchRemoteDataSource: SearchRemoteDataSourceProtocol {
 public func searchGames(for query: String) -> AnyPublisher<GamesSearchResponse, Error> {
    if #available(macOS 10.15, *) {
      return Future<GamesSearchResponse, Error> { completion in
        if let url = API.buildUrl(endpoint: .games, args: ["search": query]) {
          AF.request(url)
            .validate()
            .responseDecodable(of: GamesSearchResponse.self) { response in
              switch response.result {
              case .success(let value):
                completion(.success(value))
              case .failure:
                completion(.failure(URLError.invalidResponse))
              }
            }
        }
      }.eraseToAnyPublisher()
    } else {
      // Fallback on earlier versions
    }
  }

}
