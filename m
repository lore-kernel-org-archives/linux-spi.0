From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: xcomm: Remove duplicate code to set default
 bits_per_word and max speed
Date: Tue, 4 Mar 2014 11:19:38 +0800
Message-ID: <20140304031938.GX2411@sirena.org.uk>
References: <1393771721.4044.7.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m0OTIrBz/ErRqy1N"
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393771721.4044.7.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--m0OTIrBz/ErRqy1N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 02, 2014 at 10:48:41PM +0800, Axel Lin wrote:
> In the implementation of __spi_validate(), spi core will set transfer
> bits_per_word and max speed as spi device default if it is not set for
> this transfer. So we can remove the same logic in spi_xcomm_setup_transfer().
> Also remove a redundant code to initialize is_first variable.

Applied, thanks.

--m0OTIrBz/ErRqy1N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFUZGAAoJELSic+t+oim9miMP/2MeDlBO0Ff0LfM9YRW4O4gw
tfzYdaPycKgTQfysR5Ono6Wf3ePtn1nmVi3YejYXagJ0JIhkC6nvS44Lc251HHPq
ZQEQb/LzZtdZuJnC5hHxw/2x7MsU7GL68B9Ej6jc5+Er9P2GUDidWifeEOV80Xst
p2r7AtlRth2jVlci9p3cGGGBpEkiFURewWGQLO/Akr0lb1P1OjlC1vAaBxAfsdna
OZ0yiZBYBQ3DbeZylaGa4xF5M4l9YU38KJsiowE//ADY7DwUj9PQdE+P15wgxdGm
1XR0y7+FQTrt8RKqAio8Y0CRv62R0P5KPZxXuzRc3Uy94rsvcpL9K4QG2hbCkdxB
SuQhzyZwjPkFRm7Aowg9sfB5JH6wI5yqKTM5SwTLU6V/QJEuQsPM63Z5cEbBu64f
IBV5CTc8W8rNnbJVXUxrWgpxElGlqe1cZNEV0kG5xaDMdTWn4/sj2oYNFLUVPgPx
76wWNt7O8kUDdh9yXoLuL6YsDGck4HdEbndBagjJ2zx06KMVsEmf3OKfTY1wZDeO
PBmuDl3gfXfE3yKud2XpFkOsIhhcaD2l47iOOD0kSvSKCUkB80ttaLJNBJ4mADV5
ifw6oeQRyZfHv+djnQbFU99FnTg3YeAH4bOI8gXYowFoseV9IqJL6JsPmZaymAWG
CwYazQQ8rmVKbHlrVATD
=eOnF
-----END PGP SIGNATURE-----

--m0OTIrBz/ErRqy1N--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
