From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/6] add spi support for i.MX51 in the existing spi_imx
	driver
Date: Fri, 24 Sep 2010 01:00:14 -0600
Message-ID: <AANLkTi=mMGe10rDhA6g0OZYXhSW3=M07PKr6yN8VwnnJ@mail.gmail.com>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<20100902082759.GE14214@pengutronix.de> <4C7F777E.1090104@gmail.com>
	<20100902143908.GK14214@pengutronix.de>
	<20100917095247.GB30441@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general@lists.sourceforge.net, s.hauer@pengutronix.de,
	Jason Wang <jason77.wang@gmail.com>, linux-arm-kernel@lists.infradead.org,
	amit.kucheria@canonical.com
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100917095247.GB30441@pengutronix.de>
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

2010/9/17 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Thu, Sep 02, 2010 at 04:39:08PM +0200, Uwe Kleine-K=F6nig wrote:
>> Hello Jason,
>>
>> >> Actually I would prefer our patches, but of course I'm biased :-)
>> >>
>> >> I don't know how we should handle this. =A0And Sascha is on vacation =
this
>> >> and next week. =A0I will investigate if our patches are already free =
to be
>> >> posted.
>> OK, I can post our patches. =A0I think the driver part is quite similar,
>> the platform part is not. =A0But look for yourself, I'll post them in re=
ply to
>> this mail. =A0Hopefully we can join forces to get the best out of the two
>> approaches.
> I now made the effort to try doing this. =A0I hope this is OK though it
> feels strage that no commit is attributed to Sascha.
>
> The following changes since commit 5b1caa2452a2cf09417ab657ae3a2275ebd781=
03:
>
> =A0ARM: mx5/mx51_babbage: Add FEC support (2010-09-13 11:31:22 +0200)
>
> are available in the git repository at:
> =A0git://git.pengutronix.de/git/ukl/linux-2.6.git spi-imx51
>
> (5b1caa2452a2cf09417ab657ae3a2275ebd78103 is the result of rebasing
> Sascha's for-2.6.37 branch on top of 2.6.36-rc4---done mainly to contain
> the for-2.6.36 branch)
>
> Jason Wang (4):
> =A0 =A0 =A0ARM: mx5/clock-mx51: add spi clocks
> =A0 =A0 =A0ARM: mx5/iomux-mx51: add iomux definitions for eCSPI2 on the i=
mx51_3ds board
> =A0 =A0 =A0ARM: mx5/mx51_3ds: add eCSPI2 support on the imx51_3ds board
> =A0 =A0 =A0ARM: mx5/mx51_3ds: add SPI NOR flash in the board init stage
>
> Uwe Kleine-K=F6nig (12):
> =A0 =A0 =A0spi/imx: default to m on platforms that have such devices
> =A0 =A0 =A0spi/imx: convert driver to use platform ids
> =A0 =A0 =A0spi/imx: get rid of more ifs depending on the used cpu
> =A0 =A0 =A0spi/imx: save the spi chip select in config struct, not the gp=
io to use
> =A0 =A0 =A0spi/imx: add support for imx51's eCSPI and CSPI
> =A0 =A0 =A0ARM: imx: change the way spi-imx devices are registered
> =A0 =A0 =A0ARM: imx: use platform ids for spi_imx devices
> =A0 =A0 =A0ARM: mx51: clean up mx51 header
> =A0 =A0 =A0ARM: mx51: fix naming of spi related defines
> =A0 =A0 =A0ARM: mx5: add spi_imx device registration
> =A0 =A0 =A0ARM: mx5/clock-mx51: refactor ccgr callbacks to use common code
> =A0 =A0 =A0ARM: mx5/clock-mx51: new macro that defines a clk with all mem=
bers
>
> =A0arch/arm/mach-imx/clock-imx1.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A02 +-
> =A0arch/arm/mach-imx/clock-imx21.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A06 +-
> =A0arch/arm/mach-imx/clock-imx27.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A06 +-
> =A0arch/arm/mach-imx/devices-imx21.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A09 +-
> =A0arch/arm/mach-imx/devices-imx27.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 12=
 +-
> =A0arch/arm/mach-mx25/clock.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A06 +-
> =A0arch/arm/mach-mx25/devices-imx25.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 12=
 +-
> =A0arch/arm/mach-mx3/clock-imx31.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A06 +-
> =A0arch/arm/mach-mx3/clock-imx35.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A04 +-
> =A0arch/arm/mach-mx3/devices-imx31.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 12=
 +-
> =A0arch/arm/mach-mx3/devices-imx35.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A09 +-
> =A0arch/arm/mach-mx5/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A01 +
> =A0arch/arm/mach-mx5/board-mx51_3ds.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 33=
 ++
> =A0arch/arm/mach-mx5/clock-mx51.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0113 ++++-
> =A0arch/arm/mach-mx5/devices-imx51.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 18=
 +
> =A0arch/arm/plat-mxc/devices/platform-spi_imx.c =A0 =A0| =A0 89 +++-
> =A0arch/arm/plat-mxc/include/mach/devices-common.h | =A0 11 +-
> =A0arch/arm/plat-mxc/include/mach/iomux-mx51.h =A0 =A0 | =A0 =A05 +
> =A0arch/arm/plat-mxc/include/mach/mx51.h =A0 =A0 =A0 =A0 =A0 | =A0608 +++=
++++++++------------
> =A0drivers/spi/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 16 +
> =A0drivers/spi/spi_imx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0394 ++++++++++++---
> =A021 files changed, 919 insertions(+), 453 deletions(-)
> =A0create mode 100644 arch/arm/mach-mx5/devices-imx51.h
>
> Thanks
> Uwe

I'm fine with this series.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

What tree do you want to merge them through?

g.
