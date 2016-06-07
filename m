From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6] spi: st-ssc4: Remove 'no clocking' hack
Date: Tue, 7 Jun 2016 16:17:12 +0100
Message-ID: <20160607151712.GA7510@sirena.org.uk>
References: <20160607111930.10375-1-lee.jones@linaro.org>
 <20160607111930.10375-7-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LG5jgFgJbJFFiAfj"
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@stlinux.com, maxime.coquelin@st.com, patrice.chotard@st.com,
	mturquette@baylibre.com, sboyd@codeaurora.org,
	linux-clk@vger.kernel.org, linux-spi@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160607111930.10375-7-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--LG5jgFgJbJFFiAfj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 07, 2016 at 12:19:30PM +0100, Lee Jones wrote:
> Due to the newly upstreamed 'critical clocks' API we can now
> safely handle clocking in the SPI and I2C drivers without fear
> of catastrophically crippling the running platform.

Acked-by: Mark Brown <broonie@kernel.org>

--LG5jgFgJbJFFiAfj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXVuV0AAoJECTWi3JdVIfQwWoH/A4zqWQ4CjX03RA0QfIhbiZX
DjoYz9YmwRsONygQuj1Zv/R85SO5srPqdEZy6T0C22V9IG7BbV3eU5NDAko39EKV
MbzNzFbRQ17EJNDoeLI05BjfQHHNYV5xWiEAMthHcwArATQwwm2CAJvqhDJocmtj
L0RBZTNqRHtBQf8Y4YbM2CUqmgim86qCZu46S7Hi/sA/2lAHd0PBrtUAjJbImkO6
4lSzuW+SQJd+LulxFda5Z+apKyhdSC3ZsUioipnGvuYiIRvzVYvuHsyoSxtL90/Y
DPPtXfgja+PYBxwLTp0efBZ+A65YtKuh89dHJajXwXPLeRtJZ8+4Pusy45zwJSM=
=S9zW
-----END PGP SIGNATURE-----

--LG5jgFgJbJFFiAfj--
