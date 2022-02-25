//
//  SearchItemResultEntity.swift
//  Gemmu
//
//  Created by Akashaka on 18/02/22.
//
public struct SearchItemResultEntity: Equatable, Identifiable {
 public let id: Int
 public  let name: String
 public let imageUrl: String
 public let released: String
 public let genres: [String]
}

public extension SearchItemResult {
   func toEntity() -> SearchItemResultEntity {
    return SearchItemResultEntity(
      id: self.id,
      name: self.name ,
      imageUrl: self.backgroundImage ?? "",
      released: self.released ?? "",
      genres: self.extractGenreName()
    )
  }
    func extractPlatformsName() -> [String] {
        var results: [String]=[]
        for platform in self.platforms {
            results.append(platform.platform.slug)
        }
        return results
    }
     func extractGenreName() -> [String] {
        var results: [String]=[]
        for genre in self.genres {
            results.append(genre.name)
        }
        return results
    }

}
