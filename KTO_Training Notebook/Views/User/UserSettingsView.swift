//
//  UserSettingsView.swift
//  KTO_Training Notebook
//
//  Created by Роман on 13.10.2024.
//

import SwiftUI

struct UserSettingsView: View {
    @Binding var isPresented: Bool
    @StateObject var vm: UserViewModel
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .onTapGesture {
                    isPresented.toggle()
                }
            VStack {
                Spacer()
                
                VStack {
                    Text("Your data")
                        .font(.title2)
                    VStack {
                        Image(.noExercises)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(8)
                        HStack{
                            VStack(alignment: .leading){
                                Text("Weight")
                                    .foregroundStyle(.white.opacity(0.7))
                                TextField("0 kg", text: $vm.weight)
                                    .padding()
                                    .background {
                                        Color.white.opacity(0.05).cornerRadius(12)
                                    }
                            }
                            VStack(alignment: .leading){
                                Text("Height")
                                    .foregroundStyle(.white.opacity(0.7))
                                TextField("0", text: $vm.height)
                                    .padding()
                                    .background {
                                        Color.white.opacity(0.05).cornerRadius(12)
                                    }
                            }
                        }
                        HStack{
                            VStack(alignment: .leading){
                                Text("Age")
                                    .foregroundStyle(.white.opacity(0.7))
                                TextField("0 kg", text: $vm.age)
                                    .padding()
                                    .background {
                                        Color.white.opacity(0.05).cornerRadius(12)
                                    }
                            }
                            VStack(alignment: .leading){
                                Text("% of fat")
                                    .foregroundStyle(.white.opacity(0.7))
                                TextField("0", text: $vm.fat)
                                    .padding()
                                    .background {
                                        Color.white.opacity(0.05).cornerRadius(12)
                                    }
                            }
                        }
                        Button {
                            vm.save()
                            isPresented.toggle()
                        } label: {
                            RedButtonView(text: "Save")
                        }

                        
                    }.padding()
                }.background {
                    Color.black
                       // .opacity(0.05)
                        .cornerRadius(12)
                }
            }
        }
    }
}

#Preview {
    UserSettingsView(isPresented: .constant(true), vm: UserViewModel())
}
