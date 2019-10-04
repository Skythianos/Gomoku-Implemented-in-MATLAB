%-------------------------------------------------------------------------
% FIELD_size: the size of the game field
% n: cycle counter of the game
% who_starts: 0 if the player starts, 1 if the computer starts
% B,A: coordinates of the last stone in the FIELD matrix (B row, A column)
% xp,yp: needed for drawing the circle
%-------------------------------------------------------------------------
function [fig,obj]=draw_xo(fig,FIELD_size,n,who_starts,B,A,xp,yp)

% Alternately...
if(mod(FIELD_size^2-n+who_starts,2)==0)

    % ...draw an X...
    line([A-0.1 A-0.9],[B-0.1 B-0.9]);
    line([A-0.9 A-0.1],[B-0.1 B-0.9]);
    [y,Fs]=audioread('player_put.wav');
    sound(y,Fs);

else

    % ...or an O
    obj=plot(A-0.5+xp,B-0.5+yp,'r');
    [y,Fs]=audioread('cpu_put.wav');
    sound(y,Fs);
end