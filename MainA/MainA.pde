import java.util.*;

// For running A* Search
float heuristic(Node a, Node b) {
  // chebyshev distance is needed
  // chebyshev of x,y is the max(abs(x1-x2), abs(y1 - y2))
  float d;
  float xMax = abs(a.x - b.x);
  float yMax = abs(a.y - b.y);
  if (xMax >= yMax) {
    d = xMax;
  } else {
    d = yMax;
  }
  return d;
}
// columns and rows
int columns = 100;
int rows = 100;
double pathCost;
// This will be the 2D array that has the coordinates of all the things(Nodes)
Node[][] grid = new Node[columns][rows];
// Open and closed set
List<Node> openSet = new ArrayList<Node>();
List<Node> closedSet = new ArrayList<Node>();
// Start and goal
Node start;
Node goal;
Node current;
Node necessaryEvil;
// Width and height of each cell of grid
float w, h;
// The road taken
List<Node> path = new ArrayList<Node>();
void setup() {
  size(800, 800);
  println("A*");
  // Grid cell size
  w = float(width) / columns;
  h = float(height) / rows;
  for (int i = 0; i < columns; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j] = new Node(i, j);
    }
  }
  // Start and goal
  start = grid[0][0];
  goal = grid[columns - 1][rows - 1];
  necessaryEvil = grid[columns - 1][0];
  necessaryEvil.obstacle = true;
  start.obstacle = false;
  goal.obstacle = false;
  // All the neighbours
  for (int i = 0; i < columns; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].addNeighbours(grid);
    }
  }
  // openSet starts with beginning only
  openSet.add(start);
}
void draw() {
  // Am I still searching?
  if (openSet.size() > 0) {
    // Best next option
    // acts as a queue head check function
    int winner = 0;
    for (int i = 0; i < openSet.size(); i++) {
      if (openSet.get(i).f < openSet.get(winner).f) {
        winner = i;
      }
    }
    current = openSet.get(winner);
    // Did I finish?
    if (current == goal) {
      noLoop();
      println("Finished");
      println("Exiting at " + millis()/1000.0 + " seconds");
      println("Cost of the route is " + pathCost);
    }
    // Best option moves from openSet to closedSet
    openSet.remove(current);
    closedSet.add(current);
    // Check all the neighbours
    List<Node> neighbours = current.neighbours;
    for (int i = 0; i < neighbours.size(); i++) {
      Node neighbour = neighbours.get(i);
      // Valid next Node?
      if (!closedSet.contains(neighbour) && !neighbour.obstacle) {
        neighbour.heuristic = heuristic(neighbour, goal);
        float tempF = neighbour.g + neighbour.heuristic;
        // Is this a better path than before?
        boolean newPath = false;
        if (openSet.contains(neighbour)) {
          if (tempF < neighbour.f) {
            neighbour.f = tempF;
            newPath = true;
          }
        } else {
          neighbour.f = tempF;
          newPath = true;
          openSet.add(neighbour);
        }
        // Yes, it's a better path
        if (newPath) {
          neighbour.f = neighbour.g + neighbour.heuristic;
          neighbour.parent = current;
        }
      }
    }
  } else {
    // There is a chance where there is no path.
    println("no solution");
    noLoop();
    return;
  }
  // Draw everything, background is white
  background(255);
  // Draws whatever node is there
  for (int i = 0; i < columns; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].show();
    }
  }
  for (int i = 0; i < closedSet.size(); i++) {
    closedSet.get(i).show(color(255, 0, 0, 100));
  }
  for (int i = 0; i < openSet.size(); i++) {
    openSet.get(i).show(color(0, 255, 0, 100));
  }
  // Find the path by working backwards
  List<Node> path = new ArrayList<Node>();
  Node temp = current;
  path.add(temp);
  pathCost = 0;
  while (temp.parent != null) {
    pathCost = pathCost + temp.g;
    path.add(temp.parent);
    temp = temp.parent;
  }
  // Drawing path as continuous line
  noFill();
  stroke(255, 0, 200);
  strokeWeight(w / 2);
  beginShape();
  for (int i = 0; i < path.size(); i++) {
    vertex(path.get(i).x * w + w / 2, path.get(i).y * h + h / 2);
  }
  endShape();
  /*
  //randomise the rest of the map
  for (int i = 0; i < columns; i++) {
  for (int j = 0; j < rows; j++) {
  Node currentNodeTwo = grid[i][j];
  if (!closedSet.contains(currentNodeTwo) && !openSet.contains(currentNodeTwo)){
  currentNodeTwo.makeThingsChange(grid);
  }
  }
  }
  for (int i = 0; i < columns; i++) {
  for (int j = 0; j < rows; j++) {
  Node currentNodeTwo = grid[i][j];
  List<Node> neighboursAgain = currentNodeTwo.neighbours;
  for (int k = 0; k < neighboursAgain.size(); k++) {
  Node neighbourAgain = neighboursAgain.get(k);
  // Valid next Node?
  if (closedSet.contains(neighbourAgain) && !neighbourAgain.obstacle) {
  neighbourAgain.heuristic = heuristic(neighbourAgain, goal);
  float tempG = neighbourAgain.g + neighbourAgain.heuristic;
  // Is this a better path than before?
  if (openSet.contains(neighbourAgain)) {
  if (tempG < neighbourAgain.g) {
  neighbourAgain.g = tempG;
  }
  } else {
  neighbourAgain.g = tempG;
  openSet.add(neighbourAgain);
  }
  }
  }
  }
  }
  */
}
