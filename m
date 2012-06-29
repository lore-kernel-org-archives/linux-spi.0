From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] spi/s3c64xx: Convert to devm_request_and_ioremap()
Date: Fri, 29 Jun 2012 02:20:28 +0100
Message-ID: <20120629012028.GK28922@opensource.wolfsonmicro.com>
References: <1340889811-7524-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CACRpkdYwGoUwSRX2ASa5kJPpNFtmxbKPtgwUnFhQzZs9EUoHQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huBJOJF9BsF479P6"
Cc: Kukjin Kim <kgene.kim@samsung.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-samsung-soc@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYwGoUwSRX2ASa5kJPpNFtmxbKPtgwUnFhQzZs9EUoHQQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--huBJOJF9BsF479P6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 28, 2012 at 08:51:44PM +0200, Linus Walleij wrote:

> I'm starting to wonder if it would not be possible to mass-convert these
> using coccinelle.

Probably, yes.  I'm not actually going through these particularly,
really what I'm doing is looking to find drivers I run on my systems
that might be able to use regmap-mmio and fixing things I find as I
look.

--huBJOJF9BsF479P6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP7QKqAAoJEBus8iNuMP3d13MP/A63AEGJv8P5oZkJCRqg2e5S
JNIZpfIKVCBr7JsaAdswCRoPZOuEiIltavc68O25Ba8oo/U0fQaXt254VbGAtP3Q
YVQliS+QEzbMczb9HphzoxEJFkGjmbiT1jepjo2RfzxLXGjoCR9x3zXL8JJE+/xB
T3EIltYilGOJr2LfLlkEFy94sbG8gBKkUyo4lS9GZaCZcN36OlVKAeD3FOXvH8fs
KglvIdy0ePtqyRGG8k4cjU3XBGASSkfqkiPRiEwVgDn6RfzaztZEgd0Op2vA6BSk
yb2m50GyyuESN6aniuVX9wR5vnG2HLyUWD1QiVzV9YUw8p2UgZLg6zDZAB9nUU/O
snSH0xr5CXLTQF5nYoqmE0SozUSmr7w4Yek129HWqqnTUtoaI6Ka6KS86dxnQS3s
2trSkTMdW2+WBJr1NZFJEareEl0H2QXaM2BL51IQXIunPNqAuRKohnjwjE7Hz0Xs
i7sSYDirwX9oMm5LVSk5TMl1KMONR0iG7zRTF6TSKKUQL839txYmjKxzBWREjQ1s
WwOBo0kZZeGq5h/tC6OXENv1fBM6cG22nE+AWpaoivdn9bQ/mhBzvcL/jRwAo8fj
CFyS/EUjs1oJ/BxyhbTMgQ/eCXrJyE81WF7A2VBH8nvmi6k5BpEFaHeaZVHnAzGQ
oVjNHCscmQ8LfELDgfDH
=+OEy
-----END PGP SIGNATURE-----

--huBJOJF9BsF479P6--
