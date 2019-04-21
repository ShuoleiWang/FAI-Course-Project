function [] = dispMaze(maze)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 Program Description
%	This function This function formats the matrix to be graphed via
%   heatmap. This is a two dimensional graph in which there are different
%   colors based on the value in the matrix. That way, the walls can be
%   grey, paths blue, and start/end orange. 制定格式
%
% Function Call
%   function [] = dispMaze(maze)
%
% Input Arguments
%	1. maze: Current maze
%
% Output Arguments
%	1. None
%
% Assignment Information
%	Assignment:         MATLAB Individual Project
%	Author:             Ryan Schwartz, schwar95@purdue.edu
%  	Team ID:            001-07
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% INITIALIZATION ---
% Color map
cmap = [1 1 1; .12 .39 1; 1 1 1; 1 .5 0; 1 .5 0; 0 0 0; 1 0 0; .65 .65 .65];

%% CALCULATIONS ---
% Create live imagery of map
hmo = imagesc(maze);
colormap(cmap);      %生成展示迷宫的那个框  
set(gca, 'XColor', 'none');
set(gca, 'Ycolor', 'none');
drawnow
