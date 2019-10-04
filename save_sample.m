%-------------------------------------------------------------------------
% samples: a cell array which stores the samples and their degrees;
%          the first column stores the samples,
%          the second column stores the degrees
% FIELD: the matrix, which represents the game field
% FIELD_size: the size of the game field
% B,A: coordinates of the last stone in the FIELD matrix (B row, A column)
% win_number: how many stones in a row are needed to win
%-------------------------------------------------------------------------
% samples: the original
%          cell array with the new sample added to its end
%-------------------------------------------------------------------------
function samples=save_sample(samples,FIELD,FIELD_size,B,A,win_number)

% For all the stored samples
for ii=1:size(samples,1)
    
    % If the sample contains at least two stone
    if(samples{ii,2}>1)
        
        % Check if with the last step the known sample was formed
        rot_found=find_rot_sample(FIELD,FIELD_size,B,A,samples{ii,1});

        for jj=1:4
            
            % If yes (a known sample was formed)
            if(rot_found(jj,1)==1)
%------------------------------------------------------------------------                
%% FIRST SAVE THE NEWLY FOUND SAMPLE

                % Put together the previous state as a new sample to store
                sample_to_save=found_handle(win_number,rot_found(jj,:),B,A,FIELD);

                % Check if this new sample is already stored
                already_have=0;
                for kk=1:size(samples,1)
                    try
                        if(samples{kk,1}==sample_to_save)
                            already_have=already_have+1;
                        end
                    catch ME
                        if(strcmp(ME.identifier,'MATLAB:dimagree'))
                            already_have=already_have;
                        end
                    end
                end

                % If not, then inserts it at the end of the list of stored samples
                if(already_have==0)
                    samples{size(samples,1)+1,1}=sample_to_save;
                    samples{size(samples,1),2}=samples{ii,2}/5;
                end
           
 %------------------------------------------------------------------------
 %% THEN SAVE THE SAME SAMPLE WITH THE STONES OF THE OTHER PLAYER
 
                % Set up the same new sample with the stones of the other
                % player
                sample_to_save=(sample_to_save==2)*1+(sample_to_save==1)*2+(sample_to_save==8)*8;
                
                % Check if this new sample is already stored
                already_have=0;
                for kk=1:size(samples,1)
                    try
                        if(samples{kk,1}==sample_to_save)
                            already_have=already_have+1;
                        end
                    catch ME
                        if(strcmp(ME.identifier,'MATLAB:dimagree'))
                            already_have=already_have;
                        end
                    end
                end

                % If not, then inserts it at the end of the list of stored samples
                if(already_have==0)
                    samples{size(samples,1)+1,1}=sample_to_save;
                    samples{size(samples,1),2}=samples{ii,2}/5;
                end
                
%------------------------------------------------------------------------
            end

        end
        
    end

end





