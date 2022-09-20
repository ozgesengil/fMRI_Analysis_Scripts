function [] = blue_box(box_position,side)
    if box_position > 0
        Screen('FillRect', w, blue, box_rects(box_position,:) + side*[test_distance 0 test_distance 0]);
    end
end