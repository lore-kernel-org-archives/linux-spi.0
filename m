From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6] spi: spi-imx: add DMA support
Date: Tue, 16 Sep 2014 10:41:12 -0700
Message-ID: <20140916174112.GU7960@sirena.org.uk>
References: <1410398324-15284-1-git-send-email-b38343@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="saqwZB8dd8xoGD4q"
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Gong <b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410398324-15284-1-git-send-email-b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--saqwZB8dd8xoGD4q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 11, 2014 at 09:18:44AM +0800, Robin Gong wrote:
> Enable DMA support on i.mx6. The read speed can increase from 600KB/s
> to 1.2MB/s on i.mx6q. You can disable or enable dma function in dts.
> If not set "dma-names" in dts, spi will use PIO mode. This patch only
> validate on i.mx6, not i.mx5, but encourage ones to apply this patch
> on i.mx5 since they share the same IP.

Applied, thanks.

--saqwZB8dd8xoGD4q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGHY3AAoJECTWi3JdVIfQjyAH/idzcyENZCv5XYBmBARGjcLd
VBO8sU5OieN4U5/bq2TyDzVW4vRP0BfBoQ2PQZec5N1UcYnWAsfjupzGC1yvGAqK
mq9OAe4J5qihlwNLg+YNn9AHTGEcBJ+UKmJE+Y3KhS58wIGiLYq3YVfb9hyflVla
6gQ9Wjmqc3uNtRvvr3sey8/19B+7i0Lr8vlUyBM751I7nVUZPOy26YoHsNc1QS82
WgX7QcmB4WpUeUtQ4nxFrrq8jxi+dexrU5HHcuqOa+wqA8SNeQbdREdUekn5N+Mf
IdI7X1I8KtOTpbFF9fF/eHT/h8PwInhuCvgBc76KNRAZOLGYFileVkn8pg9HcbU=
=5iX7
-----END PGP SIGNATURE-----

--saqwZB8dd8xoGD4q--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
