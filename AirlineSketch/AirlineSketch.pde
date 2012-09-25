int DIM_X = 10000;
int DIM_Y = 5000;

class Airport{
  int id;          //Unique ID
  String name;     //Airport Name
  String city;     //City
  String country;  //Country
  String faa;      //FAA or IATA code
  String icao;     //ICAO code
  float latitude;  //Latitude - decimal degrees
  float longitude; //Longitude - decimal degrees
  int x;
  int y;
  
  public Airport(String[] pieces){
    id = int(pieces[0]);
    name = pieces[1];
    city = pieces[2];
    country = pieces[3];
    faa = pieces[4];
    icao = pieces[5];
    latitude = float(pieces[6]);
    longitude = float(pieces[7]);
  }
}

class Route{
  String airline;        //Airline carrier code
  int airlineID;         //Airline ID
  String sourceAirport;  //Route Source Airport
  int sourceID;          //Source ID
  String destAirport;    //Route Destination Airport
  int destID;            //Destination ID
  int x1;
  int x2;
  int y1;
  int y2;
  PVector vec;
  
  public Route(String[] pieces){
    airline = pieces[0];
    airlineID = int(pieces[1]);
    sourceAirport = pieces[2];
    sourceID = int(pieces[3]);
    destAirport = pieces[4];
    destID = int(pieces[5]);
  }
}

Airport[] drawAirports(Airport[] airports){

  for(int i = 0; i < airports.length; ++i){
    airports[i].latitude = 90 - airports[i].latitude;
    airports[i].longitude = 180 + airports[i].longitude;
    
    airports[i].y = int(log(tan(0.25*PI+0.5*int(airports[i].latitude/180 * DIM_Y))));    
    airports[i].x = int(airports[i].longitude/360 * DIM_X);
    
    drawCircle(airports[i].x,airports[i].y);
  }
 
  return airports; 
}

Route[] drawRoutes(Airport[] airports, Route[] routes, int pieces){

  for(int i = 0; i < routes.length; ++i){
     int rest = 0;
     for(int j = 0; j < airports.length; ++j){
       
       if (routes[i].sourceID == airports[j].id){
         routes[i].x1 = int(airports[j].x);
         routes[i].y1 = int(airports[j].y);
       }
         
       if (routes[i].destID == airports[j].id){
         routes[i].x2 = int(airports[j].x);
         routes[i].y2 = int(airports[j].y);
       }
     }
     
     routes[i].vec = new PVector(routes[i].x2-routes[i].x1, routes[i].y2-routes[i].y1);     
    
     if ((routes[i].x1 == 0 && routes[i].y1 == 0) || (routes[i].x2 == 0 && routes[i].y2 == 0)){
       point(0,0);
     }
     else{
       drawLine(routes[i].x1, routes[i].x2, routes[i].y1, routes[i].y2); 
     }
  }
  
  return routes;
}

void drawCircle(int x, int y){
  smooth();
  fill(0);
  noStroke();
  ellipse(x, y, DIM_X/1000, DIM_X/1000);
}

void drawLine(int x1, int x2, int y1, int y2){
    smooth();
    stroke(0, 20);
    noFill();
     
    if ((x1 == 0 && y1 == 0) || (x2 == 0 && y2 == 0)){
      point(0,0);
    }
    else{
      //line(x1, y1, x2, y2);
      bezier(x1, y1, x1, y1-int(distance(x1,x2,y1,y2)/3), x2, y2-int(distance(x1,x2,y1,y2)/3), x2, y2);
    }
}

float distance(int x1, int x2, int y1, int y2){
  return (sqrt(sq(x1-x2)+sq(y1-y2)));
}

void setup(){
  background(255);
  size(DIM_X, DIM_Y);
  
  String[] airportData = null;
  String[] routeData = null;
  Airport[] airports = null;
  Route[] routes = null;
  
  int pieces = 5;

  airportData = loadStrings("airports.dat");
  routeData = loadStrings("routes.dat");
  
  airports = new Airport[airportData.length];
  routes = new Route[routeData.length];
  
  for(int i = 0; i < airportData.length; ++i){
    String[] airport = split(airportData[i], ',');
    airports[i] = new Airport(airport);
  }
  
  for(int i = 0; i < routeData.length; ++i){
    String[] route = split(routeData[i], ',');
    routes[i] = new Route(route); 
  }

  println("Rendering Airports");
  drawAirports(airports); 
  println("Rendering Routes");
  drawRoutes(airports, routes, pieces);
  
  println("Saving Image");
  save("output1.png");
}
