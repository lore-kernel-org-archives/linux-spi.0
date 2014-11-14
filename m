From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: Fix mapping from vmalloc-ed buffer to scatter
 list
Date: Fri, 14 Nov 2014 15:52:22 +0000
Message-ID: <20141114155222.GF3815@sirena.org.uk>
References: <1415979645-26264-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dz6SLyimFayN/Xsc"
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415979645-26264-1-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--dz6SLyimFayN/Xsc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 14, 2014 at 03:40:44PM +0000, Charles Keepax wrote:
> We can only use page_address on memory that has been mapped using kmap,
> when the buffer passed to the SPI has been allocated by vmalloc the page
> has not necessarily been mapped through kmap. This means sometimes
> page_address will return NULL causing the pointer we pass to sg_set_buf
> to be invalid.

Hrm, this is a bug in the mxs driver (which is where we copied the core
code from) - care to fix that too?

> As we only call page_address such that we can pass a virtual address to

s/such/so/

--dz6SLyimFayN/Xsc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUZiU2AAoJECTWi3JdVIfQ5q8H/1HrSy/3wRHRZEpzkNuhv4zv
4NTM/f2X9Iq3VB0gOtLSbVDWNfda2CnVYGoZ7nVW5uY7zkpQVHtq7jmCvtTP1mK7
I+n//E+X8MJM+aAGziS6Of9/Dae23TimYjK4MWpqd5NLl4KJRQBOJRmgnSkbRXCY
JJ3SUC+LYVASCJZQahQr+wVnAuKfwbKLU1TeGA17JUytYL9pvLaK6zHk4dHvRzbD
wKvd4000H2J7GusJ9gcZ5FzJbd3fTc5xZzlgena6TM51BVvIJiQLZvyw3g/OZv3O
Uc5M9UmKH9ZyZw67GcTiJLIR0DpZBp3MyTXeEcr5H+xYrdaj1q8CoQR8tTkvHLg=
=lPPy
-----END PGP SIGNATURE-----

--dz6SLyimFayN/Xsc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
