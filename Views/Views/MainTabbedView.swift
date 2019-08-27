//
//  MainTabbedView.swift
//  Calagator
//
//  Created by Noah Emmet on 6/17/19.
//  Copyright © 2019 Noah Emmet. All rights reserved.
//

import SwiftUI
import SFSafeSymbols
import Models
import Common

public struct MainTabbedView : View {
	public init() { }
	
	@State private var selection = 0
	@State private var isShowingAddEvent = false
	let eventLoadingView = EventLoadingView()
	
	public var body: some View {
		TabView(selection: $selection){
			NavigationView {
				// Events
				eventLoadingView
					.onAppear {
						self.eventLoadingView.eventFetcher.fetch()
				}
				.tabItem {
					Image(systemSymbol: .calendar)
					Text("Events")
				}
				.navigationBarTitle(Text("Calagator"), displayMode: .inline)
				.navigationBarItems(trailing:
					Button(action: showAddEvent) {
						Image(systemSymbol: .plus)
				})
					.tag(0)
					.sheet(isPresented: $isShowingAddEvent,
								 content: {
									SafariView(url: URL(string: "http://calagator.org/events/new")!)
				})
			}
			
			// Venues
			VenuesView()
				.font(.title)
				//                .tabItemLabel(Image("map"))
				.tabItem {
					Image(systemSymbol: .map)
					Text("Venues")
			}
			.tag(1)
		}
	}
	
	func showAddEvent() {
		isShowingAddEvent = true
	}
}

#if DEBUG
struct MainTabbedView_Previews : PreviewProvider {
	static var previews: some View {
		MainTabbedView()
	}
}
#endif
