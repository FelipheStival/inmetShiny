

 ui = dashboardPage(
    
   #========================header=========================
    
   dashboardHeader( title =  APP_NAME),
   
   #=======================================================
   
   
   #=======================SiderBar========================
   
   dashboardSidebar(
      sidebarMenu(
         itemMenuMapa(),
         itemMenuAnalise(),
         itemMenuGraficos(),
         itemFiltroUI()
      )
   ),
   
   #========================================================
   
   
   #=======================body=============================
   
   dashboardBody(
      tabItems(
         createAnaliseUI(),
         createMapaUI(),
         createdadosPerdidosUI(),
         createMapaMatrizUI(),
         createPrecipitacaoUI(),
         createPrecipitacaoCumulativaUI(),
         createPeriodoChuvosoUI()
      )
   )
   
   #========================================================
 )
