From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/6] add spi support for i.MX51 in the existing spi_imx
	driver
Date: Fri, 24 Sep 2010 10:12:47 -0600
Message-ID: <AANLkTimKGjz0=3KGhH-Oek9=k6OQ=738Ydcwn7D-RpdB@mail.gmail.com>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<20100902082759.GE14214@pengutronix.de> <4C7F777E.1090104@gmail.com>
	<20100902143908.GK14214@pengutronix.de>
	<20100917095247.GB30441@pengutronix.de>
	<AANLkTi=mMGe10rDhA6g0OZYXhSW3=M07PKr6yN8VwnnJ@mail.gmail.com>
	<20100924091120.GA25312@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general@lists.sourceforge.net, s.hauer@pengutronix.de,
	Jason Wang <jason77.wang@gmail.com>, linux-arm-kernel@lists.infradead.org,
	amit.kucheria@canonical.com
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100924091120.GA25312@pengutronix.de>
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

2010/9/24 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> Hello Grant,
>
> On Fri, Sep 24, 2010 at 01:00:14AM -0600, Grant Likely wrote:
>> > Jason Wang (4):
>> > =A0 =A0 =A0ARM: mx5/clock-mx51: add spi clocks
>> > =A0 =A0 =A0ARM: mx5/iomux-mx51: add iomux definitions for eCSPI2 on th=
e imx51_3ds board
>> > =A0 =A0 =A0ARM: mx5/mx51_3ds: add eCSPI2 support on the imx51_3ds board
>> > =A0 =A0 =A0ARM: mx5/mx51_3ds: add SPI NOR flash in the board init stage
>> >
>> > Uwe Kleine-K=F6nig (12):
>> > =A0 =A0 =A0spi/imx: default to m on platforms that have such devices
>> > =A0 =A0 =A0spi/imx: convert driver to use platform ids
>> > =A0 =A0 =A0spi/imx: get rid of more ifs depending on the used cpu
>> > =A0 =A0 =A0spi/imx: save the spi chip select in config struct, not the=
 gpio to use
>> > =A0 =A0 =A0spi/imx: add support for imx51's eCSPI and CSPI
>> > =A0 =A0 =A0ARM: imx: change the way spi-imx devices are registered
>> > =A0 =A0 =A0ARM: imx: use platform ids for spi_imx devices
>> > =A0 =A0 =A0ARM: mx51: clean up mx51 header
>> > =A0 =A0 =A0ARM: mx51: fix naming of spi related defines
>> > =A0 =A0 =A0ARM: mx5: add spi_imx device registration
>> > =A0 =A0 =A0ARM: mx5/clock-mx51: refactor ccgr callbacks to use common =
code
>> > =A0 =A0 =A0ARM: mx5/clock-mx51: new macro that defines a clk with all =
members
>> >
>> > =A0arch/arm/mach-imx/clock-imx1.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A02 +-
>> > =A0arch/arm/mach-imx/clock-imx21.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A06 +-
>> > =A0arch/arm/mach-imx/clock-imx27.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A06 +-
>> > =A0arch/arm/mach-imx/devices-imx21.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A09 +-
>> > =A0arch/arm/mach-imx/devices-imx27.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 12 +-
>> > =A0arch/arm/mach-mx25/clock.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A06 +-
>> > =A0arch/arm/mach-mx25/devices-imx25.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 12 +-
>> > =A0arch/arm/mach-mx3/clock-imx31.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A06 +-
>> > =A0arch/arm/mach-mx3/clock-imx35.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A04 +-
>> > =A0arch/arm/mach-mx3/devices-imx31.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 12 +-
>> > =A0arch/arm/mach-mx3/devices-imx35.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A09 +-
>> > =A0arch/arm/mach-mx5/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 =A01 +
>> > =A0arch/arm/mach-mx5/board-mx51_3ds.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 33 ++
>> > =A0arch/arm/mach-mx5/clock-mx51.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0113 ++++-
>> > =A0arch/arm/mach-mx5/devices-imx51.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 18 +
>> > =A0arch/arm/plat-mxc/devices/platform-spi_imx.c =A0 =A0| =A0 89 +++-
>> > =A0arch/arm/plat-mxc/include/mach/devices-common.h | =A0 11 +-
>> > =A0arch/arm/plat-mxc/include/mach/iomux-mx51.h =A0 =A0 | =A0 =A05 +
>> > =A0arch/arm/plat-mxc/include/mach/mx51.h =A0 =A0 =A0 =A0 =A0 | =A0608 =
+++++++++++------------
>> > =A0drivers/spi/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 16 +
>> > =A0drivers/spi/spi_imx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0394 ++++++++++++---
>> > =A021 files changed, 919 insertions(+), 453 deletions(-)
>> > =A0create mode 100644 arch/arm/mach-mx5/devices-imx51.h
>>
>> I'm fine with this series.
>>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>>
>> What tree do you want to merge them through?
> I thought that the five patches touching drivers/spi should go via your
> tree, the others via Sascha's. =A0Assuming this is OK for you, too, do you
> prefer to pick the patches out here or should I prepare a branch with
> these patches for you to pull?

You can just add my acked-by and take the whole series via Sascha.  No
sense breaking them up.

g.
