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
	let eventLoadingView = EventLoadingView()
	
	public var body: some View {
		TabView(selection: $selection){
			
			// Events
			eventLoadingView
				.onAppear {
					self.eventLoadingView.eventFetcher.fetch()
			}
			.font(.title)
				//                .tabItemLabel(Image("clock", bundle: Bundle(identifier: "sticks.Views")!))
				.tabItem {
					Text("Events")
			}
			.tag(0)
			
			// Venues
			VenuesView()
				.font(.title)
				//                .tabItemLabel(Image("map"))
				.tabItem {
					Text("Venues")
			}
			.tag(1)
		}
			//			Text("detail")
			.navigationBarHidden(true)
			.navigationBarTitle(Text("Calagator"), displayMode: .inline)
			.navigationBarItems(trailing:
				NavigationLink(destination: SafariView(url: URL(string: "http://calagator.org/events/new")!)) {
					Image
			})
		
	}
}

#if DEBUG
struct MainTabbedView_Previews : PreviewProvider {
	static var previews: some View {
		MainTabbedView()
	}
}
#endif
