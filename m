From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 04/16] spi: bfin-sport: Calculate transfer speed unconditionally
Date: Tue, 15 Sep 2015 16:26:16 +0300
Message-ID: <1442323588-29642-4-git-send-email-jarkko.nikula@linux.intel.com>
References: <1442323588-29642-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442323588-29642-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

SPI core validates the transfer speed and defaults to spi->max_speed_hz in
case the transfer speed is not set so code here won't use the
chip->baud value (which is derived from spi->max_speed_hz).

Please note driver uses chip->baud at the beginning of message transmission
by calling the bfin_sport_spi_restore_state() but then programs per
transfer speed in bfin_sport_spi_pump_transfers(). I'm not familiar with
the HW so I don't know would it be possible to remove chip->baud completely
by either using constant value in bfin_sport_spi_restore_state() or by
removing the tclkdiv register write there.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-bfin-sport.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bfin-sport.c b/drivers/spi/spi-bfin-sport.c
index a78693189f45..6c967555a56a 100644
--- a/drivers/spi/spi-bfin-sport.c
+++ b/drivers/spi/spi-bfin-sport.c
@@ -352,10 +352,7 @@ bfin_sport_spi_pump_transfers(unsigned long data)
 	transfer = drv_data->cur_transfer;
 	chip = drv_data->cur_chip;
 
-	if (transfer->speed_hz)
-		transfer_speed = bfin_sport_hz_to_spi_baud(transfer->speed_hz);
-	else
-		transfer_speed = chip->baud;
+	transfer_speed = bfin_sport_hz_to_spi_baud(transfer->speed_hz);
 	bfin_write(&drv_data->regs->tclkdiv, transfer_speed);
 	SSYNC();
 
-- 
2.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
