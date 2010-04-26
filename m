From: thomas.koeller-x9WYMywdo8BF6kxbq+BtvQ@public.gmane.org
Subject: [PATCH] DaVinci SPI: Fix SPI clock prescale
	factor computation
Date: Mon, 26 Apr 2010 11:01:45 +0200
Message-ID: <1272272505-5021-2-git-send-email-thomas.koeller@baslerweb.com>
References: <871veaksca.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>,
	Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>,
	Thomas Koeller <thomas.koeller-x9WYMywdo8BF6kxbq+BtvQ@public.gmane.org>,
	Sandeep Paulraj <s-paulraj-l0cyMroinI0@public.gmane.org>, Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
To: davinci-linux-open-source-VycZQUHpC/Nq7ICLvS4PUAC/G2K4zDHf@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <871veaksca.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
In-Reply-To: <871veaksca.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
References: <871veaksca.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Thomas Koeller <thomas.koeller-x9WYMywdo8BF6kxbq+BtvQ@public.gmane.org>

Computation of the clock prescaler value returned bogus results if
the requested SPI clock was impossible to set. It now sets either
the maximum or minimum clock frequency, as appropriate.

Signed-off-by: Thomas Koeller <thomas.koeller-x9WYMywdo8BF6kxbq+BtvQ@public.gmane.org>
---
 drivers/spi/davinci_spi.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 956f617..02e1a76 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -153,7 +153,7 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 	struct davinci_spi *davinci_spi;
 	struct davinci_spi_platform_data *pdata;
 	u8 bits_per_word = 0;
-	u32 hz = 0, prescale;
+	u32 hz = 0, prescale = 0, clkspeed;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
 	pdata = davinci_spi->pdata;
@@ -190,10 +190,16 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 	set_fmt_bits(davinci_spi->base, bits_per_word & 0x1f,
 			spi->chip_select);
 
-	prescale = ((clk_get_rate(davinci_spi->clk) / hz) - 1) & 0xff;
+	clkspeed = clk_get_rate(davinci_spi->clk);
+	if (hz > clkspeed / 2)
+		prescale = 1 << 8;
+	if (hz < clkspeed / 256)
+		prescale = 255 << 8;
+	if (!prescale)
+		prescale = ((clkspeed / hz - 1) << 8) & 0x0000ff00;
 
 	clear_fmt_bits(davinci_spi->base, 0x0000ff00, spi->chip_select);
-	set_fmt_bits(davinci_spi->base, prescale << 8, spi->chip_select);
+	set_fmt_bits(davinci_spi->base, prescale, spi->chip_select);
 
 	return 0;
 }
-- 
1.7.0.3


------------------------------------------------------------------------------
