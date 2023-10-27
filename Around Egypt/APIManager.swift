//
//  APIManager.swift
//  Around Egypt
//
//  Created by Karim Elshaarawy on 27/10/2023.
//

import Foundation
import Alamofire

class APIManager{
    
   private static let recommendedUrl = "https://aroundegypt.34ml.com/api/v2/experiences?filter[recommended]=true"
    
    static func getRecommendedExperiences(completion: @escaping (_ experiences: [Datum]?,_ error: Error?)-> Void){
        
        
        AF.request(recommendedUrl,method: .get,parameters: nil,encoding: URLEncoding.default).response{ response in
            guard response.error == nil else{
                print(response.error?.localizedDescription)
                completion(nil,response.error)
                return
            }
            
            guard let data = response.data else{
                print("Couldn't get data from API")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let experiences = try decoder.decode(ExperiencesRequest.self, from: data)
                completion(experiences.data,nil)

            } catch let error{
                completion(nil,error)
            }
            
        }
    }
}

