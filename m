From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/5] spi: spi-fsl-dspi: Exit the ISR with IRQ_NONE
 when it's not ours
Date: Fri, 23 Aug 2019 11:59:49 +0100
Message-ID: <20190823105949.GQ23391@sirena.co.uk>
References: <20190822211514.19288-1-olteanv@gmail.com>
 <20190822211514.19288-3-olteanv@gmail.com>
 <20190823102816.GN23391@sirena.co.uk>
 <CA+h21hoUfbW8Gpyfa+a-vqVp_qARYoq1_eyFfZFh-5USNGNE2g@mail.gmail.com>
 <20190823105044.GO23391@sirena.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9ToWwKEyhugL+MAz"
Cc: linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, netdev <netdev@vger.kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190823105044.GO23391@sirena.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--9ToWwKEyhugL+MAz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 23, 2019 at 11:50:44AM +0100, Mark Brown wrote:
> On Fri, Aug 23, 2019 at 01:30:27PM +0300, Vladimir Oltean wrote:

> > Did you see this?
> > https://lkml.org/lkml/2019/8/22/1542

> I'm not online enough to readily follow that link right now, I
> did apply another patch for a similar issue though.  If that's
> a different version of the same change please don't do that,
> sending multiple conflicting versions of the same thing creates
> conflicts and makes everything harder to work with.

Oh, I guess this was due to there being an existing refactoring
in -next that meant the fix wouldn't apply directly.  I sorted
that out now I think, but in general the same thing applies -
it's better to put fixes before anything else in the series,
it'll flag up when reviewing.

--9ToWwKEyhugL+MAz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1fxyQACgkQJNaLcl1U
h9DqNwf/QNh0rvN7VFuAHpO+9fAuH2a16emof71uPK515M62lfJjwg0Q29hWXiuS
Operl313jrRdaddOr+bqos+xnevzFqwrcP8f5klFa7Nmofx0La8XaIk9lbrn+FKd
erNLzFHeq+Ot9Oe+NYGSoCS1NigyIFpmm017334bJ2Z/dqBEBUWj8PPSVzeUKqvG
xCjBsN/sCThnstMDwhmQA6uTP8FIu+Q+iLOSjM3jP5qRV03+M7m2o+QOAbVFZpKb
0Ls4dA70Cma3t0i0B8ZT1/NODz2A8Tm2HW3kFnjDH+LxtmpGNyvYqfvD+JOQiFRD
n++9Eg+abR59AW6YMBxsNiIzFdWBFQ==
=4GBH
-----END PGP SIGNATURE-----

--9ToWwKEyhugL+MAz--
