From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 05/10] ARM: Samsung: Update the device names for spi
 clock lookup
Date: Sun, 13 May 2012 15:51:35 +0100
Message-ID: <20120513145134.GA6381@opensource.wolfsonmicro.com>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-6-git-send-email-thomas.abraham@linaro.org>
 <20120509085249.GA28702@sirena.org.uk>
 <CAJuYYwQ+Wn11puF7AdPD41Jntbuj7oZHqNfzQA2T8V=2cigQnw@mail.gmail.com>
 <20120509142836.GT3955@opensource.wolfsonmicro.com>
 <CAJuYYwSTJoNRuN87GoTZMgF-qahbu02kJ9SUd7omQ5WD0VjTww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Cc: spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org, kgene.kim@samsung.com,
	rob.herring@calxeda.com, grant.likely@secretlab.ca,
	jaswinder.singh@linaro.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJuYYwSTJoNRuN87GoTZMgF-qahbu02kJ9SUd7omQ5WD0VjTww@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 10, 2012 at 01:17:32AM +0800, Thomas Abraham wrote:
> On 9 May 2012 22:28, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > This means that bisection will be broken - anything with only one tree
> > won't be able to load the SPI driver successfully until it's merged
> > with the other which isn't ideal.

> Yes, we would have that problem until the two trees are merged. But I
> still prefer not to squash the two patches which already contain huge
> diff.

I'd not say the diff is *that* big (and most of what's there is simple
and repetitive), and bisection is a very useful tool.  I know I
frequently find it enormously painful trying to figure out breakage when
large chunks of the history don't work usefully.

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPr8o7AAoJEBus8iNuMP3dgagP/A7mKrizYW+adHb7Rn///vWv
3Ob/XG/AgiioD+0zeHs5/tKECe4oHrFiXZUKwKuXHHH2KU/uYuEkGlW+O5VoHG/2
msxyuaWFU8HjrMkrM7onjRJdQJNIocXLXgR8Ou4AKt3xgfVzajwtxfcIz6+jP6WQ
PK6Dng9666yoHzKcwJoQkdmJJXy9O5i8VuyUclf12ifssPjDiF+Osl+zth5TcZ6T
SN0SS8lS537huRXbbfbNvd1KZl4E98e1l2HGfiYdLmcWyN1QVK6I5dC0pU0OiGKG
7oxi51BQ3T3HBcXTKHErIdvHRgVY92gXwoQOLgAzPCxaeT3n/mC2lHQmuq/8q5UH
SdFHfKRiFMzjDJmgvSOeFFODwu5v1xNWsXxAjNybIpaA35alX8m7+GSVv3pCp3Pt
MF0WRDkwnA9vjS9TK52IoOMytaDVn8tOnJSzl9EorLAhr62Hg2l/g42EQxsZFeh0
V/+LPPsVITs5X497EW+Nx4dWfKYjWdAUpfC4Q4txkJ/xiUq4iagZTMwwrB3HGiwL
D/vE+8AVhPsRdTTu4LNe8qmXKQwqfJ0uLwELRBMq8r0P9MLPS5N7kTIkKJKLKLYP
MTEohI7940V6/gWBoqfwnvn+0WOnXdFaz94NWj6Fca7iVIzxyqpwFXp6lI7hcbSR
RQ/WulHFOW9St3zQf+5T
=M6co
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
