function [maze, nodes, position, endPos] = setup(size)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 Program Description
%	This function This function takes a size parameter and generates a nxn
%   matrix of that size. Next, the function creates a border of 8's around
%   the outside edges. It then randomly generates a start and end point
%   (which will be returned at the end of the function). The start point
%   will be located at some point along the bottom row (where it will
%   replace one of the 8's). The end point will be located at some point
%   along the top row (where it will replace one of the 8's). A 1 (path)
%   will be generated directly above the start point, and a node will be
%   created at that point. The function then returns the created maze, a
%   list of nodes, and the start/end positions of the maze.
%
% Function Call
%   function [maze, nodes, position, endPos] = setup(size)
%
% Input Arguments
%	1. size: User-defined maze size
%
% Output Arguments
%	1. maze: Blank maze template of size x size dimensions
%   2. nodes: Initial list of nodes
%   3. position: Initial position
%   4. endPos: Position of ending block
%
% Assignment Information
%	Assignment:         MATLAB Individual Project
%	Author:             Ryan Schwartz, schwar95@purdue.edu
%  	Team ID:            001-07
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% INITIALIZATION ---
% Generate maze, create borders of 8s
maze = zeros(size);
maze(1, 1:end) = 8;                         %创建迷宫并生成起点终点
maze(1:end, 1) = 8;
maze(end, 1:end) = 8;   %边界是8,其余都是0
maze(1:end, end) = 8;

%% CALCULATIONS ---
% Generate random starting and ending points
position = point(size, randi([2 (size - 1)]));%randi返回一个1到2（size-1）的随机数 position.row=size
maze = setMazePosition(maze, position, 3);%maze(position.raw, position.column)=3 让一个位置有一个值
position = adjust(position, -1, 0);%生成新的点 x-1,y不变
maze = setMazePosition(maze, position, 1);%起点上面的点等于1，1应代表路径，0代表墙
xStart = position.row; 
yStart = position.col;
nodes(1, 1) = position.row;           %nodes可能不代表点
nodes(2, 1) = position.col;

endPos = point(1, randi([2 (size - 1)]));
maze = setMazePosition(maze, endPos, 4);%终点等于4，起点等于3
