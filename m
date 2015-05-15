From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: mediatek: Add spi bus for Mediatek MT8173
Date: Fri, 15 May 2015 10:25:43 +0100
Message-ID: <20150515092543.GY2761@sirena.org.uk>
References: <1431075343-7887-1-git-send-email-leilk.liu@mediatek.com>
 <1431075343-7887-3-git-send-email-leilk.liu@mediatek.com>
 <20150508175306.GG2761@sirena.org.uk>
 <1431434356.2128.9.camel@mhfsdcap03>
 <20150512160540.GB3066@sirena.org.uk>
 <1431675522.2128.13.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3rA5Es2VluvhcIdy"
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>,
	Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>,
	Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	Hongzhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org,
	Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: leilk liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431675522.2128.13.camel@mhfsdcap03>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--3rA5Es2VluvhcIdy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2015 at 03:38:42PM +0800, leilk liu wrote:
> On Tue, 2015-05-12 at 17:05 +0100, Mark Brown wrote:

> > Implement can_dma() - look for drivers providing that for examples.

> MTK spi hardware uses the dmaengine in spi controller. According to
> datasheet, spi driver just need to enable dma register bit and write a
> physical address to relevant dma address register, so I think it may be
> complex while the driver supports can_dma.

That's how a very large proportion of devices that work with DMA are
done - why would this be complicated?  All can_dma() does is report if
DMA is possible.

--3rA5Es2VluvhcIdy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVVbuXAAoJECTWi3JdVIfQOM0H/1QA4VRmTcQKW4xIuJZwMWcE
B1JVTfAeAvI8BVWMp6m3eEpTzQbGpbaZYqFKg+63AD7d1zUF76EGREVixnkojiS+
6agjzTR0CX8wHReIbNP62GYdGL7gKGSgVNv847OcnbeALj20+QSfWvHS/QsbjHZN
+8/hIYtqYFQTviQhCKeOgqDTMtJ730id+HTabUfhjvL8IiB20N4H0QUMJZIl1aA0
4ENqbLW7ROAiaCrdr+2UgD3AVUdYJUQLyt/tz7AHc/19YHw01T9MTjeTqSID7kI1
//aaRtTQ8ftBncJl9JP6i8A5GiNaPbKTMatugVMbAPwWAa1HSeq3Fuq9s59MtWk=
=xdg4
-----END PGP SIGNATURE-----

--3rA5Es2VluvhcIdy--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
