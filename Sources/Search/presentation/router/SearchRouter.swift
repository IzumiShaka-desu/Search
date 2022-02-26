//
//  SearchRouter.swift
//  Gemmu
//
//  Created by Akashaka on 20/02/22.
//

import SwiftUI

public class SearchRouterBase {

 public func makeDetailView(for id: Int) -> some View {
  
    return DefaultView()
  }
}
struct DefaultView:View{
  var body: some View{
    HStack{}
  }
}
