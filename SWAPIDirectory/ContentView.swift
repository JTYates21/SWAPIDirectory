//
//  ContentView.swift
//  APISWDirectory
//
//  Created by Jacek Yates on 8/19/22.
//

import SwiftUI
import CoreData
import Foundation

struct URLImage: View {
    let urlString: String
    
    @State var data: Data?
    
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:130, height: 70)
                .background(Color.gray)
                .padding(3)
        }
        else {
            Image("")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:130, height: 70)
                .background(Color.gray)
                .padding(3)
                .onAppear {
                    fetchData()
                }
        }
    }
    private func fetchData() {
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        task.resume()
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp!, ascending: true),],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.people, id: \.self) { person in
                    NavigationLink {
                        PersonDetail(person: person)
                    } label: {
                        HStack {
                            Text("\(person.firstName) \(person.lastName)")
                                .bold()
                        }
                        .padding(3)
                    }
                }
                
            }
            .navigationTitle("Directory")
            .onAppear {
                viewModel.fetch()
            }  
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
