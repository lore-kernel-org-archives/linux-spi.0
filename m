From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "spi: Add QuadSPI driver for Atmel SAMA5D2" to the spi
 tree
Date: Thu, 8 Nov 2018 12:07:52 +0000
Message-ID: <20181108120752.GC6675@sirena.org.uk>
References: <20181105103625.9644-6-bugalski.piotr@gmail.com>
 <20181107150327.B6DC41124E14@debutante.sirena.org.uk>
 <20181107151836.GB6809@sirena.org.uk>
 <20181108095022.66ad3ad1@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Cc: Piotr Bugalski <bugalski.piotr@gmail.com>,
        linux-spi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181108095022.66ad3ad1@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 08, 2018 at 09:50:22AM +0100, Boris Brezillon wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > Sorry, I got confused about which patch series Boris had asked me to
> > apply for him - it wasn't this one!  Since the review looked like it was
> > just one minor issue last time I'll just leave them for now, they were
> > applied on a separate branch for sharing with the MTD tree so it's easy
> > for me to drop them if that's required or if I should put together the
> > pull request for MTD.  Sorry for any confusion this ends up causing,
> > it's entirely my mistake.

> I'm probably missing something, but I don't see where you made a
> mistake :-). It's indeed the series I asked you to merge, the only
> comment I had was actually a suggestion to help Piotr solve his perf
> issue (which was already present in the old driver).

Oh, OK.  Then we can definitively say I'm confused then :)

> And thanks for creating the mtd topic branch BTW.

Here's a signed tag for just the MTD bits:

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-mtd-atmel

for you to fetch changes up to 6ca622c87149a20a47abbb954f896f515e2292a7:

  mtd: spi-nor: atmel-quadspi: Remove unused code from atmel-quadspi driver (2018-11-07 13:21:10 +0000)

----------------------------------------------------------------
mtd: Atmel QuadSPI changes for MTD

These changes are dependencies for a branch merged into the SPI tree,
create a signed tag to share them with the MTD tree.

----------------------------------------------------------------
Piotr Bugalski (4):
      mtd: spi-nor: atmel-quaspi: Typo fix
      mtd: spi-nor: atmel-quadspi: Add spi-mem support to atmel-quadspi
      mtd: spi-nor: atmel-quadspi: Use spi-mem interface for atmel-quadspi driver
      mtd: spi-nor: atmel-quadspi: Remove unused code from atmel-quadspi driver

 drivers/mtd/spi-nor/atmel-quadspi.c | 528 ++++++++++--------------------------
 1 file changed, 148 insertions(+), 380 deletions(-)

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvkJxgACgkQJNaLcl1U
h9BcJgf+NBCkwqCGZqSr7hUTakUsHoRWEPxfsKxf2iq4IXSlsq9ilM+d/TwJXXjf
YQLK9WPUFg2xKylbtQscBOgt49oVGP+cCywuEWrnO32Ix5by1e9BGRFt1n2scsBT
LyAlHyJaQr4HAagkp2F2AZjoBrXq5nRinpYSAjSfRWfL3fFl/9JIScVg+RPxraqW
SZT8C87kQRLcU7AIIij0Q5kSuHthsunFv5tz6DFRILgDMbB5/e4BXwIHbULFj0aq
dIBjhVMkCyhq+MJtief7hTLcO/VGVyCh1tPW449+y6UiSWh1X6bh/t9HHKYAov/e
zZrrK+gCRC9BfrVwEvDZ5ycn4koNOQ==
=C77L
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
