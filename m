From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/5] spi: sirf: fix spi full-duplex DMA transferring issue
Date: Mon, 14 Apr 2014 21:06:28 +0100
Message-ID: <20140414200628.GX25182@sirena.org.uk>
References: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
 <1397457001-5266-6-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XLTQE3HqOi3RIrZG"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	workgroup.linux-kQvG35nSl+M@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397457001-5266-6-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--XLTQE3HqOi3RIrZG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2014 at 02:30:01PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>=20
> sometimes t->tx can be equal with t->rx. for example, spidev will make
> tx and rx point to spidev->buffer at the same time. currently, for this
> case, we map the buffer BIDIRECTION to fix the cache consistency.

I've applied this but such usage is out of spec - do we have any drivers
doing this in mainline?

--XLTQE3HqOi3RIrZG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTD/BAAoJELSic+t+oim9NK4QAJT9L+Wk0rrXl8y2e57wXhnA
3MBZTSYeqKQcri7b+z+tYcu1dZ9BkPe632f2t3tlMb5X1HeL47T+xZUKiQOu+RDR
HMEGa6Qrl3EB/IcAIrjE4v58ubm4DlQK6QIwetA4xCd1okxWp9pxNm+XW4YquF4y
g0IDln2dIfgLL5Vrxr08FdkOCzc1cZFrvF/MBgVJJy++X9VALgdcZDv0TijDNvvA
2F1EkowA1WD4lWBa0EV4rR615SCESUNiTRnka/vu7krwnJUO0zqREuGx0XgDVE+Z
HOScKxr7EUGRGMtS2KBWRFnZVoWZUctP2j0SiMLtPEmzdgt0TBJ+oDIucjGOppCJ
oERiux1K/YfRo+Nic/B9lqjZDKxq4OcO3uZLJpm/nrO0aYnjebZxDRUUTmrm4Gy2
cByDz35iEEn7vXIrUKy1V5dhkPdewSuhhWbWLCUuDNmW1gx66CW6QDD2YWmXc4CZ
TAJN9MGQppwTm3c4v4vuFR7Us2Lar/6HR2L6UmrIHktgvUqzA8kicljb2L1jJmUg
l55mzeEV6UZoqgbKEWNzh3RtsYLkmezTXtdgGfCKchVY/8CAfH9x6OQVKw01jCfK
bVM+EhdDUAyhkyzz8DEiSoSTCQyiDxqduUIo8aiGNQ1Tfnd4VIj9LC8v4jrkBT8a
BXOdZApuxh4iQPkVahPz
=WFDg
-----END PGP SIGNATURE-----

--XLTQE3HqOi3RIrZG--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
