dashboardPage(
  #argumen skin mengubah warna header menjadi merah
    skin = "red",
    dashboardHeader(title = "Plant Cycle Time FIMA"),
    
    dashboardSidebar(
        
        sidebarMenu(
          #tabName digunakan untuk ID tiap menuItem. disambungkan ke tabItem pada dashboardBody()
            menuItem("Plant Cycle Time Line 4", tabName = "Plant Cycle Time Line 4", icon = icon("fa-brands fa-github-square")),
            menuItem("Data", tabName = "data", icon = icon("table"))
        )
        
        
    ),
    dashboardBody(
    
        tabItems(

     
            # --------- HALAMAN KEDUA: Plant Cycle Time Line 4
            tabItem(
              tabName = "Plant Cycle Time Line 4",
                
                # --------- INPUT
                              fluidRow(
                                  box(
                                    width = 12,
                                    selectInput(
                                      inputId = "input_category", 
                                      label = "Choose Month", 
                                      choices = levels(PL4_RF$Bulan)
                                    )
                                  )
                                ),
                #--------- INFO BOXES
                                fluidRow(
                                    infoBox("BN release", a, icon = icon("fa-solid fa-building"), color = "red"),
                                    infoBox("LT Production", b, icon = icon("fa-solid fa-people-line"), color = "black"),
                                    infoBox("LT QC", c, icon = icon("fa-solid fa-sitemap"), color = "red"),
                                    infoBox("LT QA", d, icon = icon("fa-solid fa-sitemap"), color = "red")
                                ),
                
                # --------- POINT PLOT
                fluidRow(
                  # fungsi box tidak diberikan argumen title karena mengikuti title dari server
                  box(
                    width = 6,
                    title = "PCT Line 4",
                    plotlyOutput(outputId = "pointplot")
                  ),
                  
                  box(
                    width = 6,
                    title = "Distribution PCT Line 4",
                    plotlyOutput(outputId = "boxplot")
                  ),
                 
                  box(
                    width = 4,
                    title = "Daily Lead Time Production",
                    plotlyOutput(outputId = "lineplot1")
                  ),
                  box(
                    width = 4,
                    title = "Daily Lead Time QC",
                    plotlyOutput(outputId = "lineplot2")
                  ),
                  box(
                    width = 4,
                    title = "Daily Lead Time QA",
                    plotlyOutput(outputId = "lineplot3")
                  )
                )
            ),
            
            # --------- HALAMAN KETIGA: DATA
            tabItem(
                tabName = "data",
                DT::dataTableOutput(outputId = "table")
            )
        )
    )
)