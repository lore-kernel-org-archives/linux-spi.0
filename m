From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 8/9] spi: rockchip: modify DMA max burst to 1
Date: Thu, 3 Sep 2015 13:54:29 +0100
Message-ID: <20150903125429.GA12027@sirena.org.uk>
References: <1441101381-1329-1-git-send-email-shawn.lin@rock-chips.com>
 <1441101524-1700-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5EhqeiticJwWsSCK"
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>,
	Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>,
	Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Olof Johansson <olofj-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441101524-1700-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5EhqeiticJwWsSCK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 01, 2015 at 05:58:44PM +0800, Shawn Lin wrote:

> Generic dma controller on Rockchips' platform cannot support
> DMAFLUSHP instruction which make dma to flush the req of non-aligned
> or non-multiple of what we need. That will cause an unrecoverable
> dma bus error. The saftest way is to set dma max burst to 1.

If this is a quirk of the DMA controller why is it being fixed with a
property specific to the SPI controller?  Can't the DMA controller just
override the burst size?

> +#define ROCKCHIP_SPI_BORKEN_BURST_LEN (1<<0) /* broken burst len*/

This is misspelt.

--5EhqeiticJwWsSCK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV6EMFAAoJECTWi3JdVIfQ12EH/3J2qry3k16pYz7vDs0aG4y+
zC9BSz7ESW5CXlymQT4CP4cPG+6qEgp0/stwWCHq5ew3q5NkC+NFUleIN/4njiau
uNfyRwnUC7ovudKV4dNSSYTGazrghmM8+0CLg8GME7k4Dsk29N6F83CgGzqGJsak
hQRBtT8ssEbUrIySiu53qUZZ9ddDU/wWrRS48FOfcjd8SkfOhHHf5ZoZ2lJ9ry9q
U1d+HHUqGccmUNWzCIFbm646soEUkxeojQchNngQ3TTRdY7oCoO9lPA/NNKcwrCX
sU7vJMG/r3qkp5WwLsjAy9IshTPl3Jhwh+aOILUznPditIEwcWeTYAo79sSyRa4=
=MdEO
-----END PGP SIGNATURE-----

--5EhqeiticJwWsSCK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
