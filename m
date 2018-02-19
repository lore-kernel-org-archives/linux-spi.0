From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] drm/tinydrm: Remove chunk splitting in
 tinydrm_spi_transfer
Date: Mon, 19 Feb 2018 17:42:31 +0000
Message-ID: <20180219174231.GM32761@sirena.org.uk>
References: <20180219114723.npfsjzyrvhylwrtz@raspberrypi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1061891041=="
Cc: Daniel Vetter <daniel.vetter@intel.com>, dri-devel@lists.freedesktop.org,
 linux-spi@vger.kernel.org
To: Meghana Madhyastha <meghana.madhyastha@gmail.com>
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180219114723.npfsjzyrvhylwrtz@raspberrypi>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
List-Id: linux-spi.vger.kernel.org


--===============1061891041==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ICrdrp3pM9DyZLTK"
Content-Disposition: inline


--ICrdrp3pM9DyZLTK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2018 at 11:47:23AM +0000, Meghana Madhyastha wrote:
> -Remove chunk splitting in tinydrm_spi_transfer in tinydrm-helpers as The=
 spi core will split a buffer into max_dma_len chunks for the
>  spi controller driver to handle.
> -Remove automatic byte swapping in tinydrm_spi_transfer as it doesn't hav=
e users.
> -Remove the upper bound check on dma transfer length in bcm2835_spi_can_d=
ma().

This looks like a series of related changes that should be split up into
individual commits, probably at least one per bullet point there.

> -	/* BCM2835_SPI_DLEN has defined a max transfer size as
> -	 * 16 bit, so max is 65535
> -	 * we can revisit this by using an alternative transfer
> -	 * method - ideally this would get done without any more
> -	 * interaction...
> -	 */
> -	if (tfr->len > 65535) {
> -		dev_warn_once(&spi->dev,
> -			      "transfer size of %d too big for dma-transfer\n",
> -			      tfr->len);
> -		return false;
> -	}
> -

The changelog says we're removing this check but doesn't explain why
and...

>  	/* if we run rx/tx_buf with word aligned addresses then we are OK */
>  	if ((((size_t)tfr->rx_buf & 3) =3D=3D 0) &&
>  	    (((size_t)tfr->tx_buf & 3) =3D=3D 0))
> @@ -461,7 +448,7 @@ static void bcm2835_dma_init(struct spi_master *maste=
r, struct device *dev)
> =20
>  	/* all went well, so set can_dma */
>  	master->can_dma =3D bcm2835_spi_can_dma;
> -	master->max_dma_len =3D 65535; /* limitation by BCM2835_SPI_DLEN */
> +	master->max_dma_len =3D 65528; /* limitation by BCM2835_SPI_DLEN */
>  	/* need to do TX AND RX DMA, so we need dummy buffers */
>  	master->flags =3D SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;

=2E..this bit of the change isn't mentioned at all?

--ICrdrp3pM9DyZLTK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqLDIYACgkQJNaLcl1U
h9BIHwf/T6X/m+UxHBXi0rMkLUmFXs7aIaLlxRaQfuEiXDq2xDVIeZzeW7uu6o/y
qjvJDg+PzNgUGtiUMXjti5mPqGjZn0MLpDNIjM5B0ygBCMLtQON8nfyWSMh6GdgM
H/+xvEqNy13ru+HNnrRByW/8uexUseGYyoTkGgt5+GjqLCwE6VQhNQT0jKx6xcsi
MDtCtT6ek3t24918o3FyM49OexWehFZvlHyMaAuqihqSayzWsGHB/bTqZvpTtzC6
2tjB8BYp0rwffOZzTqyPdmUBlU8Bg7t8qSNQ9+a7gv5D7xVK+vsZ47bUQj35xLS3
g+DASo6jcC1YOPiVcl/n6caZ4226HQ==
=GBJx
-----END PGP SIGNATURE-----

--ICrdrp3pM9DyZLTK--

--===============1061891041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1061891041==--
