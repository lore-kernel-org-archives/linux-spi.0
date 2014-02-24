From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: sirf: provide a shortcut for spi command-data
 mode
Date: Mon, 24 Feb 2014 11:25:17 +0900
Message-ID: <20140224022517.GX25940@sirena.org.uk>
References: <1392222620-17273-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q4CwITyjmtKT1iTX"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392222620-17273-1-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--q4CwITyjmtKT1iTX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2014 at 12:30:18AM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>=20
> there are many SPI clients which use the following protocal:
> step 1: send command bytes to clients(rx buffer is empty)
> step 2: send data bytes to clients or receive data bytes from
> clients.

The code here is a bit impenetrable, it could probably benefit from some
comments or possibly refactoring to split out the command based
transfers into a separate function so you end up with this:

> +	if (t && t->tx_buf && !t->rx_buf && (t->len <=3D SIRFSOC_MAX_CMD_BYTES)=
) {

		do_cmd_xfer();
	else
		do_normal_xfer();

> +		const u32 *cmd_ptr;
> +		u32 cmd;
> +		sspi->tx_by_cmd =3D true;
> +		cmd_ptr =3D sspi->tx;
> +		cmd =3D *cmd_ptr;
> +		if (sspi->word_width =3D=3D 1 && !(spi->mode & SPI_LSB_FIRST))
> +			cmd =3D cpu_to_be32(cmd) >>
> +				((SIRFSOC_MAX_CMD_BYTES - t->len) * 8);
> +		if (sspi->word_width =3D=3D 2 && t->len =3D=3D 4 &&
> +				(!(spi->mode & SPI_LSB_FIRST)))
> +			cmd =3D ((cmd & 0xffff) << 16) | (cmd >> 16);

The above dererferences cmd_ptr no matter what the actual length is.  If
it's 4 bytes that's fine but if it's less this means the code is reading
beyond the end of the buffer.  Most likely this is going to be safe but
it's out of spec and could result in doing something that messes with
DMA mappings.  A memcpy() would be safer.

This is also a bit unclear since the code is so densely written, more
whitespace would help, as would avoiding splitting the set of
assignments you use to avoid casts (but like I say they seem unsafe
anyway).

> +		return t->len;
> +	} else
> +		sspi->tx_by_cmd =3D false;

You should have { } on either both sides or only one side of the if.

> +	if (t && t->tx_buf && !t->rx_buf && (t->len <=3D SIRFSOC_MAX_CMD_BYTES))
> +		regval |=3D (SIRFSOC_SPI_CMD_BYTE_NUM((t->len - 1)) |
> +				SIRFSOC_SPI_CMD_MODE);
> +	else
> +		regval &=3D ~SIRFSOC_SPI_CMD_MODE;

This check is being repeated in two places which doesn't feel 100% safe,
why not use tx_by_cmd?

What the code is doing is basically fine but it's quite hard to read.

--q4CwITyjmtKT1iTX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCq1xAAoJELSic+t+oim9wusP/juPykSATQL+Yi47UeklqywJ
gZnKpGZuEO4sjdQJpO30MWLQQt5Ufqi1mWooZskZ0yPhHXNk+qOxyZH2XhByeXHx
YsdA4MAXLJIB7g2hE+BHFyY0b7lsIkM1WUaTZUcXEI1EWC2DfTbGqoggAkV74T6n
khe7Y3UFx4T5/S3lKk4Xa/3MgZ+mowkqvn0YjSDFQQ3fLZi5DtmcCAx7XiOzZ+wU
FPxhnN3rz+P+EtT3rcfohKv/MJ0teV8ZcQ4fWX7WA6zT7YBfNM+w/50g/hfHG0SZ
LiQVqCN3/SRZMr0rogVMzIM8NtSLVbcSlnTfF3wvQKIdZD9xpt2PpOBxcwfVsG4Y
oHr9MU4aebj+76gQfNPApGPAlGe7SXD1V3UcXUamD7hjnu8YJW/YBKXcEwvCDDdt
APK4LPGWHcanXWTvw3w1tNxRQcIJkxqz3ONsJF1mjCT0izaHMkf8YIq8Brk0cXnS
/4bduYLrmmj/IMTY/tlcG+IQ5UCnM4a1QExhGlOfXiz87UaVp/X4IGUXU+vUudaY
4MKoSPSRUEGwo6kaYOpyhzB0287pBOMr/fmSAGh+PuBjf3pPIhwXdoyk8FXlPqjm
7Ezb/eVpYUpEuPPl5Y08ce1wvd2rzyP4GYQZJmByZ9ZP/2wKQ7nDw+hstGKAL/IS
DNYdv+KLTWfYxu86vZ0Q
=AWVS
-----END PGP SIGNATURE-----

--q4CwITyjmtKT1iTX--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
