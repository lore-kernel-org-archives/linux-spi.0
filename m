From: Mark Brown <broonie@kernel.org>
Subject: Re: spidev: fix hang when transfer_one_message fails
Date: Thu, 23 Jan 2014 18:17:37 +0000
Message-ID: <20140123181737.GA11727@sirena.org.uk>
References: <1388965166-27334-1-git-send-email-daniel.santos@pobox.com>
 <CAMuHMdU0FRi4=YejN+3TLJCwcptHVaaGFTLPyuwzO4NH9=-cUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Cc: Daniel Santos <daniel.santos@pobox.com>,
	linux-spi <linux-spi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdU0FRi4=YejN+3TLJCwcptHVaaGFTLPyuwzO4NH9=-cUw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 23, 2014 at 05:47:02PM +0100, Geert Uytterhoeven wrote:

> Probably your transfer_one_message() forgot to call
> spi_finalize_current_message()? Is this allowed in case of failure?

Probably not, or at least we should be consistent about requiring it or
not.  Do you want to send a revert for this with a suitable changelog?

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4Vy9AAoJELSic+t+oim95T0P/2QA8L9jv6wipYzEwYqAg4dg
3z2nslWVOMJ4Lwk0OgF0/Wc2rg/SccodS9ZPoTU4EZ1gCJ6uKJTPx9nfd5KRP7tl
ysISVwWzqAi4SV8fS7U1oHbaGqo2B5c7AOrj4WPrAqpWkDyEy+Y2xw3/wSZJLN7I
2fMDdfe+Vrk2K/47DHaYQW6G8jHsInaVP8dzN+duztdVxafle0tAODdQVBsdH/QT
PG6MTV4BuKnzg5wYkJHXOrR8LVK9ficPTy8UwB4rtGpFP2OImUsLghdK2xaVLRiv
V5IYEJzXmVa3lZHLw2ZnCHJoeLy/Tk3eK83RdLI755kUkqOcoV2C4+RcCPoeY9g+
7VINFtuAlKE7ShefdAIXoLlHdK948jzvlAKuaxOliXee8Hss5NVXm9DcLGyEb81b
xKhfXuTy3pzykCcP/Npl3AnS5eor0jFHKKUJuvavE81YUJBJ+uYHxUe6V51WfdV0
VVg/RTpKaVsuhmMnqogvpm1MNfvl7Gmhbei4ptjWlDLj9GxXz7Loy+6WmHfwkb8p
0f0fiKn3MbGVXTw/xnEi8gSQMJKklGHAE/3MJ/6d8cc7q7flclg6IvEzm17r47Au
R/Cn61yt5UcTEotaBMCZo7v+QdMhNfU7YKSlHwjrDvXBVOaYoF4e0G/tfJzA79O0
jRaNyTgFVtL/ZJGbeDZ2
=/A6d
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
