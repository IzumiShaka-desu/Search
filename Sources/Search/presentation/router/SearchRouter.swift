//
//  SearchRouter.swift
//  Gemmu
//
//  Created by Akashaka on 20/02/22.
//

import SwiftUI

open class SearchRouterBase {
public init() {}
 public func makeDetailView(for id: Int) -> some View {

    return DefaultView()
  }
}
 struct DefaultView: View {
  var body: some View {
    HStack {}
  }
}
