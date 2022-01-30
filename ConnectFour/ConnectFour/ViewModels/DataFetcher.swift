//
//  DataFetcher.swift
//  ConnectFour
//
//  Created by Gajula Ravi Kiran on 30/01/2022.
//

import Foundation

class DataFetcher: NSObject {
    var resObject: [JsonModel]?

    override init() {
        super.init()
        if let data = readLocalJSONFile(forName: "MockApi") {
            resObject = parse(jsonData: data)
        }
    }
}

//MARK: Json Loading
extension DataFetcher {
    
    private func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
    
    func parse(jsonData: Data) -> [JsonModel]? {
        do {
            let decodedData = try JSONDecoder().decode([JsonModel].self, from: jsonData)
            return decodedData
        } catch {
            print("error: \(error)")
        }
        return nil
    }
}
