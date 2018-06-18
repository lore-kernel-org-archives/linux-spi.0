From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.14 116/189] spi: bcm2835aux: ensure interrupts are enabled for shared handler
Date: Mon, 18 Jun 2018 10:13:32 +0200
Message-ID: <20180618081213.916723840@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Graf <agraf@suse.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
To: linux-kernel@vger.kernel.org
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring <robh@kernel.org>

[ Upstream commit bc519d9574618e47a0c788000fb78da95e18d953 ]

The BCM2835 AUX SPI has a shared interrupt line (with AUX UART).
Downstream fixes this with an AUX irqchip to demux the IRQ sources and a
DT change which breaks compatibility with older kernels. The AUX irqchip
was already rejected for upstream[1] and the DT change would break
working systems if the DTB is updated to a newer one. The latter issue
was brought to my attention by Alex Graf.

The root cause however is a bug in the shared handler. Shared handlers
must check that interrupts are actually enabled before servicing the
interrupt. Add a check that the TXEMPTY or IDLE interrupts are enabled.

[1] https://patchwork.kernel.org/patch/9781221/

Cc: Alexander Graf <agraf@suse.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Eric Anholt <eric@anholt.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-spi@vger.kernel.org
Cc: linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-bcm2835aux.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -184,6 +184,11 @@ static irqreturn_t bcm2835aux_spi_interr
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
 	irqreturn_t ret = IRQ_NONE;
 
+	/* IRQ may be shared, so return if our interrupts are disabled */
+	if (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_CNTL1) &
+	      (BCM2835_AUX_SPI_CNTL1_TXEMPTY | BCM2835_AUX_SPI_CNTL1_IDLE)))
+		return ret;
+
 	/* check if we have data to read */
 	while (bs->rx_len &&
 	       (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT) &
