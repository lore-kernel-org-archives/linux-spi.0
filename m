From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] spi: orion.c: Add direct access mode
Date: Wed, 13 Apr 2016 18:20:20 +0100
Message-ID: <20160413172020.GB29471@sirena.org.uk>
References: <1460030811-13787-1-git-send-email-sr@denx.de>
 <20160411105740.GB3351@sirena.org.uk>
 <570CDF5F.9070106@denx.de>
 <20160412192736.GC14664@sirena.org.uk>
 <570DD967.8010703@denx.de>
 <20160413055946.GH14664@sirena.org.uk>
 <570E3010.10309@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <570E3010.10309-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 13, 2016 at 01:40:00PM +0200, Stefan Roese wrote:
> On 13.04.2016 07:59, Mark Brown wrote:

> >  It also seems like we need to document what
> > the meaning of the reg properties of the device is, it's all very well
> > saying that there's a generic MBus binding but we still need to say how
> > the device will interpret the MBus windows that it has (assuming they
> > are configured to specific hardware functions transparently).

> Should I add something to the bindings documentation of
> the orion-spi driver? With an example of how this direct mode
> can is enabled on a specific board for e.g. SPI0-DEV1? Or what do
> you think is missing in the mbus bindings documentation I
> mentioned above?

I think the biggest thing that's missing is a reference from the Orion
binding to the MBus binding that the reader can follow (probably added
to the reg property documentation).  I did look there and couldn't see
anything about how this would work.

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDn/TAAoJECTWi3JdVIfQSpkH/jeOChriu/OnZCb2oletqZ9+
5Aw49ngo1c+byDEiBD/iBEK7Ua+JDlZNXh993hH2WNoNabwGdW9HP70btEAAPraO
vXggs7Cds1CQpgF4Rx6WqjySE4XAgVz6iTiYuotDq2yp0IRQ3I/qF3P8JuzZwq6Z
VpgfyNQ1zQhhESUThWAhFXTTQhGGn4igwskO/1PtCYQZ2BkGIMX6QVD22xS2X4tr
/FeQ5szNfyLHrtbnctg0vLhfqgMaepyKNvronAG6d2LyrFLdT78YBzQoq3CbKHeY
El5wt+e8BaWXZsLhS369XX2dk6KSpnrcSB0xCqlFyy3QyVJdhyc531hSXDKQipc=
=pSFx
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
