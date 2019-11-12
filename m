From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-controller: add wakeup-source
 and interrupts
Date: Tue, 12 Nov 2019 19:42:23 +0000
Message-ID: <20191112194223.GM5195@sirena.co.uk>
References: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
 <20191112055412.192675-2-dmitry.torokhov@gmail.com>
 <20191112120307.GB5195@sirena.co.uk>
 <20191112190328.GA199853@dtor-ws>
 <20191112191547.GK5195@sirena.co.uk>
 <20191112193653.GB13374@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pFpMklMRdxwSC3Yi"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191112193653.GB13374@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--pFpMklMRdxwSC3Yi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 12, 2019 at 11:36:53AM -0800, Dmitry Torokhov wrote:

> As far as scheme goes - I hope that Rob could confirm that we can
> override number of interrupts and names in consumers of the binding, as
> needed.

Yes, I think that's the main worry here - if there's issue with the
framework bit we should be able to sort that.

--pFpMklMRdxwSC3Yi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3LCx8ACgkQJNaLcl1U
h9CsMQf9EiGfHZdWSXq6DKiXomGkOIZ+BC27XAQ9dHxneP99B19i4vn584IKaeok
EcBi6YqjpD1oIf2KBBixy/vaTlJuA07QV5NoORICvMR75gWy4XvWYt0UCZxGs1vY
BNduo6rLmePAoRKjoBVT4e3H07cLkDxkZ6V4r0jZJIwleLZOsi5mDXlS8Rwd0C0k
p8YLQBgmFFqiVqiJae/WgxzWuYCU0PgX93YXIGlLZgyDav2SQ62nyYcK5iMEwU4q
15Y6cdvRZd4iRiMZJOaAW6cLdj607FKp7fj4Hh/uZKs7FzNnskcL0b+YpxNaRDIr
g1kjE11Jqb1i/tG8C42S5ylH7HdDiQ==
=MTTr
-----END PGP SIGNATURE-----

--pFpMklMRdxwSC3Yi--
