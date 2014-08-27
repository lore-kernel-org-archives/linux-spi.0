From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [Fixes: PATCH v1] spi: dw: fix kernel crash due to NULL pointer
 dereference
Date: Wed, 27 Aug 2014 17:39:39 +0100
Message-ID: <20140827163939.GK17528@sirena.org.uk>
References: <1409156768-28461-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PtqI9FCiPnELgtD1"
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409156768-28461-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--PtqI9FCiPnELgtD1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2014 at 07:26:08PM +0300, Andy Shevchenko wrote:
> The obvious fix after the commit d9c73bb8a3a5 "spi: dw: add support for g=
pio
> controlled chip select". This patch fixes the issue by using locally defi=
ned
> temporary variable.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v3.16+

Applied, but to repeat please use Fixes.

--PtqI9FCiPnELgtD1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/gnHAAoJELSic+t+oim9WqsQAJUBmnqG1tWfdBYQTwda5OyO
9gToQxHIVd7UdNL7NG2+YJPs/pkID/JvavhiZ99zxRrPCPiSPs3XQFCsmpcAGVgC
JfF+z5RqY7qFbT60Zs2iF63m2fLIL5e2cz4Cidbyp1wsYOQz5GMdkRk6g8Ov1Twv
kdzKoKPlfFYw8AeA7q5ee63SIdUShUwyc8LOR5a6T3WUYck7F0SiLyNe3a+jZq++
yA8MHlSkZEdv1hgZXysQlfm3utz0qUi26sGtIBjqiwJWwtMSqJJ1CrVgMksP0opZ
RRrIRKr0aGZhhYVSsYvHMGZRz9ND236Y0p/5iP+DUYimXRlG6BCCU4WY8M2R+INR
jQd/nhSohk+MqqgP6LTj60iHAxC165Mp7s7dF9TR8I9i+ABRu9hoigHvIDRnWotg
C8sDq9J+F+gdb4X1/AwkwA3+1e9/RfzQCC9KLXBAdb6kXBmqtnKyMZ+d7XxieRyy
tqf/LvnQsDv+rf/EKY/gak9hbWAhx7YnmR5dJPTabhelFfc6jK95JmBQtAtctTgm
E2+5qPgKp9rc7wFUOvr/mw+yAynzVukbQVur1aClxR0kcf+WdxzN/IhzHJN3PXDJ
1iHjt6NzD15df6v3f97KSAwJMSTD+TqjKBSiyWjWv6rl4Mpw70r9Ru6Xoal80usn
ZVX/M+6NZt0kkZYAEZBK
=cE1z
-----END PGP SIGNATURE-----

--PtqI9FCiPnELgtD1--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
