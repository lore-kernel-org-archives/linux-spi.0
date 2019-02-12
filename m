From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver" to the spi tree
Date: Tue, 12 Feb 2019 16:49:40 +0000
Message-ID: <20190212164940.GI20635@sirena.org.uk>
References: <20190212142236.2807D1128113@debutante.sirena.org.uk>
 <4f91497a-96ee-4c10-436f-4d011edb3834@gmail.com>
 <20190212144359.GD20635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l0l+eSofNeLXHSnY"
Cc: Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Marek Vasut <marek.vasut@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212144359.GD20635@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--l0l+eSofNeLXHSnY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 12, 2019 at 02:43:59PM +0000, Mark Brown wrote:

> Mason had submitted a new verison a couple of weeks ago and there'd been
> no replies on the new version so I'd thought that all the prior issues
> had been addressed.  I guess that's not the case?  The thread on the
> version before was a bit long but seemed to peter out, though looking at
> the archives it seems the main issue was that Mason stopped replying.

Following some IRC discussion with Marek and Sergei I've dropped these
for now.  The interaction with the HyperFlash support seems unclear
still and might be a bit more than a simple refactoring, worst case
it'll be binding incompatible though hopefully not.  Mason, if you could
work with them to figure out the MFD that'll be needed the driver looks
fine from a SPI subsystem point of view.

Sorry about the confusion for everyone here.

--l0l+eSofNeLXHSnY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxi+SMACgkQJNaLcl1U
h9C84Af/cS7fCpLU+Lf+jhGYKtuIzQ+L2S3hPAMWRwg7OoBXok3jTyMHLs3Tin9e
ev69K6yi+yIObemPTHA0K74u7LHtNbe3qZhGmuJ864+3FpPecUbgqmnrGd9eBENH
S28tgG0rORO+IfzwxjvfIFfRdL4Btqra5UbtIyJRvMPM4XXRiIE/iHX4z87XtRkt
QOS8nYfasrQQsF0tUEi2xSWdXMTIss9uilYc/Y6EXlaPw1BgmLu9dn7i/YI6ox8e
wi35bMH12U8lDvlgu/izyZOXO3asTCzhIwhtaP+JYMtmd6NX7CjDBSjcDpiOSuEq
vHOxR7tEKoAn3ZW/5zTy0msgWxf2gQ==
=ykMc
-----END PGP SIGNATURE-----

--l0l+eSofNeLXHSnY--
