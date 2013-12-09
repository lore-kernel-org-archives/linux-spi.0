From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: omap-100k: Remove casting the return value which is
 a void pointer
Date: Mon, 9 Dec 2013 11:55:36 +0000
Message-ID: <20131209115536.GR29268@sirena.org.uk>
References: <001801cef4ca$8c605e20$a5211a60$%han@samsung.com>
 <8761qyuv6g.fsf@mina86.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hwMNHYNcH9aNQF1X"
Cc: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	'Cory Maccarrone' <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8761qyuv6g.fsf-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--hwMNHYNcH9aNQF1X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 09, 2013 at 12:21:11PM +0100, Michal Nazarewicz wrote:
> On Mon, Dec 09 2013, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:

> > -	spi100k->base = (void __iomem *)dev_get_platdata(&pdev->dev);
> > +	spi100k->base = dev_get_platdata(&pdev->dev);

> I might be wrong, but I would assume that __iomem is the important bit
> here and removing this cast will make linter unhappy.

Yes, I'd expect so.  Jingoo have you tested with sparse?

--hwMNHYNcH9aNQF1X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSpa+1AAoJELSic+t+oim9f+YP/i4cZlJhCQWGO/f5PiP572Co
AydZjI0dJ75NM86Yz/dMygutl16SxXngvjmfwuKLH5lMMIPQE5/3UzkWxTjM3Slw
Psp2sDUj4UlRWMNad0cZ5MYujivyZWk7RTACx0AGh3hh4mHOBQ/CasUWCXNO5X7B
5qkMr3piv/U4hnwlOAiheo7QNDliBb0dIoThG1suG/N49aVJaPlCHje+Qyb2NL3C
TOT0xP4MjRZ7k6T7NmVymO98CRAaT4+OO+mwGWniWj25ymwAyGXgOkUX6zugxN47
Al+W5HTVAheboOJLyTR2Z8qKYtuT/pDxSlj3igZqESH1qknfmqOhOPaDYQF4mQs/
U8TC9O7u2NLbImtPBspBY9gcxBCWDnOYqjghVEum8khDiEatwcnI0ug5ctq1ezou
0gim+ryuE0x5ajE1Cxbgr9iKoHrgVS++Li7IbiPVYUDkTneBgRqgPDeL/B0+vpks
LjlUuobz0yjJ9/GTYPqzpJ8ArRyOhPEW9Pbg4ksxd96vNx9OtbLJkDc9+HURTiKa
wrIS4/l5dfR+ClsSPduuABS7z5UDSvxILRO7WuR1rC4mqxSiL6/gfRdbZdeFLttm
aWbrYBZOuTTYD8kU5VwOiV7Copx7cOn3kd1Uvg3JEO77GvTkfzo0ReFHTOICy8sj
1wEfisB13Bra/xdZgcuz
=4EWL
-----END PGP SIGNATURE-----

--hwMNHYNcH9aNQF1X--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
