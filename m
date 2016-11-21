From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/4] spi: spi-fsl-dspi: Fix SPI transfer issue when
 using multiple SPI_IOC_MESSAGE
Date: Mon, 21 Nov 2016 19:18:47 +0000
Message-ID: <20161121191847.vg32cwople4qmini@sirena.org.uk>
References: <cover.1479706671.git.maitysanchayan@gmail.com>
 <bbdbc8df434dd2af74eb351b799a2812a1c1967e.1479706671.git.maitysanchayan@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ztispalktchm4tng"
Cc: stefan-XLVq0VzYD2Y@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sanchayan Maity <maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <bbdbc8df434dd2af74eb351b799a2812a1c1967e.1479706671.git.maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ztispalktchm4tng
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 21, 2016 at 11:24:01AM +0530, Sanchayan Maity wrote:
> Current DMA implementation had a bug where the DMA transfer would
> exit the loop in dspi_transfer_one_message after the completion of
> a single transfer. This results in a multi message transfer submitted
> with SPI_IOC_MESSAGE to terminate incorrectly without an error.

Please don't resend already applied patches.  If there are any changes
needed please send incremental changes on top of what's already applied.

--ztispalktchm4tng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYM0iWAAoJECTWi3JdVIfQWHEIAIXGly+6Of0v3BM6CRLRnhMn
V680cDJGQge+pvq9nQH8aH6/VAvOKGVAFtLcnj1uq6qCygKHW5oOrI+8mmC1pmcP
jVJukXc6Y0Cc9bQsI/rp0PJT1ct6N5rzdUIqKoagK/Rs0/ntIbTXp3JyoMdAbLd5
+GUwou0TeC8WBjTo/ynkVc0qtkZ5wA3kJz+1RJOgkQAzQYqx6D0ZVAwAI++5dS4T
phSstfTaTJ0GtM3DE4wNDKzLNXFnzxJLbN7YvjYGO1AupbdEJwRgEBg19mA/EApZ
V4eAJoJdQSdpI/W5LCe3Hf/2nkP4A+l2qmQgDTdKXrX9aUD2td2s978VUurDUVI=
=yoNT
-----END PGP SIGNATURE-----

--ztispalktchm4tng--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
