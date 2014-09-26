From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] SPI: spi-pxa2xx: SPI support for Intel Quark X1000
Date: Fri, 26 Sep 2014 11:08:32 +0100
Message-ID: <20140926100832.GE27755@sirena.org.uk>
References: <1411752349-31490-1-git-send-email-alvin.chen@intel.com>
 <1411752349-31490-2-git-send-email-alvin.chen@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ugMgaRwDDWDxqvmW"
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mika Westerberg <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Hock Leong Kweh <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Boon Leong Ong <boon.leong.ong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Raymond Tan <raymond.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Weike Chen <alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411752349-31490-2-git-send-email-alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ugMgaRwDDWDxqvmW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2014 at 10:25:49AM -0700, Weike Chen wrote:

> +static u32 pxa2xx_spi_get_ssrc1_change_mask(const struct driver_data *dr=
v_data)
> +{
> +	if (!is_quark_x1000_ssp(drv_data))
> +		return SSCR1_CHANGE_MASK;
> +
> +	return QUARK_X1000_SSCR1_CHANGE_MASK;
> +}

These functions would be much better written as switch statements -
think how they're going to look when we've got another controller which
needs custom values.  It might also be helpful for review to have two
patches, one splitting things out into the functions and another adding
the Quark support.

> +/*  see Quark SPI data sheet for implementation rationale */
> +static u32 quark_x1000_set_clk_regvals(u32 rate, u32 *dds, u32 *clk_div)
> +{

Please document this in the driver - I don't know if this datasheet is
public but even if it is it may not stay that way.

> @@ -613,6 +759,8 @@ static void pump_transfers(unsigned long data)
>  	u32 cr1;
>  	u32 dma_thresh =3D drv_data->cur_chip->dma_threshold;
>  	u32 dma_burst =3D drv_data->cur_chip->dma_burst_size;
> +	u32 change_mask =3D pxa2xx_spi_get_ssrc1_change_mask(drv_data);
> +
> =20

Extra blank line being added here.

> @@ -145,6 +147,9 @@ static inline int pxa25x_ssp_comp(struct driver_data =
*drv_data)
>  		return 1;
>  	if (drv_data->ssp_type =3D=3D CE4100_SSP)
>  		return 1;
> +	if (drv_data->ssp_type =3D=3D QUARK_X1000_SSP)
> +		return 1;
> +
>  	return 0;
>  }

Things like this should also be refactored into switch statements - in
general anything that's deciding what to do based on ssp_type probably
ought to be using switch statements.

--ugMgaRwDDWDxqvmW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUJTsfAAoJECTWi3JdVIfQE+gH/16f2SYwr2HYqCpe7Vin3oVI
eh/D/ty70TT5l0/U2C4cSeb5IB2hDd1o79+L2qEDm5Cxmf9jtUYoTtagsVmd1gz3
cOoq0ifuwMzEDmI+UEnp+97jt5x+AfPGKO7+qKoTDWXIAU7ppPRguv4YC/TH9sla
0YPKOU/0AByy9DEiIsTld91eFvKcUggbGdEJVYiRtodLrnrf36/txXJ/VAERO6+K
F5cMRjEmy+7NXYLNKn30KbTG0BaOdPYJjIUyxuM6uFAGAYAajB9XqzvUIp7/b3u7
MhHfQU0AzJ4a8C6rqa172Y81QS24d2mKP6zjuotLYvYtWq3P3tGFD9qOFoW81CE=
=EhTZ
-----END PGP SIGNATURE-----

--ugMgaRwDDWDxqvmW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
