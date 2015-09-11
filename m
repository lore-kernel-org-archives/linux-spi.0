From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 08/10] spi: rockchip: modify DMA max burst to 1
Date: Fri, 11 Sep 2015 12:28:07 +0100
Message-ID: <20150911112807.GH12027@sirena.org.uk>
References: <1441501881-13700-1-git-send-email-shawn.lin@rock-chips.com>
 <1441501986-14034-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fgOXmB9TvEybD/N/"
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
In-Reply-To: <1441501986-14034-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--fgOXmB9TvEybD/N/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 06, 2015 at 09:13:06AM +0800, Shawn Lin wrote:
> From: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>=20
> Generic dma controller on Rockchips' platform cannot support
> DMAFLUSHP instruction which make dma to flush the req of non-aligned
> or non-multiple of what we need. That will cause an unrecoverable
> dma bus error. The saftest way is to set dma max burst to 1.

Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

--fgOXmB9TvEybD/N/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8rrGAAoJECTWi3JdVIfQcNsH+wbzxE+Bh7KVYNw+UC54OdVj
ytn/OyUAf3T4DcZQqe0J9m3eMIMLpxh01v2filrIJNGnv0q5R2uYgcpu7MDWChmw
3YA3iTMzFsp+HLtc473bqVgbh/BXN07Rh1XvbI5s8O7OjVIkTz9N5sTabuGV+TDh
qQWxAdxXpNFCV0FxZ3mbwR5lcoSK8xAAewEbJCuQ+Y8+5EcSFqao8es/fAgjuR+U
NA0UUVBVTxj2OYl+pt11lxnKM8IafH3XPN8Rlw/4jY7qIz/pUJePpU3VBPlt/UY7
uB0bYNJJg/26Q96Eb2x32IM+OjTsHyGissV1v7hHkG/MxP7ycpI25d0hQ7cmUsE=
=sgF9
-----END PGP SIGNATURE-----

--fgOXmB9TvEybD/N/--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
