//
//  GenericListView.swift
//  DemoAppAssignment
//
//  Created by Sonam Kumari on 14/02/25.
//

import SwiftUI
import ComposableArchitecture

//struct GenericListView<Item: Identifiable & Equatable>: View {
//    let store: StoreOf<SpotifyGenericReducer<Item>>
//    let title: String
//    let fetchAction: SpotifyGenericReducer<Item>.Action
//    let imageURL: (Item) -> String?
//    let itemName: (Item) -> String
//    let destinationView: (Item) -> AnyView
//
//    var body: some View {
//        WithViewStore(store, observe: { $0 }) { viewStore in
//            NavigationView {
//                VStack {
//                    if viewStore.isLoading {
//                        ProgressView("Loading \(title)...")
//                    } else if let error = viewStore.errorMessage {
//                        VStack {
//                            Text("Error: \(error)").foregroundColor(.red)
//                            Button(action: {
//                                viewStore.send(fetchAction)
//                            }) {
//                                Image(systemName: "arrow.clockwise")
//                                    .foregroundColor(.blue)
//                            }
//                        }
//                    } else {
//                        List(viewStore.items) { item in
//                            NavigationLink(destination: destinationView(item)) {
//                                HStack {
//                                    AsyncImage(url: URL(string: imageURL(item) ?? ""))
//                                        .frame(width: 50, height: 50)
//                                        .clipShape(RoundedRectangle(cornerRadius: 8))
//                                    Text(itemName(item))
//                                }
//                            }
//                        }
//                        .refreshable {
//                            viewStore.send(fetchAction)
//                        }
//                    }
//                }
//                .navigationBarTitleDisplayMode(.inline)
//                .toolbar {
//                    ToolbarItem(placement: .principal) {
//                        Text(title)
//                            .font(.headline)
//                    }
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Button(action: {
//                            viewStore.send(fetchAction)
//                        }) {
//                            Image(systemName: "arrow.clockwise")
//                                .foregroundColor(.blue)
//                        }
//                    }
//                }
//                .onAppear {
//                    viewStore.send(fetchAction)
//                }
//            }
//        }
//    }
//}
