From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] dt-bindings: mtd: atmel-quadspi: add an optional
 property 'dmacap,memcpy'
Date: Wed, 3 Jan 2018 11:51:16 +0000
Message-ID: <20180103115116.GG5603@sirena.org.uk>
References: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
 <143542c61ca674d53da4985bbabc142e8e6ebefc.1514087323.git.cyrille.pitchen@wedev4u.fr>
 <20171226232330.trljk2ofyvu4ly3n@rob-hp-laptop>
 <0149ba05-64b1-2739-e61f-78d5170775fb@wedev4u.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xs+9IvWevLaxKUtW"
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, richard-/L3Ra7n9ekc@public.gmane.org,
        boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org,
        linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0149ba05-64b1-2739-e61f-78d5170775fb-yU5RGvR974pGWvitb5QawA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--xs+9IvWevLaxKUtW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2017 at 10:40:00PM +0100, Cyrille Pitchen wrote:
> Le 27/12/2017 =E0 00:23, Rob Herring a =E9crit :
> > On Sun, Dec 24, 2017 at 05:36:05AM +0100, Cyrille Pitchen wrote:

> >> +Optional properties:
> >> +- dmacap,memcpy:  Reserve a DMA channel to perform DMA memcpy() betwe=
en the
> >> +                  system memory and the QSPI mapped memory.

> > How is this a h/w property? Why would I not want to always enable DMA i=
f=20
> > possible?

> The number of DMA channels is limited for a given SoC. This number may be
> lower than the number of enabled controllers (spi, i2c, qspi, aes, sha,
> des, sdmmc, usart, ...).

> So we use a DT property to explicitly tell the matching drivers to request
> and reserved the DMA channels they need. This policy is not driver or even
> SoC specific but board specific. It's very common to reserved DMA channels
> for the most used or most performance dependent controllers, setting the
> relevant properties in the device-tree then restricting remaining
> controllers to their PIO mode.

Why can't we just time share the DMA channels at runtime, why do we need
this static allocation? =20

--xs+9IvWevLaxKUtW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpMw7MACgkQJNaLcl1U
h9AWGQf9F0RsEiNtRpRHLeDZldvGY8OSYaP3t3RRrpTrlrKfx3BxDGqCeuTj5gfB
7wCpMzuTn8ckXz3nSuP3i2rdWUDSIZxX7zMHUElNLDEQBtUofXi4Ub35NznNShTN
0EAuW9xc86ek/iPZUnGHjQe6BcCzZajeLMpPOdxg6YPqGKHYNwtPH7RvZ9sTYI+Y
w8vj6lx5Y9o1UB0Lw/TIevyjWIOdndfy3IN0g2a2H8isDuATg0edR+CUtDKG0LBM
3EHxrxilgFks/Y3TmnirTcDMcFT+IzelUmIxtYG01DLALQQoHpMrHEfOI22/x7Hr
15vQ8RoA0kndI977/52eKt4b1QvQeg==
=1Kgv
-----END PGP SIGNATURE-----

--xs+9IvWevLaxKUtW--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
