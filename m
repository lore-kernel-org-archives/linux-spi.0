From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/fsl-espi: fix rx_buf in
 fsl_espi_cmd_trans()/fsl_espi_rw_trans()
Date: Mon, 26 May 2014 16:57:26 +0100
Message-ID: <20140526155726.GE22111@sirena.org.uk>
References: <1400251581-26617-1-git-send-email-valentin.longchamp@keymile.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="35iEUiFini4fM4u+"
Cc: Linux SPI <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Marshall <markmarshall14-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1400251581-26617-1-git-send-email-valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--35iEUiFini4fM4u+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 16, 2014 at 04:46:21PM +0200, Valentin Longchamp wrote:
> By default for every espi transfer, the rx_buf is placed right after the
> tx_buf. This can lead to a buffer overflow when the size of both the TX
> and RX data cumulated is higher than the allocated 64K buffer for the
> transfer (this is the case when sending for instance a read command and
> reading 64K back, please see:
> http://article.gmane.org/gmane.linux.drivers.mtd/53411 )

Applied, thanks.

--35iEUiFini4fM4u+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTg2RjAAoJELSic+t+oim9BtkP/3kFDaMwigKlvQT+LTDEbhqX
oMTgpgzf604dja7RuUpz4xVWZ6IneI6YjCd5SaXNBMdpYrvDLIcAXXIKv+KarR8D
qho+QnV52fyRt3ARRWmI/Etu9TBQvVRdDoWOtvzjnmAdSHp/Ll7xTulzA6fgGYN4
9y63JaNA6JBcbYpE9Jt8fh+U1Bq6AfaB/JJg86k+VZfzlKQlNByUyIi7NOEym9Dh
1T3TDOjSDrpih4NErZQW2fnQcXa4jotiRCTQG2nDVvFN98fvlJobYvSNhJjkhsqH
O6Gey7ulyjeT0+GSMq7sQ8vNiH8LOzRt0rilfESZkZVjfZaoft0j6EImSaUe7s3G
GSngXwxFa1gf5YkbLpBTGNZynyfE3F772TjkAd2r22DIu8r9qEdN9zs6G2F1wD1f
iuDrTCHXTJOn3jMUDZjYRiueaNQZt2jBCC6bfDFgGT8OF+OWqxX7TDV+0NPlsqCw
CURTaPwwUqs24sVN8DS782DI2asOGHAmhjkHkWYdtf9gTD9qVoNV9k1ZBLJlpAId
cXv3zgubQxlgwQu0Pmi+059bAI6HX73VkXDaFftZx85h/DC+CTVlsgTXhDb+uo8R
yMM6NchTxkZRZV/8rtP5hApMNAFqelWDzFf4ebhaBp+nuDPsXZt2eTzoBdA/kheA
zvL9xaCmejtlxYwtqRao
=68L1
-----END PGP SIGNATURE-----

--35iEUiFini4fM4u+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
