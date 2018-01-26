From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: sprd: Use 'spi_master_put()' instead of
 'spi_controller_put()'
Date: Fri, 26 Jan 2018 17:32:18 +0000
Message-ID: <20180126173218.GF32674@sirena.org.uk>
References: <20180126155256.25956-1-christophe.jaillet@wanadoo.fr>
 <CAMuHMdXMndPDnCYyfxJ8=mrJdWTdn-ANqwGHkY8+BAVUYBm4NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ChQOR20MqfxkMJg9"
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXMndPDnCYyfxJ8=mrJdWTdn-ANqwGHkY8+BAVUYBm4NA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--ChQOR20MqfxkMJg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 26, 2018 at 05:16:34PM +0100, Geert Uytterhoeven wrote:
> On Fri, Jan 26, 2018 at 4:52 PM, Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
> > 'spi_alloc_master()' calls should be balanced by a 'spi_master_put()' call.

> > 'spi_controller_put()' is equivalent (see include/linux/spi/spi.h) but it
> > is cleaner and more logical to use 'spi_master_put()'.

> My intention was to phase out the spi_master_* names, and remove them
> when there are no users left.

Yeah, a better change here would be adding the matching allocation
function and using that.

--ChQOR20MqfxkMJg9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlprZiEACgkQJNaLcl1U
h9BM+Af/Yr4QqNAqW6MHtbb595L/lMcB7slMA58WGBRB1HQ60se2V8WQA9CWitkw
cogpF8D2mluhhFl7ONBb5JYuP6z7tZRuFIx3ODUOTlsUZUQ59Hdir6etcLjrXAyu
adwC7/k2aBDyGLzCucfYLAnQra0pmk1qr6YTQ8y7J4Th4HNgdaQ5e9BDdX2dFnCJ
Xo4PiV5XdeDY+wwGXeqMZFPBtjLQVRuRv9WJ7VLI7bkw/espGihVGwBzcgG0t0fG
Rz2Ss1YJo9CGyfC5oS26yr4188iDnHg7j72dWu77OT5IpEkt9F+QrVnsiWGNG0mh
ARWwbvFYOEVtCDh0GCk/tWJQly6iTA==
=JRM+
-----END PGP SIGNATURE-----

--ChQOR20MqfxkMJg9--
