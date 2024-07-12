//
//  AuthResponse.swift
//  Spotify
//
//  Created by 황민채 on 7/12/24.
//

import Foundation

struct AuthResponse: Decodable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String
    let scope: String
    let access: String
    let token_type: String
}
