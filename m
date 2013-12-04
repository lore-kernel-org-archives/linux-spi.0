From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: spi-xcomm: Use devm_spi_register_master()
Date: Wed, 4 Dec 2013 12:52:59 +0000
Message-ID: <20131204125259.GP29268@sirena.org.uk>
References: <002d01cef0af$5a21f140$0e65d3c0$%han@samsung.com>
 <003001cef0af$d5c84ce0$8158e6a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="THYEXwetZJOK3OLY"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Lars-Peter Clausen' <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <003001cef0af$d5c84ce0$8158e6a0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--THYEXwetZJOK3OLY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2013 at 02:15:23PM +0900, Jingoo Han wrote:
> Use devm_spi_register_master() to make cleanup paths simpler,
> and remove unnecessary remove().

Applied, thanks.

--THYEXwetZJOK3OLY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnyWoAAoJELSic+t+oim9gMIP/0wEzzPA5zICovEPNoNn3NOU
80W/23+kFJb+b9p1DvREFc3gM09zp0sI/g5u4dfpDDgDuRNko4L15FlUksr5sG9b
ZtCOLBEMYVV3eOOBdrU+UoqNr07FLNjBd5Ll3/oa6WK4o4JrEB6d04YGJcf16kv9
pBo/k2pU3+RfI6Qjj2Spj3yM3rqemPLqA9LY/s56TuSaOjIj1qwyVv1Hp55YMMid
tEB5i9M43ZN3nK3L/I5ov89uCXspsG3SDeAM/BNq88QF+mfOL0lwiLFm+F/3XaRY
Rys58+/FNOI+A6sF4dZkdHUQckhyQH7rNdUlmgVWi95E2V4ynJsUMiHb8PG5vpFk
f/BmbBX1PlCJRP/Iqp0SiuHBCgw4JWqPEZgAbakloy3hCucmImWdZ7exbmpnmKFN
1LKAbRMSo/KTWRAE370w9jhBo8mri9zBnlO9jd2Ehko+4Z82giLr3yaJDJtT9DzH
KhHbexVTXvbSWuMRRkNG5uwSR87ufaP8Iys3HGbMk5+bvZ4cflGnCPWoC/71WthD
XGUdyWpmx/8c12T6Dqsy9xg5dYA1W55BOBy9D+bTq5TGsq3j6DBXM5TqHDPAdaNW
vIu2cZ+it7+oLQwQahbTO/nmWE6Rql/fJzd6YFk1zxF20SoKrhOUumZVVobQnB1F
csCRJ/xpnyit+7Dsb9eB
=asjn
-----END PGP SIGNATURE-----

--THYEXwetZJOK3OLY--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
