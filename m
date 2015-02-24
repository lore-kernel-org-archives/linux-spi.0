From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sirf: add reset controller dependency
Date: Tue, 24 Feb 2015 16:50:18 +0900
Message-ID: <20150224075018.GM6236@finisterre.sirena.org.uk>
References: <4553005.HBquOfbqXe@wuerfel>
 <7767301.zaEX63gvjp@wuerfel>
 <20150221094458.GM6236@finisterre.sirena.org.uk>
 <6170208.Z0Upu48JrX@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7trrzIZ+323l9a6P"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6170208.Z0Upu48JrX@wuerfel>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7trrzIZ+323l9a6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 23, 2015 at 11:01:18PM +0100, Arnd Bergmann wrote:
> On Saturday 21 February 2015 18:44:58 Mark Brown wrote:

> > In that case a dependency seems wrong, I'd expect to see a select - it's
> > a bit obscure to have to grovel around to figure out what magic options
> > are needed to make things turn on and resets feel more like a utility
> > thing than a control bus (which tend to be the things we depend on).
> > Dunno, perhaps I'm wrong?

> Mixing 'select' and 'depends on' causes recursive dependencies, and
> there are already lots of drivers that do 'depends on RESET_CONTROLLER'.

Well, perhaps that's the cleanup we should be doing then...  one of the
big problems with some of the other randconfig work there's been is that
a lot of the patches just add dependencies without looking at if that
makes sense.

> Most users of this symbol seem to follow the strategy of selecting
> RESET_CONTROLLER when a driver is there to provide the functionality,
> but depending on it when a driver uses it. We are however a bit
> inconsistent here and it would be nice to clean it up.

Right, to me that feels the opposite way round to how we normally do
things - the drivers for the subsystem normally depend on the subsystem
(or are hidden by it).

> In this particular patch, I'm just following what others do.

> We should probably 'select ARCH_HAS_RESET_CONTROLLER' unconditionally
> for ARM ARCH_MULTIPLATFORM, as it's a bit silly to select both
> ARCH_HAS_RESET_CONTROLLER and RESET_CONTROLLER from platform code.

That does seem a bit odd.  TBH I'm never sure that ARCH_HAS_ is that
good an idea for the driver things, most of them can just as reasonably
be used by off-SoC things.

--7trrzIZ+323l9a6P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7C05AAoJECTWi3JdVIfQGvkH/1PYb8WmnKNFtPdSMLAINd1o
O2PQxLB5bGssuuOB9jbK75Zbtkowbx63cYITLPThrOyKYsik9OY0LxQDt+RoXYu+
NC6FbZTkPVREdzlY6J3Q9DBBLpWfRUpo7ybppMnUeVeuUukkwWKTuGNxlHphWdkp
BBU4a79bZHZqVoKlB38isYrG1GEGGg8tNlZIs0jw39ufpHDKmttgCaN9BjwVoY4Y
Uf2fUU9wwV/NGo5bRadOF6EK/4TJpBaCZly85uvIRibw1Wu1XBjaV8pRH6eTCY2D
CZy1FDCvjLuqMsxF/OAd+/4IXXaumzn+CunwK3vFQR4oBvBTd7p0mSNg7ZIus88=
=jvr6
-----END PGP SIGNATURE-----

--7trrzIZ+323l9a6P--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
