From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] spi: Reduce kthread priority
Date: Thu, 1 Aug 2019 12:26:55 +0100
Message-ID: <20190801112655.GA5488@sirena.org.uk>
References: <20190801111348.530242235@infradead.org>
 <20190801111541.917256884@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>, linux-spi@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190801111541.917256884@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 01, 2019 at 01:13:53PM +0200, Peter Zijlstra wrote:

> The SPI thingies request FIFO-99 by default, reduce this to FIFO-50.

I don't have a cover letter or any other context, what's going on here
with dependencies?

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1CzHwACgkQJNaLcl1U
h9Bi1gf/R2RBFRK38yt4CRZFig5dJ3Fm/3wsfKj5hFNGFGrz8KB7AC0KdnjuX6wf
IveemuHcUiCpATP7HwY3w47Z6DFlFJSYaXFce8ku9+i/jmJ85e82GbikQHndMSqd
l3Kv2hC6y9wmWRgr2GJ4isTtRIH9vPei9nHWaGGUmkLwZQnphY7pbPLx+GPFBFHt
gIRwDK2kw4ivbCJrS6uwaXSlXPIKu5SxVF6o0kkyGUb2QxdlzqnuwxUQpoX+r183
iebAuHWZJEheKQtd/+yhAbSH8rGThdQ3sie3Q1e8KPf9Coc8RteL58NV47RFyYQj
B7gEl66Otu+l9uYADgMTz+VsY6d+uQ==
=tJYV
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
