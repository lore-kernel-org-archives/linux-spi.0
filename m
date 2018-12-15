From: Schrempf Frieder <frieder.schrempf@kontron.de>
Subject: AW: [PATCH 0/5] Prepare devicetrees for the new FSL QSPI driver
Date: Sat, 15 Dec 2018 10:04:55 +0000
Message-ID: <937b0f34e3eb485aaae45cd649cdeb4f@kontron.de>
References: <1544459182-23655-1-git-send-email-frieder.schrempf@kontron.de>
 <ce1442f3-357b-d647-958e-cc4a89282b79@kontron.de>
 <1ad93cdf-7ba1-ff49-f330-6bbd0f6c6972@kontron.de>,<20181214004251.GA15775@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181214004251.GA15775@dragon>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

>On Thu, Dec 13, 2018 at 09:45:04AM +0000, Schrempf Frieder wrote:
>> + Shawn, Sascha
>>
>> On 10.12.18 17:31, Schrempf Frieder wrote:
>> > Hi FSL/ARM maintainers,
>> >
>> > On 10.12.18 17:26, Schrempf Frieder wrote:
>> >> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>> >>
>> >> We have prepared a new driver for the FSL QSPI controller that works under
>> >> the SPI framework. The current devicetrees are broken because they use an
>> >> inconsistent scheme for assigning the reg properties.
>> >>
>> >> As, in contrast to the current driver, the new driver will use the reg
>> >> properties to select the correct chip, we need to fix them.
>> >>
>> >> We also add spi-[tx/rx]-bus-width to make sure the full buswidth will be used
>> >> and while at it clean up and remove some unused properties.
>> >
>> > could you please consider these devicetree patches for v4.21?
>>
>> Any chance to get this merged? Otherwise we would need to postpone the
>> new driver even further.
>
>As it came up a little bit late (the same day I sent pull request for
>4.21), I was considering it as 4.22 material.  But as you mentioned that
>the series is non-intrusive, I can try to send it to arm-soc folk for
>4.21 merge window, and then that will be their call.  But before I do
>it, I need you to double confirm that the series will not break anything
>that is already working.

I can confirm, that the series does only remove or add properties to the
devicetree, that are currently not used by the driver. Therefore it won't break
anything.

Thanks,
Frieder

>
>Shawn
>
>>
>> All the changes to the devicetrees in this series are non-intrusive and
>> uncritical, anyway.
>>
>> Thanks,
>> Frieder
>>
>> >
>> > We have the new FSL QSPI driver under the SPI framework ([1]) ready, but
>> > we need some small fixes to the devicetrees that are currently broken.
>> >
>> > As the new driver depends on these changes (mainly the change to the reg
>> > properties) and it is not possible to add compatibility for the old
>> > bindings, it would be really nice to have them in v4.21, so we can queue
>> > the driver for v4.22 or whatever the next release will be called.
>> >
>> > Please also see [2] for some more explanation.
>> >
>> > Thanks,
>> > Frieder
>> >
>> > [1] https://patchwork.ozlabs.org/cover/1007641/
>> > [2] https://patchwork.ozlabs.org/patch/922817/#1925445
>> >
>> >>
>> >> Frieder Schrempf (5):
>> >>     arm64: dts: Remove unused properties from FSL QSPI driver nodes
>> >>     ARM: dts: Remove unused properties from FSL QSPI driver nodes
>> >>     ARM: dts: imx6sx-sdb: Fix the reg properties for the FSL QSPI nodes
>> >>     arm64: dts: Add spi-[tx/rx]-bus-width for the FSL QSPI controller
>> >>     ARM: dts: Add spi-[tx/rx]-bus-width for the FSL QSPI controller
>> >>
>> >>    arch/arm/boot/dts/imx6sx-sdb-reva.dts              | 8 ++++++--
>> >>    arch/arm/boot/dts/imx6sx-sdb.dts                   | 8 ++++++--
>> >>    arch/arm/boot/dts/imx6ul-14x14-evk.dtsi            | 2 ++
>> >>    arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts        | 5 ++---
>> >>    arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  | 3 ++-
>> >>    arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  | 4 ++--
>> >>    arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  | 6 ++++--
>> >>    arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi | 4 ++++
>> >>    8 files changed, 28 insertions(+), 12 deletions(-)
>> >>
>> > ______________________________________________________
>> > Linux MTD discussion mailing list
>> > http://lists.infradead.org/mailman/listinfo/linux-mtd/
>> >
