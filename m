From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: Micrel eth switch: declare missing of table
Date: Thu, 25 Apr 2019 19:04:48 +0100
Message-ID: <20190425180448.GB23183@sirena.org.uk>
References: <1555960084-8462-1-git-send-email-dagmcr@gmail.com>
 <d4376323-36b7-d463-dc75-56970f750d35@gmail.com>
 <20190423122857.GB3371@lunn.ch>
 <0d2f503f-bd45-0009-343c-e6d47d7d6fe1@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Cc: Andrew Lunn <andrew@lunn.ch>, Daniel Gomez <dagmcr@gmail.com>,
        f.fainelli@gmail.com, davem@davemloft.net, netdev@vger.kernel.org,
        javier@dowhile0.org,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0d2f503f-bd45-0009-343c-e6d47d7d6fe1@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 23, 2019 at 07:33:10PM +0200, Heiner Kallweit wrote:

> Except having "switch" in the name this driver is solely a SPI driver
> and it uses no network code at all. And it has no dependency on any
> network driver. Therefore I wouldn't consider it a network driver.
> Else any functionality found on a SoC would need to be under drivers/soc ;)

Not seen the code here but what Heiner says makes sense to me - note
also that we did at some point add some network framework support for
ethernet switch chips so the device end of the SPI link should be
supportable via standard frameworks now.

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzB9r8ACgkQJNaLcl1U
h9CMuwf/U3loyuII1qSgy+LdXW3AVD1N1ykdQlBXjigcEwe9WYEFvBtmnNN2yIMC
VWd1hvBbJn0gVpR1qJqXtk7Xv9vJ6YtFuT2rbuplCWfP41WZF87lJZxS8hZwsJOT
qKbjNPkPWTBe8/QGIZ1fg34frRNXtIYxslwuvmtEPdEiMLtnd5AhiOyRHv+1mEWE
YXxZx9Dgo2GvYz2YyqudVXnUBhSocgo3N5cCfkAUxpAFsy7bZifo7II62w334ySC
BHHjxFJe3reFs0NBc3+jec86kbHtLrQaxfHkxDb0vtOapDxf6D0/J6wykyUDBboY
BIKnF3NMq7SaY2i51QCQHLkbKqs4Rg==
=aycs
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
