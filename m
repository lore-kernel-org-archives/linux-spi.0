From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND] spi: davinci: Allow device tree devices to use DMA
Date: Mon, 9 Jan 2017 19:48:11 +0000
Message-ID: <20170109194811.p3if5pzvjjaez2g3@sirena.org.uk>
References: <1483673177-31516-1-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mt3mgm5kce34a3hd"
Cc: nsekhar-l0cyMroinI0@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1483673177-31516-1-git-send-email-david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mt3mgm5kce34a3hd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 05, 2017 at 09:26:17PM -0600, David Lechner wrote:

> This allows SPI devices specified in a device tree to use DMA when the
> master controller.

> Since device tree is supposed to only describe the hardware, adding such
> a configuration option to device tree would not be acceptable. So, this
> is the best we can do for now to get SPI devices working with DMA.

> Unfortunately, this excludes the possibility of using one SPI device with
> DMA and one without on the same master.

Why would you ever want to do that?  What would ever make sense about
not using DMA if it's available and the transfer is suitably large, or
conversely why would one want to force DMA even if PIO would be more
performant?

> When I originally submitted this patch, there was some discussion as to whether
> dspi->dma_rx should be changed to return an error rather than being null.

> However, I prefer it the way it is and don't see a compelling reason to change
> it.

I don't know what the above comment means, sorry (and don't recall
having seen any earlier versions of this).

--mt3mgm5kce34a3hd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhz6PoACgkQJNaLcl1U
h9CkBwf+Kc0mzLwTwHQp+839pBHF2VluarLvWYDAI8EEgRBHNnOt5NTxVmGVwlT5
dY+cdN3vm9MuGPb4mPDCVS/DVD0EdbSp4HgLxh0+PENN3gZlCRc7RW7oWuLCfb+3
apC0qP/e1bsWtdhV2xJmbWbYPB6R6W4GdTmwhN5gyw/mGn3jkgZLNYoHpN3eLowo
+v9lDPpZ3llwu32Y0V8L/8F6WK7H7xGUtA5VMTeE0PhawdTpe5rxOA4JZkozIicr
iw5YoVEbK29u/K7B1iDPHwTjDItJJnae1Gl6kD7/+Q5zpf4Xu9k8yYdAFZ2vETOo
+DCgy8ZQ62bWiUCJ18i7Ypxf9l7OUQ==
=UPSL
-----END PGP SIGNATURE-----

--mt3mgm5kce34a3hd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
