From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] spi: spi-fsl-dspi: Add DMA support for Vybrid
Date: Fri, 11 Nov 2016 12:20:36 +0000
Message-ID: <20161111122036.fubv7b4jc5vkdxhc@sirena.org.uk>
References: <836dd6a84fa149cafdbb0b53e792d305febf6207.1478778329.git.maitysanchayan@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="edmsioyepdlvabem"
Cc: stefan-XLVq0VzYD2Y@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sanchayan Maity <maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <836dd6a84fa149cafdbb0b53e792d305febf6207.1478778329.git.maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--edmsioyepdlvabem
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 10, 2016 at 05:49:15PM +0530, Sanchayan Maity wrote:

A couple of small things, please send followup patches fixing them.

> +	rx_word = is_double_byte_mode(dspi);
> +
> +	len = rx_word ? (dma->curr_xfer_len / 2) : dma->curr_xfer_len;

Please use normal if statements, they're much easier to read.

> +err_slave_config:
> +	devm_kfree(dev, dma->rx_dma_buf);
> +err_rx_dma_buf:
> +	devm_kfree(dev, dma->tx_dma_buf);

You really shouldn't need to explicitly free things like this if you're
using devm_, especially in the error path from the probe function like
this where a failure is just going to result in the device failing to
instantiate so you won't have the allocation sitting around unused for
any length of time.

--edmsioyepdlvabem
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYJbeTAAoJECTWi3JdVIfQBOoH/R20WLl5Pg8qVocL8dDkgL68
BmJca8Xs7jyECuV4vdHDg0n7Uk05vgqn/oo4FfBiaZ2SvELY8vZ2y4adQvHkbgX2
JJ9Hi+dmvz/aTihIAx1uw6MU8xl4Xz1X1ufr+XvA7aTDc0XGx1NlLNukslnQr6VA
uj3hRcnlDnPYS8fnLkTjkUzotJhJS6PjzVhuNKgs8zzw/CK+d4PFgTkvkqKEikML
X/iw+szR17Z4h8AL3JaVvQyeWtBl99CylnwEK7EnCz3+n88dxSWnj2vT3cenwZvG
S+l5U7VBcj4KKNzJPt9z5eecf8/Jx5Z7/x8Tg7cNkaio4BH7SXkkZ1QjjCEsD4c=
=R3SX
-----END PGP SIGNATURE-----

--edmsioyepdlvabem--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
