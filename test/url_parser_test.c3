module url;

fn void! test_foo() @test {
    Url url = parse_url("foo://example.com:8042/over/there?name=ferret#nose")!;

    assert(url.scheme == "foo", "got '%s'", url.scheme);
    assert(url.host == "example.com", "got '%s'", url.host);
    assert(url.port == 8042, "got '%d'", url.port);
    assert(url.username == "", "got '%s'", url.username);
    assert(url.password == "", "got '%s'", url.password);
    assert(url.path == "/over/there", "got '%s'", url.path);
    assert(url.query == "name=ferret", "got '%s'", url.query);
    assert(url.fragment == "nose", "got: '%s'", url.fragment);
}

fn void! test_urn() @test {
    Url url = parse_url("urn:example:animal:ferret:nose")!;

    assert(url.scheme == "urn");
    assert(url.host == "");
    assert(url.port == 0);
    assert(url.username == "", "got '%s'", url.username);
    assert(url.password == "", "got '%s'", url.password);
    assert(url.path == "example:animal:ferret:nose");
    assert(url.query == "");
    assert(url.fragment == "");
}

fn void! test_jdbc() @test {
    Url url = parse_url("jdbc:mysql://test_user:ouupppssss@localhost:3306/sakila?profileSQL=true")!;

    assert(url.scheme == "jdbc:mysql");
    assert(url.host == "localhost");
    assert(url.port == 3306);
    assert(url.username == "test_user", "got '%s'", url.username);
    assert(url.password == "ouupppssss", "got '%s'", url.password);
    assert(url.path == "/sakila");
    assert(url.query == "profileSQL=true");
    assert(url.fragment == "");
}

fn void! test_ftp() @test {
    Url url = parse_url("ftp://ftp.is.co.za/rfc/rfc1808.txt")!;

    assert(url.scheme == "ftp");
    assert(url.host == "ftp.is.co.za");
    assert(url.port == 0);
    assert(url.username == "", "got '%s'", url.username);
    assert(url.password == "", "got '%s'", url.password);
    assert(url.path == "/rfc/rfc1808.txt");
    assert(url.query == "");
    assert(url.fragment == "");
}

fn void! test_http() @test {
    Url url = parse_url("http://www.ietf.org/rfc/rfc2396.txt#header1")!;

    assert(url.scheme == "http");
    assert(url.host == "www.ietf.org");
    assert(url.port == 0);
    assert(url.username == "", "got '%s'", url.username);
    assert(url.password == "", "got '%s'", url.password);
    assert(url.path == "/rfc/rfc2396.txt");
    assert(url.query == "");
    assert(url.fragment == "header1");
}

fn void! test_ldap() @test {
    Url url = parse_url("ldap://[2001:db8::7]/c=GB?objectClass=one&objectClass=two")!;

    assert(url.scheme == "ldap");
    assert(url.host == "[2001:db8::7]");
    assert(url.port == 0);
    assert(url.username == "", "got '%s'", url.username);
    assert(url.password == "", "got '%s'", url.password);
    assert(url.path == "/c=GB");
    assert(url.query == "objectClass=one&objectClass=two");
    assert(url.fragment == "");
}

fn void! test_mailto() @test {
    Url url = parse_url("mailto:John.Doe@example.com")!;

    assert(url.scheme == "mailto");
    assert(url.host == "");
    assert(url.port == 0);
    assert(url.username == "", "got '%s'", url.username);
    assert(url.password == "", "got '%s'", url.password);
    assert(url.path == "John.Doe@example.com");
    assert(url.query == "");
    assert(url.fragment == "");
}

fn void! test_news() @test {
    Url url = parse_url("news:comp.infosystems.www.servers.unix")!;

    assert(url.scheme == "news");
    assert(url.host == "");
    assert(url.port == 0);
    assert(url.username == "", "got '%s'", url.username);
    assert(url.password == "", "got '%s'", url.password);
    assert(url.path == "comp.infosystems.www.servers.unix");
    assert(url.query == "");
    assert(url.fragment == "");
}

fn void! test_tel() @test {
    Url url = parse_url("tel:+1-816-555-1212")!;

    assert(url.scheme == "tel");
    assert(url.host == "");
    assert(url.port == 0);
    assert(url.username == "", "got '%s'", url.username);
    assert(url.password == "", "got '%s'", url.password);
    assert(url.path == "+1-816-555-1212");
    assert(url.query == "");
    assert(url.fragment == "");
}

fn void! test_telnet() @test {
    Url url = parse_url("telnet://192.0.2.16:80/")!;

    assert(url.scheme == "telnet");
    assert(url.host == "192.0.2.16");
    assert(url.port == 80);
    assert(url.username == "", "got '%s'", url.username);
    assert(url.password == "", "got '%s'", url.password);
    assert(url.path == "/");
    assert(url.query == "");
    assert(url.fragment == "");
}

fn void! test_urn2() @test {
    Url url = parse_url("urn:oasis:names:specification:docbook:dtd:xml:4.1.2")!;

    assert(url.scheme == "urn");
    assert(url.host == "");
    assert(url.port == 0);
    assert(url.username == "", "got '%s'", url.username);
    assert(url.password == "", "got '%s'", url.password);
    assert(url.path == "oasis:names:specification:docbook:dtd:xml:4.1.2");
    assert(url.query == "");
    assert(url.fragment == "");
}
