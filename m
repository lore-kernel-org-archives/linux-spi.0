From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: cadence: Change usleep_range() to udelay(), for atomic context" to the spi tree
Date: Mon, 18 Jun 2018 13:06:13 +0100
Message-ID: <E1fUsvF-0001ML-8t@debutante>
References: <65980D27-1B52-43A3-A7CA-33B804A62AC5@cadence.com>
Cc: Jan Kotas <jank@cadence.com>, Mark Brown <broonie@kernel.org>,
        stable@vger.kernel.org, "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
To: Janek Kotas <jank@cadence.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <65980D27-1B52-43A3-A7CA-33B804A62AC5@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: cadence: Change usleep_range() to udelay(), for atomic context

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 931c4e9a72ae91d59c5332ffb6812911a749da8e Mon Sep 17 00:00:00 2001
From: Janek Kotas <jank@cadence.com>
Date: Mon, 4 Jun 2018 11:24:44 +0000
Subject: [PATCH] spi: cadence: Change usleep_range() to udelay(), for atomic
 context

The path "spi: cadence: Add usleep_range() for
cdns_spi_fill_tx_fifo()" added a usleep_range() function call,
which cannot be used in atomic context.
However the cdns_spi_fill_tx_fifo() function can be called during
an interrupt which may result in a kernel panic:

BUG: scheduling while atomic: grep/561/0x00010002
Modules linked in:
Preemption disabled at:
[<ffffff800858ea28>] wait_for_common+0x48/0x178
CPU: 0 PID: 561 Comm: grep Not tainted 4.17.0 #1
Hardware name: Cadence CSP (DT)
Call trace:
 dump_backtrace+0x0/0x198
 show_stack+0x14/0x20
 dump_stack+0x8c/0xac
 __schedule_bug+0x6c/0xb8
 __schedule+0x570/0x5d8
 schedule+0x34/0x98
 schedule_hrtimeout_range_clock+0x98/0x110
 schedule_hrtimeout_range+0x10/0x18
 usleep_range+0x64/0x98
 cdns_spi_fill_tx_fifo+0x70/0xb0
 cdns_spi_irq+0xd0/0xe0
 __handle_irq_event_percpu+0x9c/0x128
 handle_irq_event_percpu+0x34/0x88
 handle_irq_event+0x48/0x78
 handle_fasteoi_irq+0xbc/0x1b0
 generic_handle_irq+0x24/0x38
 __handle_domain_irq+0x84/0xf8
 gic_handle_irq+0xc4/0x180

This patch replaces the function call with udelay() which can be
used in an atomic context, like an interrupt.

Signed-off-by: Jan Kotas <jank@cadence.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-cadence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index f3dad6fcdc35..a568f35522f9 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -319,7 +319,7 @@ static void cdns_spi_fill_tx_fifo(struct cdns_spi *xspi)
 		 */
 		if (cdns_spi_read(xspi, CDNS_SPI_ISR) &
 		    CDNS_SPI_IXR_TXFULL)
-			usleep_range(10, 20);
+			udelay(10);
 
 		if (xspi->txbuf)
 			cdns_spi_write(xspi, CDNS_SPI_TXD, *xspi->txbuf++);
-- 
2.17.1
