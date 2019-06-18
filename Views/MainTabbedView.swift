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
	private let eventData: [Event] = [
		.init(id: 1, title: "Event 1", summary: "Event summary"),
		.init(id: 2, title: "Event 2", summary: "Event summary"),
		.init(id: 3, title: "Event 3", summary: "Event summary"),
		.init(id: 4, title: "Event 4", summary: "Event summary"),
		.init(id: 5, title: "Event 5", summary: "Event summary"),
		.init(id: 6, title: "Event 6", summary: "Event summary"),
	]
    @State private var selection = 0
 
    public var body: some View {
        TabbedView(selection: $selection){
            EventsView(events: eventData)
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
