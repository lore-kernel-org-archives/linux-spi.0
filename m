From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: lpspi: Fix CLK pin becomes low before one transfer
Date: Wed, 12 Dec 2018 18:16:23 +0000
Message-ID: <20181212181623.GF6920@sirena.org.uk>
References: <20181204062224.28844-1-xiaoning.wang@nxp.com>
 <20181211143005.GJ6686@sirena.org.uk>
 <AM6PR04MB5016E6D2220CDD266B2C6C01F3A70@AM6PR04MB5016.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kR3zbvD4cgoYnS/6"
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Clark Wang <xiaoning.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AM6PR04MB5016E6D2220CDD266B2C6C01F3A70@AM6PR04MB5016.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--kR3zbvD4cgoYnS/6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 12, 2018 at 02:10:46AM +0000, Clark Wang wrote:

> These five patches are based on patch series spi: lpspi: Add Slave Mode support for LPSPI. For the patch series make a big change, should I hold these five patches until the patch series are applied in your git branch?

OK, if you're sending patches that depend on other things that are still
in review it's important to call that out in the cover letter for the
series or after the --- for single patches, that way it's clear what's
going on.  Please resend these as a series with a note pointing at the
other series.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--kR3zbvD4cgoYnS/6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwRUHcACgkQJNaLcl1U
h9DWQwf/eSs6W0no3bCwdBsHEh6RjMVq16uNECwN7o3UEJ3f5Aq5J/74kFUB2N8E
keaeg9YYszDCrdbjJen+3TPk+k843CnNFVbo7X7WRGHCTjtkjM9Epfdol4eUbEjn
1aGwp+D33j13gAeVoTy7SBLbMTke5VC+9X4mdaRpbg/vT6R2NEmgFin/JDWnR35J
5m85rQgS78Rw8R5WZpEZsN8Qi+7nQ3aRLsRggRDgEZPcibWwzSVKfg+RRcaxab4N
XWpZYakgbnkzoKbtFgjV9D0YqbPYIuBiMgzXlkLA9bviKU5nRENC1AYGmpQzpkqN
lVTQWOBUNwpIT/jc9oaIL40vbrqi4Q==
=/8Ft
-----END PGP SIGNATURE-----

--kR3zbvD4cgoYnS/6--
