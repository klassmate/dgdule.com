module AssessmentsHelper
  def label_and_sublabel(main, sub)
    main + '<br />'.html_safe + content_tag(:small, sub).html_safe
  end
end
