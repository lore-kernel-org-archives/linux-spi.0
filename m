From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/6] add spi support for i.MX51 in the existing spi_imx
	driver
Date: Fri, 17 Sep 2010 11:52:47 +0200
Message-ID: <20100917095247.GB30441@pengutronix.de>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<20100902082759.GE14214@pengutronix.de>
	<4C7F777E.1090104@gmail.com>
	<20100902143908.GK14214@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: grant.likely@secretlab.ca, spi-devel-general@lists.sourceforge.net,
	s.hauer@pengutronix.de, amit.kucheria@canonical.com,
	linux-arm-kernel@lists.infradead.org
To: Jason Wang <jason77.wang@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20100902143908.GK14214@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hello,

On Thu, Sep 02, 2010 at 04:39:08PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello Jason,
> =

> >> Actually I would prefer our patches, but of course I'm biased :-)
> >>
> >> I don't know how we should handle this.  And Sascha is on vacation this
> >> and next week.  I will investigate if our patches are already free to =
be
> >> posted.
> OK, I can post our patches.  I think the driver part is quite similar,
> the platform part is not.  But look for yourself, I'll post them in reply=
 to
> this mail.  Hopefully we can join forces to get the best out of the two
> approaches.
I now made the effort to try doing this.  I hope this is OK though it
feels strage that no commit is attributed to Sascha.

The following changes since commit 5b1caa2452a2cf09417ab657ae3a2275ebd78103:

  ARM: mx5/mx51_babbage: Add FEC support (2010-09-13 11:31:22 +0200)

are available in the git repository at:
  git://git.pengutronix.de/git/ukl/linux-2.6.git spi-imx51

(5b1caa2452a2cf09417ab657ae3a2275ebd78103 is the result of rebasing
Sascha's for-2.6.37 branch on top of 2.6.36-rc4---done mainly to contain
the for-2.6.36 branch)

Jason Wang (4):
      ARM: mx5/clock-mx51: add spi clocks
      ARM: mx5/iomux-mx51: add iomux definitions for eCSPI2 on the imx51_3d=
s board
      ARM: mx5/mx51_3ds: add eCSPI2 support on the imx51_3ds board
      ARM: mx5/mx51_3ds: add SPI NOR flash in the board init stage

Uwe Kleine-K=F6nig (12):
      spi/imx: default to m on platforms that have such devices
      spi/imx: convert driver to use platform ids
      spi/imx: get rid of more ifs depending on the used cpu
      spi/imx: save the spi chip select in config struct, not the gpio to u=
se
      spi/imx: add support for imx51's eCSPI and CSPI
      ARM: imx: change the way spi-imx devices are registered
      ARM: imx: use platform ids for spi_imx devices
      ARM: mx51: clean up mx51 header
      ARM: mx51: fix naming of spi related defines
      ARM: mx5: add spi_imx device registration
      ARM: mx5/clock-mx51: refactor ccgr callbacks to use common code
      ARM: mx5/clock-mx51: new macro that defines a clk with all members

 arch/arm/mach-imx/clock-imx1.c                  |    2 +-
 arch/arm/mach-imx/clock-imx21.c                 |    6 +-
 arch/arm/mach-imx/clock-imx27.c                 |    6 +-
 arch/arm/mach-imx/devices-imx21.h               |    9 +-
 arch/arm/mach-imx/devices-imx27.h               |   12 +-
 arch/arm/mach-mx25/clock.c                      |    6 +-
 arch/arm/mach-mx25/devices-imx25.h              |   12 +-
 arch/arm/mach-mx3/clock-imx31.c                 |    6 +-
 arch/arm/mach-mx3/clock-imx35.c                 |    4 +-
 arch/arm/mach-mx3/devices-imx31.h               |   12 +-
 arch/arm/mach-mx3/devices-imx35.h               |    9 +-
 arch/arm/mach-mx5/Kconfig                       |    1 +
 arch/arm/mach-mx5/board-mx51_3ds.c              |   33 ++
 arch/arm/mach-mx5/clock-mx51.c                  |  113 ++++-
 arch/arm/mach-mx5/devices-imx51.h               |   18 +
 arch/arm/plat-mxc/devices/platform-spi_imx.c    |   89 +++-
 arch/arm/plat-mxc/include/mach/devices-common.h |   11 +-
 arch/arm/plat-mxc/include/mach/iomux-mx51.h     |    5 +
 arch/arm/plat-mxc/include/mach/mx51.h           |  608 +++++++++++--------=
----
 drivers/spi/Kconfig                             |   16 +
 drivers/spi/spi_imx.c                           |  394 ++++++++++++---
 21 files changed, 919 insertions(+), 453 deletions(-)
 create mode 100644 arch/arm/mach-mx5/devices-imx51.h

Thanks
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
