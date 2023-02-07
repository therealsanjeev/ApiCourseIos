//
//  ContentView.swift
//  ApiCourses
//
//  Created by Sanjeev Gupta on 07/02/23.
//

import SwiftUI


struct URLImage: View{
    let urlString: String
    
    @State var data: Data?
    var body: some View{
        
        if let data = data, let uiimage = UIImage(data: data){
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width: 130, height: 70)
                .background(Color.gray)
                
        } else{
            Image(systemName: "Video")
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width: 130, height: 70)
                .background(Color.gray)
                .onAppear{
                    fetchData()
                }
            
            
        }
    }
    
    private func fetchData(){
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data, _,_ in
            
            self.data = data
        }
        task.resume()
        
    }
}
struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()7788
    var body: some View {
        
        NavigationView{
            List{
                
                ForEach(viewModel.courses, id: \.self){ course in
                    HStack{
                        
                        URLImage(urlString: course.image)
                        
                        Text(course.name)
                            .bold()
                    }
                    .padding(
                    )
                    
                }
            }
            .navigationTitle("Courses")
            .onAppear{
                viewModel.fetch()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
