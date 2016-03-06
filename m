From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: sunxi: spi: add notice about SPI FIFO limit.
Date: Sun, 6 Mar 2016 19:12:48 +0100
Message-ID: <20160306181248.GV8418@lukather>
References: <1456466217-6793-1-git-send-email-plaes@plaes.org>
 <1456466217-6793-3-git-send-email-plaes@plaes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vuDFP+lnL2KW5uet"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Emilio =?iso-8859-1?Q?L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456466217-6793-3-git-send-email-plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--vuDFP+lnL2KW5uet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 26, 2016 at 07:56:57AM +0200, Priit Laes wrote:
> From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> When testing SPI without DMA I noticed that filling the FIFO on the
> spi controller causes timeout. This should never happen with DMA support
> so just adding a comment.
>=20
> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi-sun4i.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index 78141a6..b750664 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -333,7 +333,9 @@ static int sun4i_spi_transfer_one(struct spi_master *=
master,
>  		sun4i_spi_write(sspi, SUN4I_DMA_CTL_REG, 0);
> =20
>  		/* Fill the TX FIFO */
> -		sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
> +		/* Filling the fifo fully causes timeout for some reason - at least on=
 spi2 on a10s */
> +		/* The can_dma check is txlen >=3D SUN4I_FIFO_DEPTH so with DMA this s=
hould never happen anyway. */
> +		sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH - 1);

Please wrap the lines at 80 chars and use the proper multiline comment
style.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--vuDFP+lnL2KW5uet
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW3HMgAAoJEBx+YmzsjxAgpe8P/2I67Aly3U5//0WZ9hhpm7tQ
dOJjz0Ci7tDSf34i/NHHK99c8oFqgWboGBFo15koy0n1UpOo47r8j4QeEKucM5TO
T30GC8EWrl/jP16fnPURLZ7XeiKdK5K5nGGDbxpsWvyhwsuIIpv8aM7sIXbYZvQE
c1aurWwfe2Ggl5YmCNv5XtoHVHg54JwbHTj2f5kdhY0l9yi2maBX+pZLjCt5uZjI
PNwamanRmw69q1M+akqCEimw9OmuOk9T7uOSQV50SzrnxygI22zzJ+v5h48BI/ZY
Ns/AyG/t61x1YKQR6dGVi/FPDZ3gXOangBc4By6zk2/CytGUNtnzm8+gzi9RBgTi
RzhGbqD/78XZpsjcrUXFRIfpj8nvp6cYtzBZmw72tXjBzR5t2xNvD5zliAH9ME8b
ZNVKKLQoVZu7J0pUmEH2Is2/7EILKG1x/vCOh+Jsm9ySMob8ekeQ9HLAx193pQ38
y9Z5LvydCaN20AtqlU6+IuDSxvMNXVYWBfKlOro+V+oJpefGoTkE21zjVPC50c9R
A/4Bu7iUmD0HEkgsBzexPWYjYYiWkqTwJamwWltH/tbg9l1PyKM53tU5m+YVzi3y
sITdsjfQbJ90US5Fceb1VEvTHRIX4+7AI6Z7CtkxRUpE7WBfTzwTNTiP3BtAfyZY
4v0jwoxrLBfoUIPkQu4u
=enxj
-----END PGP SIGNATURE-----

--vuDFP+lnL2KW5uet--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
