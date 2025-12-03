# handshake-simple-resolver
HandShake Caching resolver that uses other people's public Handshake resolvers

This is a small and simple Handshake ware DNS resolver. It does not resolve names itself, but uses
other public Handshake resolvers, but caches the answers for the TTL.

The list of public resolvers is taken from the IP Addresses on the host name `recs.hogshake.net`, but you can
override this.

It has some anti-abuse including [rate-limiting](etc/rate-limit.inc).


## Env Vars for Tweaking

All environmant variables are optional and have sensible default values.

| Var | Purpose | default
|-----|---------|-----------
| `SIMPLE_REQUIRE_COOKIES` | Are clients required to send DNS cookies | yes
| `SIMPLE_ALLOWED_SUBNETS` | SEMI-COLON separated list of subnets allowed to use this server | All RFC1918 IPs plus `127.0.0.0/8`
| `SIMPLE_RESOLVERS_HOST` | Host name to get IP list of public resolvers | `recs.hogshake.net`
| `SIMPLE_BOOT_NAME_SERVERS` | Space separated list of IP Address to use to resolve the `SIMPLE_RESOLVERS_HOST` name | `8.8.8.8 8.8.4.4 1.1.1.1 1.0.0.1`
| `SIMPLE_RESOLVERS_LIST` | Instead of getting the public resolvers list from a host nane, just use this list instead, SEMI-COLON separate list of IP Addresses | None

NOTE: Whatever list of subnets you give in `SIMPLE_ALLOWED_SUBNETS` the localhost subnet (`127.0.0.0/8`) will always get automatically added.

If you want anybody to be able to use your resolver, set `SIMPLE_ALLOWED_SUBNETS` to `any`.

DNS Cookies are session control cookies used in DNS, although quite new, they are very widely used & supported,
but you may need to change this to `no` if you have clients that are failing.

If you want to provide your own rate-limiting / anti-abuse options, I recommend you write it as a text file
and use the docker option `-v` to map it over the default one at `/usr/local/etc/rate-limit.inc`.
