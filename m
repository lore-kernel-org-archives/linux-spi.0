From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: atmel: Fix crash when using more than 4 gpio CS
Date: Thu, 19 Sep 2019 17:03:15 +0100
Message-ID: <20190919160315.GQ3642@sirena.co.uk>
References: <20190919153847.7179-1-gregory.clement@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Vxa5joy26gVGOrvU"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190919153847.7179-1-gregory.clement@bootlin.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Vxa5joy26gVGOrvU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2019 at 05:38:47PM +0200, Gregory CLEMENT wrote:

> With this patch, when using a gpio CS, the hardware CS0 is always
> used. Thanks to this, there is no more limitation for the number of
> gpio CS we can use.

This is going to break any system where we use both a GPIO chip select
and chip select 0.  Ideally we'd try to figure out an unused chip select
to use here...

--Vxa5joy26gVGOrvU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2DpsIACgkQJNaLcl1U
h9DKfgf+Jsooil74xOpQ+umzYyZp8Qb3FEcyImIlX60lGCNBSHiEvAhRajJ6+AXX
CsWEWs+bSzrHgo4y5RRwOrtp7RXbEJARgR2ke9JZ0l9P9qdU3oW/m8A8Ghq4Q8z/
3w+GW4UoWkqUuDjK/LZeOvBtmq1+viYePqq+wOLg12uVCc+aifI1qZlTJHFaGJUf
EJDxnopv92Ct66G3ZcQ8lMmujukMAuk6Z7+H6SJqvhIDOQLd8Ryt955+6v198wcq
M8zO5suWI6sTMK0HpsN6L3K/WOe7vOUOPYyyLtKBSAA4+Piy9EaQcVsWv1mVLJfp
SO2Y3XYEQykklvv+yX+7XlZxS6QYAg==
=WMib
-----END PGP SIGNATURE-----

--Vxa5joy26gVGOrvU--
