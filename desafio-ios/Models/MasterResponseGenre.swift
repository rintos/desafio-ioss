

import Foundation

public class MasterResponseGenre: Decodable {
	public var genres : Array<Genres>?
    
    public func convertArray(genres : Array<Genres>?)-> NSDictionary {
        var resultado: Any?
        var convert: NSDictionary?
        
        
        for dado in genres! {
            resultado = dado as Any
            convert = resultado as? NSDictionary
        }
        
        return convert!
    }

}

public class Genres: Decodable {
    public var id : Int?
    public var name : String?
}
