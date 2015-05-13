From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1] spi: spi-fsl-dspi: Enable TCF interrupt mode support
Date: Wed, 13 May 2015 12:45:58 +0100
Message-ID: <20150513114558.GL3066@sirena.org.uk>
References: <1431351698-44015-1-git-send-email-haikun.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6T2vOV0TokPza8xG"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Haikun Wang <haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431351698-44015-1-git-send-email-haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--6T2vOV0TokPza8xG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2015 at 09:41:38PM +0800, Haikun Wang wrote:
> DSPI module has two optional interrupts when complete data transfer.
> One is EOQ interrupt, the other one is TCF interrupt.
> EOQ indicates a queue of data frame has been transmitted.
> TCF indicates a frame has been transmitted.
> This patch enable support TCF mode.
> User can select expected mode from dts node.
>=20
> Signed-off-by: Haikun Wang <haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  drivers/spi/spi-fsl-dspi.c | 175 +++++++++++++++++++++++++++++----------=
------
>  1 file changed, 112 insertions(+), 63 deletions(-)

This is adding a DT binding without documenting it, all DT bindings need
to be documented.  I'm also not clear why this is something the user
would want to be able to select from DT - what is platform specific
about this?  Shouldn't the driver just ensure that the most appropriate
interrupt mode is used?

--6T2vOV0TokPza8xG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUzl2AAoJECTWi3JdVIfQpGIH+gJ7+OM4XosVYCeRFEeJIJFF
kuKs4mnnVrrZcB+6IXzhCBIAahBdedopOz71JAWxXga6RcrTJX6XkCaeqva7I6Mb
yxuhOsEFVoY5wxi824pKWNn3poHzVdY0PqXUsuz3HbALoBQPoIzF4EPMqtEcAsep
GEBQFZhKVVyIAFfUn/xEF5jffVNIt5qCbsy1IOP1eKICFEToXvghmKZOc6yN1OXh
cffMve6njdFKYwTcqo2KgiGdFrHot5UxpeUcAMljroUZrN/B7fnUCg6PA45gn36r
5xGaxedFg08fZkG1pp2DGOoyMj407BeL5edf81BJicCusKTcgjdDblvtHYJo0us=
=PqYX
-----END PGP SIGNATURE-----

--6T2vOV0TokPza8xG--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
