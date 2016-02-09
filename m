From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: s3c64xx: Get fifosize via device tree
Date: Tue, 9 Feb 2016 16:10:36 +0000
Message-ID: <20160209161036.GI13270@sirena.org.uk>
References: <1455031585-11113-1-git-send-email-ym0914@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Li7ckgedzMh1NgdW"
Cc: kgene@kernel.org, k.kozlowski@samsung.com,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
To: Youngmin Nam <ym0914@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455031585-11113-1-git-send-email-ym0914@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Li7ckgedzMh1NgdW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 10, 2016 at 12:26:25AM +0900, Youngmin Nam wrote:

> SPI driver on some SoCs only differ in the fifosize of each
> SPI channel. It is useless to duplicate the s3c64xx_spi_port_config struc=
ture
> or create a compatible name for such a change.

I disagree that it is useless to do this, it means that if we realize
later that there is some other difference between the implementations
then we have the information in the DT to handle this without needing=20
to update the ABI.

> +Optional SoC Specific properties:
> +
> +- samsung,spi-fifosize: The fifo size supported by the SPI channel
> +
> +

In units of...?  FIFO sizes do get quoted in both words and bytes so it
seems good to be clear.

--Li7ckgedzMh1NgdW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWug97AAoJECTWi3JdVIfQ6BEH/ArILUtDqECGIVGHk5KH0RR8
jXv4Gqa6SErTZduDYxZn6XI5ZCWG29C3WbO/QQekHc7sOdEt9dnYV+lYlKkTL6oE
rfuReYPlL8VGpJRR1wr0FFNfHnXR9xfg/WYY6GAWBbpBZAKNRKA2DZkNPPsM6phh
DwOrLtfSRQXbAi9fmrCXxS7j9mMgnv6Xj/C29x/b05NV6b4p+0MXjdrA45/4glGS
ndUtmBAe1/qEaQuJy8Uceq7PSPPhFiUksS+PnF6LMt5PG2lt+3Rm9E36RxHEhKru
06qMlGwTnOewEfOkc70zJ/3g/7r8G+24Ei8CSjqnm8aoBAlvedjYfgS6upKtySA=
=JVKH
-----END PGP SIGNATURE-----

--Li7ckgedzMh1NgdW--
