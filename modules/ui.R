


ui = dashboardPage(
   #========================header=========================
   
   dashboardHeader(title =  APP_NAME),
   
   #=======================================================
   
   
   #=======================SiderBar========================
   
   dashboardSidebar(
      sidebarMenu(
         itemMenuMapa(),
         itemMenuAnalise(),
         itemMenuTabela(),
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
         createPeriodoChuvosoUI(),
         createTabelaUI(),
         createGraficoBasicoUI(),
         createDiaSecoUmidoUI()
      )
   )
   
   #========================================================
)
