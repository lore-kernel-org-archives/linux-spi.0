From: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [v2 0/2] Add Broadcom STB SPI support
Date: Fri, 30 Dec 2016 15:29:59 +0900
Message-ID: <20161230063001.944-1-jaedon.shin@gmail.com>
Cc: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi all,

This series adds dependency with BMIPS_GENERIC for Broadcom MIPS based SoCs
and device nodes.

As far as I know the boards are booting from NAND by default except BCM97358,
BCM97360 and BCM97425, and therefore the SPI nodes for boot (qspi) of the boards
are disabled.

Changes in v2:
- Use upg_clk instead of new spi_clk.

Jaedon Shin (2):
  spi: bcm-qspi: Enable the driver on BMIPS_GENERIC
  MIPS: BMIPS: Add support SPI device nodes

 arch/mips/boot/dts/brcm/bcm7125.dtsi      | 49 +++++++++++++++++++++++++++++--
 arch/mips/boot/dts/brcm/bcm7346.dtsi      | 43 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7358.dtsi      | 43 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7360.dtsi      | 43 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi      | 43 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7420.dtsi      | 49 +++++++++++++++++++++++++++++--
 arch/mips/boot/dts/brcm/bcm7425.dtsi      | 43 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi      | 43 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97125cbmb.dts  |  4 +++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts |  4 +++
 arch/mips/boot/dts/brcm/bcm97358svmb.dts  | 36 +++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts  | 36 +++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts  |  4 +++
 arch/mips/boot/dts/brcm/bcm97420c.dts     |  4 +++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts  | 36 +++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts  |  4 +++
 drivers/spi/Kconfig                       |  3 +-
 17 files changed, 480 insertions(+), 7 deletions(-)

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
