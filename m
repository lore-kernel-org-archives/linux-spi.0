From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Fwd: [alsa-devel] [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Thu, 25 Jun 2015 15:58:53 +0100
Message-ID: <20150625145853.GP14071@sirena.org.uk>
References: <CAKor6TfKws63jh6f3VzyYpmTffL4-DHWDTdJ6GSgDC08C5W=8w@mail.gmail.com>
 <20150625073618.GH827@lahna.fi.intel.com>
 <CAKor6TfxNW6UW6iX_FkRn2yZOHvdRHcsj6pKoKH-UWU51Bqvvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a6wDsyrohEFyzhnP"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
To: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKor6TfxNW6UW6iX_FkRn2yZOHvdRHcsj6pKoKH-UWU51Bqvvg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--a6wDsyrohEFyzhnP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 25, 2015 at 02:18:23PM +0200, Christian Hartmann wrote:

>                 Name (_HID, "WM510205")  // _HID: Hardware ID
>                 Name (_CID, "WM510205")  // _CID: Compatible ID
>                 Name (_DDN, "Wolfson Microelectronics Audio WM5102")

Separately to the chip select discussion one thing to highlight here is
that for some reason the BIOS is listing the device as "WM510205" rather
than "WM5102" - do those extra numbers mean anything and does this mean
that WM50120[1-4] and possibly higher numbers are also valid?

--a6wDsyrohEFyzhnP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVjBcsAAoJECTWi3JdVIfQH9QH+gOpLGjivXEEISOgg8u7tYZ8
Xxlv8nRmfNOa2cdJLq0RvvXC/LKJuEvNmKTLK1jhS2RF4KAWZO2h3wZjsr9/8Tl3
J0Yy5djIgpGhxaNuH2E55zcWQS9mPFSQFokDVSz4I4xZ5Ido5inTktY859bZp9/i
r1KkcM3bkR9sLQjV0XiYj9C43bquOE5KKJSGfbXgzZ6dGxwuDoT4VO0eVjZlZHVV
oPMnQpnNwJLpK0d9J1PiXG20LllNX2A4DlJ1pGXfJ19gPuzR+6/FiQAw3+PSkonY
JxHskvd3oRe0r+D5RcCfSslt125HXzpG+WUr6D0kegePDRaLuuj12rbjMXPmv2g=
=0mQ1
-----END PGP SIGNATURE-----

--a6wDsyrohEFyzhnP--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
