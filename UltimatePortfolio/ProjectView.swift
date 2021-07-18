//
//  ProjectView.swift
//  UltimatePortfolio
//
//  Created by Charles Johler on 16.07.21.
//

import SwiftUI

struct ProjectView: View {
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    
    static let openTag: String? = "Open"
    static let closedTag: String? = "Closed"
    
    let showClosedProjects: Bool
    
    let projects: FetchRequest<Project>
    
    init(showClosedProjects: Bool){
        self.showClosedProjects = showClosedProjects
        
        projects = FetchRequest<Project>(entity: Project.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)], predicate: NSPredicate(format: "closed = %d", showClosedProjects))
        
    }
    var body: some View {
        NavigationView {
            List {
                ForEach(projects.wrappedValue){ project in
                    Section(header: ProjectHeaderView(project: project)){
                            // for later
                            //                        ForEach(project.projectItems, content: ItemRowView.init)
                            //
                        ForEach(project.projectItems) { item in
                            ItemRowView(item: item)
                        }
                        .onDelete { offsets in
                            let allItems = project.projectItems
                                //print(project.projectItems.count)
                            
                            for offset in offsets {
                                let item = allItems[offset]
                                dataController.delete(item)
                            }
                                //print(project.projectItems.count)
                            
                            dataController.save()
                        }
                        
                        if showClosedProjects == false {
                            Button {
                                withAnimation {
                                    let item = Item(context: managedObjectContext)
                                    item.project = project
                                    item.creationDate = Date()
                                    dataController.save()
                                }
                            } label : {
                                Label("Add new item", systemImage: "plus")
                            }
                        }
                    }
                }
            }
            
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(showClosedProjects ? "Closed Projects" : "Open Projects")
            .toolbar {
                if showClosedProjects == false {
                    Button {
                        withAnimation {
                            let project = Project(context: managedObjectContext)
                            project.closed = false
                            project.creationDate = Date()
                            dataController.save()
                        }
                    } label : {
                        Label("Add new Project", systemImage: "plus")
                    }
                }
            }
        }
    }
    
}

struct ProjectView_Previews: PreviewProvider {
    static var dataController = DataController.preview
    
    static var previews: some View {
        ProjectView(showClosedProjects: false)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)

    }
}
