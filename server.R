function(input, output) {
    
    
    # # --------- HALAMAN PERTAMA: OVERVIEW
    # 
    # output$lollipop <- renderPlotly({
    # 
    #     # ggplot
    #   plot1 <- ds_sal_top10 %>%
    #     ggplot(aes(x = salary_in_usd,
    #                y = reorder(job_title, salary_in_usd),
    #                color = salary_in_usd,
    #                text = label)) +
    #     geom_point(size = 3) +
    #     geom_segment(aes(x = 0,
    #                      xend = salary_in_usd,
    #                      yend = job_title),
    #                  size = 1) +
    #     labs(x = 'Salary in USD',
    #          y = NULL) +
    #     scale_color_gradient(low = "Blue", high = "green") +
    #     scale_x_continuous(labels = scales::comma) +
    #     theme_minimal() +
    #     theme(legend.position = "none",
    #           plot.margin = margin(r = 20))
    # 
    #     # plotly
    #   ggplotly(plot1, tooltip = "text")
    # 
    # })
    # 
    # output$barplot <- renderPlotly({
    # 
    #   # ggplot
    #   plot2 <- ds_sal_type_top5 %>%
    #     ggplot(aes(x = count,
    #                y = reorder(job_title, count),
    #                fill = count,
    #                text = label)) +
    #     geom_col() +
    #     scale_fill_gradient(low = "green", high = "orange") +
    #     theme_minimal() +
    #     theme(legend.position = "none") +
    #     labs(x = 'Job Count',
    #          y = NULL)
    # 
    #   # plotly
    #   ggplotly(plot2, tooltip = "text")
    # 
    # })
    
  # --------- HALAMAN KEDUA: Infobox
 
  a <- PL4_RF %>%
    filter(Bulan==input$input_category) %>% 
    group_by(Bulan) %>% 
    summarise(count = n()) %>% 
    arrange(desc(count)) %>% 
    ungroup()
  
  b <- PL4_RF %>%
    filter(Bulan==input$input_category) %>%
    group_by(Bulan) %>% 
    summarise(mean.LTP = mean(LT.Produksi)) %>% 
    arrange(desc(mean.LTP)) %>% 
    ungroup()
  
  c <- PL4_RF %>%
    filter(Bulan==input$input_category) %>%
    group_by(Bulan) %>% 
    summarise(mean.LTP = mean(LT.QC)) %>% 
    arrange(desc(mean.LTP)) %>% 
    ungroup()
  
  d <- PL4_RF %>%
    filter(Bulan==input$input_category) %>%
    group_by(Bulan) %>% 
    summarise(mean.LTP = mean(LT.QA)) %>% 
    arrange(desc(mean.LTP)) %>% 
    ungroup()  
  
  
  
  
  # --------- HALAMAN KEDUA: PCT Line 4
    
    output$pointplot <- renderPlotly({
        
      e <- PL4_RF %>% 
        filter(Bulan==input$input_category) %>% 
        group_by(Bulan) %>% 
        summarise(mean.LT.Line4 = mean(LT.Line4)) %>% 
        mutate(label = glue("Bulan: {Bulan}
                      PCT Line 4: {mean.LT.Line4} days"))
      
      plot1 <- e %>% 
        ggplot(aes(x = Bulan,
                   y = mean.LT.Line4,
                   text = label)) + 
        geom_col(fill="green")+
        theme_minimal() +
        geom_hline(yintercept = 16)+
        theme(legend.position = "none") +
        labs(title = "Plant Cycle Time Line 4",
             x = 'Bulan',
             y = 'Plant Cycle Time')
      
      ggplotly(plot1, tooltip = "text")
        
        
    })
    
    
    output$boxplot <- renderPlotly({
      
      ea <- PL4_RF %>% 
        filter(Bulan==input$input_category) %>% 
        group_by(Bulan) %>% 
        mutate(label = glue("Bulan: {Bulan}
                      PCT Line 4: {LT.Line4} days"))
      
      plot12 <- ggplot(data = ea, mapping = aes(x = Bulan, y = LT.Line4, text=label)) +
        geom_boxplot()+
        geom_jitter()+
        theme_minimal()+
        labs(title = "Distribution PCT Line 4",
             x = NULL,
             y = "Lead Time")
      
      ggplotly(plot12, tooltip = "text")
      
      
    })
    
    output$lineplot1 <- renderPlotly({
        
      g <- PL4_RF %>% 
        filter(Bulan==input$input_category) %>% 
        tail(10) %>% 
        mutate(label = glue("Batch No.: {BN}
                      LT.Produksi: {LT.Produksi} days"))
      
      plot3 <- g %>% 
        ggplot(aes(x = BN,
                   y = LT.Produksi)) +
        geom_line(aes(group=1), color = "red") +
        geom_hline(yintercept = 2)+
        geom_point(aes(text = label)) +
        scale_y_continuous(labels = scales::comma) +
        labs(title = "Lead Time Production per BN",
             x = NULL,
             y = "Lead Time") +
        theme_minimal()
      
      ggplotly(plot3, tooltip = "text")
        
    })
    
    output$lineplot2 <- renderPlotly({
      
      h <- PL4_RF %>% 
        filter(Bulan==input$input_category) %>% 
        tail(10) %>% 
        mutate(label = glue("Batch No.: {BN}
                      LT.QC: {LT.QC} days"))
      
      plot4 <- h %>% 
        ggplot(aes(x = BN,
                   y = LT.QC)) +
        geom_line(aes(group=1), color = "red") +
        geom_point(aes(text = label)) +
        geom_hline(yintercept = 14)+
        scale_y_continuous(labels = scales::comma) +
        labs(title = "Lead Time QC per BN",
             x = NULL,
             y = "Lead Time") +
        theme_minimal()
      
      ggplotly(plot4, tooltip = "text")
      
    })
    
    output$lineplot3 <- renderPlotly({
      
      i <- PL4_RF %>% 
        filter(Bulan==input$input_category) %>% 
        tail(10) %>% 
        mutate(label = glue("Batch No.: {BN}
                      LT.QA: {LT.QA} days"))
      
      plot5 <- i %>% 
        ggplot(aes(x = BN,
                   y = LT.QA)) +
        geom_line(aes(group=1), color = "red") +
        geom_point(aes(text = label)) +
        geom_hline(yintercept = 0.1)+
        scale_y_continuous(labels = scales::comma) +
        labs(title = "Lead Time QA per BN",
             x = NULL,
             y = "Lead Time") +
        theme_minimal()
      
      ggplotly(plot5, tooltip = "text")
      
    })
    
    # --------- HALAMAN KETIGA: DATA
    output$table <- renderDataTable({
        
        DT::datatable(PL4_R,
                  #argumen/parameter agar dataframe dapat discroll
                  options = list(scrollX = TRUE))
        
    })
    
    
}