class SearchsController < ApplicationController
  def search
    # 選択したmodelの値を@modelに代入。
    @model = params["model"]
    # 選択した検索方法の値を@methodに代入。
    @method = params["method"]
    # 検索ワードを@contentに代入。
    @content = params["content"]
    # @model, @content, @methodを代入した、search_forを@recordsに代入。
    @records = search_for(@model, @content, @method)
  end

  private

  def search_for(model, content, method)
    if model == 'user' #Userモデルだったら
      # 選択した検索方法がが完全一致だったら
      if method == 'perfect'
        User.where(name: content)
      # 選択した検索方法がが部分一致だったら
      else
        User.where('name LIKE ?', '%'+content+'%')
      end
    elsif model == 'post' #Postモデルだったら
      if method == 'perfect'
        Post.where(title: content, shop_name: content, introduction: content)
      else
        Post.where(['title LIKE ? OR shop_name LIKE ? OR introduction LIKE ?', '%'+content+'%', '%'+content+'%', '%'+content+'%'])
      end
    elsif model == 'spot' #Spotモデルだったら
      if method == 'perfect'
        Spot.where(address: content)
      else
        Spot.where('address LIKE ?', '%'+content+'%')
      end
    end
  end
end
