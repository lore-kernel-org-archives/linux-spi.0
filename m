From: Mark Brown <broonie@kernel.org>
Subject: Re: [EXT] Re: [PATCH 1/3] spi: spi-nxp-fspi: dynamically alloc AHB
 memory for FSPI
Date: Thu, 11 Jul 2019 13:41:17 +0100
Message-ID: <20190711124117.GG14859@sirena.co.uk>
References: <20190710023128.13115-1-han.xu@nxp.com>
 <20190710023128.13115-2-han.xu@nxp.com>
 <20190710151628.GF14859@sirena.co.uk>
 <AM6PR04MB49672BE152440416ACCE275197F00@AM6PR04MB4967.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4ndw/alBWmZEhfcZ"
Cc: Ashish Kumar <ashish.kumar@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
To: Han Xu <han.xu@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AM6PR04MB49672BE152440416ACCE275197F00@AM6PR04MB4967.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--4ndw/alBWmZEhfcZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 10, 2019 at 03:35:46PM +0000, Han Xu wrote:

> > > dynamically alloc AHB memory for FSPI controller

> > Why?  This is currently done at probe which is what you'd expect to happen
> > here, there's no explanation as to why this change is being made.

> Explained in cover letter, It failed to alloc the whole memory mapping area during
> probe on some platforms, since the AHB memory area could be pretty large. The
> error may look like:

> [    1.129404] fsl-quadspi 1550000.spi: ioremap failed for resource [mem 0x40000000-0x7fffffff]

The commit itself needs to have some explanation of what it's
doing so it's in the git log, particularly for something odd like
this.  More generally this just doesn't feel like it's solving
the problem - essentially we're just deferring the mapping and
then keep on failing operations until the allocation succeeds for
some reason.  That's going to be disruptive for users of the
device and it doesn't seem like it's going to be a robust
solution.  Why does the allocation not work initially and why is
it more likely to work later on?

--4ndw/alBWmZEhfcZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0nLmwACgkQJNaLcl1U
h9A+Bgf6AwDQOAxz8HNRuZUiqA0sCkEKXRDLd50GzqscTcokWsglR/zwhB8hT2o4
ui8ywL3XMsPaiJANgZ9jjXoCroNHhl52Xsjb/d3B8fcVGk/w7XRk4jmsgpcDkmCC
7KqbRkhIqOnqAbeEkgh2q3JXrJMrZr4f1dAcukG9t39z2I1gPu7okG8+Zqaso/py
7mpD7AMzeBKLuktxUGv866HhtZyrVS8s/QK3l6alqZmmSA5A9WQWIzNBmDTu8QCZ
FwG3G85vE+EOj2Z18nFN759QMzVyxLuYFjrRs7W4CP42oEJze7ixXOjHvqFw5hWn
IIc9v+dlFMmZ+/YZ10LuImjktd5eMg==
=rGo2
-----END PGP SIGNATURE-----

--4ndw/alBWmZEhfcZ--
