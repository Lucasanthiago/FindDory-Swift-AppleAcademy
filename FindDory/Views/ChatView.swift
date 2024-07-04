//
//  ChatView.swift
//  teste dory
//
//  Created by Lucas Santos on 29/02/24.
//

import SwiftUI
import Foundation

struct ChatView: View {
    @State private var messageTitle = ""
    @State private var messageText = ""
    @State private var messages: [ChatMessage] = []
    
    @AppStorage("chat_messages") private var messagesData = ""
    
    init() {
        if let decoded = UserDefaults.standard.data(forKey: "chat_messages") {
            if let decodedMessages = try? JSONDecoder().decode([ChatMessage].self, from: decoded) {
                _messages = State(initialValue: decodedMessages)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 0.0) {
                List {
                    ForEach(messages) { message in
                        NavigationLink {
                            TextView(chatMessage: message)
                        } label: {
                            VStack(alignment: .leading, spacing: 0.0) {
                                
                                Text(message.title)
                                    .fontWeight(.bold)
                                    .font(.title)
                                    .foregroundColor(noventa)
                                    .multilineTextAlignment(.leading)
                                
                                Text(message.text)
                                    .foregroundColor(noventa)
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                                
                                Text(message.dateString)
                                    .font(.caption)
                                    .foregroundColor(vinte)
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal, 8.0)
                                    .frame(maxWidth: .infinity, maxHeight: 26, alignment: .leading)
                                    .background(setenta)
                                    .cornerRadius(8)
                                
                            }
                            .padding(16)
                            
                            .frame(width: 350, height: 122, alignment: .leading)
                            .background(trinta)
                            .cornerRadius(15)
                        }
                        .padding([.leading])
                        
                    }
                    
                    .onDelete(perform: deleteMessage)
                    .listRowBackground(dez)
                }
                
                .listStyle(PlainListStyle())
                HStack {
                    VStack {
                        TextField("Title...", text: $messageTitle)
                        //                            .textFieldStyle(.roundedBorder)
                        //                            .padding([.horizontal, .top])
                            .font(.title3)
                        
                        TextField("Write a note...", text: $messageText, axis: .vertical)
                            .font(.body)
                            .lineLimit(3)
                        //                            .textFieldStyle(.roundedBorder)
                        //                            .padding(.horizontal)
                        
                    }
                    .padding(20)
                    
                    //                        .padding([.vertical, .bottom])
                    
                    Button(action: {
                        sendMessage()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .foregroundColor(setenta)
                    }
                    .padding(20)
                    //                        .padding([.top, .trailing])
                }
                .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
                .background(quarenta)
                .cornerRadius(30)
                //                        .padding([.top, .trailing])
                
                
                Spacer()
            }
            .padding(.horizontal, 16.0)
            
            .background(dez)
            
            .navigationTitle("Diary")
        }
    }
    
    private func sendMessage() {
        if !messageText.isEmpty {
            let newMessage = ChatMessage(title: messageTitle, text: messageText, date: Date())
            messages.append(newMessage)
            messageTitle = ""
            messageText = ""
            saveMessages()
        }
    }
    
    private func deleteMessage(at offsets: IndexSet) {
        messages.remove(atOffsets: offsets)
        saveMessages()
    }
    
    private func saveMessages() {
        if let encoded = try? JSONEncoder().encode(messages) {
            UserDefaults.standard.set(encoded, forKey: "chat_messages")
        }
    }
}

struct ChatMessage: Identifiable, Codable {
    var id: UUID = UUID()
    let title: String
    let text: String
    let date: Date
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    ChatView()
}
