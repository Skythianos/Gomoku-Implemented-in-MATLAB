%%------------------------------------------------------------------------
%% Necessary calculations for drawing the circles
r=0.4;
ang=0:0.01:2*pi;
xp=r*cos(ang);
yp=r*sin(ang);
clear obj

%%-----------------------------------------------------------------------
%% GET INPUT DATA

% Gets the size of the field
FIELD_size=0;
while(FIELD_size<2)
    FIELD_size=input('Size of the field:');
end
FIELD_size=floor(FIELD_size);

% Gets the size of the winning set (must be smaller or equal to the size of the field.
win_number=inf;
while(win_number>FIELD_size)
    win_number=input('Number of signs needed for victory:');
end
win_number=floor(win_number);

who_starts=2;
while(who_starts>=2)
    who_starts=input('Who starts? The player (0) or the computer (1)?');
end
who_starts=floor(who_starts);

%%-----------------------------------------------------------------------
%% DRAW THE FIELD GUI

% Drawing the field
close all;
fig=figure;
hold on;
hline=line([0 FIELD_size],[[0:FIELD_size]' [0:FIELD_size]']);
vline=line([[0:FIELD_size]' [0:FIELD_size]'],[0 FIELD_size]);
set(vline,'Color','k')
set(hline,'Color','k')
axis equal

%%-----------------------------------------------------------------------
%% CREATE FIELD MATRIX

% Creating the FIELD matrix, which represents the game field
FIELD=8.*ones(FIELD_size,FIELD_size);

%%-----------------------------------------------------------------------
%% CREATE THE SAMPLES

% Create the first two elements of samples
samples{1,1}=ones(1,win_number)*2;
samples{1,2}=5^(win_number-1);
samples{2,1}=ones(1,win_number);
samples{2,2}=5^(win_number-1);

%%-----------------------------------------------------------------------
%% LOAD SAMPLES

% Load previously saved samples
%load samples.mat;

%%-----------------------------------------------------------------------
%% START THE GAME

% Game untill there is empty space (cycles or rounds counted by n)
n=FIELD_size^2;
AAA=ceil(FIELD_size/2);
BBB=ceil(FIELD_size/2);
while(n>0)

%%-----------------------------------------------------------------------
%% PUT STONE

    % Player puts first, then the computer
    if(mod(FIELD_size^2-n+who_starts,2)==0)
        title('Your turn!')
        [X,Y]=ginput2(1);
        A=ceil(X); % column
        B=ceil(Y); % row
    else
        AUTO_PUT=[AAA(1) BBB(1)];       % "Intelligent" mode
        %AUTO_PUT=put_random(FIELD,n);   % "Random" mode
        clear AAA;
        clear BBB;
        A=AUTO_PUT(1); % column
        B=AUTO_PUT(2); % row
    end

%%-----------------------------------------------------------------------
%% UPDATE MATRIX AND GUI    
    
    % If player clicked on the field
    if(A<=FIELD_size && B<=FIELD_size && A>0 && B>0)

        % If player chose an empty square
        if (FIELD(B,A)==8)
            
            % Draw X and O alternately
            if exist('obj')
                set(obj,'LineWidth',1);
            end
            
            if (mod(FIELD_size^2-n+who_starts,2)==0)
                [fig]=draw_xo(fig,FIELD_size,n,who_starts,B,A,xp,yp);
            else
                [fig,obj]=draw_xo(fig,FIELD_size,n,who_starts,B,A,xp,yp);
                set(obj,'LineWidth',2);
            end
            
            pause(0.001)
            
            % Update the FIELD matrix
            [FIELD]=update_FIELD(FIELD,FIELD_size,n,who_starts,B,A);

%%-----------------------------------------------------------------------            
%% SAVE SAMPLE

            % Checks if there is a new sample to save and saves it
            samples=save_sample(samples,FIELD,FIELD_size,B,A,win_number);
            
            % Save samples in .mat file
            %save samples.mat samples
                
%%------------------------------------------------------------------------
%% CHECK WIN

            % If the game has reached the win_numberth round
            if(n<=FIELD_size^2-(2*(win_number-1)))

                % Check for win, if win, connect the winning stones
                win=check_win(win_number,FIELD,FIELD_size,B,A);
                
                % If win, end of game
                if(win(1))
                    [y,Fs]=audioread('tada.wav');
                    %[y,Fs,NBITS]=wavread('al_bundy.wav');
                    sound(y,Fs);
                    if(FIELD_size==15)
                        fifteen
                    end
                    break;
                end
                
            end
            
%%------------------------------------------------------------------------
%% EVALUATE

            % If this was my round (next is the computer)
            if(mod(FIELD_size^2-n+who_starts,2)==0)
                title('The computer is thinking...')
                drawnow
                % Evaluate the FIELD
                FIELD_2=evaluate(FIELD,FIELD_size,samples);

                % Choose the highest rated square as possible next moves
                % for the computer
                [Value Index]=max(FIELD_2(:));
                [BBB AAA]=find(FIELD_2==Value);
            end
                        
%%------------------------------------------------------------------------             
%% DECREASE n

            % Decrease n in each cycle
            n=n-1;

%-------------------------------------------------------------------------            

        end
    end
end





