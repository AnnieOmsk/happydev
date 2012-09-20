jQuery ->
  $(document).ready ->
    ## global variable
    if window.location.pathname == "/speakers"
      main_content_tag = '.b-reporters__persons'
      row_counter_keys = [3,6,9,13,16]
      first_item = other_item = "<div class='item'>"
    else
      main_content_tag = '.carousel-speakers'
      row_counter_keys = [4,8,12,16,20]
      first_item = "<div class='item clearfix active'>"
      other_item = "<div class='item clearfix'>"
    ##########################################
    main_object = $(main_content_tag).clone()

    exclude_speech = (item, data_type, data_name, data_spec2, data_sec2) ->
      $(item).find('.b-reporters__person-theme-link').each ->
        if data_spec2.length
          if data_spec2 == data_name
            $(this).parents('.js-spec').find('.b-icon__icon_manager-s').parent().hide();
            $(this).parents('.js-spec').find('.b-icon__icon_designer-s').parent().attr('style', 'display:block;');
          else
            $(this).parents('.js-spec').find('.b-icon__icon_designer-s').parent().hide();
            $(this).parents('.js-spec').find('.b-icon__icon_manager-s').parent().attr('style', 'display:block;');
        else if $(this).attr(data_type) == data_name || data_sec2.length
          if $(this).attr('data-section') == "Общий"
            if data_type == 'data-section'
              $(this).parents('.js-spec').find('.b-icon__icon').attr('class', 'b-icon__icon').addClass('b-icon__icon_general');
            else if data_type == 'data-specialization'
              if data_name == "Разработка"
                $(this).parents('.js-spec').find('.b-icon__icon').attr('class', 'b-icon__icon').addClass('b-icon__icon_developer-s');
              else
                $(this).parents('.js-spec').find('.b-icon__icon').attr('class', 'b-icon__icon').addClass('b-icon__icon_manager-s');
          $(this).parents('.js-spec').find('.b-icon__item').attr('style', 'display:block;');
          $(this).parent().show();
        else
          $(this).parent().hide();
      item

    create_person_item = (item, array) ->
      elem = "<div class='b-reporters__person'>" + $(item).html() + "</div>";
      if jQuery.inArray(elem, array) < 1
        array.push(elem);
      array

    row_counter = (key) ->
      if jQuery.inArray(key, row_counter_keys) >= 0
        return true
      else
        return false

    speakers_filter = (link) ->
      if data_name = $(link).attr('data-section')
        data_type = 'data-section';
      else
        data_name = $(link).attr('data-specialization');
        data_type = 'data-specialization';
      array = [];
      $(main_object).find('.b-reporters__person').each ->
        item = this;
        $(this).find(".b-reporters__person-theme-link").each ->
          if data_type == 'data-section'
            if $(this).attr(data_type) == "Общий"
              item = exclude_speech(item, data_type, "Общий", "", "");
              create_person_item(item, array);
            else if $(this).attr(data_type) == data_name || $(this).attr("data-section2") == data_name
              item = exclude_speech(item, data_type, data_name, "", $(this).attr("data-section2") || "");
              create_person_item(item, array);
          else                        # if data-specialization
            if $(this).attr(data_type) == data_name || $(this).attr("data-specialization2") == data_name
              item = exclude_speech(item, data_type, data_name, $(this).attr("data-specialization2") || "", "");
              create_person_item(item, array);
      # console.log array
      $(main_content_tag).html('')
      carousel = ""
      item = first_item
      $.each array, (key, value) ->
        if row_counter(key)
          item += "</div>"
          carousel += item;
          item = other_item
        item += value;
      item += "</div>"
      carousel += item;
      $(main_content_tag).html(carousel);

    $('.b-filter__item').click ->
      if $('.b-filter__item').hasClass('b-filter__item_state_current')
        $('.b-filter__item').removeClass('b-filter__item_state_current');
      $(this).addClass('b-filter__item_state_current');
      speakers_filter($(this).html());
