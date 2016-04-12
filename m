From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 1/1] spi: dw-mid: set DMA burst on memory side
Date: Tue, 12 Apr 2016 01:34:09 +0100
Message-ID: <20160412003409.GN3351@sirena.org.uk>
References: <1460392212-101116-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E0h0CbphJD8hN+Gf"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460392212-101116-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--E0h0CbphJD8hN+Gf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 11, 2016 at 07:30:12PM +0300, Andy Shevchenko wrote:

> To optimize amount of bus writes on memory side set burst to be the same amount
> of data on both sides.

> +	txconf.src_maxburst = 4 * dws->dma_width;
>  	txconf.dst_maxburst = 16;

This doesn't seem to do what the subject says (at least not always,
it'll align for a dma_width of 4)?

--E0h0CbphJD8hN+Gf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDEKAAAoJECTWi3JdVIfQJrAH/1HJjnire9dPse8fEGmKVEtX
XPjgatiC1W67SUZxPRnxIW8561i8cdfvhGW9ZtsuiCarwvuhPRRVGnXIMNXuBd70
yKrV8+AWDsMgpuQDLqHIWB5OW4X9B/q3ycFB0RRVliq6909Mdl7SWSzlHE6QYzHG
T4iQQA9oyUi4zYWMY9Nt+zmMSfpo5KqeWRsUtl59i2DSNdhp5G5rRFK0CE17FAPD
O8rWFZOCwVftgOM8PMa8cSM5c67sdWACtnZ8LtArwjHHMfb4hofRU804SRXX3LUt
dGvQz+6oOMIlK8X+lQ7UQJWzbZhDKP1bmM7afDAxhvLPlJFTrwDQ7fvNwzFNoOE=
=DqjS
-----END PGP SIGNATURE-----

--E0h0CbphJD8hN+Gf--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
