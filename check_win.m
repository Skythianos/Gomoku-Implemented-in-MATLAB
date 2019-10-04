%-------------------------------------------------------------------------
% win_number: how many stones in a row are needed to win
% FIELD: the matrix, which represents the game field
% FIELD_size: the size of the game field
% B,A: coordinates of the last stone in the FIELD matrix (B row, A column)
%-------------------------------------------------------------------------
% win: coordinates of the ends of the winning line
%      (win=[0 0 0 0] if there is no winning)
%-------------------------------------------------------------------------
function win=check_win(win_number,FIELD,FIELD_size,B,A)

% Initialization of the return variable
win=[0 0 0 0];

% Right
horizontal=0;
right=[B A];
for k=1:win_number-1
    if(A+k<=FIELD_size)
        if(FIELD(B,A)==FIELD(B,A+k))
            horizontal=horizontal+1;
            right=[B A+k];
        else
            break;
        end
    else
        break;
    end
end

% Left
left=[B A];
for k=1:win_number-1
    if(A-k>=1)
        if(FIELD(B,A)==FIELD(B,A-k))
            horizontal=horizontal+1;
            left=[B A-k];
        else
            break;
        end
    else
        break;
    end
end

% Add the actual square
horizontal=horizontal+1;


% Down (in the matrix)
vertical=0;
down=[B A];
for k=1:win_number-1
    if(B+k<=FIELD_size)
        if(FIELD(B,A)==FIELD(B+k,A))
            vertical=vertical+1;
            down=[B+k A];
        else
            break;
        end
    else
        break;
    end
end

% Up (in the matrix)
up=[B A];
for k=1:win_number-1
    if(B-k>=1)
        if(FIELD(B,A)==FIELD(B-k,A))
            vertical=vertical+1;
            up=[B-k A];
        else
            break;
        end
    else
        break;
    end
end

% Add the actual square
vertical=vertical+1;


% Down-right (in the matrix)
cross_a=0;
right_down=[B A];
for k=1:win_number-1
    if(A+k<=FIELD_size && B+k<=FIELD_size)
        if(FIELD(B,A)==FIELD(B+k,A+k))
            cross_a=cross_a+1;
            right_down=[B+k A+k];
        else
            break;
        end
    else
        break;
    end
end

% Left-up (in the matrix)
left_up=[B A];
for k=1:win_number-1
    if(A-k>=1 && B-k>=1)
        if(FIELD(B,A)==FIELD(B-k,A-k))
            cross_a=cross_a+1;
            left_up=[B-k A-k];
        else
            break;
        end
    else
        break;
    end
end

% Add the actual square
cross_a=cross_a+1;


% Left-down (in the matrix)
cross_b=0;
left_down=[B A];
for k=1:win_number-1
    if(A-k>=1 && B+k<=FIELD_size)
        if(FIELD(B,A)==FIELD(B+k,A-k))
            cross_b=cross_b+1;
            left_down=[B+k A-k];
        else
            break;
        end
    else
        break;
    end
end

% Right-up (in the matrix)
right_up=[B A];
for k=1:win_number-1
    if(A+k<=FIELD_size && B-k>=1)
        if(FIELD(B,A)==FIELD(B-k,A+k))
            cross_b=cross_b+1;
            right_up=[B-k A+k];
        else
            break;
        end
    else
        break;
    end
end

% Add the actual square
cross_b=cross_b+1;


% If in any directions there is at least win_number stones, connect the winning line 
if(horizontal>=win_number)
    win=[left right];
    line([win(2)-0.5 win(4)-0.5],[win(1)-0.5 win(3)-0.5],'LineWidth',3,'Color','k');
end

if(vertical>=win_number)
    win=[down up];
    line([win(2)-0.5 win(4)-0.5],[win(1)-0.5 win(3)-0.5],'LineWidth',3,'Color','k');
end

if(cross_a>=win_number)
    win=[right_down left_up];
    line([win(2)-0.5 win(4)-0.5],[win(1)-0.5 win(3)-0.5],'LineWidth',3,'Color','k');
end

if(cross_b>=win_number)
    win=[left_down right_up];
    line([win(2)-0.5 win(4)-0.5],[win(1)-0.5 win(3)-0.5],'LineWidth',3,'Color','k');
end






