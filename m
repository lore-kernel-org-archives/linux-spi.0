From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: pxa2xx: Set controller->max_transfer_size in dma mode
Date: Mon, 21 Oct 2019 12:35:37 +0100
Message-ID: <20191021113537.GB4691@sirena.co.uk>
References: <20191016195721.3714-1-daniel.vetter@ffwll.ch>
 <20191017064426.30814-1-daniel.vetter@ffwll.ch>
 <20191017070638.GB32742@smile.fi.intel.com>
 <20191021110857.GR32742@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0847796250=="
Cc: linux-arm-kernel@lists.infradead.org,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Sam Ravnborg <sam@ravnborg.org>, Daniel Mack <daniel@zonque.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191021110857.GR32742@smile.fi.intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
List-Id: linux-spi.vger.kernel.org


--===============0847796250==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2019 at 02:08:57PM +0300, Andy Shevchenko wrote:

> Mark, can be this applied?

b2662a164f9dc48d

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2tmAkACgkQJNaLcl1U
h9Bmiwf+LpkNRvFDHKJlEidZWltSZa/YXEUiHkXF+RPQ50Dg7H7u4mTpMHYE6p4j
GzZoajbCmd20mLDAY/AV+PQc5AmjFdXmMk5/3vqbYPWL92Wmlfx/2pIX+O8NV/dz
MUaCFgYJf8ZStxwwsEKGYSxPzdkVi+e57w7GQZMZP8JKm1VfRjxHCBNV22ZmXD2L
WGxdBr9lIPfs34GplBpk2Gr3Y5dlDbHC03tgsxf1qcDQlRiG9HaX8zEiRF5CsnAh
XK2lkJmT86hCJiqRNP6QnT1SmjqahHwHbUXakBNNmS5nr1JYYZb3hCgSWPrdpbbg
UP2goIpeqbEN0JAhJNMQA9OQGT58kw==
=2kIE
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--

--===============0847796250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============0847796250==--
