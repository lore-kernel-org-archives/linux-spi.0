From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fix pointer-integer size mismatch warning
Date: Tue, 4 Feb 2014 11:17:43 +0000
Message-ID: <20140204111743.GU22609@sirena.org.uk>
References: <1391497089-6831-1-git-send-email-sj38.park@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kFkAOFB2pjIHo9zC"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: SeongJae Park <sj38.park-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391497089-6831-1-git-send-email-sj38.park-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--kFkAOFB2pjIHo9zC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2014 at 03:58:09PM +0900, SeongJae Park wrote:
> Fix the pointer-integer size mismatch warning below:
> 	drivers/spi/spi-gpio.c: In function =E2=80=98spi_gpio_setup=E2=80=99:
> 	drivers/spi/spi-gpio.c:252:8: warning: cast from pointer to integer of
> 			different size [-Wpointer-to-int-cast]
> 	   cs =3D (unsigned int) spi->controller_data;
> 	        ^

Applied, thanks.

--kFkAOFB2pjIHo9zC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8MxUAAoJELSic+t+oim9TsAP/1iKYzcQ3WCIXiD6tY5Xg92B
OOTQ1XhYLVLe5Jif1IJmbERz0eZeh/wbDFy1IOtCfDzVntvPwHv93APP5W62tbpH
ugDPQlGQco/7Lu/ypGT8Co4YeNTsuTIEvpKJc21mwTuQB58RNK0CfeVBkL75u4lx
14fhW001a4RLDSEipE1+6kyg5GppBoAO/CnvyfKcJoPAg7/CvdJTuUeiVdxOpcCP
TxpvSvxOQyigl2d79nMQ//YM72g8+VdTSoA3hNBixSykSgkSwiKg6ixzOeKG212F
OPoxemPUZcC/n9u5hlMFIlJfjotg8Qd07SFDUSwh5fHl+Ugogn97r7fped2vcm1l
3czbLOtQXQe55xWfqTXW3AwtJ8HuMzLgfL/uX+h7xH8f6+m05/FT5wKujphi0rNB
BO+CL5OWNv6ymfnHiPo8u22Fxxee0ajjlYWJbkASlLV4qhvQ4XaVFEw0B13k6wAQ
vrMCza5DXACcziigFsr+6rhAFbF187irrRrmFzXtSHkJwg70n5zjsdsQrzOjU363
VkO3+v19EyWdKZLd+7LQo7glATvIyXGIAuy7x/NCn2rziW+H6TMFIUmQb2PygGT4
DpuQp8WDBmng/IJG3K/hPJG2KIOAiPkjNIknRC/NQ4NAG5OO8jBA7Shw5lk+xMiF
mm3NBB0FQGs6lJR2hN/M
=tmnh
-----END PGP SIGNATURE-----

--kFkAOFB2pjIHo9zC--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
