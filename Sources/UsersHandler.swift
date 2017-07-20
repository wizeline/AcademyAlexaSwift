//
//  UsersHandler.swift
//  SwiftEcho
//
//  Created by Oscar Mendoza Ochoa on 7/7/17.
//
//

// TODO
//  handle errors in functions

import Foundation
import CouchDB
import SwiftyJSON
import HeliumLogger

public class UsersHandler {
    
    let connProperties = ConnectionProperties(
        host: DatabasePropierties.host,         // httpd address
        port: DatabasePropierties.port,         // httpd port
        secured: false,                         // https or http
        username: DatabasePropierties.admin,    // admin username
        password: DatabasePropierties.password  // admin password
    )
    private var database: Database
    
    /// Init
    init() {
        // Create couchDBClient instance using conn properties
        let couchDBClient = CouchDBClient(connectionProperties: connProperties)
        database = couchDBClient.database(DatabasePropierties.name)
    }
    
    
    /// Save a user into CouchDB
    ///
    /// - Parameter user: a League of Legends valid user, with attached Alexa ID
    /// - Returns: true if inserted correctly, otherwise false
    public func save(_ user: User, completition: @escaping (_ result: Bool) -> ()) {
        
        let userDict: [String: AnyObject] = [
            "_id":              user.alexaId as AnyObject,
            "name":             user.name as AnyObject,
            "summonerLevel":    user.summonerLevel as AnyObject,
            "accountId":        user.accountId as AnyObject,
            "revisionDate":     user.revisionDate as AnyObject,
            "region":           user.region as AnyObject,
            "id":               user.summonerID as AnyObject
        ]
        let json = JSON(userDict as AnyObject)
        
        database.create(json, callback: { (id, rev, document, error) in
            if let error = error {
                print("Error: \(error.code).")
                completition(false)
            } else {
                completition(true)
            }
        })
    }
    
    
    /// Retrives an User object of determined Amazon Id.
    ///
    /// - Parameter alexaId:
    /// - Returns: nil if not found
    public func find(_ alexaId: String, completition: @escaping (_ result: User?) -> ()) {
        database.retrieve(alexaId) { (document, error) in
            if error != nil {
                if let errorCode = error?.code {
                    print("Error \(errorCode).")
                } else {
                    print("Unknow error.")
                }
                completition(nil)
            } else {
                if let doc = document {
                    completition(User(with: doc, alexaId: doc["_id"].stringValue))
                } else {
                    completition(nil)
                }
            }
        }
    }
    

    /// Removes an user from the database.
    /// Should be used on log out intent.
    ///
    /// - Parameters:
    ///   - alexaId: The Alexa Id of the user
    public func delete(_ alexaId: String, completition: @escaping (_ result: Bool) -> ()) {
        database.retrieve(alexaId) { (document, error) in
            if error != nil {
                if let errorCode = error?.code {
                    print("Error \(errorCode).")
                } else {
                    print("Unknow error.")
                }
                completition(false)
            } else {
                if let doc = document {
                    self.database.delete(doc["_id"].stringValue, rev: doc["_rev"].stringValue, callback: { (error) in
                        if error != nil {
                            print("Error removing element from database.")
                            completition(false)
                        } else {
                            completition(true)
                        }
                    })
                } else {
                    print("Error removing element from database.")
                    completition(false)
                }
            }
        }
    }
}
