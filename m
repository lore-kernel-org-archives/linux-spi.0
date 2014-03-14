From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: efm32: properly namespace location property
Date: Fri, 14 Mar 2014 19:27:03 +0000
Message-ID: <20140314192703.GC366@sirena.org.uk>
References: <1394812888-22697-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TS2lcZuyPwZjLAUw"
Cc: kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394812888-22697-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--TS2lcZuyPwZjLAUw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2014 at 05:01:28PM +0100, Uwe Kleine-K=F6nig wrote:
> While reviewing an i2c driver for efm32 that needs a similar property
> Wolfram Sang pointed out that "location" is a too generic name for someth=
ing
> that is efm32 specific. So add an appropriate namespace and fall back to =
the
> generic name in case of failure.

This doesn't apply against current code (I expect due to the non-DT
cleanup from Axel) and like I said earlier needs a binding update.  It
does make sense - can you respin against my topic/efm32 please?

--TS2lcZuyPwZjLAUw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTI1gEAAoJELSic+t+oim9eSoP/R2k5Xvrponqu92od+RPUKRC
WCpZ2WxSThZmLChkwzs/AZeLhCWnZAYa44YamJ4P2AGQgJ/DX3FMkOpKzihZo1jn
Wyehf8e4mdXS4bxVbEMdQnK6S0iA7Rg6Sq6v+zYIb0xxeYZMYNfhhPoadnhWVARb
fv3VkxEMe5FTDinxQ0YmUSX6ueUXl6h9nFe42jsg4mxxX4tCiarNKXKkxj4xn7dQ
hn8LPq4KE6RrE9UgUXlfqrW5IHmXF3PP4DJdMk6SibzRbeaAVLeLOTBHX4lX986d
NLCNHgAzvh05we37wuztn/1kTAjIQ6Yu+TXUMxaeq6yU2A3xluJv0Mg4DGttObX8
zUf8t0wvZHY/FYjhxvlOy667KeoTXXOMM5P+RKTsmDKItawfeFTBIE7KntF6fDFz
FchhiVo3oT4Q1Jju20x/CR+xgR4e8/UWB9Qa7k2gnO9E7CzrKzjd4rvDrJmT6qP9
IrOudWghPFxoD6Znraigfo/JivaFG9Pqtw+72gGhvmrHZGJdCExWxtQRHPFfwLjf
5kbl0D0gpivs5p3blyXfsmRrHqnSn4ueuPFOInq1fwfZ/t11mHWhLJiyY8E+rc4R
1rUVnKhi0K2SA8zA4oJKOCj+FXavtAhZI/cqVTN0+1l6MW4/+wS751qKjkZgsXA+
sIFAsGyG5HWH3onKiOQ1
=gTht
-----END PGP SIGNATURE-----

--TS2lcZuyPwZjLAUw--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
