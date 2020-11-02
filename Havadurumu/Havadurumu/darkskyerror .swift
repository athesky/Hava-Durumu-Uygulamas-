
import Foundation

enum DarkSkyError {
    
    case RequestError
    case ResponseUnsuccesful(statusCode : Int)
    case invalidData
    case JSONParsingError
    case invalidURL
}
