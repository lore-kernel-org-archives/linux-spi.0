From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: Add Renesas R-Car RPC SPI controller driver
Date: Mon, 19 Nov 2018 15:27:35 +0000
Message-ID: <20181119152735.GB3535@sirena.org.uk>
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
 <1542621690-10229-2-git-send-email-masonccyang@mxic.com.tw>
 <0223f43b-c6a6-eade-49af-4e7b7ef7f022@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Cc: Mason Yang <masonccyang@mxic.com.tw>, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>, boris.brezillon@bootlin.com,
        juliensu@mxic.com.tw, Geert Uytterhoeven <geert+renesas@glider.be>,
        zhengxunli@mxic.com.tw
To: Marek Vasut <marek.vasut@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0223f43b-c6a6-eade-49af-4e7b7ef7f022@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 19, 2018 at 03:12:00PM +0100, Marek Vasut wrote:
> On 11/19/2018 11:01 AM, Mason Yang wrote:

> > +++ b/drivers/spi/spi-renesas-rpc.c
> > @@ -0,0 +1,750 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
> > +// Copyright (C) 2018 Macronix International Co., Ltd.
> > +//
> > +// R-Car D3 RPC SPI/QSPI/Octa driver
> > +//
> > +// Authors:
> > +//	Mason Yang <masonccyang@mxic.com.tw>
> > +//

> Fix multiline comment please.

The SPDX header needs to be C++ style so I push people to make the whole
block C++ otherwise it looks messy.

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvy1mcACgkQJNaLcl1U
h9AZPwgAgz+jR6KDSiQW6O7CN72Z0ZZHZYG5GwRntXc5QS7quRocYsywQF3J3efX
dkH2TaTlFg5xR67jkpz80982DIfUNTNi+5FgoTOahIqCKYU68ioZMFQCfiDjlCy2
60V+M4HI0eLUtMTEHai6sOkd6Pfxmro4RcsCdGS6KOUpbv5Ye4er0v/gRB5jo7OW
LTi3WMpTFmaA3CjPEnLUZu0tTdmGpNbheBGn8+WIrG6wZW/0yBeBdX2j8yARy3nt
JCRkRnWEs7oMDS2yimdDvG1WiDvDDzsaf8WqUuRX4rM48hDYoKp2CADyVzL7FEtj
d53z/bQUCT5UYxoC+n0ic7IkQ3BwXQ==
=dihg
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
