From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Wed, 15 Jul 2015 10:17:09 +0100
Message-ID: <20150715091709.GK11162@sirena.org.uk>
References: <20150626115823.GY14071@sirena.org.uk>
 <CAKor6Tf20eC1WQSO=AV2b+XoB5Qv-2Oin_nrrTJUiDV4czxLjA@mail.gmail.com>
 <20150629094854.GB11162@sirena.org.uk>
 <CAKor6TdDPb2qOgdHbeX2w+yQa_ioDM5ak9bk+=jF+cKt_twiXw@mail.gmail.com>
 <20150630103404.GI6321@opensource.wolfsonmicro.com>
 <CAKor6TdKk2OUz4o12RiQBSVZyhD=L4JpBJcYkGE=_6X+ZeQY_g@mail.gmail.com>
 <20150713095359.GM16517@opensource.wolfsonmicro.com>
 <CAKor6Td83zgOS+iHGHGhFW4n26H=tC-QQDuzaHHfybhLeH-jvw@mail.gmail.com>
 <CAKor6TdheYM73aqti362bOnP2GZmX60uuDY5v2eow1vqO9tcKw@mail.gmail.com>
 <20150715081224.GN16517@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vHmniAU8lLDT2+7p"
Cc: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150715081224.GN16517-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--vHmniAU8lLDT2+7p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2015 at 09:12:24AM +0100, Charles Keepax wrote:

Folks, please remember to delete irrelevant context from your replies so
it's possible to find any new content you might have added.

> I suspect we still have some issues with the GPIO lookups, I
> suspect we want to actually pull them from ACPI rather than
> putting them into the pdata, as I don't know if the number will
> translate directly over.

Yes, you shouldn't be fishing numbers directly out of ACPI but instead
resolving them into Linux GPIO numbers.

--vHmniAU8lLDT2+7p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVpiUUAAoJECTWi3JdVIfQLQoH/0IFl4jsC3Pxh3qBK/SHLrN7
YiJM8txrqsJYJJ84mD404CecAmWFDeRgL+1dfH3XhgQDNo0G1roHPe7YCEWpMzaz
nfSunttvpgbe2uGZcNzqfygc0tYV79/QzMdqlMI2YGuUSWjNus+3IunEEETq4Px5
IV3HIwSronkLWw3mcNSrZaWSGKabfq3YcBNPGN1YDaGvVZqKX3v+jNXRPh561BbY
/WSr90hWfJoMrZ+nAvuj+9S/w0LTpGnZkP+azuH735b3UD5UWdT5Y8Gh9v/+gpHF
wx1hULMtE6qeKNEsUzzzkPysoJTvcvDzbrWbbnb8xEQ4eU+LzO/FgGVdBg/7jRY=
=QmVH
-----END PGP SIGNATURE-----

--vHmniAU8lLDT2+7p--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
