From: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH devicetree 0/2] Remainder for "[PATCH v5 00/12] NXP DSPI bugfixes and support for LS1028A"
Date: Fri, 20 Mar 2020 18:13:44 +0200
Message-ID: <20200320161346.14155-1-olteanv@gmail.com>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        michael-QKn5cuLxLXY@public.gmane.org, peng.ma-3arQi8VN3Tc@public.gmane.org
To: shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>

The series with DSPI support for LS1028A was merged by Mark Brown in his
linux-spi tree here:

https://www.spinics.net/lists/linux-spi/msg20842.html

These remaining 2 patches from that series apply on top of Michael
Walle's basic device tree support patch:

https://patchwork.kernel.org/patch/11389157/#23165893

Vladimir Oltean (2):
  arm64: dts: ls1028a: Specify the DMA channels for the DSPI controllers
  arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS

 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 14 ++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    |  6 ++++++
 2 files changed, 20 insertions(+)

-- 
2.17.1
