From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] spi: mediatek: Add spi bus for Mediatek MT8173
Date: Tue, 12 May 2015 17:05:40 +0100
Message-ID: <20150512160540.GB3066@sirena.org.uk>
References: <1431075343-7887-1-git-send-email-leilk.liu@mediatek.com>
 <1431075343-7887-3-git-send-email-leilk.liu@mediatek.com>
 <20150508175306.GG2761@sirena.org.uk>
 <1431434356.2128.9.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Cc: Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Hongzhou Yang <hongzhou.yang@mediatek.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
	Sascha Hauer <kernel@pengutronix.de>
To: leilk liu <leilk.liu@mediatek.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431434356.2128.9.camel@mhfsdcap03>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2015 at 08:39:16PM +0800, leilk liu wrote:
> On Fri, 2015-05-08 at 18:53 +0100, Mark Brown wrote:
> > On Fri, May 08, 2015 at 04:55:42PM +0800, leilk.liu@mediatek.com wrote:

> Could you tell me more details about "You should also be using the core
> helpers for DMA mapping"?

Implement can_dma() - look for drivers providing that for examples.

> > > +static const struct of_device_id mtk_spi_of_match[] =3D {
> > > +	{ .compatible =3D "mediatek,mt6589-spi", .data =3D (void *)COMPAT_M=
T6589},
> > > +	{ .compatible =3D "mediatek,mt8173-spi", .data =3D (void *)COMPAT_M=
T8173},
> > > +	{}
> > > +};
> > > +MODULE_DEVICE_TABLE(of, mtk_spi_of_match);

> > There were three compatible strings listed in the DT binding but only
> > two here.

> MT6589 and MT8135 is compatible;=20
> For MT8135 IC, it can use the follow way in dts to probe:
>   compatible =3D "mediatek,mt8135-spi",=20
> 	       "mediatek,mt6589-spi";

> And I test it's ok on MT8135 platform. So I add struct of_device_id
> mtk_spi_of_match like this in spi driver code.

You should list all the compatibles documented in the binding here, if
some of them are the same just have them map to a single constant.

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUiTUAAoJECTWi3JdVIfQyRsH/RIfXC/axE4Vnj/fc10xN1sA
ouHn1R2VNR2a22+BW2TiEV50STna+tHzOd/O3jbnLzt8PFwQhFzQEiWJnkm0l1ZP
zi+fFz48mMUuCuzEuW5qKyyw6jI2zXrngAE3Pn/dDIbhxNQJOGmNxsZbShNF0Gf9
3/KSrnI8lter1xWXJojNkfA8BYPy0PHDCECqIVBEWpd4BaOf0RKnZTeDUW3fU9ZB
73zwIKWNCWvPjdx7igOPi2Th6fICK8wfVEW2ByR1pEEsHclbTCYAT08+jzzAU1Vp
SP70datG78Pi/ttBJuh3fgZ9UCGy/pJjb0gnTj6gD+DCyuTrW62WIf/faTtT5NA=
=2z4G
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
