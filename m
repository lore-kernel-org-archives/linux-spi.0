From: Sergiu Cuciurean <sergiu.cuciurean-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2] spi: spi-mpc52xx: Use new structure for SPI transfer delays
Date: Thu, 27 Feb 2020 16:39:31 +0200
Message-ID: <20200227143931.20688-1-sergiu.cuciurean@analog.com>
References: <20200227142131.14940-1-sergiu.cuciurean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sergiu Cuciurean <sergiu.cuciurean-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200227142131.14940-1-sergiu.cuciurean-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

In a recent change to the SPI subsystem [1], a new `delay` struct was added
to replace the `delay_usecs`. This change replaces the current
`delay_usecs` with `delay` for this driver.

The `spi_transfer_delay_exec()` function [in the SPI framework] makes sure
that both `delay_usecs` & `delay` are used (in this order to preserve
backwards compatibility).

[1] commit bebcfd272df6 ("spi: introduce `delay` field for
`spi_transfer` + spi_transfer_delay_exec()")
Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
---

Changelog v1->v2:
*Increment the timestamp only if the delay unit is microseconds

 drivers/spi/spi-mpc52xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index ef2f24420460..36f941500676 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -248,7 +248,9 @@ static int mpc52xx_spi_fsmstate_transfer(int irq, struct mpc52xx_spi *ms,
 	ms->len--;
 	if (ms->len == 0) {
 		ms->timestamp = get_tbl();
-		ms->timestamp += ms->transfer->delay_usecs * tb_ticks_per_usec;
+		if (ms->transfer->delay.unit == SPI_DELAY_UNIT_USECS)
+			ms->timestamp += ms->transfer->delay.value *
+					 tb_ticks_per_usec;
 		ms->state = mpc52xx_spi_fsmstate_wait;
 		return FSM_CONTINUE;
 	}
-- 
2.17.1
