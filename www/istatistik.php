<?php
	/* Database connection settings */
	$host = 'localhost';
	$user = 'root';
	$pass = '';
	$db = '2017469021';
    $mysqli = new mysqli($host,$user,$pass,$db) or die($mysqli->error);
    $mysqli -> set_charset("utf8");


	 /* //query to get data from the table
	 $sql = "SELECT iller.il_id, iller.orman_yogunlugu_yuzde FROM iller";
     $result = mysqli_query($mysqli, $sql);


	 //loop through the returned data
	 while ($row = mysqli_fetch_array($result)) {
	
	  
	 		while ($row = mysqli_fetch_array($result)) {
	 			echo "{'id'",":","'".$row['il_id']."','yuzde'",":".$row['orman_yogunlugu_yuzde']."},";
	 		}
	
     }  */
     
        $sql = "SELECT iller.il_ad as il_adi, bolge.bolge_ad as bolge_Adi, iller.orman_yogunlugu_yuzde as orman_yogunlugu_yuzde FROM iller,bolge WHERE iller.bolge_id=bolge.bolge_id AND iller.orman_yogunlugu_yuzde=(SELECT MAX(iller.orman_yogunlugu_yuzde) FROM iller)";
        $result = mysqli_query($mysqli, $sql);
        $enfazla=mysqli_fetch_assoc($result);
  

?>






<!DOCTYPE html>
<html>

<head>
    <title>Holding KDS</title>
    <meta charset="utf-8">
    <meta name="description" content="Drone ile Yemek Siparişi">
    <meta name="keyword" content="yemek,drone,hızlı sipariş">

    <link href="istatistik.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js">
    </script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script src="https://cdn.anychart.com/releases/v8/js/anychart-base.min.js"></script>
  <script src="https://cdn.anychart.com/releases/v8/js/anychart-ui.min.js"></script>
  <script src="https://cdn.anychart.com/releases/v8/js/anychart-exports.min.js"></script>


    <link href="https://playground.anychart.com/geodata/countries/Turkey/iframe" rel="canonical">
  <meta content="Choropleth Map,Geo Chart,Geo Visualization" name="keywords">
  <meta content="AnyChart - JavaScript Charts designed to be embedded and integrated" name="description">
  <!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
  <link href="https://cdn.anychart.com/releases/v8/css/anychart-ui.min.css" rel="stylesheet" type="text/css">
  
    
</head>

<body>
    <div class="sidebar">
            <div class="title">
                <div class= "logo">
                    <img class="logo1" src="01761456-586a-4bcd-b487-672a4c665025_200x200.png">
                </div>
            </div>
            <div class="dot">
                <i class="fas fa-ellipsis-h"></i>
            </div>
            <div class="sidebarnotif">
                    <div class="message">
                        <div class="note">
                            <a href="index.php" title="Anasayfa" class="anasayfa">
                                <i class="fas fa-home"></i>
                            </a>
                        </div>
                    </div>
                <div class= "note2">
                    <a href="harita.php" title="Ağaç Türlerinin Yayılış Haritaları" class="harita1">
                        <i class="far fa-envelope"></i>
                    </a>
                </div>
                <div class= "note3">
                    <a href="harita2.php" title="Yangın Risk Haritası" class="harita2">
                        <i class="fab fa-gripfire"></i> 
                    </a>
                    
                </div>
                <div class=  "note4">
                      <a href="istatistik.php" title="İl Bazlı İstatistikler" class="istatistik1">
                        <i class="far fa-chart-bar"></i>
                      </a>        
                </div>

                <div class=  "note5">
                    <a href="agac.php" title="Ağaçlar" class="agac">
                      <i class="fab fa-canadian-maple-leaf"></i>
                    </a>        
                </div>
                <div class=  "note6">
                    <a href="sonuc.php" title="Sonuç Analizi" class="sonuc">
                    <i class="fas fa-poll"></i>
                    </a> 
                </div>
            </div>
        </div>


    <div class="content">
        <div class="header">
           

            <div class="not">
                <i class="fas fa-th-large"></i>
                <i class="fas fa-bell"></i>
                <i class="fas fa-circle"></i>
                <i class="fas fa-ellipsis-v"></i>
            </div>
            <div class="headerInfo">
                <img src="https://www.haberler.com/trend/71/henry-cavill_9044_b.jpg">
                <span>Oğulcan Galata</span>
                <i class="fas fa-arrow-down"></i>
            </div>
        </div>
        <div class="main">
            <div class="nav">
                <span class="dash">Analizler</span>
                <div class="navigation">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Home</span>
                    <span>></span>
                    <span>Analizler</span>
                </div>
            </div>

        </div>
        <div class="box">
            <div class="boxes1">
                <div class="box1">
                    <div id="container"></div>
                    <script>

    anychart.onDocumentReady(function () {
      // create bar chart
      var chart = anychart.bar();

      chart.animation(true);

      chart.padding([10, 40, 5, 20]);

      chart.title("Ormanlık Alanın En Yüksek Olduğu 10 İl");

      // create bar series with passed data
      var series = chart.bar([
        <?php
        $sql = "SELECT iller.il_ad as il_adlari,iller.orman_yogunlugu_yuzde as il_orman_yogunlugu_orani
        FROM iller
        ORDER BY iller.orman_yogunlugu_yuzde DESC
        LIMIT 10";
          $result = mysqli_query($mysqli, $sql);
      
          
          $i = 0;
          //loop through the returned data
          while ($row = mysqli_fetch_array($result)) {
            echo "['".$row['il_adlari']."',".$row['il_orman_yogunlugu_orani'].",","'","#2e8024","'","],";
            
          }
        
        ?>
      ]);

      // set tooltip settings
      series
        .tooltip()
        .position('right')
        .anchor('left-center')
        .offsetX(5)
        .offsetY(0)
        .titleFormat('{%X}')
        .format('%{%Value}');

      // set yAxis labels formatter
      chart.yAxis().labels().format('{%Value}{groupsSeparator: }');

      // set titles for axises
      chart.xAxis().title('');
      chart.yAxis().title('Yüzde');
      chart.interactivity().hoverMode('by-x');
      chart.tooltip().positionMode('point');
      // set scale minimum
      chart.yScale().minimum(0);

      // set container id for the chart
      chart.container('container');
      // initiate chart drawing
      chart.draw();
    });
  
</script>
                </div>
                <div class="box2">
                <div id="container2"></div>
                    <script>

    anychart.onDocumentReady(function () {
      // create bar chart
      var chart = anychart.bar();

      chart.animation(true);

      chart.padding([10, 40, 5, 20]);

      chart.title("Ormanlık Alanın En Az Olduğu 10 İl");

      // create bar series with passed data
      var series = chart.bar([
        <?php
        $sql = "SELECT iller.il_ad as il_adlari,iller.orman_yogunlugu_yuzde as il_orman_yogunlugu_orani
        FROM iller
        ORDER BY iller.orman_yogunlugu_yuzde ASC
        LIMIT 10";
          $result = mysqli_query($mysqli, $sql);
      
          
          $i = 0;
          //loop through the returned data
          while ($row = mysqli_fetch_array($result)) {
            echo "['".$row['il_adlari']."',".$row['il_orman_yogunlugu_orani'].",","'","#2e8024","'","],";
            
          }
        
        ?>
      ]);

      // set tooltip settings
      series
        .tooltip()
        .position('right')
        .anchor('left-center')
        .offsetX(5)
        .offsetY(0)
        .titleFormat('{%X}')
        .format('%{%Value}');

      // set yAxis labels formatter
      chart.yAxis().labels().format('{%Value}{groupsSeparator: }');

      // set titles for axises
      chart.xAxis().title('');
      chart.yAxis().title('Yüzde');
      chart.interactivity().hoverMode('by-x');
      chart.tooltip().positionMode('point');
      // set scale minimum
      chart.yScale().minimum(0);

      // set container id for the chart
      chart.container('container2');
      // initiate chart drawing
      chart.draw();
    });
  
</script>
                </div>
            </div>
        <div class="boxe2">
            <div class="boxes2">
                <div class="box3">
                    <div id="container3"></div>
                    <script>

    anychart.onDocumentReady(function () {
      // create bar chart
      var chart = anychart.bar();

      chart.animation(true);

      chart.padding([10, 40, 5, 20]);

      chart.title('Kişi Başına En Çok Orman Alanı Düşen İller');

      // create bar series with passed data
      var series = chart.bar([
        ['Tuncel', '27.8'],
        ['Artvin', '23.2'],
        ['Kastamonu', '22.8'],
        ['Bolu', '17.1'],
        ['Sinop', '16.7'],
        ['Gümüşhane', '14.7'],
        ['Burdur', '12.3'],
        ['Karabük', '11.2'],
        ['Kütahya', '11.2'],
        ['Bilecik', '10.8']
      ]);

      // set tooltip settings
      series
        .tooltip()
        .position('right')
        .anchor('left-center')
        .offsetX(5)
        .offsetY(0)
        .titleFormat('{%X}')
        .format('{%Value}');

      // set yAxis labels formatter
      chart.yAxis().labels().format('{%Value}{groupsSeparator: }');

      // set titles for axises
      chart.xAxis().title('');
      chart.yAxis().title('');
      chart.interactivity().hoverMode('by-x');
      chart.tooltip().positionMode('point');
      // set scale minimum
      chart.yScale().minimum(0);

      // set container id for the chart
      chart.container('container3');
      // initiate chart drawing
      chart.draw();
    });
  
</script>

                </div>
                <div class="box4">
                    <div id="container4"></div>
                    <script>

    anychart.onDocumentReady(function () {
      // create bar chart
      var chart = anychart.bar();

      chart.animation(true);

      chart.padding([10, 40, 5, 20]);

      chart.title('Kişi Başına En Az Orman Alanı Düşen İller');

      // create bar series with passed data
      var series = chart.bar([
        ['Iğdır', '0.008'],
        ['Şanlıurfa', '0.07'],
        ['Ağrı', '0.1'],
        ['İstanbul', '0.16'],
        ['Nevşehir', '0.37'],
        ['Van', '0.4'],
        ['Gaziantep', '0.55'],
        ['Aksaray', '0.56'],
        ['Kocaeli', '0.75'],
        ['Ankara', '0.82']
      ]);

      // set tooltip settings
      series
        .tooltip()
        .position('right')
        .anchor('left-center')
        .offsetX(5)
        .offsetY(0)
        .titleFormat('{%X}')
        .format('{%Value}');

      // set yAxis labels formatter
      chart.yAxis().labels().format('{%Value}{groupsSeparator: }');

      // set titles for axises
      chart.xAxis().title('');
      chart.yAxis().title('');
      chart.interactivity().hoverMode('by-x');
      chart.tooltip().positionMode('point');
      // set scale minimum
      chart.yScale().minimum(0);

      // set container id for the chart
      chart.container('container4');
      // initiate chart drawing
      chart.draw();
    });
  
</script>
                </div>
            </div>
        </div>
            
                

            
                
                
            </div>
        </div>

    </div>







</body>

</html>