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
