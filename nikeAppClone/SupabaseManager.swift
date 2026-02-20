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
            supabaseURL: URL(string: "https://mmwwdokdnzabqxneysjb.supabase.co")!,
            supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1td3dkb2tkbnphYnF4bmV5c2piIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA2MTY2NDEsImV4cCI6MjA4NjE5MjY0MX0.ropLKbJ40to2KFuQFrgEx7xRFTOpn6clyxyQeZvXYV8"
        )
    }
}
