From: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 4/5] ARM: davinci: da850: override SPI DT node device name
Date: Tue, 12 Mar 2013 13:40:26 +0530
Message-ID: <1363075827-31053-5-git-send-email-prakash.pm@ti.com>
References: <1363075827-31053-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, "Manjunathappa,
	Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, hs-ynQEQJNshbs@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1363075827-31053-1-git-send-email-prakash.pm-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Populate OF_DEV_AUXDATA with desired device name expected by spi-davinci
driver. Without this clk_get of spi-davinci DT driver fails.

Signed-off-by: Manjunathappa, Prakash <prakash.pm-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-davinci/da8xx-dt.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 5404e92..e049f07 100644
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


------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
