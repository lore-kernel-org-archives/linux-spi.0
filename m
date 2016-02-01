From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Fix incomplete handling of
 SPI_MASTER_MUST_RX/_MUST_TX
Date: Mon, 1 Feb 2016 23:17:33 +0000
Message-ID: <20160201231733.GK4455@sirena.org.uk>
References: <1454366363-10564-1-git-send-email-joshua.henderson@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QnBU6tTI9sljzm9u"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joshua Henderson <joshua.henderson-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1454366363-10564-1-git-send-email-joshua.henderson-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--QnBU6tTI9sljzm9u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 01, 2016 at 03:39:23PM -0700, Joshua Henderson wrote:
> From: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>

> There is a BUG in the way SPI_MASTER_MUST_RX/TX is implemented which can create

Bug is a WORD like any other WORD...

> (1) spi core assigns dummy_rx buffer to transfer.rx_buf member and
> (2) passes it to lower layer for handling. and lower layer completed the
>     transfer/message in due time.
> (3) spi core deletes the buffer if no other requests pending, but
>     'transfer.rx_buf' continues to hold *stale* dummy buffer pointer.
> (4) If spi client driver (like mmc_spi) reuses the same transfer structure and
>     don't touch .rx_buf to NULL

> mmc_spi doesn't reset the ptr unless data transfer direction changes in future
> transaction(s). spi core will skip assigning new dummy buffer and underlying
> master driver will treat .rx_buf as legitimate ptr. This will result into memory
> corruption due to usage of free'd ptr.

It's not clear to me that this is the best fix, it's causing problems to
free the transfer but we could also fix that by just not freeing the
dummy data once we realize we need it unless the adaptor is freed.  That
should also be more efficient since it saves us having to allocate and
free things.

--QnBU6tTI9sljzm9u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWr+eMAAoJECTWi3JdVIfQrtIH/ic20yqcyFpL8e71ly4cgeN1
YcRhQFnuNHlq1T7RgDlNA/DBVdIywcA2Hu+LoOTdDy+i0x+KcAZvUo3n2kxel0Ok
WCvWG8oDmeCgTMK6cdXAfYX94p2Bk3V69ZbFcbrCOfmyEfzw9e2OD6KePOX9hwz7
dDNRpa959IaJkL5z4aUB1DMaFGZ+XZH6R6T7jONHd/S/IO0y5cTOWseCSdImJnPn
t50o5dZ1BxRUJFyOdw79ia7mwT3on54cXlokJKaTT7846Kr1Dd9Sh7qdLbFX1IpK
uu/zaURZVn53qcLAEq4vc5/j2zbd8z4VLvPdQv2tM4os7cCKUTTDidtxpv19r6U=
=bttV
-----END PGP SIGNATURE-----

--QnBU6tTI9sljzm9u--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
