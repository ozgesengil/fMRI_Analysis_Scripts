function [] = drawgrid()
    Screen('FillRect', w, black, background_rect);
    for rect_number = 1:12
        Screen('FillRect', w, white, box_rects(rect_number,:));
    end
end