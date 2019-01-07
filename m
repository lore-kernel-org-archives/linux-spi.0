From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/8] spi: lpspi: Add i.MX8 boards support for lpspi
Date: Mon, 7 Jan 2019 15:15:38 +0000
Message-ID: <20190107151538.GE9570@sirena.org.uk>
References: <20190107074639.6336-1-xiaoning.wang@nxp.com>
 <20190107074639.6336-2-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Oiv9uiLrevHtW1RS"
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Clark Wang <xiaoning.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190107074639.6336-2-xiaoning.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Oiv9uiLrevHtW1RS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 07, 2019 at 07:47:34AM +0000, Clark Wang wrote:
> Add both ipg and per clock for lpspi to support i.MX8QM/QXP boards.

This needs a binding doc update to reflect the new clock that is being
added (it's not clear from the changelog that ipg was already being
handled).

--Oiv9uiLrevHtW1RS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwzbRoACgkQJNaLcl1U
h9DmAgf/TzYsHsx8PkDjhgE4y/BrKrVNiA77FAnYjkbAYM4yaOMu/o1SIqjU1ciz
lhf9FutknRIeKB8LYTfsL097s2URjO0cvI4ETXf5JmQ2CurLsiATUx4JjhSTXZ2a
keRivDKg/fXwIFzlGOk5qg9alGf1yA5JbXKj67aSzL+W9s3cayBiCzwAMj5EnH3v
aXQjwlI1NNZyQmgrCOvMQn9PwAG5XGZaDmi6P1vp2/I4LyQXwQpAMdBQtrNWpDUb
flKq1SWIULlCD0zOm2VdTz3qJ6SrRscRnqK0FhZ41j1o6MU3Zjrj43NNtQj3NLP0
HmlgRmSH/d2NxohCTJZeNmGfiEsmEw==
=oHpd
-----END PGP SIGNATURE-----

--Oiv9uiLrevHtW1RS--
