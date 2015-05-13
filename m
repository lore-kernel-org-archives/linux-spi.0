From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/3] spi: spi-fsl-dspi: Enable TCF interrupt mode
 support
Date: Wed, 13 May 2015 19:17:01 +0100
Message-ID: <20150513181701.GJ2761@sirena.org.uk>
References: <1431511911-19376-1-git-send-email-haikun.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v4FgCkd4vT7RadTR"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Haikun Wang <haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431511911-19376-1-git-send-email-haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--v4FgCkd4vT7RadTR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2015 at 06:11:51PM +0800, Haikun Wang wrote:
> DSPI module has two optional interrupts when complete data transfer.
> One is EOQ interrupt, the other one is TCF interrupt.
> EOQ indicates a queue of data frame has been transmitted.
> TCF indicates a frame has been transmitted.
> This patch enable support TCF mode.
> User can configure expected mode in dts node.

Same feedback as before: why make this user selectable?

--v4FgCkd4vT7RadTR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVU5UcAAoJECTWi3JdVIfQHroH/3BBpje3cxLpbJy/x45y1wq8
zLZRl9ttPXhHUDfmSXvggcvZ6RcRuw+Tn5kfVVfZvXOFr9LURZlAjTxPrvbGLXBk
ANBEsDGXw7gOxjXpPhLjC/pF5e+qUWlRa1YVA1fr3Pc6dMWj2iTcLOHLC5mfTrXk
7ZTPteXwU7uIE8oUlbhaz4GZ1Mypn3IEif8kFsImFKtQzmb0VVgV1YTa2ABqYZvt
/UtA9Pj5sNRre4w09SAv0g3PHI7oTOYq4f9UAnm0ofx5aJ5xVarorgib8CWX2la8
we0vP17uslnzfk55WppnCkeHWvpZucLSjIECaZowzy2l/gMHK2jmcF3FKUt8O00=
=4C1i
-----END PGP SIGNATURE-----

--v4FgCkd4vT7RadTR--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
