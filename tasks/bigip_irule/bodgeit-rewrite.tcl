when HTTP_REQUEST {
	if {[HTTP::path] eq "/"} {
    		HTTP::uri "/bodgeit"
	}
}
