# url_c3

This package contains the `url` module which can parse all kinds of URLs into a struct.

## Installing

Clone the repository and run `c3c test` to run tests.

## Usage

Parse URLs:

```c3
import url;

Url my_url = url::parse_url("jdbc:mysql://test_user:ouupppssss@localhost:3306/sakila?profileSQL=true#fragment")!;

assert(my_url.scheme == "jdbc:mysql");
assert(my_url.host == "localhost");
assert(my_url.port == 3306);
assert(my_url.username == "test_user");
assert(my_url.password == "ouupppssss");
assert(my_url.path == "/sakila");
assert(my_url.query == "profileSQL=true");
assert(my_url.fragment == "fragment");
```

`Url` implements the `Printable` interface, so you can use a formatter to convert it to a string:

```c3
Url url = { .scheme="jdbc:mysql", 
            .host="localhost", 
            .port=3306, 
            .username="test_user", 
            .password="ouupppssss", 
            .path="/sakila", 
            .query="profileSQL=true" };
String str = string::new_format("%s", url);

assert(str == "jdbc:mysql://test_user:ouupppssss@localhost:3306/sakila?profileSQL=true");
```

## API

```c3
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

fn Url!   parse_url(String url_string)
fn String Url.to_string(Url* self, Allocator allocator = allocator::heap());
```

## LICENSE

MIT. See [LICENSE](LICENSE).
