//
//  ArticleVIew.swift
//  gallery
//
//  Created by kehwa weng on 2023/12/19.
//

import SwiftUI


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

struct ArticleVIew: View {
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading, content: {
                    HeaderView()
                    ArticleTextView(text: "the art of beging an artist", size: 34)
                        .padding(.top,30)
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 3)
                        .opacity(0.2)
                    ArticleTextView(text: "simplified products", size: 20)
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 250, height: 3)
                        .opacity(0.2)
                    ArticleTextView(text: "tags", size: 18)
                    Divider()
                    ArticleTextView(text: "article conent", size: 18)
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 3)
                        .opacity(0.2)
                    ArticleTextView(text: content, size: 18)
                })
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .padding()
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        HStack{
            Text("New article")
                .font(.custom("ArialRoundedMTBold", size: 34))
            Spacer()
            Image(systemName: "square.and.arrow.down")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity)
    }
    @ViewBuilder
    func ArticleTextView(
        text: String,
        isBold: Bool = true,
        size: CGFloat
    ) -> some View {
        Text(text)
            .font(.custom(isBold ? "ArialRoundedMTBold" : "ArialRoundMT", size: size))

    }
    
}

#Preview {
    ArticleVIew()
}
