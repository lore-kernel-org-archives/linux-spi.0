From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Mon, 29 Jun 2015 10:48:54 +0100
Message-ID: <20150629094854.GB11162@sirena.org.uk>
References: <CAKor6TfKws63jh6f3VzyYpmTffL4-DHWDTdJ6GSgDC08C5W=8w@mail.gmail.com>
 <20150625073618.GH827@lahna.fi.intel.com>
 <CAKor6TfxNW6UW6iX_FkRn2yZOHvdRHcsj6pKoKH-UWU51Bqvvg@mail.gmail.com>
 <20150625145853.GP14071@sirena.org.uk>
 <20150625154407.GE6321@opensource.wolfsonmicro.com>
 <558D3BAA.3080700@linux.intel.com>
 <20150626115823.GY14071@sirena.org.uk>
 <CAKor6Tf20eC1WQSO=AV2b+XoB5Qv-2Oin_nrrTJUiDV4czxLjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
To: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKor6Tf20eC1WQSO=AV2b+XoB5Qv-2Oin_nrrTJUiDV4czxLjA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 29, 2015 at 09:27:17AM +0200, Christian Hartmann wrote:

> FYI: I can confirm that with the changed DSDT.dsl file and loading
> the new custom DSDT table, I do not need this patch mentioned above.

Are you sure?

> [    5.927801] spi-WM510205:00 supply DCVDD not found, using dummy regulator
> [    5.928958] arizona spi-WM510205:00: Unknown device ID: ffff
> [    5.929098] pxa2xx-spi 80860F0E:00: registered child spi-WM510205:00

The above is saying that SPI I/O to the device isn't working - the
device ID is not being read back successfully.

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVkRSFAAoJECTWi3JdVIfQLekH/jpDmnjuFKm677K1+rMwz3LT
We6vraoqNY1vULDI8JkTwN4xt3DEAnBTtuF2oOrMitRKunD3FoxJh5XIOeNOlXUT
JpYdlQaUCxoki19rmnLAzmCdJMo0X6fLvnHDs/EIw+Z32rXSDxA8sH4zKZOXExfh
5oDWjYZ1HxU0+vnmstvBVzA4Y7XpbzXQqGhYZW0oxAoINTQx9SR1EMEmKiKg7HBc
LLRMVE4fcYbSEWOFsqNUMbgoEz8dR1oFeuScI+YT5umFFF2qcIbxqXWPtkhL6Chg
XAyu3l14WLz2dwjdieetjQRwKOE8gPmy3CzUjvBr89z+f/NlO5N/F9GVcrVUmm0=
=hnBE
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
