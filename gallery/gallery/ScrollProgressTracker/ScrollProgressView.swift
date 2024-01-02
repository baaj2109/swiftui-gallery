//
//  ScrollProgressView.swift
//  gallery
//
//  Created by kehwa weng on 2024/1/2.
//

import SwiftUI



struct ScrollProgressView: View {
    
    @State private var scrollOffset: CGFloat = 0
    @State private var contentHeight: CGFloat = 0
    
    var body: some View {
        //1
        ScrollViewReader(content: { scrollProxy in
            GeometryReader(content: { fullview in
                ZStack(alignment: .top, content: {
                    ScrollView {
                        //3
                        GeometryReader(content: { ScrollViewGeo in
                            Color.clear.preference(key: ScrollOffsetKey.self,
                                                   value: ScrollViewGeo.frame(in: .global).minY)
                        })
                        .frame(height: 0).id(0)
                        
                        VStack{
                            Text(content)
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        //2
                        .background(GeometryReader(content: { contentGeo in
                            Color.clear.preference(key: ContentHeightPreferenceKey.self,
                                                   value: contentGeo.size.height)
                        }))
                    }
                    .onPreferenceChange(ScrollOffsetKey.self, perform: { value in
                        self.scrollOffset = value - fullview.safeAreaInsets.top
                    })
                    
                    .onPreferenceChange(ContentHeightPreferenceKey.self, perform: { value in
                        self.contentHeight = value
                    })
                  
                    progressView(fullView: fullview, scrollProxy: scrollProxy)
                })
            })
        })
    }
    
    func progressView(fullView: GeometryProxy, scrollProxy: ScrollViewProxy) -> some View {
        let progress = min(1, max(0, -scrollOffset / (contentHeight - fullView.size.height)))
        let progressPercentage = Int(progress * 100 )
        return ZStack {
            Group {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 40)
                        .frame(width: 250, height: 55)
                        .foregroundStyle(.white)
                    HStack{
                        Text("\(progressPercentage)%")
                            .bold()
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.red)
                            .frame(width: 150 * progress, height: 8)
                    }
                    .padding(.leading, 20)
                    .opacity(progressPercentage > 0 && progressPercentage < 100 ? 0.8: 0)
                    .animation(.easeInOut, value: progressPercentage)
                    
                }
            }
            .opacity(progressPercentage > 0 ? 0.8 : 0)
            Button {
                withAnimation(.easeInOut(duration: 5)) {
                    scrollProxy.scrollTo(0, anchor: .top )
                }
            } label: {
                Image(systemName: "arrow.up")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.black)
                    .frame(width: 55, height: 55)
            }
            .offset(y:progressPercentage == 100 ? 0 : 100)
            .animation(.easeInOut, value: progressPercentage)

        }
        .mask(RoundedRectangle(cornerRadius: 40)
            .frame(width: progressPercentage > 0 && progressPercentage < 100 ? 250 : 50, height: 55)
            .animation(.easeInOut, value: progressPercentage)
        )
        .frame(maxHeight: .infinity, alignment: .bottom)

    }
    
}

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct ContentHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

#Preview {
    ScrollProgressView()
}


fileprivate let content: String = """
Full-Text Search is a technical term referred to advanced linguistic text query for a database or text documents. The search engine examines all the words stored in a document as it tries to match certain search criteria giving by the user.

Many web websites depend on Full-text search to perform advanced search operations.

As a new trend, many developers, and companies tend to create static websites instead of dynamic database-driven ones. In both cases they can use Full-Text search with help of several libraries and services.

Some cloud-based services offer Full-Text search as a service likeAlgolia.com. However, open-source alternatives can save time and resources as provide better control for enterprise.

Why is Full-text search required?
Speed: Using Full-text search ensure speed in retrieval of the results for large numbers of documents of a huge text database.
Efficiency: Accurate precise search results in all fields.
Configurable search criteria and logic.
Static websites support: Many static websites use flat-files approach like JSON or Markdown formatted files. Some libraries and frameworks are using
Mobile apps support
Implementing Full-text search with static generated websites is a necessity, especially when most of the static website generators don't include search as a primary functionality. Also, if you are using a self-hosted Ghost blog system, you may want to include a full-text search yourself, mainly because Ghost does not offer built-in search.

Here we will list the best open-source full-text search libraries for developers which can be used to enrich the user experience and provide more valid and accurate search results.

1- Lunrjs
LunrJS is a JavaScript library designed to work on the browser and the server. It does not require any external dependencies or any extra service. It comes with multiple languages processors which can be tweaked according to the user needs.

It's a lightweight alternative library for Apache Solr. Lunr supports 14 languages out-of-box and offers fuzzy term.

Lunr: A bit like Solr, but much smaller and not as bright
2-  Apache Solr
As an enterprise-grade platform, Solr is packed with features like load-balancing queries, automated functions, centralized configuration, distributed instant indexing and scale-ready infrastructure.

Solr is used by several big players like DuckDuckGo, AT&T, Instagram, eBey, Comcast, Magento eCommerce, Adobe, Netflix, Internet Archive and more.

Developer can build apps on Solr easily because it supports many open-standards interfaces: JSON, XML and HTTP.

Welcome to Apache Solr

Apache Solr

3- Sphinx Search
Sphinx is a full-text search engine server written in C++ for best performance. It works seamlessly on Windows, Linux, macOS.   It indexes all data in SQL or NoSQL database.

Sphinx offers a rich API (SphinxAPI) that allows developer to integrate it easily and search using SphinxQL which resample old school SQL.

It's proven to index 10-15mb of text per second per single CPU core and 60+MB/sec per server. For a double core desktop machine it runs 500+ queries/sec.

Sphinx is a scale ready, it's noted that the biggest Sphinx cluster indexes 25+ billion documents at Craigslist serving 300+ million search queries/day.

It features, SQL/ NoSQL database indexing, non-text attributes search, real-time full-text indexing and supports distributed search.

Sphinx | Open Source Search Engine
Sphinx is an open source full text search server, designed with performance, relevance (search quality),and integration simplicity in mind. Sphinx lets you either batch index and search data stored in files, an SQL database, NoSQL storage --or index and search data on the fly, working with Sphinx…

Open Source Search Server

4- Manticore Search
Manticore Search is a multilingual full-text search with support for big data sets and real-time data streaming.

It's the best project on this list that offers unique features as geo-search, replications, search ranking algorithms, real-time indexing and built-in JSON support.
"""

