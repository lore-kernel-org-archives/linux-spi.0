From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] spi: add bcm63xx HSSPI driver
Date: Wed, 4 Dec 2013 14:08:53 +0000
Message-ID: <20131204140853.GU29268@sirena.org.uk>
References: <1385811726-6746-1-git-send-email-jogo@openwrt.org>
 <1385811726-6746-6-git-send-email-jogo@openwrt.org>
 <20131204133823.GS29268@sirena.org.uk>
 <CAOiHx==utbmYUS4BLoSaaGi91Kw5voQ2vFiA97GLmwn8yU19Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Nx8xdmI2KD3LNVVP"
Cc: MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-spi@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>
To: Jonas Gorski <jogo@openwrt.org>
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <CAOiHx==utbmYUS4BLoSaaGi91Kw5voQ2vFiA97GLmwn8yU19Dw@mail.gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Id: linux-spi.vger.kernel.org


--Nx8xdmI2KD3LNVVP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2013 at 03:04:48PM +0100, Jonas Gorski wrote:
> On Wed, Dec 4, 2013 at 2:38 PM, Mark Brown <broonie@kernel.org> wrote:

> > This ought to be disable_unprepare().  It would also be better to move
> > this to runtime PM (you can set auto_runtime_pm to have the core manage
> > the enable and disable for you) since that will save a bit of power.

> I already set auto_runtime_pm to true. I basically copied what's
> currently in spi-bcm63xx.c *coughs*. Is there anything else needed
> besides what you mentioned?

You'll need to call pm_runtime_enable() and so on to turn on runtime PM
in probe() and reverse that in remove() but otherwise no, just adding
the runtime callbacks should be fine.

--Nx8xdmI2KD3LNVVP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnzdxAAoJELSic+t+oim9HHUP/R4Et3NLLUEWaC6wSjLjwXtB
ZTEGcgHZ5qsIcpgFhI95vPiZex/sHQ1+tse7UNgQ1c8R+x7nF0NwZIjj3vlkXPtl
2wF3jXErw3kBpLfp3mbUzxIel7hRpOb+tPyojlxWMQrULL+mfrO23cdafCLf5mD7
E9NuHDZy58k7xlKyJv1iAX8Yb8Ka/7gvhxBg4oEshuMj68ij7t5F1QdvBY+MXcZq
bqCSrId+OdTDNFo8dbJp+Ul9ViDVOsRpDmNC3N+OJWhAZXyvas/82Jeo9jyefuqn
WZX8V2Mbwg6GyzKvvLpoq5/BRQ2D6YVDQvTuDQBhLzo5Z+cniBvMb4y/qyaG7oz1
gzfcafEZRTqiHQg6/2mYcwn/hXmoLsQ6Vcp+M3AzzUIQEby4n096V21OuNC/hvX2
z0obJyYGXyWDwY6cmqHFRNFoZoggcSeLDL/MHoV2yWf3R8xyHZD7dJU+SEZzTHtq
G62UfxLCWyLBTystXKkMPpVDwcW3TeDV3LLrkuPelkwY+zJoyQ1d93YgaXFzbbGV
xqm2FEOGxBEuJafVAr3Ecajin2ECShO++dmuezf7nUBq4CZi0xVzOzOiowrru+hn
4uv6AloQY8p19X6lbX8yjfIUd0JRyEjDgK1SrTqBZXdKMyvGTOGCoO41nmdHykm+
OcBssvzaoPelLPWjWDQw
=sJcT
-----END PGP SIGNATURE-----

--Nx8xdmI2KD3LNVVP--
