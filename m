From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: imx: dynamic burst length adjust for PIO mode
Date: Tue, 14 Feb 2017 18:20:19 +0000
Message-ID: <20170214182019.s3o5uphsfz4bxlkq@sirena.org.uk>
References: <20170208062028.22313-1-jiada_wang@mentor.com>
 <20170208062028.22313-2-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="557rppaffxvm5vwf"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        fixed-term.Oleksij.Rempel-V5te9oGctAVWk0Htik3J/w@public.gmane.org
To: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170208062028.22313-2-jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--557rppaffxvm5vwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 08, 2017 at 03:20:27PM +0900, Jiada Wang wrote:

This looks basically fine, a couple of fairly minor things here:

> +	for (i = 0; i < transfer->len / 4; i++) {
> +		u8 temp;
> +
> +		temp = *(buf + i * 4);
> +		*(buf + i * 4) = *(buf + i * 4 + 3);
> +		*(buf + i * 4 + 3) = temp;

Should this be using one of the cpu_to_ functions?  It's a bit unclear
what the goal is here and if it'll work if the kernel is big endian
(which people do do with i.MX systems IIRC).

> +	if (spi_imx->bpw_w == 1)
> +		spi_imx_buf_rx_u8(spi_imx);
> +	else if (spi_imx->bpw_w == 2)
> +		spi_imx_buf_rx_u16(spi_imx);

switch statement please.

> +	if (spi_imx->dynamic_burst) {
> +		spi_imx->count_index =
> +				spi_imx->count > MX51_ECSPI_CTRL_MAX_BURST ?
> +				spi_imx->count % MX51_ECSPI_CTRL_MAX_BURST :
> +				spi_imx->count % sizeof(u32);

Just write a normal if statement please, it's easier to read.

--557rppaffxvm5vwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlijSmIACgkQJNaLcl1U
h9BjeAf+MXpcqZVEn4O8iT3+abRFj4d4A1o+JiTlTD4LdLgkRYIWUyAN9uaQctf7
jDSep47fA8ykbrR0eUQ/DbMzk/KGU2KxzKoAuK9xqMuMHnKp52pfp4+Bb096+HJL
WamCT2AITgh1nJyWFCBDtzXn8PQ6gEajsDgO3OQTwMSll16z0+3Xe/OUhENAOmd6
cmZHp+rJgUqM0UedWtDR8hIjxlbiVF4wxTNsAHRk1ACsqj7rvCLQHZZoJ910w8mu
EUROETDIn60k7khuBwex38uptsQ5oS8hdrBQ0W76XvEdGxgUXjpbpJSufP3M/jVT
hAA64J4NJU24vQgZ7xFPJ5a0pA76XA==
=VXqC
-----END PGP SIGNATURE-----

--557rppaffxvm5vwf--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
