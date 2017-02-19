From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/6] spi: davinci: Use SPI framework to handle DMA
 mapping
Date: Sun, 19 Feb 2017 16:29:55 +0000
Message-ID: <20170219162955.cf3t6dljxblf5zwg@sirena.org.uk>
References: <1487327904-28311-1-git-send-email-fisaksen@baylibre.com>
 <1487327904-28311-2-git-send-email-fisaksen@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hyznqlol5bqi5r74"
Cc: nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
To: Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1487327904-28311-2-git-send-email-fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--hyznqlol5bqi5r74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 17, 2017 at 11:38:19AM +0100, Frode Isaksen wrote:

> +static inline bool __davinci_spi_can_dma(struct spi_device *spi)
> +{
> +	struct davinci_spi_config *spicfg = spi->controller_data;
> +
> +	return spicfg ? spicfg->io_type == SPI_IO_TYPE_DMA : false;
> +}
> +
> +static bool davinci_spi_can_dma(struct spi_master *master,
> +				struct spi_device *spi,
> +				struct spi_transfer *xfer)
> +{
> +	return __davinci_spi_can_dma(spi);
> +}

Why the wrapper function?  __davinci_spi_can_dma has exactly one user
immediately below it.  Also please write normal if statements, it really
helps with legibility.

--hyznqlol5bqi5r74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlipyAMACgkQJNaLcl1U
h9D6qgf/bfhK6F8zC6jyD8o62E0DGMdXTklISzvIijRJrSBvEWtShKunZFoC6c5K
51ZRxXzwkEdGMG6e+Ol6y/Wmqv9777srsuO5XEHi9kebTBFRMgan/bCCXkTtGNjZ
C3HfT7Ty1OIKudgIIxgtgCYmMQTykg2IEc0IPQisD5WvUQmuNp5nCilD40cuYw0d
Ae1sze4LLrv7FdE9gpzk/7eZcvCnNKYP8zsqynSMV0YsbU9s185z59wakXesVMrU
5ETcrHWKfxZ9yRWLbkfVpyJr+rzdHSfhKgMnNyeqv1hDymlABnyon7JNQ4lIF580
w94hzSh4Pe9gvclraLBr52t3EIO89Q==
=qlLi
-----END PGP SIGNATURE-----

--hyznqlol5bqi5r74--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
