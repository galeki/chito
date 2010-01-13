module BlogHelperPlugin
    def rewriter_of_footer
	@user.custom_footer.to_s
    end
end
