jQuery ->
  main_object = $('.carousel-speakers').clone()

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

  speakers_filter = (link) ->
    if data_name = $(link).attr('data-section')
      data_type = 'data-section';
    else
      data_name = $(link).attr('data-specialization');
      data_type = 'data-specialization';
    array = [];
    # $(this).find("[" + data_type + "='" + data_name + "']");
    $(main_object).find('.item .b-reporters__person').each ->
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
    $('.carousel-speakers').html('')
    carousel = ""
    item = "<div class='item clearfix active'>"
    $.each array, (key, value) ->
      if key == 4 || key == 8 || key == 12 || key == 16 || key == 20
        item += "</div>"
        carousel += item;
        item = "<div class='item clearfix'>"
      item += value;
    item += "</div>"
    carousel += item;
    $('.carousel-speakers').html(carousel);

  $('.b-filter__item').click ->
    if $('.b-filter__item').hasClass('b-filter__item_state_current')
      $('.b-filter__item').removeClass('b-filter__item_state_current');
    $(this).addClass('b-filter__item_state_current');
    speakers_filter($(this).html());
