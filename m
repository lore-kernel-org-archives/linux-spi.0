From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: davinci: Use SPI framework to handle DMA mapping
Date: Mon, 6 Feb 2017 16:48:25 +0000
Message-ID: <20170206164825.7daqoxyv4zmbafyn@sirena.org.uk>
References: <20170206145708.24356-1-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vpdhjht6tyy4toee"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        nsekhar-l0cyMroinI0@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
To: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170206145708.24356-1-fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--vpdhjht6tyy4toee
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 06, 2017 at 03:57:07PM +0100, Fabien Parent wrote:

> This commit updates the davinci SPI driver in order to use the SPI
> framework to handle the DMA mapping of buffers coming from an upper
> layer.

This claims to be using the framework to do DMA mapping but...

> +		if (!t->rx_buf) {
> +			sg_init_table(&sg_rx, 1);
> +			t->rx_dma = dma_map_single(&spi->dev, dummy_buf,
> +					t->len, DMA_FROM_DEVICE);
> +			if (dma_mapping_error(&spi->dev, !t->rx_dma)) {
> +				ret = -EFAULT;
> +				goto err_rx_map;
> +			}
> +			sg_dma_address(&sg_rx) = t->rx_dma;
> +			sg_dma_len(&sg_rx) = t->len;

...adds code that does DMA mapping.  That's confusing?

--vpdhjht6tyy4toee
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliYqNgACgkQJNaLcl1U
h9DEJwf+LPM0CyzgJlabyJ/0UCt/3ou0+9EqMC9MjIh7cffnjQqzajbm4eWEKVJT
aO8HOffdi+OCd4Ynpi0x43AL5RCLqAgcQvM6hTNJopx1NxVCe0svy6aObGOq4SSY
brC+rrh8ES81i1xMSK/z02bDRMQLiBYkJFc5s246xv9PZ6Sxy1t00V486NT2ImVk
e/inFX02yMimcVFYdpJqBBeJnOSj7ax8Mq4nzKtJPWQV6lYAx6Gt2ctUEbaduY9m
4uvn7Xhk+I6/yGHdHj18hKIgJHYDwEly6EiF4KecFwh1bR6Yg3jcB0JnJ6FNz2SN
tsBJcWLzfmxtnI5WsWCf3FF/4oVsog==
=jAHD
-----END PGP SIGNATURE-----

--vpdhjht6tyy4toee--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
