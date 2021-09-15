global.solvedRooms = 0;

// tile 1
inst_tile1.leftRef = inst_tile3;
inst_tile1.rightRef = inst_tile2;
inst_tile1.upRef = inst_tile3;
inst_tile1.downRef = inst_tile4;

// tile 2

inst_tile2.leftRef = inst_tile1;
inst_tile2.rightRef = inst_tile3;
inst_tile2.upRef = inst_tile8;
inst_tile2.downRef = inst_tile5;

// tile 3

inst_tile3.leftRef = inst_tile2;
inst_tile3.rightRef = inst_tile1;
inst_tile3.upRef = inst_tile9;
inst_tile3.downRef = inst_tile6;

// tile 4

inst_tile4.leftRef = inst_tile6;
inst_tile4.rightRef = inst_tile1;
inst_tile4.upRef = inst_tile9;
inst_tile4.downRef = inst_tile6;

// tile 5

inst_tile5.leftRef = inst_tile4;
inst_tile5.rightRef = inst_tile6;
inst_tile5.upRef = inst_tile2;
inst_tile5.downRef = inst_tile8;

// tile 6

inst_tile6.leftRef = inst_tile5;
inst_tile6.rightRef = inst_tile4;
inst_tile6.upRef = inst_tile3;
inst_tile6.downRef = inst_tile9;

// tile 7

inst_tile6.leftRef = inst_tile5;
inst_tile6.rightRef = inst_tile4;
inst_tile6.upRef = inst_tile3;
inst_tile6.downRef = inst_tile9;

// tile 7
inst_tile7.leftRef = inst_tile9;
inst_tile7.rightRef = inst_tile8;
inst_tile7.upRef = inst_tile4;
inst_tile7.downRef = inst_tile1;

// tile 8
inst_tile8.leftRef = inst_tile7;
inst_tile8.rightRef = inst_tile9;
inst_tile8.upRef = inst_tile5;
inst_tile8.downRef = inst_tile2;

// tile 9
inst_tile9.leftRef = inst_tile8;
inst_tile9.rightRef = inst_tile7;
inst_tile9.upRef = inst_tile6;
inst_tile9.downRef = inst_tile3;

