%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A* ALGORITHM Demo
% 04-26-2005    Copyright 2009-2010 The MathWorks, Inc.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Matlab Basics
%{
    % "MATLAB Overview" @ MathWorks
    % "Writing a Matlab Program" @ MathWorks
    % Choose your working folder, where all Astar files are saved
    % Understand step-by-step the source code, and start working on Coursework 1
%}
function AStarMazeSolver(maze)

%% define the problem via GUI
%problem();
MAX_X=size(maze,1);
MAX_Y=MAX_X;
% OBSTACLE: [X val, Y val]
OBSTACLE = [];
k = 1;
for i = 2 : MAX_X-1
    for j = 2 : MAX_Y-1
        if(maze(i, j) == 0)
            OBSTACLE(k, 1) = i; %检索所有点，如果有一个点是障碍，那么就把这个点的坐标写到excel上，1列x值，2列y值
            OBSTACLE(k, 2) = j;
            k = k + 1;
        end
    end
end
for i = 1 : MAX_X
    for j = 1 : MAX_Y
        if (maze(i,j) == 3)
            xStart=i-1;
            yStart=j;
        end
        if (maze(i,j) == 4)
            xTarget=i+1;
            yTarget=j;
        end
    end
end     
OBST_COUNT = size(OBSTACLE, 1); %有几个障碍点
OBST_COUNT = OBST_COUNT + 1;
OBSTACLE(OBST_COUNT, :) = [xStart, yStart];

%% add the starting node as the first node (root node) in QUEUE
% QUEUE: [0/1, X val, Y val, Parent X val, Parent Y val, g(n),h(n), f(n)]
xNode = xStart;    %把起始点赋值给节点node
yNode = yStart;
QUEUE = [];         %声明队列，队列数初始为1
QUEUE_COUNT = 1;
NoPath = 1; % assume there exists a path
path_cost = 0; % cost g(n): start node to the current node n    %g(n)=0,已走过距离
goal_distance = distance(xNode, yNode, xTarget, yTarget); % cost h(n): heuristic cost of n
QUEUE(QUEUE_COUNT, :) = insert(xNode, yNode, xNode, yNode, path_cost, goal_distance, goal_distance);%赋值整个第一行
QUEUE(QUEUE_COUNT, 1) = 0; % What does this do? %说明这个点是

%% Start the search
while((xNode ~= xTarget || yNode ~= yTarget) && NoPath == 1) %当节点不和终点重合且有路径
    
    % expand the current node to obtain child nodes
    exp = expand(xNode, yNode, path_cost, xTarget, yTarget, OBSTACLE, MAX_X, MAX_Y);
    exp_count = size(exp, 1); %exp-count代表扩展了多少个点，一次最多有8个
    % Update QUEUE with child nodes; exp: [X val, Y val, g(n), h(n), f(n)]
    for i = 1 : exp_count     
        flag = 0;
        for j = 1 : QUEUE_COUNT
            if(exp(i, 1) == QUEUE(j, 2) && exp(i, 2) == QUEUE(j, 3))  %第i个扩张点和第j个插入点相同
                QUEUE(j, 8) = min(QUEUE(j, 8), exp(i, 5));        %f(n)(queue)=queue和exp的f(n)的最小值
                if (QUEUE(j, 8) == exp(i, 5))   %如果2个f(n)相等
                    % update parents, g(n) and h(n)
                    maze(xNode,yNode)=6;
                    dispMaze(maze);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    QUEUE(j, 4) = xNode;    %赋给父类x
                    QUEUE(j, 5) = yNode;
                    QUEUE(j, 6) = exp(i, 3);%g(n)  exp-array
                    QUEUE(j, 7) = exp(i, 4);%h(n)
                end; % end of minimum f(n) check
                flag = 1;
            end;
        end;
        if flag == 0 %说明expand和insert两点不重合
            QUEUE_COUNT = QUEUE_COUNT + 1;                        %第二行放第一个扩张的点
            QUEUE(QUEUE_COUNT, :) = insert(exp(i, 1), exp(i, 2), xNode, yNode, exp(i, 3), exp(i, 4), exp(i, 5));
            maze(xNode,yNode)=6;
            dispMaze(maze);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end; % end of insert new element into QUEUE    
    end;
 
    % A*: find the node in QUEUE with the smallest f(n), returned by min_fn
    index_min_node = min_fn(QUEUE, QUEUE_COUNT);
    if (index_min_node ~= -1)
        % !!!!set current node (xNode, yNode) to the node with minimum f(n)
        xNode = QUEUE(index_min_node, 2);
        yNode = QUEUE(index_min_node, 3);
        path_cost = QUEUE(index_min_node, 6); % cost g(n)
        % move the node to OBSTACLE
        OBST_COUNT = OBST_COUNT + 1;
        OBSTACLE(OBST_COUNT, 1) = xNode;
        OBSTACLE(OBST_COUNT, 2) = yNode;
        QUEUE(index_min_node, 1) = 0;
    else
        NoPath = 0; % there is no path!
    end;
end;

%% Output / plot your route
result();



%% Your Coursework 1 report
%{
    % Comparess a. all your program files and b. coursework report
    % Submit the file with name: FAIcw1-YourID.zip
%}
