Simple ReadME

CLI - App project will scrape the onthesnow website on the snow reports for US Ski Resorts http://www.onthesnow.com/united-states/skireport.html

It should also work for the Canadian Ski resorts from the below link for Canadian Ski Resorts
http://www.onthesnow.com/canada/skireport.html

CLI app:  

"***********************************"
*    Welcome to the Snow Status    *
"***********************************"

"Please Choose Region"
 Regions
 All
Sub-Menu
    1) "List all open resort as of (update date)"
    2) "List all resorts only open on weekends"
    3) "List all resorts that are open or open on weekends only"
    4) "List all resorts including closed resorts"
    5) "List all closed resorts"
    Sub-Menu - (resort details)
    - Resort name
       -Snow Fall
       - Base depth / upper depth
       -Lifts Open


** scrape table **

table = doc.css("table")
rows = table.css("tr")
rows.shift(2)
rows.pop
rows - array or nokogiri rows after first 2 rows

build class that instantiates resorts
