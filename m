From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Wed, 13 Nov 2013 15:11:02 +0000
Message-ID: <20131113151102.GS878@sirena.org.uk>
References: <20131107203127.GB2493@sirena.org.uk>
 <86AE15B6-05AF-4EFF-8B8F-10806A7C148B@sperl.org>
 <20131108161957.GP2493@sirena.org.uk>
 <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org>
 <20131108180934.GQ2493@sirena.org.uk>
 <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org>
 <20131109183056.GU2493@sirena.org.uk>
 <6C7903B3-8563-490E-AD7D-BA5D65FFB9BC@sperl.org>
 <20131112011954.GH2674@sirena.org.uk>
 <52823E73.503@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p2u4WfPhYOuYlOsk"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52823E73.503-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--p2u4WfPhYOuYlOsk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 12, 2013 at 03:42:59PM +0100, Martin Sperl wrote:

Not fully read this yet but one thing...

> >The messages and transfers ought to be totally reusable already, the
> >only bit that should need to be recreated is any data the driver creates
> >internally, most likely that's only going to be data for DMA.  We do
> >already have an interface for drivers to do the DMA mapping though it's
> >not very well loved at the minute...

> What DMA-interface are you talking about? at least in spi.h in 3.10
> I find nothing that would indicate an extra DMA interface...

Drivers can supply pre-mapped DMA buffers if they set is_dma_mapped
which is about as good as you get with dmaengine at the minute.  The
main opportunities for enhancement here are in the master interface
rather than the client, at least as things stand.

--p2u4WfPhYOuYlOsk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSg5aCAAoJELSic+t+oim9oO0P/jSkEI+OpxVY9jyZlsggiLVh
9HS2xPJvhSrmjLNN10SgDwDKrPGcr0mxtvw4gvImT9p7wHxFEUUv88uCxni/0X/C
XTFqaz+qdnd3QkRtu6FARaVisAf7K5SoVGRHdmr71c0IjeW3Qf3kLC4j0y/cHMSm
Yj2yawk0SVOoKlvX/uf6HfKnLdoUD8FI/PMm6d+nD0mmkM+URzvHNgNjJHDUuOxG
xSIQKM6r3lpbFbqbqlPrIKXJxtGap2ItvfqThc9TTlyGKAnjiG80wVTpveGOsGSk
wN6vIEaq+Gm5lFglpgMQMhn0cZNURyPYLEuZUdGbvHG2W9FEdpbDn5CYJExt/71x
jaorHeXrf9ocdy+jPWt6acqH5/7EkWXiYRE7amWhY+SKMHQ/hpHmBDNtEm4NBqWT
n3D6NI1aPQjjdR5sG5QwHjDDNnSVQMHn/5PpShzk70/+2PpvYYzcomI5zdYLR6dg
mzzLOdx3nYyyxX+i8uCusrkEwKsw5S2mdsjdBDq9z7g09Jwa/08p3p48Zb8n6Nkb
zPTdPnPSdkvgZnZdkXZFEU50at4aLdARN4rFf/FNCUAZJi5ZNthRFraZ17YR0hUr
QSpkGfg7B1yad/0asyo0R9QUgn5e9tpxlkERhMZLJ85TPCpKfNVJklvFxeaatL84
ed/5RX/QDhR/Fdu3oDVj
=N5Cn
-----END PGP SIGNATURE-----

--p2u4WfPhYOuYlOsk--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
