From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: add driver for Rockchip RK3xxx SoCs
 integrated SPI
Date: Mon, 7 Jul 2014 08:16:45 +0100
Message-ID: <20140707071645.GA30458@sirena.org.uk>
References: <1403582852-9751-1-git-send-email-addy.ke@rock-chips.com>
 <1404176639-3315-1-git-send-email-addy.ke@rock-chips.com>
 <20140704183249.GC14896@sirena.org.uk>
 <53B9FB1C.7080008@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wei.luo-TNX95d0MmH7DzftRWevZcw@public.gmane.org
To: addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53B9FB1C.7080008-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2014 at 09:42:52AM +0800, addy ke wrote:

> > The driver shouldn't be doing this, if it needs a delay it needs to
> > implement it itself.  delay_usecs can be set by devices if they need a
> > delay between transfers, it should be in addition to the time taken for
> > the transfer to complete.

> > Please send a followup patch fixing this.

> Are the following modifications reasonable?

Yes, that looks sensible.

> >> +static const struct of_device_id rockchip_spi_dt_match[] =3D {
> >> +	{ .compatible =3D "rockchip,rk3066-spi", },
> >> +	{ },
> >> +};
> >> +MODULE_DEVICE_TABLE(of, rockchip_spi_dt_match);

> > Your DT binding defined some additional compatible strings, please add
> > those to the driver.

> So which is better to describe DT binding for rockchip spi driver as foll=
ow:

> 2. Add "rockchip,rk3066-spi", "rockchip,rk3066-spi", "rockchip,rk3066-spi=
" for each soc:
>=20
> In Documentation/devicetree/bindings/spi/spi-rockchip.txt
> - compatible: should be one of the following.
>     "rockchip,rk3066-spi" for rk3066.
>     "rockchip,rk3188-spi", "rockchip,rk3066-spi" for rk3188.
>     "rockchip,rk3288-spi", "rockchip,rk3066-spi" for rk3288.
>=20
> In drivers/spi/spi-rockchip.c
> static const struct of_device_id rockchip_spi_dt_match[] =3D {
>         { .compatible =3D "rockchip,rk3066-spi", },
>         { .compatible =3D "rockchip,rk3188-spi", },
>         { .compatible =3D "rockchip,rk3288-spi", },
>         { },
> };

This is better - that way if we need to care about the differences then
we already have device trees which have the specific compatible strings
in them.

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTuklTAAoJELSic+t+oim9HBAP/RUSB2tsDNnAKczV9RFh+F1G
+Gkhf1v3QU7DfnSEf87YYXZs2DbIDLCAosbT9HscX3F5PHA3wZChVUTSlJnrPoVi
uioKu3s7+/VLKO8lDShuT+4+rjGDIrz6NaNocuvL1hEdfp/xYE3VvPwBth0InECN
7HA0YxRfWPFA7xW7Kjrw+HXsdyxZ2VQ5ghwLSKiAQetbz/CoQonFQ1aTgJpTGd/x
b6++ks2fBmtd+0z8EE3xS4G0kD+LdA1lEZ1tBIMSXW6K3xeeLqhFIDgGOOPJfdyK
oxwqnZyFqJC+gLJfFGHlffVWcm6eLz4b81iXtY2V5fV7jfevQCVnm2kTU48CI/Bz
4GMvWeKyOgN/2D8KZETefB9yiyb1QhfraoI+rIY/cE1U160Ok+HZ6/u1kwBf3HfS
YvSR7KyMnVE8IYr8VxlWdEEg63RtC7dVwpV9Gyk86C2TZ9Yh/9N0+tuCKqgzsQp4
OsCgB/hWN0laDEOndQ9AV9uQ+D8F7wVhEmeiNGpoYFVoAUEBOaP2x4BLoZNDGUKS
/X7IgZvyKxza0452lP6JsN6zlGpI5xwP9aOB+f8dT+KjxowTO1E9zU9YaQ2nCmzT
DvbmNoGL321xMQuhcBGOEVRUA4Qj/CmYug7b8jvVvrUfdVY2K/+QgGfqbAgk0oBj
NfgylZBtOLddACMrMeOv
=ZyE0
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
