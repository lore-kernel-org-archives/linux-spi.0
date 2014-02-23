From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: qup: Fix build error due to a typo
Date: Sun, 23 Feb 2014 14:39:53 +0900
Message-ID: <20140223053953.GN25940@sirena.org.uk>
References: <1393133236.32087.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f7rhGhcaiuL9D15N"
Cc: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393133236.32087.0.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--f7rhGhcaiuL9D15N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 23, 2014 at 01:27:16PM +0800, Axel Lin wrote:
> Fix below build error when CONFIG_PM_RUNTIME=y:

Applied both, thanks.

--f7rhGhcaiuL9D15N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCYmhAAoJELSic+t+oim9Vr4P/2tJbIIECrBDfftCF69XDIrb
hSgGlB8RMIZrt1BmziT6snvcvrFN126dcJtl1ab0gbWmRXG2YpylB99i8WK/sFBE
X1m3XqJFymFW8xxjvYFPr/6C34XsQwkFDe+oMbAFUG45OHIjDXj4c//sLZsCY+NB
qPHsQB/rG/6g+MeynzWVTkibT//lFNurv8vr4MmmD11tsSuy557F4iN9QVu6sv3x
nvGE/m4A/UIwWktdd6uszLEro+GuQ0BHSjrqzDnGTitL0/5MpzJNirN34xQb7Rf/
O72e+kyETcvT43wMML3sXhpwNdMKkslgd6IVJR7WFi2yWWbhm8za8jeJVB0J7Iw5
c4tJ1o+VbFv+OMeod+2UW9PtkYCwDqmrGmblxAvVROXGCupWo7YJHrU6n9mghRa+
aglivzOslq8xizZ/4DB3JIcvauwnY4GnHIJt6lnFzp77APa7St/HswAfEKljTaJ2
Egg471T60st9GEpfsSYVQ4iQPke5Y34jD+C3VdmHAw4dnw9GV8pjaHTYl77pmiA/
nSn45qChYmbVVDjx+fALuey5VK+hLRdxDUE2RnW+gAIpqDd8pa+wwY/aI9t64d7L
lbTeAziRnlZ9kqYSHNp3dH9wuxFph9dDVY7K1yFkq1XhjbC4kIas7aAzARi48Cdz
bbrqW5YhnchTVNhQeEjk
=qZ+H
-----END PGP SIGNATURE-----

--f7rhGhcaiuL9D15N--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
