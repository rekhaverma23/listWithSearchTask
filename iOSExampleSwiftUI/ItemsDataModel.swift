//
//  ItemsDataModel.swift
//  iOSExampleSwiftUI
//
//  Created by Rekha Verma on 17/09/24.
//

import Foundation

class ItemDataModel : ObservableObject {
    
    @Published var items = [DataModel]()
    @Published var imageArray = ["nature", "bird", "night", "nature", "bird"]
    
    init() {
        for i in 0..<8 {
            items.append(DataModel(image: "nature", title: "Title\(i)", subtitle: "SubTitle\(i)"))
        }
    }
}



struct DataModel : Identifiable {
    
    var id = UUID()
    var image : String
    var title : String
    var subtitle : String
    
    init(image: String, title: String, subtitle: String) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
    }
}



class HomeViewModel : ObservableObject {
    @Published var offset : CGFloat = 0
}
