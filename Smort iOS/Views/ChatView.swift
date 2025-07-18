////
////  ChatView.swift
////  Learning
////
////  Created by Mehdi Shakibapour on 7/15/25.
////
//
//import SwiftUI
//
//struct ChatView: View {
//    @State private var userInput: String = ""
//    @State private var messages: [ChatMessage] = []
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .trailing) {
//                ForEach(messages, id: \.self) { message in
//                    Text(message.content)
//                }
//            }
//            .padding()
//            .frame(maxWidth: .infinity)
//        }
//        // let's have a Hstack with an input textfield and a send button
//        HStack {
//            TextField("Type a message...", text: $userInput)
//            Button(action: {
//                let InputMessage = ChatMessage(content: userInput, isUser: true)
//                handleUserInput(input: userInput)
//                messages.append(InputMessage)
//                userInput = ""
//            }) {
//                Text("Send")
//            }
//        }
//        .padding()
//    }
//}
//
//struct ChatMessage: Hashable{
//    var content:String = ""
//    var isUser: Bool
//    var date: Date = Date()
//}
//
//private func handleUserInput(input: String){
//    ///
//}
//
//#Preview {
//    ChatView()
//}
