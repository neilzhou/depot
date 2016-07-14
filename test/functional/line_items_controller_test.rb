require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  setup do
    @line_item = line_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      post :create, product_id: products(:ruby).id
    end

    assert_redirected_to store_path
  end

  test "should create line_item via ajax" do
    assert_difference('LineItem.count') do
      xhr :post, :create, :product_id => products(:ruby).id
    end
    assert_response :success

    assert_js_select 'tr#current_item td', /Programming Ruby 1.9/
  end

  test "should show line_item" do
    get :show, id: @line_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @line_item
    assert_response :success
  end

  test "should update line_item" do
    put :update, id: @line_item, line_item: { cart_id: @line_item.cart_id, product_id: @line_item.product_id }

    assert_redirected_to line_item_path(assigns(:line_item))
  end

  test "should destroy line_item" do
    assert_difference('LineItem.count', -1) do
      delete :destroy, id: @line_item
    end

    assert_redirected_to line_items_path
  end
  # wrapper method around the native assert_select method that extracts out the html
  # from raw html text that is embedded within javascript code.
  # ex.
  # $('body').append("<div id=\"edit_post_form_container\" class=\"active modal_form_container\">
  # <a href=\"#\" class=\"close\">
  # <img alt=\"Close\" height=\"16\" src=\"/images/close.png?1293730609\" width=\"16\" />
  # <\/a>
  # <form accept-charset=\"UTF-8\" action=\"/posts/1023110335\" .../>")
  #
  # assert_js_select "input[type=?][name=?]", "text", "foo[bar]", :count => 1
  # assert_js_select "textarea", "Some long text"
  # assert_js_select "textarea[name=?]", "post_text", "Some long text"
  # assert_js_select "textarea[name=?][class=?]", ["post_text", "css_class", "Some long text"
  def assert_js_select(*args, &block)
    extracted_text = @response.body.match(/(\<.*\>)/)[0].
      gsub("\\n", "").gsub("\\t", "").gsub(/\\"/, '"').gsub("\\", '')
    if extracted_text.present?
      doc = HTML::Document.new(CGI::unescapeHTML(extracted_text)).root
      args.insert(0, doc)
      assert_select(*args, &block)
    else
      assert false, "Unable to extract any html from the js code."
    end
  end
end
