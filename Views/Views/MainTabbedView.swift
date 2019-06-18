//
//  MainTabbedView.swift
//  Calagator
//
//  Created by Noah Emmet on 6/17/19.
//  Copyright © 2019 Noah Emmet. All rights reserved.
//

import SwiftUI
import Models

public struct MainTabbedView : View {
	public init() { }
	
    @State private var selection = 0
 
    public var body: some View {
        TabbedView(selection: $selection){
            EventLoadingView()
                .font(.title)
//                .tabItemLabel(Image("clock", bundle: Bundle(identifier: "com.sticks.Views")))
				.tabItemLabel(Text("Events"))
                .tag(0)
            VenuesView()
                .font(.title)
//                .tabItemLabel(Image("map"))
				.tabItemLabel(Text("Venues"))
                .tag(1)
        }
    }
}

#if DEBUG
struct MainTabbedView_Previews : PreviewProvider {
    static var previews: some View {
        MainTabbedView()
    }
}
#endif
