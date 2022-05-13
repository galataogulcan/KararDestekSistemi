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

    <link href="harita.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js">
    </script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>


    <link href="https://playground.anychart.com/geodata/countries/Turkey/iframe" rel="canonical">
  <meta content="Choropleth Map,Geo Chart,Geo Visualization" name="keywords">
  <meta content="AnyChart - JavaScript Charts designed to be embedded and integrated" name="description">
  <!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
  <link href="https://cdn.anychart.com/releases/v8/css/anychart-ui.min.css" rel="stylesheet" type="text/css">
  

    <script type="text/javascript">
        google.charts.load('current', {
            'packages': ['corechart']
        });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {

            var data = google.visualization.arrayToDataTable([
                ['Task', 'Hours per Day'],
                <?php

            $sql = "SELECT bolge.bolge_ad ,avg(iller.orman_yogunlugu_yuzde) as yogunluk FROM iller,bolge WHERE iller.bolge_id=bolge.bolge_id GROUP BY bolge.bolge_ad  ";
            $result = mysqli_query($mysqli, $sql);

    
        
        
            
              
                while ($row = mysqli_fetch_array($result)) {
                    echo "['".$row['bolge_ad']."',".$row['yogunluk']."],";
                }


            
        

        ?>

            ]);

            var options = {
                title: 'Bölgelerin Toplam Orman Yoğunluğu'
            };

            var chart = new google.visualization.PieChart(document.getElementById('piechart'));

            chart.draw(data, options);
        }
    </script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['Tarım',     31.1],
          ['Orman',      27.6],
          ['Su',  1.4],
          ['Mera', 18.6],
          ['Diğer',    21.3]
        ]);

        var options = {
          title: 'Türkiye Arazi Durumu',
          is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
        chart.draw(data, options);
      }
    </script>
   

    <style>
         table, th ,td{
             border:1px solid black;
             
             
         }
     </style>
    
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
                <span class="dash">Ağaç Türleri Yayılış Haritaları</span>
                <div class="navigation">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Home</span>
                    <span>></span>
                    <span>Ağaç Türleri Haritaları</span>
                </div>
            </div>

        </div>
        <div class=boxes>
            <div class=box1>
                <img src="genişYapraklıAgac.png">
            </div>
            
            <div class="box2">
                <img src="ibreliyayılış.png">
            </div>
        </div>







</body>

</html>