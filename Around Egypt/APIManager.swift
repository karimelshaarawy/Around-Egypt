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
    private static let recentUrl = "https://aroundegypt.34ml.com/api/v2/experiences"
    
    private static let searchUrl = "https://aroundegypt.34ml.com/api/v2/experiences?filter[title]="

    private static let likeUrl = "https://aroundegypt.34ml.com/api/v2/experiences/"
    
    
    
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
 
    static func getRecentExperiences(completion: @escaping (_ experiences: [Datum]?,_ error: Error?)-> Void){
        
        
        AF.request(recentUrl,method: .get,parameters: nil,encoding: URLEncoding.default).response{ response in
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
    
    static func getSearchedExperiences(searchText: String,completion: @escaping (_ experiences: [Datum]?,_ error: Error?)-> Void){
        
        let url = searchUrl + searchText
        
        AF.request(url,method: .get,parameters: nil,encoding: URLEncoding.default).response{ response in
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
    

    static func postLikeRequest(id: String,completion: @escaping (_ likes: Int?,_ error: Error?)-> Void){
        
        let url = likeUrl + id + "/like"
        
        AF.request(url,method: .post,parameters: nil,encoding: JSONEncoding.default).response{ response in
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
                let likes = try decoder.decode(LikePostResponse.self, from: data)
                completion(likes.data,nil)

            } catch let error{
                completion(nil,error)
            }
            
        }
    }
    
}



