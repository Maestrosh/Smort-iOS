//
//  HomeView.swift
//  Learning
//
//  Created by Mehdi Shakibapour on 7/17/25.
//

import SwiftUI
import SwiftData
import FoundationModels

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    let session: LanguageModelSession
    @State private var newItemName: String = ""
    @State private var isPresentingAddSheet = false
    @State private var userMessage: String = ""
    @AppStorage("Custom Insutrctions") private var customInstructions: String = ""

    var body: some View {
        NavigationView {
            Group {
                if items.isEmpty {
                    List {
                        VStack(spacing: 16) {
                            Image(systemName: "tray")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.gray)
                                .padding(.top, 60)
                            
                            Text("Nothing here. Just... void")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            Text("Give your list some meaning.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.insetGrouped) // Optional: match style to rest of app
                } else {
                    List {
                        ForEach(items, id: \.self) { item in
                            NavigationLink(destination: detailView(for: item)) {
                                Text(item.title)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
            }
            .navigationTitle("Smort")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button{
                        isPresentingAddSheet = true
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingAddSheet) {
                NavigationView {
                    Form {
                            TextField("", text: $userMessage, axis: .vertical).lineLimit(10,reservesSpace: true)
                    }
                    .navigationTitle("Message to LLM")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingAddSheet = false
                                userMessage = ""
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                addItem(input: userMessage, customInstruction: customInstructions )
                                isPresentingAddSheet = false
                                userMessage = ""
                            }
                            .disabled(userMessage.trimmingCharacters(in: .whitespaces).isEmpty)
                        }
                    }
                }.presentationDetents([.medium])
                    .presentationBackgroundInteraction(.automatic)
                    .presentationBackground(.ultraThinMaterial)
            }
                
            


        }
    }
    
    @ViewBuilder
    private func detailView(for item: Item) -> some View {
        List {
            Text("Title: \(item.title)")
            Text("Time: \(item.startTime.description)")
            Text("Location: \(item.location ?? "Not Specified")")
            Text("Notes: \(item.notes ?? "None")")
            Text("Recurs: \(item.hasRecurrenceRules.description)")
            Text("All Day: \(item.isAllDay.description)")
        }
    }


    private func addItem(input: String, customInstruction: String?) {
        Task {
            do {
                let newEvent = try await session.respond(to: "Bear in mind the following:\(customInstruction ?? "") casual text:\(input)", generating: Event.self).content
                print (session.transcript)
                withAnimation {
                    
                    //TODO: Some kind of notification to say it was added and is processing.
                    
                    let newEventItem = Item(
                        timestamp: Date(),
                        title: newEvent.title,
                        starttime: newEvent.start,
                        endtime: newEvent.end,
                        location: newEvent.location,
                        notes: newEvent.notes,
                        url: newEvent.url
                    )
                    modelContext.insert(newEventItem)
                    
                    // Every time something is added, it should also go to Calendar.
                }
            } catch {
                // Handle error — maybe show alert or log
                print("Failed to convert input to event: \(error)")
            }
        }
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }

}
