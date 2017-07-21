//
//  Utils.swift
//  SwiftEcho
//
//  Created by Oscar Mendoza Ochoa on 7/7/17.
//
//

import Foundation
import SwiftyJSON

public class Utils {

    let fakeJSON = "{ \"version\": \"string\", \"sessionAttributes\": { \"string\": \"\" }, \"response\": { \"outputSpeech\": { \"type\": \"PlainText\", \"text\": \"Hello summoner. What do you want to do? \" }, \"reprompt\": { \"outputSpeech\": { \"type\": \"PlainText\", \"text\": \"Say HELP if you want to listen options.\" } }, \"shouldEndSession\": \"false\" } }"
    
    let fakeUser = "{ \"name\": \"HienAFK\", \"summonerLevel\": \"30\", \"accountId\": \"231123\", \"revisionDate\": \"1231313\", \"region\": \"LAN\" }"
    

}

func championName(_ id: String) -> String? {
    var champions: [String: String]
    champions = ["1": "Annie","2": "Olaf","3": "Galio","4": "TwistedFate","5": "XinZhao","6": "Urgot","7": "Leblanc","8": "Vladimir","9": "Fiddlesticks","10": "Kayle","11": "MasterYi","12": "Alistar","13": "Ryze","14": "Sion","15": "Sivir","16": "Soraka","17": "Teemo","18": "Tristana","19": "Warwick","20": "Nunu","21": "MissFortune","22": "Ashe","23": "Tryndamere","24": "Jax","25": "Morgana","26": "Zilean","27": "Singed","28": "Evelynn","29": "Twitch","30": "Karthus","31": "Chogath","32": "Amumu","33": "Rammus","34": "Anivia","35": "Shaco","36": "DrMundo","37": "Sona","38": "Kassadin","39": "Irelia","40": "Janna","41": "Gangplank","42": "Corki","43": "Karma","44": "Taric","45": "Veigar","48": "Trundle","50": "Swain","51": "Caitlyn","53": "Blitzcrank","54": "Malphite","55": "Katarina","56": "Nocturne","57": "Maokai","58": "Renekton","59": "JarvanIV","60": "Elise","61": "Orianna","62": "MonkeyKing","63": "Brand","64": "LeeSin","67": "Vayne","68": "Rumble","69": "Cassiopeia","72": "Skarner","74": "Heimerdinger","75": "Nasus","76": "Nidalee","77": "Udyr","78": "Poppy","79": "Gragas","80": "Pantheon","81": "Ezreal","82": "Mordekaiser","83": "Yorick","84": "Akali","85": "Kennen","86": "Garen","89": "Leona","90": "Malzahar","91": "Talon","92": "Riven","96": "KogMaw","98": "Shen","99": "Lux","101": "Xerath","102": "Shyvana","103": "Ahri","104": "Graves","105": "Fizz","106": "Volibear","107": "Rengar","110": "Varus","111": "Nautilus","112": "Viktor","113": "Sejuani","114": "Fiora","115": "Ziggs","117": "Lulu","119": "Draven","120": "Hecarim","121": "Khazix","122": "Darius","126": "Jayce","127": "Lissandra","131": "Diana","133": "Quinn","134": "Syndra","136": "AurelionSol","141": "Kayn","143": "Zyra","150": "Gnar","154": "Zac","157": "Yasuo","161": "Velkoz","163": "Taliyah","164": "Camille","201": "Braum","202": "Jhin","203": "Kindred","222": "Jinx","223": "TahmKench","236": "Lucian","238": "Zed","240": "Kled","245": "Ekko","254": "Vi","266": "Aatrox","267": "Nami","268": "Azir","412": "Thresh","420": "Illaoi","421": "RekSai","427": "Ivern","429": "Kalista","432": "Bard","497": "Rakan","498": "Xayah"]
    return champions[id]
}

//TODO - Add description
func convertToDictionary(from text: String) -> EasyJSON? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? EasyJSON
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

/// Maps intents with their respective classes
func registry() {
    Intent.registry["login"] = LoginIntent.self
    Intent.registry["logout"] = LogoutIntent.self
    Intent.registry["statistics"] = StatisticsIntent.self
    Intent.registry["AMAZON.HelpIntent"] = AmazonHelpIntent.self
    Intent.registry["AMAZON.CancelIntent"] = AmazonHelpIntent.self
    Intent.registry["AMAZON.StopIntent"] = AmazonHelpIntent.self
}

func url(forScheme scheme: String, endpoint: String, basePath: String, region: String, id: String, apiKey: String) -> URL? {
    var baseURL = URLComponents()
    baseURL.scheme = scheme
    baseURL.host =  region + "." + endpoint
    baseURL.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
    return baseURL.url?.appendingPathComponent(basePath).appendingPathComponent(id, isDirectory: false)
}

func url(forScheme scheme: String, endpoint: String, basePath: String, region: String, id: String, apiKey: String, appendingPath path: String) -> URL? {
    var baseURL = URLComponents()
    baseURL.scheme = scheme
    baseURL.host =  region + "." + endpoint
    baseURL.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
    return baseURL.url?.appendingPathComponent(basePath).appendingPathComponent(id).appendingPathComponent(path, isDirectory: false)
}

/// Explores the match object to retrive the champion id each player is playing
/// This function is horribly implemented.. need to redo
///
/// - Parameters:
///   - match: current match
///   - summonerId: id of the played we want to know his champion
/// - Returns: the championid
func whatChampion(_ match: Match, _ summonerId: Int) -> String {
    for champion in match.participants {
        if champion.summonerId == summonerId {
            if let champId = champion.championId {
                return "\(champId)"
            }
        }
    }
    return ""
}

/// Retrive region code for LoL API
///
/// - Parameter region: slot from Alexa request
/// - Returns: code for LoL API
func regionCode(_ region: String) -> String? {
    switch region.lowercased() {
        case "north america":           return "na1"
        case "latin america north":     return "la1"
        case "latin america south":     return "la2"
        case "europe west":             return "euw1"
        case "europe east":             return "eue1"
        case "korea":                   return "kr"
        case "japan":                   return "jp1"
        case "oceania":                 return "oc1"
        case "russia":                  return "ru"
        case "turkey":                  return "tr1"
        case "brazil":                  return "br1"
        default:                        return nil
    
    }
}
