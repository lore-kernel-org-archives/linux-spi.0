From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 4/6] ARM: Samsung: Modify
 s3c64xx_spi{0|1|2}_set_platdata function
Date: Wed, 30 May 2012 11:13:26 +0100
Message-ID: <20120530101326.GF9947@opensource.wolfsonmicro.com>
References: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
 <1337333613-6216-5-git-send-email-thomas.abraham@linaro.org>
 <20120520092113.GA20652@opensource.wolfsonmicro.com>
 <CAOesGMhFcdv7QW=_1U8HHfaETD83mJt=Dgk-8z40yOrC3PB_fA@mail.gmail.com>
 <20120530093421.GA9947@opensource.wolfsonmicro.com>
 <CAJuYYwShLhKSrpGhaTyxX4dqaiKDAcjBtuWSMYAdsWcOMfP=qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Cc: Olof Johansson <olof@lixom.net>,
	spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rob.herring@calxeda.com,
	grant.likely@secretlab.ca, kgene.kim@samsung.com,
	jaswinder.singh@linaro.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJuYYwShLhKSrpGhaTyxX4dqaiKDAcjBtuWSMYAdsWcOMfP=qw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 30, 2012 at 06:05:31PM +0800, Thomas Abraham wrote:
> On 30 May 2012 17:34, Mark Brown <broonie@opensource.wolfsonmicro.com> wr=
ote:

> > Right, and there's no problem at all with using the name. =A0The thing =
is
> > that there's no need to set the name at runtime since the struct device
> > being configured is always going to end up with the same name and doing
> > so is just causing confusion. =A0The device being registered is specific
> > to the SoC already so setting the SoC name at runtime isn't needed.

> I think I did not understand your point. There is only one instance of
> spi platform device statically defined for all Samsung platforms. The

No there isn't.  You've got things like s3c64xx_device_spi0 in
arch/arm/plat-samsung/devs.c (which you'd expect since the resources
that are passed in for memory mapping, DMA and interrupt vary with the
SoC).  The bit of code I was querying just changes "s3c64xx-spi" to
"s3c6410-spi" at runtime in that structure which seems like a waste of
time.

--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPxfK/AAoJEBus8iNuMP3dq5wP/jTlK1sThAap4v5QkMmHNDu/
OQ970m7KCRF15PVCRQul2mLgpoQ9o7lBBbAQGY3/VL+kDqT7BuSiQfkkUTe0hKys
0IiAb+cIv2WlMlH6pcCQyhfpEpLEQUPc263Q1ug0hgNdulnIC9lpx5m6k7gonmWV
WTW366mV230ANamEeRd2UXaX50sR+Z3nvykZAre86sTRPfgguJkUjlhwuCBxzHDx
QJYRYcRQg4NsBH8mSzwHwHT1jqe5W4jBYX+8YUQ85OlMZIjVUX7f+XSUJaedCpf3
kyvnA37Jrewd6DhRlRvBQS2Wix1v6ckJpXMQj04WXKehdf4LdP/2lZLlB31LD+lA
GK8txsf/eB8beKw/DOISTevKT4B2ZsU0eiM8wNA+Ah4j5Mjspoazjk2Zx2sKsn9s
tcBlca7RyJw4ACiPpDsF5nwXr3jxT3fUPtSLjdZGpxzd9bwv0Ydh3wlGDjaBVZCg
PI1IR1EaJoNaJqFJ0CZBTscLFEvIaxgo3bok/6nRXX1dNuvt11oEeYXblD8v7GEB
QyXvCIfpalwYiBeadcsYh1MAslOLHwqrIQELIWz4d599EAsZwv5soLq2GZ2AqVJN
u0tvDjTRzjZdwknSc8/klxO/wVL5YvpGsYTg1JC/0YgVb24gAF/G/mgCOJC/2pQW
9Hej8/z2FWFzMeJc4Yy4
=lR1x
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--
