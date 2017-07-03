From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "spi: imx: dynamic burst length adjust for PIO mode" to
 the spi tree
Date: Mon, 3 Jul 2017 16:12:34 +0100
Message-ID: <20170703151234.q3fd7vehoyz62qu3@sirena.org.uk>
References: <20170613083402.22324-1-jiada_wang@mentor.com>
 <E1dQub0-0008Ep-Hf@finisterre>
 <20170630121433.piznjqtmhy35zty6@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bhjxwdwc6wo7ek5m"
Cc: Jiada Wang <jiada_wang@mentor.com>, festevam@gmail.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170630121433.piznjqtmhy35zty6@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--bhjxwdwc6wo7ek5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 30, 2017 at 02:14:33PM +0200, Sascha Hauer wrote:

> This is wrong. MX51_ECSPI_CTRL_MAX_BURST contains the burst length in
> bytes, but the register 'val' is written to takes the burst length in
> bits - 1, so this should be:

> 			val = MX51_ECSPI_CTRL_MAX_BURST * 8 - 1;

> instead.

Well, it breaks the build anyway so I'll revert.

--bhjxwdwc6wo7ek5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllaXuEACgkQJNaLcl1U
h9BkZgf/e8RxU7kMQ7YpVN4W6mU3ek5Z4OCTm2DeCWqWnvhJ67JDGoVT3izTfilO
H8ztuB2d2lzvdimgW7H4enQ3Y05QVuRwIL8kxFfjNB9OfGQY3dWj3E4nM68ARqDk
fN6+QQX3jPijNQxbrSWwJwYDiU9Qffec606CNHB0b6Ly8MjWj6OThO+dbyKrK4MZ
YDtAoRoqGF/Igb+EcAGSDFiMp9C3adKCLrf/TzGbmn0mqTTRzilH0YkRNogoG5Yk
KvpvTBC10PsCj2UfcfnOxMJkWZnZGbOvnV0eSOOtHsgYLoqYpUIfoQxBCBYPNavG
RQNGhux6mqw6BoxSKORk0tA5rI1bSg==
=1Rbh
-----END PGP SIGNATURE-----

--bhjxwdwc6wo7ek5m--
