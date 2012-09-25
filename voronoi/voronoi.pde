import toxi.math.conversion.*;
import toxi.geom.*;
import toxi.math.*;
import toxi.geom.mesh2d.*;
import toxi.util.datatypes.*;
import toxi.util.events.*;
import toxi.geom.mesh.subdiv.*;
import toxi.geom.mesh.*;
import toxi.math.waves.*;
import toxi.util.*;
import toxi.math.noise.*;
import toxi.processing.*;

ToxiclibsSupport gfx;
Voronoi voronoi;
Vec2D[] sites;
Vec2D[] centroids;
PolygonClipper2D clip;

void setup() {
  size(1000, 1000);
  gfx = new ToxiclibsSupport(this);
  voronoi = new Voronoi();
  
  clip = new SutherlandHodgemanClipper(new Rect(0, 0, width, height));
  
  for (int i = 0; i < 100; ++i) {
    
    Vec2D site = new Vec2D(random(width), random(height));
    voronoi.addPoint(site);
  }
  
  smooth();
}

void draw() {
  
  for (Polygon2D polygon : voronoi.getRegions()) {
    
     strokeWeight(1);
     stroke(0);
     gfx.polygon2D(clip.clipPolygon(polygon));
     
     //strokeWeight(4);
     //stroke(0,0,255);
     //Vec2D centroid = polygon.getCentroid();
     //point(centroid.x, centroid.y); 
  }
  
  //strokeWeight(4);
  //stroke(255,0,0);
  //for (Vec2D site : voronoi.getSites()) {
  //   point(site.x, site.y);
  //}
  
   refreshVoronoi();
}

void refreshVoronoi() {
  
  Vec2D[] newSites = new Vec2D[voronoi.getRegions().size()];
  int i = 0;
  for(Polygon2D polygon : voronoi.getRegions()) {
    newSites[i] = clip.clipPolygon(polygon).getCentroid();
    ++i;
  }
  
  voronoi = new Voronoi();
  for(int j = 0; j < i; ++j) {
    
    if (!(newSites[j].x < 0 || newSites[j].x > width || newSites[j].y < 0 || newSites[j].y > height)) {
      voronoi.addPoint(newSites[j]);
    }
  }
}
