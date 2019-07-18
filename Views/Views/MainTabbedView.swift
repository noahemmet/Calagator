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

public struct MainTabbedView : View {
	public init() { }
	
	@State private var selection = 0
	@State private var isShowingAddEvent = false
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
					Image(systemSymbol: .calendar)
					Text("Events")
			}
			.tag(0)
			.sheet(isPresented: $isShowingAddEvent,
				   content: {
					SafariView(url: URL(string: "http://calagator.org/events/new")!)
			})
			
			// Venues
			VenuesView()
				.font(.title)
				//                .tabItemLabel(Image("map"))
				.tabItem {
					Image(systemSymbol: .calendar)
					Text("Venues")
			}
			.tag(1)
		}
			//			Text("detail")
			.navigationBarHidden(true)
			.navigationBarTitle(Text("Calagator"), displayMode: .inline)
<<<<<<< HEAD
			.navigationBarItems(trailing:
				NavigationLink(destination: SafariView(url: URL(string: "http://calagator.org/events/new")!)) {
					Image(systemSymbol: .plus)
			})
		
=======
			.navigationBarItems(trailing: Button("+", action: showAddEvent))
	}
	func showAddEvent() {
		isShowingAddEvent = true
>>>>>>> sheet
	}
}

#if DEBUG
struct MainTabbedView_Previews : PreviewProvider {
	static var previews: some View {
		MainTabbedView()
	}
}
#endif
