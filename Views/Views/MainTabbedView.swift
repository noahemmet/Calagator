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
	public enum Tab: Int {
		case events
		case venue
	}
	
	public init() { }
	
	@State private var selection = 0
	@State private var selectedEvent: Event?
	@State private var isShowingAddEvent = false
	let eventLoadingView = EventLoadingView()
	
	public var body: some View {
		TabView(selection: $selection){
			// Events
			NavigationView {
				eventLoadingView
					.onAppear {
						self.eventLoadingView.eventFetcher.fetch()
				}
				.navigationBarTitle(Text("Calagator"), displayMode: .inline)
				.navigationBarItems(trailing:
					Button(action: showAddEvent) {
						Image(systemSymbol: .plus)
				})
				
				EventDetailView(event: selectedEvent)
			}
			.navigationViewStyle(DoubleColumnNavigationViewStyle())
			.tabItem {
				Image(systemSymbol: .calendar)
				Text("Events")
			}
			.tag(Tab.events)
			.sheet(isPresented: $isShowingAddEvent,
						 content: {
							SafariView(url: URL(string: "http://calagator.org/events/new")!)
			})
			
			// Venues
			NavigationView {
				VenuesView()
			}
			.tag(Tab.venue)
			.tabItem {
				Image(systemSymbol: .map)
				Text("Venues")
			}
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
