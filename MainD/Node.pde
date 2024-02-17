class Node {
  //x and y co-ordinates
  int x, y;
  double f = 0;
  double g = 1;
  double nodeID;
  // neighbours
  // This will check for whatever is next to be
  List<Node> neighbours = new ArrayList<Node>();
  // Parent node if this is the node being travelled. If not, this will be null.
  Node parent = null;
  // obstacle
  boolean obstacle = false;
  //The node will need to have parameters of where it is at
  Node(int xOne, int yOne) {
    // Basically .this
    x = xOne;
    y = yOne;
      if (random(1) < 0.4) {
        g = 2;
      }
    if (random(1) < 0.2) {
      g = 4;
    }
    if (random(1) < 0.1) {
      g = 8;
    }
    if (random(1) < 0.05) {
      g = 16;
    }
    //Here when the node is initialised, a random number is generated and
    //they will have a higher chance of being not an obstacle
    obstacle = false;
    if (random(1) < 0.45) {
      obstacle = true;
    }
  }
  // This will colour in the actual node if it is an obstacle, processing is amazing
  // Needs to be called in later in the main method
  void show() {
    if (g == 2) {
      fill(252, 240, 3);
      noStroke();
      rect( (x*w), (y*h), w, h);
    } else if (g == 4) {
      fill( 252, 140, 3);
      noStroke();
      rect( (x*w), (y*h), w, h);
    } else if (g == 8) {
      fill( 252, 73, 3);
      noStroke();
      rect( (x*w), (y*h), w, h);
    } else if (g == 16) {
      fill(118, 0, 173);
      noStroke();
      rect( (x*w), (y*h), w, h);
    }
    if (obstacle) {
      fill(0);
      noStroke();
      rect( (x*w), (y*h), w, h);
    }
  }
  //Also colours in things, colour will be defined later and
  //will colour in the explored paths, and the open paths.
  void show(color col) {
      if (g == 2) {
        fill(252, 240, 3);
        noStroke();
        rect( (x*w), (y*h), w, h);
      } else if (g == 4) {
        fill( 252, 140, 3);
        noStroke();
        rect( (x*w), (y*h), w, h);
      } else if (g == 8) {
        fill( 252, 73, 3);
        noStroke();
        rect( (x*w), (y*h), w, h);
      } else if (g == 16) {
        fill(118, 0, 173);
        noStroke();
        rect( (x*w), (y*h), w, h);
      }
    if (!obstacle) {
      fill(col);
      rect( (x*w), (y*h), w, h);
    }
  }
  // Find out what nodes surround the current node.
  // Also makes sure that there will always be neighbours to add.
  void addNeighbours(Node[][] grid) {
    if (x < columns-1) {
      neighbours.add(grid[x + 1][y]);
    }
    if (x > 0) {
      neighbours.add(grid[x - 1][y]);
    }
    if (y < rows - 1) {
      neighbours.add(grid[x][y + 1]);
    }
    if (y > 0) {
      neighbours.add(grid[x][y - 1]);
    }
    if (x > 0 && y > 0) {
      neighbours.add(grid[x - 1][y - 1]);
    }
    if (x < columns-1 && y > 0) {
      neighbours.add(grid[x + 1][y - 1]);
    }
    if (x > 0 && y < rows-1) {
      neighbours.add(grid[x - 1][y + 1]);
    }
    if (x < columns-1 && y < rows-1) {
      neighbours.add(grid[x + 1][y + 1]);
    }
  }
}
