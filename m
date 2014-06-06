From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: clps711x: Remove unnecessary
 platform_set_drvdata()
Date: Fri, 6 Jun 2014 11:14:49 +0100
Message-ID: <20140606101449.GI2520@sirena.org.uk>
References: <1401891429-14271-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GOdHDkIp180r3pqZ"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1401891429-14271-1-git-send-email-shc_work-JGs/UdohzUI@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--GOdHDkIp180r3pqZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 04, 2014 at 06:17:06PM +0400, Alexander Shiyan wrote:
> Drop call to platform_set_drvdata() as driver data is not used
> anywhere in the driver.

Applied all, thanks.

--GOdHDkIp180r3pqZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTkZSWAAoJELSic+t+oim9XRQQAJdJcrVlUP69LDnyMP1rDknY
qAV5hZcnYMQTxLrvrTw9TDxr97D2+hPcgPK85SBa9mHxYrZf36eFlCDmBkeSpOqc
uvj1ZtKrcZ8hqVQBvj3g7w+UQ+cQxBYWvQ5rRdcopaQ4dMml0Ge8Bdqij/HDh6z2
lh63O+eKdDzZA8u0y27YvCQoUEA+eAfdIPb0iNV4duJlcUFiSNwzUOsd1ZYMVY4M
S5/i+TinZ+E5M6qXNYp3DmARhQpRZOY3wYOJ2JMm4UDj0DaVnsJ3Xyj4eGLBkkfG
8ymkuaUgxiifH16fynGDIcUOMs/X/8jUGRd2m319g58bM69lvLGnWquQmwJx4lPh
yRh+3tG7ms/aJ72UKRi/VGGpv8IJwMoridzGt/CDtDoCAkGzMEWR184U3xYXUsOC
B63TPOZ49SLT0paOJLwIUxjz0mbiT7Azu0UgVUnXsHDpvB1/MgIzNum1Kvdub41X
YlXX/MpKXeWfr0LDhznARENMbQEpt1up+jNDMQs1aXKWu3PtHnHmCCSl3k09zAyo
H8T6OstmPkFVXJwjSu3UGkqBP/hAXXGRtVZbpfgpxzMWwpJ4J8UYZhugl5y3I8Z3
FF3VH1BT8nC+GRYgCTAlsQAJEGxBRFNzHLFx92oIMOKJitHKZVDY4TXZ6pBhdXiI
/u13sKq2B3zCiOoXUseG
=w819
-----END PGP SIGNATURE-----

--GOdHDkIp180r3pqZ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
