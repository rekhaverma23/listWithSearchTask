//
//  FloatingActionButtonView.swift
//  iOSExampleSwiftUI
//
//  Created by Rekha Verma on 17/09/24.
//

import SwiftUI

struct StatisticsBottomSheet: View {
    
    var items = ["apple", "banana" , "orange", "blueberry","mango"]
    
    @State var charCount: [Character: Int] = [:]

    @State var sortedArrayList = [String]()
    

    var body: some View {
        VStack {
            
            Text("List")
                .font(.headline)
            Text("\(items)")
            
            Text("Statistics")
                .font(.headline)
                .padding()

            Text("Total items: \(items.count)")
            Text("Top 3 Characters: \("\(sortedArrayList.joined(separator: ", "))")")

            Spacer()
        }
        .padding()
        .onAppear {
            getCount()
        }
    }
    
    func getCount() {
        
        for item in items {
            
            for char in item.lowercased() {
                charCount[char, default: 0] = charCount[char, default: 0] + 1
            }
        }
        
        let sorted = charCount.sorted { $0.value > $1.value }.prefix(3)
        print(sorted)
        
        
        for (char, count) in sorted {
            print("\(char)=\(count)")
            sortedArrayList.append("\(char)=\(count)")
        }
        
        
    }
}


#Preview {
    StatisticsBottomSheet()
}
