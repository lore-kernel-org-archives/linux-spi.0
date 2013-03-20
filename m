From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: [PATCH v4 4/5] ARM: davinci: da850: override SPI DT node device name
Date: Wed, 20 Mar 2013 16:16:58 +0530
Message-ID: <1363776419-10563-5-git-send-email-prakash.pm@ti.com>
References: <1363776419-10563-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <grant.likely@secretlab.ca>, <rob.herring@calxeda.com>,
	<rob@landley.net>, <linux@arm.linux.org.uk>, <nsekhar@ti.com>,
	<hs@denx.de>, <devicetree-discuss@lists.ozlabs.org>,
	<linux-doc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	"Manjunathappa, Prakash" <prakash.pm@ti.com>
To: <davinci-linux-open-source@linux.davincidsp.com>,
	<spi-devel-general@lists.sourceforge.net>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1363776419-10563-1-git-send-email-prakash.pm@ti.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Populate OF_DEV_AUXDATA with desired device name expected by spi-davinci
driver. Without this clk_get of spi-davinci DT driver fails.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
 arch/arm/mach-davinci/da8xx-dt.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 6b7a0a2..24146de 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -40,6 +40,7 @@ static void __init da8xx_init_irq(void)
 struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,davinci-i2c", 0x01c22000, "i2c_davinci.1", NULL),
 	OF_DEV_AUXDATA("ti,davinci-wdt", 0x01c21000, "watchdog", NULL),
+	OF_DEV_AUXDATA("ti,da830-spi", 0x01f0e000, "spi_davinci.1", NULL),
 	{}
 };
 
-- 
1.7.4.1

