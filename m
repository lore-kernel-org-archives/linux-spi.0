From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: mediatek: revise mtk_spi_probe() failure flow
Date: Tue, 24 Nov 2015 13:04:26 +0000
Message-ID: <20151124130426.GL1929@sirena.org.uk>
References: <1447986080-31410-1-git-send-email-leilk.liu@mediatek.com>
 <1447986080-31410-4-git-send-email-leilk.liu@mediatek.com>
 <20151121133949.GH26072@sirena.org.uk>
 <1448332404.27169.4.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7vAdt9JsdkkzRPKN"
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: lei liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1448332404.27169.4.camel@mhfsdcap03>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--7vAdt9JsdkkzRPKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 24, 2015 at 10:33:24AM +0800, lei liu wrote:
> On Sat, 2015-11-21 at 13:39 +0000, Mark Brown wrote:
> > On Fri, Nov 20, 2015 at 10:21:19AM +0800, Leilk Liu wrote:

> > > This patch revises failure flow while pm_runtime_enable().

> > Why?  This also doesn't apply against current code, please check and
> > resend.

> I don't know. I can git am this patch to spi/for-next. I will resend it,
> please help to apply it again, thanks.

If you don't know why we should make this change then we may as well
just not make it?

--7vAdt9JsdkkzRPKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWVGBaAAoJECTWi3JdVIfQZvwH/3DJ6eln8FeT4HhERJ+140uy
d6a2V6ewkSaYfSQ/ryXUO4gY9Ngz0OqhgxiGE1J6ytGqb86oiMexiFsIvvHU8P16
dEP5UeZZrjKf4mJq3JbuQsyca33Hi3ntTeiwprHLKpvK6zqXZb56mOkCzg8dNo90
xBFsvqw9XDIIqF4JoCrRG1BmRBi+a7iamUtTrxuqZvWo04JDm9odAAyClPMCnv6d
UzvF0l5yvRUFn2aNFkAO22MAbzLQSigJHCwvxs8h5GKm1YMeKJcwCjdvtJ0xWMG8
3niZqvhb9VdHb1Wc1nJGOr0wShZMspKogSOEioKrv61TlgQ2of64kIyqVzRvJ+8=
=OdyF
-----END PGP SIGNATURE-----

--7vAdt9JsdkkzRPKN--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
