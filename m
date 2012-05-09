From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 05/10] ARM: Samsung: Update the device names for spi
 clock lookup
Date: Wed, 9 May 2012 15:28:37 +0100
Message-ID: <20120509142836.GT3955@opensource.wolfsonmicro.com>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-6-git-send-email-thomas.abraham@linaro.org>
 <20120509085249.GA28702@sirena.org.uk>
 <CAJuYYwQ+Wn11puF7AdPD41Jntbuj7oZHqNfzQA2T8V=2cigQnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TJ9V72hR/LoebVea"
Cc: spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org, kgene.kim@samsung.com,
	rob.herring@calxeda.com, grant.likely@secretlab.ca,
	jaswinder.singh@linaro.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJuYYwQ+Wn11puF7AdPD41Jntbuj7oZHqNfzQA2T8V=2cigQnw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--TJ9V72hR/LoebVea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 09, 2012 at 09:40:26PM +0800, Thomas Abraham wrote:
> On 9 May 2012 16:52, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > This should've been squashed into the patch that updated to use driver
> > data in order to avoid breaking bisection.

> This patch updates clock devname in the platform code and the
> modifications to use driver data is in the driver file. So these two
> changes are kept separate to allow them to be applied to their
> respective trees.

This means that bisection will be broken - anything with only one tree
won't be able to load the SPI driver successfully until it's merged
with the other which isn't ideal.

--TJ9V72hR/LoebVea
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqn8OAAoJEBus8iNuMP3dh2gP/22S3d/mFd2A6Joxy1+0qKec
eZlNkcq+qwpbeAB2zUJphmxYSt2z8+ft4PQmSfDk0PbcGRB2YMd2zV4BjzVeUv1f
Tz2SR9b766GLxyDOlKAkuHD3YKFMpo8UmnRfHEZnHf4n0ooc2sNv8dFIZ/OupfeD
/qetGt3BHFoRlz9eOc99M9AgKrh6+AxF7rMF+tgldIHXgbE9XhSA3cjvGPiAiix0
lBC7wJSiEqfc6us+hFOoAHZ3jEdMBRytwtGwQQkf6mB1Q/r5wZuhyW7fgymk3ca6
wBmW6SCEr4kTcJn/FZWs6BJusqDmbalI+sW2QeW9UmOIRJdqE6WNz++lzHDss4bS
q0QvtiQRhBrlRF6lAggG3vqRXO5SsRTaPXcWdne6x3CXmiTkuYO/4gVgEuCiKBS3
Hm1q9FZA0W3NvufNRo4IJlB3oiuKAhOR4MJJFPMSOfayl3BSPXjxM3r88iR12lwo
MzImhYpgOUayunPF/N72RW28q1htKUkBMWPHgmNpZwES0GMjqosVuYn/TmKvVpYR
3T/NKwoIwprdxR3UD5uUrJQRgMyh4x+T4963PcEsj4sVNJ2eXeL3s9zoxQfhHeWZ
nl6KZMsINrQX5JCoOzgcy0IUT0mYSPYZZkLGXa4oQS9goEn9Jot+R7AajwVvZeTc
jTeDpZFOjxOtgycaVt5Y
=xdHu
-----END PGP SIGNATURE-----

--TJ9V72hR/LoebVea--
