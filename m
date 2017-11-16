From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] spi: atmel: Fix DMA transfers data corruption
Date: Thu, 16 Nov 2017 10:45:08 +0000
Message-ID: <20171116104508.rm7xdabyvucowlaj@sirena.org.uk>
References: <1510763732-10151-1-git-send-email-radu.pirea@microchip.com>
 <1510763732-10151-3-git-send-email-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ji7ullfpqmq5lehg"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Radu Pirea <radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1510763732-10151-3-git-send-email-radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ji7ullfpqmq5lehg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 15, 2017 at 06:35:32PM +0200, Radu Pirea wrote:

> +#ifdef CONFIG_SOC_SAM_V4_V5
> +	/*
> +	 * On Atmel SoCs based on ARM9 cores, the data cache follows the VIVT
> +	 * model, hence the cache aliases issue can occur when buffers are
> +	 * allocated from DMA-unsafe areas, by vmalloc() for instance, where
> +	 * cache coherency is not taken into account or at least not handled
> +	 * completely (cache lines of aliases are not flushed and invalidated).
> +	 * This is not a theorical issue: it was reproduced when trying to mount
> +	 * a UBI file-system on a at91sam9g35ek board.
> +	 */
> +	flush_kernel_vmap_range((void *)xfer->rx_buf, xfer->len);
> +#endif

Shouldn't we be fixing this in the DMA mapping operations for the SoC,
won't this affect everything that does DMA on this platform and not just
this driver?  I'd expect that dma_map_sg() and so on would do the right
thing.

--ji7ullfpqmq5lehg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloNbDMACgkQJNaLcl1U
h9CbVgf+OTSWM/5qKqpMbeoI5L7NGwtE5pKuMTpZKVm9Qw+Fz9A+C8cVK6+rIi4A
WVvdlxSmjSV4Bj1Mhbf81DRoHqAX8lyPIS6L2cx31og75C9InHnSqpiQiYyHihGk
F21XhJYEgNZ4fEoRso3bHtCwWCgmy1OFJdaJ1ZZ99WEe/SeSt/wUPevVv8QM5Naf
Hpb8X03PaN6f7XkbG7xN6op1pzypgtVAEwLe4sg+JCEkdtHwKtKkXWIt5uRRPBuy
vipTT8z3DSHHWitTb/05p+9Vi9e+f5b4yp1mgggN7c/aKjNoNBNuSftZNQrGIPQz
B+IbnSklGi6aIQna0lyL0IsCWrueBw==
=8Ely
-----END PGP SIGNATURE-----

--ji7ullfpqmq5lehg--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
