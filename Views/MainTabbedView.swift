//
//  MainTabbedView.swift
//  Calagator
//
//  Created by Noah Emmet on 6/17/19.
//  Copyright © 2019 Noah Emmet. All rights reserved.
//

import SwiftUI

public struct MainTabbedView : View {
	public init() { }
	
    @State private var selection = 0
 
    public var body: some View {
        TabbedView(selection: $selection){
            Text("Events")
                .font(.title)
                .tabItemLabel(Image("first"))
                .tag(0)
            Text("Venues")
                .font(.title)
                .tabItemLabel(Image("second"))
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
