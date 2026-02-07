//
//  Supabase.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/7/26.
//

import Supabase
import Foundation

final class SupabaseManager {
    static let shared = SupabaseManager()

    let client: SupabaseClient

    private init() {
        client = SupabaseClient(
            supabaseURL: URL(string: "https://lbipgwcpslhqulpakbes.supabase.co")!,
            supabaseKey: "sb_publishable_gBkuJhc5Ge8HyUZyzV6PfA_BaMLJVED"
        )
    }
}
