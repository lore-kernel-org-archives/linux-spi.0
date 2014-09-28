From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ARM: mvebu: use improved armada spi device tree
 compatible name
Date: Sun, 28 Sep 2014 12:43:53 +0100
Message-ID: <20140928114353.GY27755@sirena.org.uk>
References: <1410147029-30067-1-git-send-email-gerg@uclinux.org>
 <20140909160043.GP30828@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZlyDGGI/Hohreivc"
Cc: gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140909160043.GP30828-u4khhh1J0LxI1Ri9qeTfzeTW4wlIGRCZ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ZlyDGGI/Hohreivc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2014 at 12:00:43PM -0400, Jason Cooper wrote:
> On Mon, Sep 08, 2014 at 01:30:29PM +1000, gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org wrote:

> > Switch the Armada SoC SPI port device tree binding to use the new improved
> > armada-370-spi compatible name. This allows for a wider range of baud rates
> > to be used.

> Applied to mvebu/dt.

Note that the corresponding driver change hasn't been applied (or sent
to me for review) so this will break users.

--ZlyDGGI/Hohreivc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUJ/R4AAoJECTWi3JdVIfQpIgH/242hhKQZxTsc75aCVo/OSVA
fZJ4gMShGZESkQMDQz8ZB5gjze6hgGMRGVVieDfb34r0NykmC4mWqqJjc4JNm4eC
qBJl7+fkwXZUUdoiIgSOeIDs8wRURq/kxKeYSh91JTZydapWIsVeUNCPcPR4qel7
cvuSwz0PC+M6f2VNXG/ca1k9t0BYnTfDehZ3SlMrhsCcElnd8roKCwlj41QysGdd
fRPznuNj9e2VPy7+VpSstndSR6CPlSCCmZIo29Uo+6LJt8num+b3zLsrhdokQaq6
YpeJBWV1ebUGsH07DB/vmsMFJY2lLFP3Nu3a3TrT1p323z0pA9iEruprEXbtl/A=
=TlnF
-----END PGP SIGNATURE-----

--ZlyDGGI/Hohreivc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
