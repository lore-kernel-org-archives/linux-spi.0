From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Always use the TCFQ devices in poll mode" to the spi tree
Date: Tue,  8 Oct 2019 11:52:54 +0100 (BST)
Message-ID: <20191008105254.171C22742998@ypsilon.sirena.org.uk>
References: <20190905010114.26718-5-olteanv@gmail.com>
Cc: andrew@lunn.ch, broonie@kernel.org, f.fainelli@gmail.com,
        h.feurstein@gmail.com, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, mlichvar@redhat.com,
        netdev@vger.kernel.org, richardcochran@gmail.com
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190905010114.26718-5-olteanv@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-fsl-dspi: Always use the TCFQ devices in poll mode

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

>From 5d2af8bcd4939d0f3d5061cc3b7783fd26311828 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <olteanv@gmail.com>
Date: Thu, 5 Sep 2019 04:01:14 +0300
Subject: [PATCH] spi: spi-fsl-dspi: Always use the TCFQ devices in poll mode

With this patch, the "interrupts" property from the device tree bindings
is ignored, even if present, if the driver runs in TCFQ mode.

Switching to using the DSPI in poll mode has several distinct
benefits:

- With interrupts, the DSPI driver in TCFQ mode raises an IRQ after each
  transmitted word. There is more time wasted for the "waitq" event than
  for actual I/O. And the DSPI IRQ count can easily get the largest in
  /proc/interrupts on Freescale boards with attached SPI devices.

- The SPI I/O time is both lower, and more consistently so. Attached to
  some Freescale devices are either PTP switches, or SPI RTCs. For
  reading time off of a SPI slave device, it is important that all SPI
  transfers take a deterministic time to complete.

- In poll mode there is much less time spent by the CPU in hardirq
  context, which helps with the response latency of the system, and at
  the same time there is more control over when interrupts must be
  disabled (to get a precise timestamp measurement): win-win.

On the LS1021A-TSN board, where the SPI device is a SJA1105 PTP switch
(with a bits_per_word=8 driver), I created a "benchmark" where I read
its PTP time once per second, for 120 seconds. Each "read PTP time" is a
12-byte SPI transfer. I then recorded the time before putting the first
byte in the TX FIFO, and the time after reading the last byte from the
RX FIFO. That is the transfer delay in nanoseconds.

Interrupt mode:

  delay: min 125120 max 168320 mean 150286 std dev 17675.3

Poll mode:

  delay: min 69440 max 119040 mean 70312.9 std dev 8065.34

Both the mean latency and the standard deviation are more than 50% lower
in poll mode than in interrupt mode. This is with an 'ondemand' governor
on an otherwise idle system - therefore running mostly at 600 MHz out of
a max of 1200 MHz.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://lore.kernel.org/r/20190905010114.26718-5-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index bec758e978fb..7bb018eb67d0 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -707,7 +707,7 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
 	regmap_write(dspi->regmap, SPI_SR, spi_sr);
 
-	if (!(spi_sr & (SPI_SR_EOQF | SPI_SR_TCFQF)))
+	if (!(spi_sr & SPI_SR_EOQF))
 		return IRQ_NONE;
 
 	if (dspi_rxtx(dspi) == 0) {
@@ -1114,6 +1114,9 @@ static int dspi_probe(struct platform_device *pdev)
 
 	dspi_init(dspi);
 
+	if (dspi->devtype_data->trans_mode == DSPI_TCFQ_MODE)
+		goto poll_mode;
+
 	dspi->irq = platform_get_irq(pdev, 0);
 	if (dspi->irq <= 0) {
 		dev_info(&pdev->dev,
-- 
2.20.1
