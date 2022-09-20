function [] = draw_response_grids()
    Screen('FillRect', w, black, background_rect + [test_distance 0 test_distance 0]);
    for rect_number = 1:12
        Screen('FillRect', w, white, box_rects(rect_number,:) + [test_distance 0 test_distance 0]);
    end
    
    Screen('FillRect', w, black, background_rect - [test_distance 0 test_distance 0]);
    for rect_number = 1:12
        Screen('FillRect', w, white, box_rects(rect_number,:) - [test_distance 0 test_distance 0]);
    end
end