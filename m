From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: pl022: Fix broken spidev when DMA is enabled
Date: Wed, 8 Oct 2014 12:21:43 +0100
Message-ID: <20141008112143.GT4609@sirena.org.uk>
References: <rjui@broadcom.com>
 <1412743127-4523-1-git-send-email-rjui@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LXsBfGm2MIDJcXyT"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	JD Zheng <jdzheng-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412743127-4523-1-git-send-email-rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--LXsBfGm2MIDJcXyT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 09:38:47PM -0700, Ray Jui wrote:

> The PL022 SPI driver maps the DMA RX buffer before the DMA TX buffer. In
> most cases, the sequence of the mapping does not matter. But in cases
> where TX and RX happen to use the same buffer, e.g., spidev, it causes
> the cached TX data not written to memory, because the same memory has
> been marked invalid when dma_map_sg on the RX buffer is called

This seems like it is a bug in spidev, using the same buffer simultaneously
for both directions isn't something I'd think would be expected to work
reliably unless it was explicitly mapped as bidirectional.

--LXsBfGm2MIDJcXyT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNR5GAAoJECTWi3JdVIfQhUgH/0zt4qPnCGtU0caRZuqNqHFr
BWm3LT2azuJqwdN0ET+Q2Vitd3AdKgLKV8FdKest5CP8xFCXRnCmeRhjDmNm5vrV
UlzSic2DgvT8Eylv2jexXSXlUseG87tQffFRkuxlyZsochTBv9oAU7B+tJ4MjPlH
7WeUbMoIgdpLiNzmPq6NK7FltT8heMv2TCHR2xIcYvY5+C0AT/cQAh0nvB+2YGaw
KX+t8j5wmeal03/PfRP8mhjTg1TE+GYWEHyTTldcxVdt3ogUhino+8GAaeqFeMdW
zgeWTNrfj3d1HF6NQXhC/CZ9ij+Hu8FcyNwX1gZY1XXHMwktQmWAVguZH2wYLHY=
=sGCg
-----END PGP SIGNATURE-----

--LXsBfGm2MIDJcXyT--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
