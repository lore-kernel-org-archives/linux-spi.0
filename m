From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 4/6] ARM: Samsung: Modify
 s3c64xx_spi{0|1|2}_set_platdata function
Date: Thu, 31 May 2012 12:36:59 +0100
Message-ID: <20120531113659.GB2666@opensource.wolfsonmicro.com>
References: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
 <1337333613-6216-5-git-send-email-thomas.abraham@linaro.org>
 <20120520092113.GA20652@opensource.wolfsonmicro.com>
 <CAOesGMhFcdv7QW=_1U8HHfaETD83mJt=Dgk-8z40yOrC3PB_fA@mail.gmail.com>
 <20120530093421.GA9947@opensource.wolfsonmicro.com>
 <CAJuYYwShLhKSrpGhaTyxX4dqaiKDAcjBtuWSMYAdsWcOMfP=qw@mail.gmail.com>
 <20120530101326.GF9947@opensource.wolfsonmicro.com>
 <CAJuYYwT88mpTKmOD8mpCjsQo9O_+Giri7+q-Rzz=zPNj+F7aDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
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
In-Reply-To: <CAJuYYwT88mpTKmOD8mpCjsQo9O_+Giri7+q-Rzz=zPNj+F7aDg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 31, 2012 at 10:05:42AM +0800, Thomas Abraham wrote:
> On 30 May 2012 18:13, Mark Brown <broonie@opensource.wolfsonmicro.com> wr=
ote:

> > No there isn't. =A0You've got things like s3c64xx_device_spi0 in
> > arch/arm/plat-samsung/devs.c (which you'd expect since the resources
> > that are passed in for memory mapping, DMA and interrupt vary with the
> > SoC). =A0The bit of code I was querying just changes "s3c64xx-spi" to
> > "s3c6410-spi" at runtime in that structure which seems like a waste of
> > time.

> So is the concern only with the change of device name from
> "s3c64xx-spi" to "s3c6410-spi"? Is there any concern with changing the
> name of the static spi platform device (s3c64xx_device_spi0/1/2) at
> runtime which then is used to select a driver data?

No, you're not getting it at all.  The changing at runtime is the
problem, it's achieving nothing except making the code more fragile and
obscure.  Those devices will always come out with exactly the same name
so we should just assign that name statically.

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPx1fFAAoJEBus8iNuMP3djjQP/iTDFIB6+JISK/182WzEohok
KaSOevQ9ZNdxpig9fqWnPFesBcr2GCPoPl4pMzg1wmaHNrztZPkIcn3PUf+veMPi
CIzzZOG5HGMe+atDfUEy+1JiGmA6AX+/oKTadwep4gdQUb2qJZMLgXuqItxoEXqz
xg20CrYk3sywQPpaTVDewqsQNuvUR3kXPq1vPfHNbYzQ4Os6it6Vj6EaPnDIEHqW
g7VL0SvJyiKUzMXXhVun938uzDt2WQVySEH2+nl8rnenu5wGY5Fi4wwHrt+9Xyjy
WdRAFXvMNnuFr/ISriB/DZhncUXVEhqkVXLtNqmb8WGN74jxU8+Xvga5TRijYhn3
5871LBQdejmm2TKMsby6a//jjTZm8aO0JsZzoIKEMCSillZIvxvgH8/OtBlSspIe
y5EKsWSFuBMoKuV4oCKek0UENI75NP2xvWekqr6wUZp1Ecfy5fdHh/WZTsyIKNj7
tYmH0qwoJ0gmCe9kKyZg+oRtmzHXDB3KN0rLdHh6h+08t+CUn3bEdquEIQaaH+AL
CbWJVf19Xexio2l3rXppHCmLDYh4jCx8PFK4f+rcqKUEY3EIlZMQ1//ci7dHdX9x
BcGCEOo7arsTgpzqbLGxP7Y6TiEfNmDtwxPnUiJxOYLguI8Iq7FPr6TxCY0bWbCq
aRSQ1qlP2AG8sEVNY4vE
=vWQf
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
