//
//  TaxStudyApp.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/27/24.
//

import SwiftData
import SwiftUI

@main
struct TaxStudyApp: App {
    
    var body: some Scene {
        DocumentGroup(newDocument: TaxProjectDocument()) { file in
            ProjectView(file.$document)
//                .presentedWindowToolbarStyle(.unified)
        }
    }

}
