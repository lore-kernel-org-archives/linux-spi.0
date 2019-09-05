From: Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 4/4] spi: spi-fsl-dspi: Always use the TCFQ devices in poll mode
Date: Thu,  5 Sep 2019 04:01:14 +0300
Message-ID: <20190905010114.26718-5-olteanv@gmail.com>
References: <20190905010114.26718-1-olteanv@gmail.com>
Cc: linux-spi@vger.kernel.org, netdev@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
To: broonie@kernel.org, h.feurstein@gmail.com, mlichvar@redhat.com,
        richardcochran@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190905010114.26718-1-olteanv@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

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
---
Changes in v2:
- None.

 drivers/spi/spi-fsl-dspi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 7caea2da4397..c30325faa050 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -716,7 +716,7 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
 	regmap_write(dspi->regmap, SPI_SR, spi_sr);
 
-	if (!(spi_sr & (SPI_SR_EOQF | SPI_SR_TCFQF)))
+	if (!(spi_sr & SPI_SR_EOQF))
 		return IRQ_NONE;
 
 	if (dspi_rxtx(dspi) == 0) {
@@ -1126,6 +1126,9 @@ static int dspi_probe(struct platform_device *pdev)
 
 	dspi_init(dspi);
 
+	if (dspi->devtype_data->trans_mode == DSPI_TCFQ_MODE)
+		goto poll_mode;
+
 	dspi->irq = platform_get_irq(pdev, 0);
 	if (dspi->irq <= 0) {
 		dev_info(&pdev->dev,
-- 
2.17.1
