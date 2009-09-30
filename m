From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 0/7] Updates for spi-imx
Date: Wed, 30 Sep 2009 21:42:11 +0200
Message-ID: <20090930194211.GB1881@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755215AbZI3TnH@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello,

as a followup to this mail I'll send some updates for the spi-imx
driver for review.

Overall diffstat and shortlog can be found below.

You can find the patches based on current Linus' master at

  git://git.pengutronix.de/git/ukl/linux-2.6.git spi-imx

Sascha Hauer (3):
      spi-imx: update state correctly
      spi-imx: Fix initial chipselect settings
      spi-imx: setup mode_bits we can handle

Uwe Kleine-K=F6nig (4):
      spi-imx: rename source file to spi_imx.c
      spi-imx: no need to assert bits_per_word being initialized
      spi-imx: initialize complete config struct
      [RFC] spi-imx: strip down chipselect function to only drive the c=
hipselect

 drivers/spi/Makefile                 |    2 +-
 drivers/spi/{mxc_spi.c =3D> spi_imx.c} |  383 +++++++++++++++++-------=
----------
 2 files changed, 190 insertions(+), 195 deletions(-)
 rename drivers/spi/{mxc_spi.c =3D> spi_imx.c} (55%)
--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
