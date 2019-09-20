From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: atmel: Fix crash when using more than 4 gpio CS
Date: Fri, 20 Sep 2019 16:54:01 +0100
Message-ID: <20190920155400.GH3822@sirena.co.uk>
References: <20190919153847.7179-1-gregory.clement@bootlin.com>
 <20190919160315.GQ3642@sirena.co.uk>
 <20190919172350.GZ21254@piout.net>
 <20190920105101.GA3822@sirena.co.uk>
 <87a7az7zt6.fsf@FE-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nFBW6CQlri5Qm8JQ"
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87a7az7zt6.fsf@FE-laptop>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--nFBW6CQlri5Qm8JQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 20, 2019 at 05:27:49PM +0200, Gregory CLEMENT wrote:

> But after going further in the details of the driver, this patch could
> cause a regression for on the old controllers.

> I also found other issues in this driver in the chip select
> management. So I will send a new series fixing all of it.

OK, great - glad at least one of us spotted a real problem!

--nFBW6CQlri5Qm8JQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2E9hgACgkQJNaLcl1U
h9DuOQf/d1YSSM95RC3kUN0e8uki1dRX6P/DzkwsU8aq/UjqRJWFqJfINJoq/iX2
Bxv2so1RItyHhc7DeDbguqZd3q7ZoGEIdpydEs0YiCe0ZsIC2WO5oQYbzR+StoUP
Go9tnNJxG00tYTUoOLSkuFt0oF28j6+IiBOqU028GK0CcCpEY5gK6bdLrO3Yg/bp
x7dnew+UZGVIqBygo6Gf4o781L0aV9exnr8toNx2meSItYSd53qBOywiLt+olUPB
i1y7ZIBMFvM/CADLLfgT8u+3bu8q6tVFs7olDfPXfiSqWC9tOzur/x3aDfY4CdQz
8iOeWl80Sr4wXQgZWxBJGWp6Gz1JHA==
=vx4t
-----END PGP SIGNATURE-----

--nFBW6CQlri5Qm8JQ--
