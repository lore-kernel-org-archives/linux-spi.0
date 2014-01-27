From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 06/14] spi: rspi: Merge rspi_send_pio() and
 rspi_receive_pio()
Date: Mon, 27 Jan 2014 20:04:07 +0000
Message-ID: <20140127200407.GH11841@sirena.org.uk>
References: <1390553044-11860-1-git-send-email-geert@linux-m68k.org>
 <1390553044-11860-7-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XyBMaHrM0hrbbr/O"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1390553044-11860-7-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--XyBMaHrM0hrbbr/O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2014 at 09:43:56AM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
>=20
> rspi_send_pio() and rspi_receive_pio() are very similar:
>   - the former only sends data, using TX Only Mode,
>   - the latter sends and receives full duplex data to/from the hardware,
>     but uses dummy transmit data.
> Merge them into rspi_transfer_out_in(), now supporting full duplex if
> needed.

Applied, thanks.

--XyBMaHrM0hrbbr/O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5ru0AAoJELSic+t+oim94QkP/RsQrcl8qsEkVB+FjlnlwqkS
iI3jsXQMZXgrTRxz7EhbcWMGjpimZB/4cuKhNYEwIi8NIjwjs31k4YEySPyY5OMR
kkLU+3q4aA78NT3it8ZSsZJx5O2sKekP43Q0ty9E79HTicapJ23E3m3ICmwFa8Kn
k/AGG7IoA8FnzC4U1nW0VgfqikArPLcSpFDnrfgIIeZS82q6rwdwrkdcXK+c/YLm
sPW9v/uIN5KgFD8eDIej4uUA1y6MC1/AQpGYpQRzdGUkWxPzX7WrpmrVtJNqsnHH
4a6N0/7+5UtLC1uUVGVXFM/N8+iWsyiQYjvBGdnmZwUrL7gzS80QLD7IlEt6h2NK
irT5ahuUQE9QYyqV4Ymec4KpGdXVQsJxBx9K11ms5WmZmMGnSqEJgqFTKsnyc8tA
hbGbrl9WlpKbILDB/EddjRiPG1Xvfru+uW/d47fgweyNTWmRjBHAW1JErmtkO8IA
BWzRKv2Ao4oA1In0n4/eIRqQweyYJR/t+KtaYsCPTjrYnNoR0P6nUKoBIfsmnWvy
Mf+UseqSME4M2CzsH8afwtGtn69zVmfsf3aXeq/IukH8sORLMHW9N3OTnKYH9yLU
LuRGf/U+YJcjvNgp0m3xBx7Keg2X55szmTmG7CCvN03YzAcljGmduZBdCfr9DR3S
5V0yhp2yDLQkB6Q8xXXF
=O7Zi
-----END PGP SIGNATURE-----

--XyBMaHrM0hrbbr/O--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
