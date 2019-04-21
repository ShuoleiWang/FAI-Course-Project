function [positions] = validateMove(maze, position)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 Program Description
%	This function telsl the move function where the current position could
%   possibly go. This function will return a matrix called directions that
%   will return either a 1 or a 0 for each direction. The format for
%   directions is up, down, left, right. Valid movements are checked using
%   a valid movement matrix outlined on
%   GitHub.返回一个叫做direction的矩阵，定义上下左右是0还是1
%
% Function Call
%   function [positions] = validateMove(maze, position)
%
% Input Arguments
%	1. maze: Current maze
%   2. position: Current position
%
% Output Arguments
%	1. positions: Matrix that shows what available directions can be used.
%	Formatted in [up down left right], where 1's are viable movements.
%
% Assignment Information
%	Assignment:         MATLAB Individual Project
%	Author:             Ryan Schwartz, schwar95@purdue.edu
%  	Team ID:            001-07
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% INITIALIZATION ---
positions = [1 1 1 1]; % Up, down, left, right !!!!!!
[numrow, numcol] = size(maze);

%% CALCULATIONS ---
% Check the up
if position.row == 2    %如果这个现在位置在最上面，那么不能往上走了
    positions(1) = 0;                                     %position(1)是起点上面那个点 ,positions（1,2,3,4）指上下左右
elseif position.row == 3 %如果现位置在第二个上面行，且上面三个点都是路径，则也不能向上走
    for z = [-1 0 1]           
        if mazeValue(maze, position, -1, z) == 1
            positions(1) = 0;
        end
    end
else
    for k = [-2 -1]             %如果现位置上面两行的三列有路径点，则也不能向上走
        for z = [-1 0 1]
            if mazeValue(maze, position, k, z) == 1
                positions(1) = 0;
            end
        end
    end
end

% Check down
if position.row == numrow - 1
    positions(2) = 0;
elseif position.row == numrow - 2
    for z = [-1 0 1]
        if mazeValue(maze, position, 1, z) == 1
            positions(2) = 0;
        end
    end
else
    for k = [1 2]
        for z = [-1 0 1]
            if mazeValue(maze, position, k, z) == 1
                positions(2) = 0;
            end
        end
    end
end

% Check left
if position.col == 2
    positions(3) = 0;
elseif position.col == 3
    for z = [-1 0 1]
        if mazeValue(maze, position, z, -1) ==1
            positions(3) = 0;
        end
    end
else
    for k = [-1 0 1]
        for z = [-2 -1]
            if mazeValue(maze, position, k, z) == 1
                positions(3) = 0;
            end
        end
    end
end

% Check right
if position.col == numcol - 1
    positions(4) = 0;
elseif position.col == numcol - 2
    for z = [-1 0 1]
        if mazeValue(maze, position, z, 1) == 1
            positions(4) = 0;
        end
    end
else
    for k = [-1 0 1]
        for z = [1 2]
            if mazeValue(maze, position, k, z) == 1
                positions(4) = 0;
            end
        end
    end
end

%% FORMATTED TEXT & FIGURE DISPLAYS ---

%% COMMAND WINDOW OUTPUTS ---


%% ACADEMIC INTEGRITY STATEMENT ---
% I/We have not used source code obtained from any other unauthorized
% source, either modified or unmodified.  Neither have I/we provided
% access to my/our code to another. The project I/we am/are submitting
% is my/our own original work.
%

