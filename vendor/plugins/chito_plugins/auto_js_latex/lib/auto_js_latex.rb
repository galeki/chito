    module BlogHelperPlugin
        def add_auto_js_latex_js_link_in_blog_tail
            html = ""
            if @user.enable_auto_js_latex
                html += plugin_javascript_inculde_tag('auto_js_latex', "jquery.jslatex.packed.js") + "\n"
                html += %Q! <script type="text/javascript">
                    function auto_js_latex(){
                        try{
                            $('#article_content').html($('#article_content').html().replace(/\\[tex\\]/g, "<span class='latex_eq'>").replace(/\\[\\/tex\\]/g, "</span>"));
                        }catch(e){;}
                        try{
                            $('#comments').html($('#comments').html().replace(/\\[tex\\]/g, "<span class='latex_eq'>").replace(/\\[\\/tex\\]/g, "</span>"));
                        }catch(e){;}
                        try{
                            $('.post_brief').each(function(index){
                                $(this).html($(this).html().replace(/\\[tex\\]/g, "<span class='latex_eq'>").replace(/\\[\\/tex\\]/g, "</span>"));
                            });
                        }catch(e){;}
                        $(".latex_eq").each(function(){
                            var html = $(this).html();
                            html = html.replace(/&nbsp;/g, " ").replace(/<br \\/>/g, "");
                            $(this).html(html);
                        });
                        $(".latex_eq").latex(); 
                    }
                    $(document).ready(auto_js_latex);
                </script>\n !
            end
            if @user.enable_mathjax
                #html += %Q! <script type="text/x-mathjax-config"> MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}}); </script>\n !
                html += %Q! <script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"> </script>\n !
            end
            html.html_safe
        end
    end
