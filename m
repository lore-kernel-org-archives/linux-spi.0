From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [Patch v1 1/2] spi: imx: add lpspi bus driver
Date: Mon, 14 Nov 2016 12:09:42 +0000
Message-ID: <20161114120942.uzswqewdyh3xgfse@sirena.org.uk>
References: <1479100967-1894-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="otlitxjf4g6hoizp"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, frank.li-3arQi8VN3Tc@public.gmane.org, fugang.duan-3arQi8VN3Tc@public.gmane.org
To: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1479100967-1894-1-git-send-email-pandy.gao-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--otlitxjf4g6hoizp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 14, 2016 at 01:22:46PM +0800, Gao Pan wrote:

> +config SPI_FSL_LPSPI
> +	tristate "Freescale i.MX LPSPI controller"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	select SPI_BITBANG

Don't use SPI_BITBANG for anything that isn't actually bitbanging (which
this clearly isn't).  Use the normal SPI interfaces, all the queue
handling that people used to abuse SPI_BITBANG for is now in the core.

--otlitxjf4g6hoizp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYKamGAAoJECTWi3JdVIfQatsH/1WqW9xLh6qrwLiD16KtwMhf
wDlFkEUVfP6J3pl9YkfYCFqCciOmfxiaXq1R0PUOs3DRiVC1kob1LEeNb97PSM0u
In/O1LK7WmAXNXbOrMMLGtsmLqugcYYxISdbMZFUjU1brvkVUKCaUksMfkWXHBIR
RQi82OfG6zU0wcizaN1ZGDWRKbAgV08NsLGAnFSraZ3tAJz6iwhiaaqjckpQw0cz
nomfqPysxFMIkV0asu46qBbjyqKDRZ99ywWAiqJnYkDQh7Jx267CcP4DWTpp8g8X
Zy0/Hy8caTQMuvF/nLozauH/zbXd5x2pE2ttPIXHu1hjBMrKqqb0TJXhI+FZo7o=
=B1m0
-----END PGP SIGNATURE-----

--otlitxjf4g6hoizp--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
