From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: ti-qspi: Simplify qspi_write_msg and qspi_read_msg
 implementation
Date: Mon, 13 Jan 2014 10:15:43 +0000
Message-ID: <20140113101543.GY29039@sirena.org.uk>
References: <1389508822.13361.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cDkCB6tn7aZ2Gopm"
Cc: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389508822.13361.3.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--cDkCB6tn7aZ2Gopm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 12, 2014 at 02:40:22PM +0800, Axel Lin wrote:
> Make the unit of wlen to be byte, and simplify the code to avoid duplicate
> code for different wlen cases.

Applied, thanks.

--cDkCB6tn7aZ2Gopm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS07zMAAoJELSic+t+oim9tUoP/3QTDEJwPEc/laiohT51LOw0
J+x/0XL7WVpMuIvEECty3tC8huXr3BeLIQ9wdjl/vciDa/OLdKdShNJSKadiHd7Z
Q6R4DHkGAQBNNDyJdCq8rpVFF7I+YxLQkVCMhoHNLUTKKVLkd9NsnJGQfO5mgZg/
UlE7GQnlM14zZXrPdm/4lZebBbLBOtGJHXJfn936sT2PI70GJ0dGwnKMbNhBa1dY
ZYDK0jG2gA15KyHmo5dgpWpGidtgqONYFoVy8huCSd43d5tKW2zvzKMkUlq75Uxp
iO4IGlT4OKZ9huWYE2NfyhJ7Mm2mOQIKD6DkvJD0ML/tQPS0j6MtAKN1hQDEn6xv
6i555WpqP14OhF3OiDZf4yWJf0zETW2F7TAX6lUHonu85h3aLoHROTklkUwDtfxZ
IDCoqE0gXF1e+HqAOrnCxM2OQ3LiHvNXhnpMzXe1ylhztq6C4NT2KraeqXyT0JrC
wUtBgtbPtJRh9CgBMxvGzdB22ch/KsJlpX7GH/unO0yUAxxM3uBAv+c9S0TVZZ3h
qT5hP6ts3obHLg75IAbRwqhlv+RcTFCZEFHamzeOfpPWe+tzNvD0W1pfpyx4hznK
h5xQ4cgZfaSCmnv3bMK9EWaVz9xd4TZV5Q4yEa2DeQmjycwVWZdPMEFwrl2hlQT4
ZlsTq9+kETwOg2+RR4x2
=XSu/
-----END PGP SIGNATURE-----

--cDkCB6tn7aZ2Gopm--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
