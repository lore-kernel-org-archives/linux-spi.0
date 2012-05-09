From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 06/10] ARM: Samsung: Modify
 s3c64xx_spi{0|1|2}_set_platdata function
Date: Wed, 9 May 2012 11:55:00 +0100
Message-ID: <20120509105500.GG3955@opensource.wolfsonmicro.com>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-7-git-send-email-thomas.abraham@linaro.org>
 <20120509085617.GB28702@sirena.org.uk>
 <201205091110.15224.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oOB74oR0WcNeq9Zb"
Cc: Thomas Abraham <thomas.abraham@linaro.org>,
	spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org, kgene.kim@samsung.com,
	rob.herring@calxeda.com, grant.likely@secretlab.ca,
	jaswinder.singh@linaro.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201205091110.15224.heiko@sntech.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--oOB74oR0WcNeq9Zb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2012 at 11:10:14AM +0200, Heiko St=FCbner wrote:

> Similar to the adc and rtc driver, all Samsung platforms reuse a common=
=20
> platform-device definition for the s3c64xx-spi and simply will set the co=
rrect=20
> name when the machine type is determined during boot.

Right, that doesn't mean this is a great way of doing things, though -
it's been a frequent source of errors in the past and is painful to
debug as the data structures get rewritten during boot which is a bit of
a surprise.

> The alternative is creating a mulitude of platform devices for each possi=
ble=20
> machine type using this driver.

Yes, that's the normal way of handling this and is actually what the
code was originally doing - there's a bunch of ifdefed devices in
plat-samsung/devs.c.  You usually have to do this anyway as the IPs move
about so the resources need changing.

--oOB74oR0WcNeq9Zb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqkz5AAoJEBus8iNuMP3dbngQAJbQqoRi/t8RmwT//QoNI13A
7S2IslIQzzhqlaI7+wMrrH4P8el9I/6QuR6njg5sqWtsKT/8atzq95YykknMiku4
hU/immXcS3Cav8RgDoO5eA2+uo771SZI/KWOAQPt5SAiZkKMzbKTHArzgafeuY/1
TENWDYUOreyGDXBncmBEApFhxNDBqe9w+uwjD1THLcMPlTmK7+OkK/w/rjXIXYoR
Ru6S4LodFS4fTOQk62ehQWlmXErYHISn/6vHL1ooKcxIb9C5UEwdAj88/M1uH1wt
tH4jW01E7UaVWdSTKpUWR2RSlf3a0KDp8B/E6XkATdGz9JNSYXQbNPFcurbaRC5j
4l1+mUAC9iR2c/1O9jecJEWRaQy+jIzLzIZYBXwxGHPdDzR/yMfNyD1SffUvey6H
EFYj/4AoQwX2vxryfsDHVDCTcP2PYcedLxVT8TKTusZZbRUWPkSNXeeZwquIEx7Q
jxusJZQ8uztLhfaUFMEHeiwSdMBBFgUEcOroV6F97/4jy34qwEVHjd7r30UBk4TF
hIBwKl/eGCK/VAk52CLx5HmM1TvHECnhBRjpK0oFN030PXaDCwHcyS+3S/FBTRv6
e6eky8EkFkX2bHuU5g1e4vv9Vaf5PXLSLO50At1XqM1faawufNVNFbt/8CY1Wxa8
mNuSIQUQFNKRW/0Nh0F9
=6YXC
-----END PGP SIGNATURE-----

--oOB74oR0WcNeq9Zb--
