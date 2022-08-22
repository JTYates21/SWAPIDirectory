//
//  ViewModel.swift
//  APIDirectory
//
//  Created by Jacek Yates on 8/17/22.
//

import Foundation
import SwiftUI

struct Individual: Codable {
    let individuals: [Person]
}

struct Person: Hashable, Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let birthdate: String
    let profilePicture: String
    let forceSensitive: Bool
    let affiliation: String
}

class ViewModel: ObservableObject {
    @Published var people: [Person] = []
    
    func fetch() {
        guard let url = URL(string: "https://edge.ldscdn.org/mobile/interview/directory") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let people = try JSONDecoder().decode(Individual.self, from: data).individuals
                DispatchQueue.main.async {
                    self?.people = people
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
}
