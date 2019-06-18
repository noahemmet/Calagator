//
//  EventsView.swift
//  Views
//
//  Created by Noah Emmet on 6/17/19.
//  Copyright © 2019 Noah Emmet. All rights reserved.
//

import SwiftUI

struct EventsView : View {
	var body: some View {
		NavigationView {
			Text("Hello World!")
		}
		.navigationBarTitle(Text("Events"))
	}
}

#if DEBUG
struct EventsView_Previews : PreviewProvider {
	static var previews: some View {
		EventsView()
	}
}
#endif
