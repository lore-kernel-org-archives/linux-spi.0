From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: pl022: Fix incorrect dma_unmap_sg
Date: Mon, 13 Oct 2014 13:08:51 +0200
Message-ID: <20141013110851.GU27755@sirena.org.uk>
References: <rjui@broadcom.com>
 <1412880294-9860-1-git-send-email-rjui@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J9FDM06y/La6Wdcu"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412880294-9860-1-git-send-email-rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--J9FDM06y/La6Wdcu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 09, 2014 at 11:44:54AM -0700, Ray Jui wrote:
> When mapped RX DMA entries are unmapped in an error condition when DMA
> is firstly configured in the driver, the number of TX DMA entries was
> passed in, which is incorrect

Applied, thanks.

--J9FDM06y/La6Wdcu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUO7LCAAoJECTWi3JdVIfQxuwH/jgj0dqO8NNfa17Bxm9iBxOv
IAyvpMdcJCBYoRwyplx08xwSZjDRNJZhPnl3VZ3mm8KzCDsRya1eV+QKrb5peQRP
fQLbKpUwA+f4XEf8CeLP/nxQaej+KlS1oAxfkRGnaTZL1xqXqSrax5mLlK3R1a49
ZXzqWXMZUF7ksBwATX4BsiY0lR/2yyNLyCoekcMD5yqAwpVsmtGJ5jB3dW9E3o5D
B7TOD2otj+Qd6cuCiYs/MplWEtHYMty6PjbaxW9zfMXY0lMDzx9WjOeVXOnkCyPF
RHspo7diIKz7VirFFZM8lWSMF3PesHUXMFwzaBO+BAqmx1GxAu/p2s7b0iuf7dg=
=2Ypm
-----END PGP SIGNATURE-----

--J9FDM06y/La6Wdcu--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
