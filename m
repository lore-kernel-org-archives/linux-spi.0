From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] spi: support inter-word delay requirement for
 devices
Date: Mon, 28 Jan 2019 18:10:38 +0000
Message-ID: <20190128181038.GF11699@sirena.org.uk>
References: <20190126163220.26421-1-jonas@norrbonn.se>
 <20190126163220.26421-2-jonas@norrbonn.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uTRFFR9qmiCqR05s"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
To: Jonas Bonn <jonas@norrbonn.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190126163220.26421-2-jonas@norrbonn.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--uTRFFR9qmiCqR05s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 26, 2019 at 05:32:19PM +0100, Jonas Bonn wrote:

> @@ -164,6 +166,7 @@ struct spi_device {
>  	char			modalias[SPI_NAME_SIZE];
>  	const char		*driver_override;
>  	int			cs_gpio;	/* chip select gpio */
> +	uint16_t		word_delay;	/* inter-word delay (us) */

This needs some code in the core joining it up with the per-transfer
word delay similar to what we have for speed_hz and bits_per_word in
__spi_validate().  Then the controller drivers can just look at the
per-transfer value and support both without having to duplicate logic.

--uTRFFR9qmiCqR05s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxPRZ0ACgkQJNaLcl1U
h9Ac7Qf+PnvdYqut3vqHiLuZnIkM0rUN8LzkQjuzbXAcNDhc1Mng0wacMxY8/197
iHfg/0ZtyZGvI3LXfVstZaUtryS7tT5sUzuf7zLhUMANNTPT73J+RxabEMojYVdC
gXAcYSvZklqJW1C8SPR+KyxvrrkVJzfTDOt1QjIP2RuKTzqqrXZMXsUyw+8ZveMP
kfDi8HPRqFwpN3TnofAUG8pXYFWUnuBqYBZtZ1p44E741r3DXPP2aT3JMNEvl3lI
Du0WLYv06i4T8VjinvD7aChUtWcPdBYBjh157S+/E7YExhJvqXFKav7BtPc54VJu
Z/iGAOazu9hGpRh6EnHpkMMyFfyNqA==
=ilNl
-----END PGP SIGNATURE-----

--uTRFFR9qmiCqR05s--
