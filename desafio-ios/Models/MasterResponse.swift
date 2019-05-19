
import Foundation
 
public class MasterResponse: Decodable {
	public var page : Int?
	public var total_results : Int?
	public var total_pages : Int?
	public var results : Array<Results>?


}

public class Results: Decodable {
    public var vote_count : Int?
    public var id : Int?
    public var video : Bool?
    public var vote_average : Double?
    public var title : String?
    public var popularity : Double?
    public var poster_path : String?
    public var original_language : String?
    public var original_title : String?
    public var genre_ids : Array<Int>?
    public var backdrop_path : String?
    public var adult : Bool?
    public var overview : String?
    public var release_date : String?
    
}
