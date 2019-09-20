From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] spi: mxic: Fix transmit path
Date: Fri, 20 Sep 2019 12:02:06 +0100
Message-ID: <20190920110206.GC3822@sirena.co.uk>
References: <20190919202504.9619-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mason Yang <masonccyang@mxic.com.tw>,
        Julien Su <juliensu@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        stable@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190919202504.9619-1-miquel.raynal@bootlin.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2019 at 10:25:01PM +0200, Miquel Raynal wrote:
> In certain circumstances, it is needed to check INT_TX_EMPTY and
> INT_RX_NOT_EMPTY in the transmit path, not only in the receive
> path. In both cases, the delay penalty is negligible.

In which circumstances and why is this required?

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2Esa0ACgkQJNaLcl1U
h9AgbAf/WGzhQIKCPqtpT234KXwcBHp9ZJZEvag3OQYnGwCZ2HTkbFi2GxY82UT4
FnSIj9o6IaTk1y4lFcXSoVfYJFm6ik+CksaPPCOKp/yX6Wdh+zcszod8nYGb9MDH
8JodKY8SteqX+PB9bxuZzip9vNkX6VaS+4ZA7Z/y+645Jmjo8FS1Yk83J/H87FJg
FroH17yf9TsGUgggStqTfz10e7sT17uPFpF6e3s/rGU3GVYqaYgtQS65vM2ARXbR
1OLvYa+4ogLGFE/JfxVFbyHDUQa7dQKZ/3fxlEXN4huhVJ9vRR0kPztathlfdX46
3TqFUQ7tJLD/tzeEt7hfU6OMdItB0A==
=717f
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
