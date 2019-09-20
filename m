From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: atmel: Fix crash when using more than 4 gpio CS
Date: Fri, 20 Sep 2019 11:51:01 +0100
Message-ID: <20190920105101.GA3822@sirena.co.uk>
References: <20190919153847.7179-1-gregory.clement@bootlin.com>
 <20190919160315.GQ3642@sirena.co.uk>
 <20190919172350.GZ21254@piout.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190919172350.GZ21254@piout.net>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2019 at 07:23:50PM +0200, Alexandre Belloni wrote:
> On 19/09/2019 17:03:15+0100, Mark Brown wrote:

> > This is going to break any system where we use both a GPIO chip select
> > and chip select 0.  Ideally we'd try to figure out an unused chip select
> > to use here...

> The point is that this use case is already broken and this patch fixes
> the crash and is easily backportable.

> Fixing the CS + gpio CS should probably be done in a separate patch.

If the GPIO is overlaid on any of the existing slots (except GPIO 0)
then it'll cause GPIO 0 to start toggling.  I'm not convinced that the
code doesn't currently support that.

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2ErxQACgkQJNaLcl1U
h9C4OAf9FfyzqjxlHkt3ntI6EvTAyZw0LS08pAM3Y9UgSh+9oAHuivVW0ZQ55DFO
IXeXuTGoNbS0doU2lJfCc4/mRGV0SLFkdf9Oa8OHBVnHjtYo7iHhWLuGfwVr6YOr
CqDSofMpphdzsQxhZ8xTycUYjC5ZrJ2Zd31CddLcCZNWRM1HsLN89XXVQ2HclVhi
dVhOkAiGJ3Cy4AeXky7/UNCJbKJfeQQvhSy8Dn+LOqbPrglKDh4xwbfTVUMChBH4
IjFd5De9X/Y5GP1Mqbr7dDz/3fVFbH8bb4jAuaWBJiO2tNkeE4WRKoTSG3BBp9EM
HhAPo7EorLaMmfC1Id2HdhxFrNrNIQ==
=40sX
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
