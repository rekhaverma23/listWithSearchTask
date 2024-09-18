//
//  StickySearchBar.swift
//  iOSExampleSwiftUI
//
//  Created by Rekha Verma on 16/09/24.
//

import SwiftUI


struct StickySearchBar: View {
    
    @StateObject var homeData = HomeViewModel()
    @StateObject var viewModel = ItemDataModel()

    @State private var showBottomSheet = false
    @State var searchText = ""
    @State private var index = 0

    var filteredItems : [DataModel] {
        viewModel.items.filter { $0.title.lowercased().contains(searchText.lowercased()) || searchText.isEmpty }
    }
    
    
    var body: some View {
        
        ZStack {
            
            ScrollView(showsIndicators: false) {
                
                LazyVStack(alignment: .leading, spacing: 8, pinnedViews: [.sectionHeaders], content: {
                    
                    
                    GeometryReader { reader -> AnyView in
                        
                        let offset = reader.frame(in: .global).minY
                        
                        if -offset >= 0 {
                            DispatchQueue.main.async {
                                homeData.offset = -offset
                            }
                        }
                        
                        return AnyView(
                            
                            VStack {
                                
                                TabView(selection: $index) {
                                    
                                    ForEach(0..<viewModel.imageArray.count, id: \.self) { i in
                                        
                                        Image(viewModel.imageArray[i])
                                            .resizable()
                                            .frame(height : 220)
                                            .cornerRadius(15)
                                            .padding(.horizontal,1)
                                        
                                    }
                                }
                                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                                .frame(height : 220)
                                
                                
                                HStack(spacing: 10) {
                                    ForEach(0..<5, id: \.self) { i in
                                        Image(systemName: index == i ? "largecircle.fill.circle" : "circle.fill")
                                            .font(Font.system(size: 10))
                                            .foregroundColor(index == i ? Color.blue  : .gray)
                                            .onTapGesture {
                                                index = i
                                            }
                                    }
                                }.padding(.top,10)
                                
                            }
                        )
                        
                    }.frame(height: 280)
                    
                    Section(header: 
                                
                                
                                HStack(alignment: .top) {
                                    
                                    Image(systemName: "magnifyingglass")
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                         TextField("Search", text: $searchText)
                                }
                                .frame(height: 44)
                                .padding(.horizontal)
                                .background(Color(.systemGray5))
                                .cornerRadius(8)
                                .padding(.vertical,8)
                    
                    
                    ) {
                        ForEach(0..<filteredItems.count, id: \.self) { i in
                            HStack{
                                Image(.nature)
                                    .resizable()
                                    .frame(width: 60,height: 60)
                                    .cornerRadius(8)
                                VStack(alignment: .leading) {
                                    Text(filteredItems[i].title)
                                    Text(filteredItems[i].subtitle)
                                }
                                Spacer()
                            }.padding(10)
                                .background(Color.appGreenColor.cornerRadius(10))
                                .padding(.vertical,5)
                        }
                    }
                    
                }).padding()
                
                
            }.overlay (
                
                Color.white.frame(height: UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .ignoresSafeArea(.all, edges: .top)
                    .opacity(homeData.offset > 250 ? 1 : 0)
                ,alignment : .top)
            
            
            //FloatingActionButtonView()
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showBottomSheet.toggle()
                    }) {
                        Image("more")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    .padding()
                }
            }
            
        }.sheet(isPresented: $showBottomSheet) {
            StatisticsBottomSheet()
        }
            
    }
}


#Preview {
    StickySearchBar()
}


