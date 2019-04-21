%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Optimal path: starting from the last node, backtrack to
% its parent nodes until it reaches the start node
% 04-26-2005    Copyright 2009-2010 The MathWorks, Inc.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Optimal_path = [];
QUEUE_COUNT = size(QUEUE, 1);
xval = QUEUE(QUEUE_COUNT, 2);
yval = QUEUE(QUEUE_COUNT, 3);
maze(xTarget, yTarget)=5;%maze(xval, yval)=5;
dispMaze(maze);                       %queue是从起点到目标点

temp = QUEUE_COUNT;         
while(((xval ~= xTarget) || (yval ~= yTarget)) && temp > 0)   %从目标点到起点回溯，从上到下
    temp = temp-1;
    xval = QUEUE(temp, 2);
    yval = QUEUE(temp, 3);
       
end

i = 1;
Optimal_path(i, 1) = xval;  %应该是放路径点的坐标
Optimal_path(i, 2) = yval;
%%%%%%%%%%%%%


if ((xval == xTarget) && (yval == yTarget))         %从起点到目标点
    inode = 0;
    % Traverse QUEUE and determine the parent nodes
    parent_x = QUEUE(index(QUEUE, xval, yval), 4);
    parent_y = QUEUE(index(QUEUE, xval, yval), 5);
   
    maze(parent_x,parent_y)=5;%%%%%%%%%    
    dispMaze(maze);%%%%%%%%%%%%%%%%%%%%
    
    while(parent_x ~= xStart || parent_y ~= yStart)
        i = i + 1;
        Optimal_path(i, 1) = parent_x; % store nodes on the optimal path
        Optimal_path(i, 2) = parent_y;
        inode = index(QUEUE, parent_x, parent_y); % find the grandparents :)
        parent_x = QUEUE(inode, 4);
        parent_y = QUEUE(inode, 5);
        maze(parent_x,parent_y)=5;%%%%%%%%%%
        dispMaze(maze);%%%%%%%%%%%%%%%%%%%%
       
    end;
    Optimal_path(i+1,1) = xStart;    % add start node to the optimal path  
    Optimal_path(i+1,2) = yStart;
end;

    