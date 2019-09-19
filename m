From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/4] spi: dw: Add basic runtime PM support
Date: Thu, 19 Sep 2019 16:23:33 +0100
Message-ID: <20190919152326.GP3642@sirena.co.uk>
References: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
 <20190919133113.GK3642@sirena.co.uk>
 <TYAPR01MB292515FE4C74044CA53321C5DF890@TYAPR01MB2925.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dzI2QqkSBOAresgT"
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Gareth Williams <gareth.williams.jx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <TYAPR01MB292515FE4C74044CA53321C5DF890@TYAPR01MB2925.jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--dzI2QqkSBOAresgT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2019 at 03:14:54PM +0000, Gareth Williams wrote:
> On Wed, Sep 19, 2019 at 14:31:32AM +0100, Mark Brown wrote:

> > Please use subject lines matching the style for the subsystem.  This makes it
> > easier for people to identify relevant patches.  This isn't even consistent
> > within the series :(

> Sorry about that, I will correct the subject lines for V3.

Don't worry about it unless you need to send a v3 for some other reason.

> Is there a set convention for the subsystem I should follow in future?
> Or should I follow the style of the individual files I work on?

Following the style for the file/directory is generally a good guide,
for SPI I tend to prefer spi: but I just moan about it rather than block
anything for it (unless I do end up missing the patch in my inbox).

--dzI2QqkSBOAresgT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2DnW0ACgkQJNaLcl1U
h9CozAf+KonuKSEWtCRvLPNHth5I6Dmv/rgmgnQLAcqXOvyYP4XKeVynEQWjP1VT
fRBeU1NL7gDivqKMWGOTDW7t+h8jULzY2zdyLJcARZ/dTByWuGk7u31qcYPUpVlW
wSiWGaAJm8d9vDeoj5dWwz9Ijg0VP7EmwQStss7hUjOTzFSOXV52mZuxOI2TQfXQ
6fm1dqVJ0f85TWNHTBBeV70W445kutx7yrF/Ed614cuCff5+SoKevGlC88PdTPV2
we5TlLr1J2/i4gISCWpWpbf6ddcjZrOaQZhoHQQfF4/3KvcWqmrgrr+wa+cTZWyI
YeEM6rjUhOpH1U3ABtzoZv8mBEQ5Gg==
=xyoB
-----END PGP SIGNATURE-----

--dzI2QqkSBOAresgT--
