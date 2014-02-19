From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi: Provide core support for full duplex devices
Date: Wed, 19 Feb 2014 22:04:07 +0900
Message-ID: <20140219130407.GR2669@sirena.org.uk>
References: <CAMuHMdUY+XEqKYh7mMOYUV18PpR+7SFw+BEUFh-9yL=H6reQkA@mail.gmail.com>
 <CAMuHMdWkPxp2U=Xz=wWu70RPxj+4GGCyifdPv=xL=47cz_upBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KHAtaOORvaARn5O0"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWkPxp2U=Xz=wWu70RPxj+4GGCyifdPv=xL=47cz_upBw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--KHAtaOORvaARn5O0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 10:59:09AM +0100, Geert Uytterhoeven wrote:

> For Dual/Quad transfers, which are half-duplex, the buffer pointer for the
> unused direction must be NULL, so the driver knows in which direction to
> transfer. Hence SPI_MASTER_MUST_TX cannot be set for Dual/Quad
> capable SPI master.

This is a particularly thoughtless hardware design it has to be said.

> I'm also worried about the buffer allocation. With m25p80 and mtchar, the
> transfer buffer can be quite large (up to 4 MiB in my case), and this can be
> triggered from userspace.

That's readily fixable for DMA capable drivers, we can just repeatedly
transfer the same page (or whatever).  PIO drivers have big problems
with such large transfers anyway but could also easily have the transfer
segmented for them in a similar way.  Once we do these things we ought
to be able to avoid having to free the buffer on idle (though a memory
pressure notifier is probably polite) which helps too.  What's there
currently is very much a first pass implementation so things work,
there's plenty of room for optimisation.

> Alternatively, to avoid the memory allocation, you could zero rx_buf,
> and use rx_buf for both tx and rx? That may break some DMA setups,
> though.

As you say it's not clever for DMA and means you have to do the memset()
each time you use the buffer.

> Concluding, for PIO mode, I'm still in favor of using

>     data = tx_buf ? *tx_buf++ : DUMMY_DATA;

> in the SPI master driver itself.

With the ternery operator for legibility of course.

--KHAtaOORvaARn5O0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBKvEAAoJELSic+t+oim9F+0P/07D+bXTrnB8Oc19At48bPpi
XZAeEnKE4TA0nFWxotiyS0cZuFBF6AWW296lVRcWdx/Swe+jDjTRQPaXtIKhsEyO
84Qaj29+LCogGz0VRFYyzcqAaOrmhYlH1aJTgsUDJm4tOlYCeH5ZiKFgjXkkj8OV
MVI3eNIz1NeOtfpcCOxk/iwczAOxVKlAa2SNVMzlfLzNGmEAQccYxutt7lSDFwXH
ClIPMUYO8toeg/1RuZN5/Ymwb760vZECI40pbK3J34ZOYTn/TVIBwgXJGw4lCx+I
tx+53VMXnax6XSSJ6QkafoHmm0BU+bdbuVjT2EtdEgfD1FiRCSZCeuSS2qtrImaJ
NufrckA+HaYIVyUyRS4XQ0A2l8cuTrmJz+d0XP8iiW1HKG+/Ul28nmsD4RVuV1LC
dy/AUDvOKNFJzie6eoWqFRPGh17l3hwOKfpde2/gVlCs+nIhcPcMEwWSawkxulCP
PNwBYNiS4nChmrIcKy9bAgZugQHsO4AgHbH4Tg6QKuIQCSw2WRnBL3ML8NAV5Qhg
Smf6Xm0MsNkMWpbA3JP6SoLsFsJCOK9vyY89lyJ3XJ4RU9PmG4Pq5XZh5OXMe/di
JqDfL5xGom9Uf84N8tUwQzsDjYc3ZtddVafBb42hIR2nLzWpt+ZD8Hk7BN9yp/cf
nq+3rcNrFusUtnrFBXLx
=OXnF
-----END PGP SIGNATURE-----

--KHAtaOORvaARn5O0--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
