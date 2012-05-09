From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 10/10] spi: s3c64xx: add device tree support
Date: Wed, 9 May 2012 17:47:07 +0100
Message-ID: <20120509164706.GJ3955@opensource.wolfsonmicro.com>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-11-git-send-email-thomas.abraham@linaro.org>
 <20120509090716.GC28702@sirena.org.uk>
 <CAJuYYwQF9Hh3wJpPTfXm_5iirvHzgwDu6imuSgH-ggenj=Vc8Q@mail.gmail.com>
 <20120509143159.GU3955@opensource.wolfsonmicro.com>
 <CAJuYYwT6SJth83tFSbvENa2h7-M182kGCoBidmw8DvECK0qUzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6xTM0kUsJcaNctaW"
Cc: spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org, kgene.kim@samsung.com,
	rob.herring@calxeda.com, grant.likely@secretlab.ca,
	jaswinder.singh@linaro.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJuYYwT6SJth83tFSbvENa2h7-M182kGCoBidmw8DvECK0qUzA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--6xTM0kUsJcaNctaW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 10, 2012 at 12:39:29AM +0800, Thomas Abraham wrote:
> On 9 May 2012 22:32, Mark Brown <broonie@opensource.wolfsonmicro.com> wro=
te:

> > Yeah, I know. =A0I'm saying we should try to come up with a binding for
> > this that can be used by new SPI contollers going forward so things are
> > consistent.

> Ok. For this patch series, I will continue with the samsung specific
> binding for the nCS line.

How about just renaming your binding to a generic one and documenting it
separately?  It looks like a sensible binding which other people should
be able to use so may as well have something there already.

--6xTM0kUsJcaNctaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqp9jAAoJEBus8iNuMP3dWiIP+wTHcaenIRSakRljnQC/HWfi
pZ9jHBF4QpCj0xye/FVT1LWIOU3Nv3YDDpOCxfHSwqrYn63+LcDKjlnUSMBjRU4z
LhlBYuXPZ+9GZT8I9Impvnhp5Pgw99jct2I46dTUnFUU3uqsih0PapBKwma6rHiI
n8gXzY017eHfCfmM/YE6QvRZkVsWawKaL/mVmn7GFimq4IFX6Hf9CNRD2thn89Yq
caSxLuqJ8O+h38hg/VWXsMHIqkASd21GW0r9PF3sO9PNczpeGVL23erkTe2hW3/N
J+YSeX6NUrI1P8a5BTgv3ug0MQlTtMif2XRVV/Tb8LeDZ4WsJYsb+lnvHiQ9VEAc
YqI/ogMeS4KCBS6wlDAfBhjk5sMOIf7FNyQQ0t+AK6OltxwQbIGnrSaCiiF9xSLO
A+O1jsB120H3oFBqklOExJkRjLRrgSxiiqpCpeRe66cNJF9/4+M5l4ghKUxaSHlY
U9A1KkxnTPq+XEYF4HPmjlt+P2bz2UoYiiYgIYuSRoyt4T/O6oJNNrh7B7K9YH1h
FKjW7Der5AdSt9EYvftG0m06qjrgS0/vBlZSol3QTuDwhZmvD6MctQicoc6nyr5+
C58nQlwGUUB9ZlOlmmNC9VLKXYOc1wXK9UDEHmfCO0r8937miUVNZv00PR9kcNj+
FFYWB2FxmlZ71XCz+ape
=jLvg
-----END PGP SIGNATURE-----

--6xTM0kUsJcaNctaW--
