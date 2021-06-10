

import Foundation
struct AllData: Codable {
    let data: [Data]
    
}



// MARK: - Datum
struct Data: Codable, Identifiable {
    let id, courseID: Int
    let showCourse: Bool
    let type, winningScore, holesNotPlayed, winningTeam: Int
    let isCupMatch: Bool
    let datumDescription: String?
    let holeOrder: [Int]?
    let playedAt, createdAt, updatedAt: String
   // let deletedAt: JSONNull?
    //let verifiedAt: String
    let liked: Bool
    let likeCount: Int
    let commented: Bool
    let commentCount: Int
   // let users: [User]?
    let course: Course
    let images: [ImageMatch]

    enum CodingKeys: String, CodingKey {
        case id
        case courseID = "course_id"
        case showCourse = "show_course"
        case type
        case winningScore = "winning_score"
        case holesNotPlayed = "holes_not_played"
        case winningTeam = "winning_team"
        case isCupMatch = "is_cup_match"
        case datumDescription = "description"
        case holeOrder = "hole_order"
        case playedAt = "played_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
      //  case deletedAt = "deleted_at"
       // case verifiedAt = "verified_at"
        case liked
        case likeCount = "like_count"
        case commented
        case commentCount = "comment_count"
       // case users, course, images
        case course, images
    }
}

// MARK: - Course
struct Course: Codable {
    let id: Int
    let clubID: JSONNull?
    let name, country: String
    let state: JSONNull?
    let city, lat, lng, createdAt: String
    let updatedAt: String
    let deletedAt: JSONNull?
    let tees: [Tee]

    enum CodingKeys: String, CodingKey {
        case id
        case clubID = "club_id"
        case name, country, state, city, lat, lng
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case tees
    }
}

// MARK: - Tee
struct Tee: Codable {
    let id, courseID: Int
    let name: String
    let courseRating: Double?
    let slopeRating: Int?
    let par: Int
    let holes: [Hole]

    enum CodingKeys: String, CodingKey {
        case id
        case courseID = "course_id"
        case name
        case courseRating = "course_rating"
        case slopeRating = "slope_rating"
        case par, holes
    }
}

// MARK: - Hole
struct Hole: Codable {
    let id, teeID: Int
    let par, tee, strokeIndex: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case teeID = "tee_id"
        case par, tee
        case strokeIndex = "stroke_index"
    }
}

// MARK: - Image
struct ImageMatch: Codable {
    let the140, the210, the560, imageDefault: String

    enum CodingKeys: String, CodingKey {
        case the140 = "140"
        case the210 = "210"
        case the560 = "560"
        case imageDefault = "default"
    }
}

// MARK: - User
struct User: Codable {
    let id: Int
    let firstName, lastName, username, email: String
    let federationNumber: String?
    let handicap: Double
    let rankingLevel: Int
    let rankingLevelAt, rankingLevelPenaltyAt: String
    let publiclyRanked: Bool
    let courseID: Int?
    let proAt: String?
    let verifiedAt: String?
    let createdAt, updatedAt: String
    let isFollowing, isGuest, isBlocked: Bool
    let pivot: Pivot
    let media: [Media]?
    let image: ImageMatch

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case username, email
        case federationNumber = "federation_number"
        case handicap
        case rankingLevel = "ranking_level"
        case rankingLevelAt = "ranking_level_at"
        case rankingLevelPenaltyAt = "ranking_level_penalty_at"
        case publiclyRanked = "publicly_ranked"
        case courseID = "course_id"
        case proAt = "pro_at"
        case verifiedAt = "verified_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isFollowing = "is_following"
        case isGuest = "is_guest"
        case isBlocked = "is_blocked"
        case pivot, media, image
    }
}

// MARK: - Media
struct Media: Codable {
    let id: Int
    let modelType: ModelType
    let modelID: Int
    let uuid: String
    let collectionName: CollectionName
    let name, fileName: String
    let mimeType: MIMEType
    let disk, conversionsDisk: Disk
    let size: Int
    let manipulations: [JSONAny]
    let customProperties: CustomPropertiesUnion
    let responsiveImages: [JSONAny]
    let orderColumn: Int
    let createdAt, updatedAt: String
    let generatedConversions: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id
        case modelType = "model_type"
        case modelID = "model_id"
        case uuid
        case collectionName = "collection_name"
        case name
        case fileName = "file_name"
        case mimeType = "mime_type"
        case disk
        case conversionsDisk = "conversions_disk"
        case size, manipulations
        case customProperties = "custom_properties"
        case responsiveImages = "responsive_images"
        case orderColumn = "order_column"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case generatedConversions = "generated_conversions"
    }
}

enum CollectionName: String, Codable {
    case collectionNameDefault = "default"
}

enum Disk: String, Codable {
    case s3 = "s3"
}

enum CustomPropertiesUnion: Codable {
    case anythingArray([JSONAny])
    case customPropertiesClass(CustomPropertiesClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([JSONAny].self) {
            self = .anythingArray(x)
            return
        }
        if let x = try? container.decode(CustomPropertiesClass.self) {
            self = .customPropertiesClass(x)
            return
        }
        throw DecodingError.typeMismatch(CustomPropertiesUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for CustomPropertiesUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .anythingArray(let x):
            try container.encode(x)
        case .customPropertiesClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - CustomPropertiesClass
struct CustomPropertiesClass: Codable {
    let customHeaders: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case customHeaders = "custom_headers"
    }
}

enum MIMEType: String, Codable {
    case imageJPEG = "image/jpeg"
}

enum ModelType: String, Codable {
    case users = "users"
}

// MARK: - Pivot
struct Pivot: Codable {
    let matchID, userID, status, team: Int
    let handicap: JSONNull?
    let strokeCount, isCreator: Int
    let scores: [Int?]
    let teeID: Int?

    enum CodingKeys: String, CodingKey {
        case matchID = "match_id"
        case userID = "user_id"
        case status, team, handicap
        case strokeCount = "stroke_count"
        case isCreator = "is_creator"
        case scores
        case teeID = "tee_id"
    }
}

enum VerifiedAt: String, Codable {
    case the20180515165408 = "2018-05-15 16:54:08"
    case the20180615141812 = "2018-06-15 14:18:12"
    case the20180913153139 = "2018-09-13 15:31:39"
}

// MARK: - Link
struct Link: Codable {
    let url: String?
    let label: String
    let active: Bool
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}

