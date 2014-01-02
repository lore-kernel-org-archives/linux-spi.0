From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: core: Use list_first_entry_or_null() instead of
 open-coded
Date: Thu, 2 Jan 2014 11:57:41 +0000
Message-ID: <20140102115741.GX31886@sirena.org.uk>
References: <1388647000.28565.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3/zQ9zHZ+bvXaNu1"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1388647000.28565.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--3/zQ9zHZ+bvXaNu1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 02, 2014 at 03:16:40PM +0800, Axel Lin wrote:
> Use list_first_entry_or_null() to save a few lines.

Applied, thanks.

--3/zQ9zHZ+bvXaNu1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSxVQxAAoJELSic+t+oim9zykQAJ20jSGPrheWiZRrzuXONUh7
c/IPkblkk8Plr2IczvwzpKyUTBVkRi/KPnhwNXxmYmxvrBRx7B4TsU6vzdfWUOSR
WM4nHsintkIPfUY7KnHiJdWkd6M8qQV6++YPY+4niW/nqAqzGcJbl4yQiP8xVqjy
FQKORr7bTe60YePDBbP3UD5USlisww6q+t0A/GW7P1zh+yLnRtBQbIc5Jmr6JNyt
S0zn7PEl5fLjQu7MTw+80uHv1EHzT3wNyBxv8EozHeozYWFqgo5fCo17MHMK4lo2
pwxOAUqK8U1bhMKqC9zeSb8UvhzK/ZwpQWeZsHVGBEyDD0HBCbaXMiTm9NW5k/RK
ieDsy2uBpZvAXdyGGdgEwnckD25Qz/7hDYUhovftNcqB4YytRzWb9q3sr31nGVkv
sVVtV4bktqkPr0SdP12WvDlvXGGyaLSRrokcI/lp48D4DDNo7eRp/qNXnw6Iyqkv
scB1gMYwLgLc0Ri6vGHiKsib8HbHt2VBM3DwfTivja+vJjGFnl0SBPWN2X7JshbN
uNx7y72jMHE1fmQeuVT1fReL28KlYe+Wph3F1iSA5Tp3pOzYTcQtcOfq0RG4PS70
eNBwm0ipizQITas1EtmHlB+YaOhLT5a9tnYAYGOdWEQ/NFUJRMwrX1b7Gif2tOfK
Ml036VL6AQXBApG8b5Ba
=GYCo
-----END PGP SIGNATURE-----

--3/zQ9zHZ+bvXaNu1--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
