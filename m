From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Tue, 7 Jul 2015 12:40:38 +0100
Message-ID: <20150707114038.GA2887@sirena.org.uk>
References: <20150625145853.GP14071@sirena.org.uk>
 <20150625154407.GE6321@opensource.wolfsonmicro.com>
 <558D3BAA.3080700@linux.intel.com>
 <20150626115823.GY14071@sirena.org.uk>
 <CAKor6Tf20eC1WQSO=AV2b+XoB5Qv-2Oin_nrrTJUiDV4czxLjA@mail.gmail.com>
 <20150629094854.GB11162@sirena.org.uk>
 <CAKor6TdDPb2qOgdHbeX2w+yQa_ioDM5ak9bk+=jF+cKt_twiXw@mail.gmail.com>
 <20150630103404.GI6321@opensource.wolfsonmicro.com>
 <CAKor6TdKk2OUz4o12RiQBSVZyhD=L4JpBJcYkGE=_6X+ZeQY_g@mail.gmail.com>
 <20150707095613.GG16517@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Cc: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150707095613.GG16517-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 07, 2015 at 10:56:13AM +0100, Charles Keepax wrote:
> On Tue, Jul 07, 2015 at 09:06:25AM +0200, Christian Hartmann wrote:

> > I am thinking actually to get a second device with Win installed, so
> > that I can get more infos which I really need here.
> > Anyway  I can also provide more infos here (if its not against valid laws :) )
> > But indeeed I can need some hints where to put the pdata structure.

> I think in this case we need to hard code the pdata into the
> driver. Probably in arizona-core.c would be the best place.

This is how other drivers with ACPI support like the Realtek ones do
this.

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVm7q1AAoJECTWi3JdVIfQECYH/A6ZWBpn50vuJHMGtKXg1dG7
j5tpWPrW3UbAxOMgCrxE7Fw5tm/yqTePTt1N4YWD7t0YLmj/7tqlIDicq6GYiW3F
MU2Aeoi/bsNu+79RKBCUCRvKVX/wQ7hyYdCR3ynSnEc42KM7P2UBGOOvW+Ob2V5H
ZefZGb+7DRhlvK+ZZjH2mMw1Crc70eD6IiFtn6keTv8LyLj3vtGyh43TYSyBMR1J
VJjqZ1FjWX0/1aCgepeDiXT3WAYopJ5BrIdvdB6yUIcrZODzEpXacesv68vSUaQ/
VduXHi3JyJsltYMtBeEzaqS+NacHrr9xVZ3BSDUe9IJcj5Yh+KdqDbuujqEDhas=
=UOmQ
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
