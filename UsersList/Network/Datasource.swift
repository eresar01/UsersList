//
//  Datasource.swift
//  UsersListTask
//
//  Created by Yerem Sargsyan on 29.12.20.
//

import Foundation
import Alamofire

class Datasource {
    
    var delegate : SearchDataDelegate?
    
    private let API_URL = "https://randomuser.me/api?seed=renderforest&results=20&page="
    
    func searchRecuest(page: Int) {
        self.makeRecuest(page: page)
    }
    
    private func makeRecuest(page: Int = 1) {
        let url = API_URL + "\(page)"
        print(url)
        Alamofire.request(url, method: .get)
        .responseJSON { response in
            if response.result.isSuccess {
                do  {
                let response = try JSONDecoder().decode(SearchResults.self, from: response.data!)
                    self.delegate?.getData(result: response)
                    
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                    
                } catch let DecodingError.keyNotFound(key, context) {
                    print("### Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("*** Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                    
                }
            } else {
            print("Error -> not result")
        }
    }
    }
    
    
}

