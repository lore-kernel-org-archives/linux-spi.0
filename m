From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v5 00/15] add ecspi ERR009165 for i.mx6/7 soc family
Date: Mon, 24 Jun 2019 08:16:45 +0800
Message-ID: <20190624001643.GB3800@dragon>
References: <20190610081753.11422-1-yibin.gong@nxp.com>
 <1561135476.7537.5.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "vkoul@kernel.org" <vkoul@kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org
To: Robin Gong <yibin.gong@nxp.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1561135476.7537.5.camel@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jun 21, 2019 at 08:42:48AM +0000, Robin Gong wrote:
> Hello Shawn/Will,
> =A0 Do you have comments for this V5 patch set? I got tags from Mark,
> Vinod and Rob.

I'm fine with the DTS change, but not sure how the series should be
merged.

Shawn

> =

> On 2019-06-10 at 08:17 +0000, yibin.gong@nxp.com wrote:
> > From: Robin Gong <yibin.gong@nxp.com>
> > =

> > =A0 There is ecspi ERR009165 on i.mx6/7 soc family, which cause FIFO
> > transfer to be send twice in DMA mode. Please get more information
> > from:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww
> > .nxp.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=3D02%7C01%7Cyibin
> > .gong%40nxp.com%7C67d3e78fe5ef4428b3af08d6ed7beb74%7C686ea1d3bc2b4c6f
> > a92cd99c5c301635%7C0%7C1%7C636957513814970412&amp;sdata=3D%2F9sbrDEmIpu
> > OazcIAVpIrELZMEjO94%2Bjen7wOOlVsVk%3D&amp;reserved=3D0. The workaround
> > is adding
> > new sdma ram script which works in XCH=A0=A0mode as PIO inside sdma
> > instead
> > of SMC mode, meanwhile, 'TX_THRESHOLD' should be 0. The issue should
> > be
> > exist on all legacy i.mx6/7 soc family before i.mx6ul.
> > =A0 NXP fix this design issue from i.mx6ul, so newer chips including
> > i.mx6ul/
> > 6ull/6sll do not need this workaroud anymore. All other i.mx6/7/8
> > chips
> > still need this workaroud. This patch set add new 'fsl,imx6ul-ecspi'
> > for ecspi driver and 'ecspi_fixed' in sdma driver to choose if need
> > errata
> > or not.
> > =A0 The first two reverted patches should be the same issue, though, it
> > seems 'fixed' by changing to other shp script. Hope Sean or Sascha
> > could
> > have the chance to test this patch set if could fix their issues.
> > =A0 Besides, enable sdma support for i.mx8mm/8mq and fix ecspi1 not
> > work
> > on i.mx8mm because the event id is zero.
> > =

> > PS:
> > =A0=A0=A0Please get sdma firmware from below linux-firmware and copy it=
 to
> > your
> > local rootfs /lib/firmware/imx/sdma.
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit
> > .kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ffirmware%2Flinux-
> > firmware.git%2Ftree%2Fimx%2Fsdma&amp;data=3D02%7C01%7Cyibin.gong%40nxp.
> > com%7C67d3e78fe5ef4428b3af08d6ed7beb74%7C686ea1d3bc2b4c6fa92cd99c5c30
> > 1635%7C0%7C1%7C636957513814970412&amp;sdata=3DxXHBWpSaSLmMosb%2FajOAiXn
> > nkxaYV6HCt25OOzgRLbI%3D&amp;reserved=3D0
> > =

> > v2:
> > =A0 1.Add commit log for reverted patches.
> > =A0 2.Add comment for 'ecspi_fixed' in sdma driver.
> > =A0 3.Add 'fsl,imx6sll-ecspi' compatible instead of 'fsl,imx6ul-ecspi'
> > =A0=A0=A0=A0rather than remove.
> > v3:
> > =A0 1.Confirm with design team make sure ERR009165 fixed on
> > i.mx6ul/i.mx6ull
> > =A0=A0=A0=A0/i.mx6sll, not fixed on i.mx8m/8mm and other i.mx6/7 legacy
> > chips.
> > =A0=A0=A0=A0Correct dts related dts patch in v2.
> > =A0 2.Clean eratta information in binding doc and new 'tx_glitch_fixed'
> > flag
> > =A0=A0=A0=A0in spi-imx driver to state ERR009165 fixed or not.
> > =A0 3.Enlarge burst size to fifo size for tx since tx_wml set to 0 in
> > the
> > =A0=A0=A0=A0errata workaroud, thus improve performance as possible.
> > v4:
> > =A0 1.add Ack tag from Mark and Vinod
> > =A0 2. remove checking 'event_id1' zero as 'event_id0'.
> > v5:
> > =A0 1.Add another patch for compatible with the current uart driver
> > which
> > =A0=A0=A0=A0using rom script, so both uart ram script and rom script
> > supported
> > =A0=A0=A0=A0in latest firmware, by default uart rom script used. UART d=
river
> > =A0=A0=A0=A0will be broken without this patch. Latest sdma firmware has=
 been
> > =A0=A0=A0=A0already updated in linux-firmware.=A0
> > =

> > Robin Gong (15):
> > =A0 Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
> > =A0 Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
> > =A0 Revert "dmaengine: imx-sdma: refine to load context only once"
> > =A0 dmaengine: imx-sdma: remove dupilicated sdma_load_context
> > =A0 dmaengine: imx-sdma: add mcu_2_ecspi script
> > =A0 spi: imx: fix ERR009165
> > =A0 spi: imx: remove ERR009165 workaround on i.mx6ul
> > =A0 spi: imx: add new i.mx6ul compatible name in binding doc
> > =A0 dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
> > =A0 dma: imx-sdma: add i.mx6ul/6sx compatible name
> > =A0 dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm
> > =A0 ARM: dts: imx6ul: add dma support on ecspi
> > =A0 ARM: dts: imx6sll: correct sdma compatible
> > =A0 arm64: defconfig: Enable SDMA on i.mx8mq/8mm
> > =A0 dmaengine: imx-sdma: add uart rom script
> > =

> > =A0.../devicetree/bindings/dma/fsl-imx-sdma.txt=A0=A0=A0=A0=A0=A0=A0|=
=A0=A02 +
> > =A0.../devicetree/bindings/spi/fsl-imx-cspi.txt=A0=A0=A0=A0=A0=A0=A0|=
=A0=A01 +
> > =A0arch/arm/boot/dts/imx6q.dtsi=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A02 +-
> > =A0arch/arm/boot/dts/imx6qdl.dtsi=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A08 +-
> > =A0arch/arm/boot/dts/imx6sll.dtsi=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A02 +-
> > =A0arch/arm/boot/dts/imx6ul.dtsi=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A08 ++
> > =A0arch/arm64/configs/defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A03 +
> > =A0drivers/dma/imx-sdma.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0| 88
> > ++++++++++++++++------
> > =A0drivers/spi/spi-imx.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0| 61
> > ++++++++++++---
> > =A0include/linux/platform_data/dma-imx-sdma.h=A0=A0=A0=A0=A0=A0=A0=A0=
=A0| 11 ++-
> > =A010 files changed, 145 insertions(+), 41 deletions(-)
> > =
