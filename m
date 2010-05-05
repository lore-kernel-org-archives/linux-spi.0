From: "Arce, Abraham" <x0066660@ti.com>
Subject: [PATCH 0/3] OMAP4 Ethernet Controller Support
Date: Wed, 5 May 2010 02:09:19 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DEEB8BF@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Enable network chip Micrel KS8851 for OMAP4430 SDP

- Based on mainline version 2.6.34 rc6
- Tested in OMAP4430 SDP

Throughput measurements using nuttcp application:
  11.9375 MB /  10.06 sec =    9.9519 Mbps 92 %TX 0 %RX 0 retrans 7.87 msRTT

Patches

 [PATCH v2 1/3] OMAP4: SPI: Fix Driver Kconfig
 [PATCH v1 2/3] OMAP4: Ethernet: KS8851 Board Support
 [PATCH v1 3/3] OMAP4: Networking: Defconfig Support

---

 arch/arm/configs/omap_4430sdp_defconfig |   57 ++++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/board-4430sdp.c     |   30 ++++++++++++++++
 drivers/spi/Kconfig                     |    6 +--
 3 files changed, 88 insertions(+), 5 deletions(-)
