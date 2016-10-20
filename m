From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: sun6i: Use the driver data to get the buffer
 size
Date: Thu, 20 Oct 2016 17:56:41 +0200
Message-ID: <20161020155641.b3erji5vrkk3wvia@lukather>
References: <20161019140234.13518-1-woogyom.kim@gmail.com>
 <20161019140234.13518-4-woogyom.kim@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="el7xfeozdi25ollc"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161019140234.13518-4-woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--el7xfeozdi25ollc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 19, 2016 at 11:02:34PM +0900, Milo Kim wrote:
> The argument can be removed because the driver private data has it.
>=20
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> Signed-off-by: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi-sun6i.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index 91235b2..c638f5d 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -105,8 +105,9 @@ static inline void sun6i_spi_write(struct sun6i_spi *=
sspi, u32 reg, u32 value)
>  	writel(value, sspi->base_addr + reg);
>  }
> =20
> -static inline void sun6i_spi_drain_fifo(struct sun6i_spi *sspi, int len)
> +static inline void sun6i_spi_drain_fifo(struct sun6i_spi *sspi)
>  {
> +	int len =3D sspi->fifo_depth;
>  	u32 reg, cnt;
>  	u8 byte;

I'm not so sure about this one. This function was initially to drain
any given number of bytes, which might be of interest at some point.

Removing that argument also remove that ability... Any particular
reason you want to change it?

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--el7xfeozdi25ollc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYCOksAAoJEBx+YmzsjxAg/r0QAKB5XgWBrr724ofCDbdCExvQ
qZFqJqN/NxLFt1EXkbGDvmVR92GOrn/r/eNtbI30K2z/EoElW3lnARRFehmX9A+4
baLlKOI0ex5O6L+XfQVtGJUECQEdzRBHKoM3vwJ7qUH+eY0F2LRaXCh5sMBpxOit
zDvs6vbd8Rpz1ZlZ4mYB4sxUbBq0GviJJW9qiP73J4pP4cc6FnNYkXhf8MOBFEsP
CuxaufuRGHMt8tw3vQ7B9D3PvvWqGH5IzfnjmsSxDRdgRUGNzn8m9cmwZFZt5LoM
xeI7FlA/Y+lx9wETxD1TQxlLf4CaaDqX0ghAsR6NJlyMKGIPZXtD0WRU9wCUaTW8
0ZwmYy3Ez95Y8HSL9aH0dYW2uqVbmBBdggDoa+0GXEs0+021z/kVwD8h2K+5sNbz
IfY8hy/mR4GFNKj+i9TR9IL6L71Kki2AVvTUTXxNmRVSyoz+4hwrFtaIUoaZZpK4
V559/fgXluajTJr6SC48KIkcLmETYK/Grx0rdgadcL1ZVc1WfVlU9usKdYHYB3dg
SMI5sLmAXHMug8hmAsmuOeGx3vVVob9/P+0MzaFrTci2rKZ7aOlOD93+w687LyAF
Tkx3COHe+9fiiK48A6tcbieUAx6JtclqGlusN3Inoh5Az8upgXUNFlOyDFr/pAn/
+meR4IYdubHr3yvRqrj/
=8DzZ
-----END PGP SIGNATURE-----

--el7xfeozdi25ollc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
