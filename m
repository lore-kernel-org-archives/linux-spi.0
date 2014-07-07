From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: add driver for Rockchip RK3xxx SoCs integrated SPI
Date: Mon, 07 Jul 2014 09:26:52 +0200
Message-ID: <2620380.GejlhFPJDO@diego>
References: <1403582852-9751-1-git-send-email-addy.ke@rock-chips.com> <5578791.jcBVzrGadW@diego> <20140707072140.GB30458@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wei.luo-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140707072140.GB30458-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am Montag, 7. Juli 2014, 08:21:40 schrieb Mark Brown:
> On Mon, Jul 07, 2014 at 09:08:41AM +0200, Heiko St=FCbner wrote:
> > Am Montag, 7. Juli 2014, 09:42:52 schrieb addy ke:
> > > > Your DT binding defined some additional compatible strings, ple=
ase add
> > > > those to the driver.
> >=20
> > citing Mark Rutland (one of the dt maintainers):
> >=20
> > --
> >=20
> >   That's why I said in addition to the common one. I'd only expect =
the
> >  =20
> >   driver to look for "rockchip,rk3066-spi", but a DTB could have:
> >         compatible =3D "rockchip,rk3188-spi", "rockchip,rk3066-spi"=
;
> >  =20
> >   Seeding the DTBs with the extra strings early makes it more likel=
y that
> >   we can rely on them later. If we don't happen to need them they o=
nly
> >   clutter some DTBs.
> >=20
> > --
> >=20
> > so it looks like the driver is doing the right thing right now
>=20
> The driver will work but it's better to list the strings that are
> supported explicitly if only to document that there's nothing specifi=
c
> Linux should be doing for them.

ok, makes sense :-)
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
