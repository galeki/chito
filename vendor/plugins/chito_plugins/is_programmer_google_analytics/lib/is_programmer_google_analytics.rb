    module BlogHelperPlugin
	def add_google_analytics_code_in_blog_tail
%q{
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-1563106-1");
pageTracker._setDomainName(".is-programmer.com");
pageTracker._trackPageview();
} catch(err) {}</script>
}
	end
    end
