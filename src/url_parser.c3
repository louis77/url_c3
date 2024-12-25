module url;

struct Url {
    String scheme;
    String host;
    uint   port;
    String username;
    String password;
    String path;
    String query;
    String fragment;
}

fn usz! String.index_of_chars(String s, char[] needle) 
{
    foreach (i, c : s) 
    {
        foreach (j, pin : needle) 
        {
            if (c == pin) return i;
        }
    }

    return SearchResult.MISSING?;
}

fn Url! parse_url(String url_string) {
    Url url = Url{};
    
    // Parse scheme
    if (try pos = url_string.index_of("://")) {
        url.scheme = url_string[0 .. pos-1];
        url_string = url_string[url.scheme.len + 3..];
    }
    else if (url_string.contains(":")) {
        // Handle schemes without authority like 'mailto:'
        url.scheme = url_string[0 .. url_string.index_of(":")!-1];
        url_string = url_string[url.scheme.len+1..];
        url.path = url_string;
        
        return url;
    }

    // Parse host, port
    if (url.scheme != "urn") {
        usz! authorityEnd = url_string.index_of_chars("/?#");
        if (catch authorityEnd) {
            authorityEnd = url_string.len;
        }

        String authority = url_string[0 ..  authorityEnd-1]!;

        if (try usz userInfoEnd = url_string.index_of_char('@')) {
            String userinfo = authority[..userInfoEnd-1];
            String[] userpass = userinfo.split(":");
            url.username = userpass[0];
            if (userpass.len > 1) {
                url.password = userpass[1];
            }
            authority = authority[userInfoEnd+1..];
        }

        // Check for IPv6 address in square brackets
        if (authority.starts_with("[") && authority.contains("]")) {
            usz ipv6End = authority.index_of("]")!;
            url.host = authority[0..ipv6End];  // Includes closing bracket
            if ((ipv6End + 1) < authority.len && authority[..ipv6End] == ":") {
                url.port = authority[..ipv6End + 1].to_uint()!;
            }
        } else {
            String[] hostPort = authority.split(":");
            defer mem::free(hostPort);
            if (hostPort.len > 1) {
                url.host = hostPort[0];
                url.port = hostPort[1].to_uint()!;
            } else {
                url.host = authority;
            }
        }
        url_string = url_string[authorityEnd ..]!;
    }

    // Parse path
    long queryIndex = (long)url_string.index_of_char('?') ?? -1;
    long fragmentIndex = (long)url_string.index_of_char('#') ?? -1;

    if (queryIndex != -1 || fragmentIndex != -1) {
        long pathEnd = min(queryIndex == -1 ? url_string.len : queryIndex, 
                           fragmentIndex == -1 ? url_string.len : fragmentIndex, 
                           url_string.len);
        url.path = url_string[0 .. (pathEnd-1)];
    } else {
        url.path = url_string;
    }

    // Remove the path part from url for further parsing
    url_string = url_string[url.path.len ..];

    // Parse query
    if (url_string.starts_with("?")) {
        fragmentIndex = (long)url_string.index_of_char('#') ?? -1;
        if (fragmentIndex == -1) {
            fragmentIndex = url_string.len;
        }
        url.query = url_string[1 .. fragmentIndex - 1];
        url_string = url_string[fragmentIndex ..];
    }

    // Parse fragment
    if (url_string.starts_with("#")) {
        url.fragment = url_string[1..];
    }

    return url;
}
