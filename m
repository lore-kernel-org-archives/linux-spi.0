From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH 11/15] spi: img-spfi: Set device select bits for SPFI port state
Date: Sun, 22 Jul 2018 23:20:06 +0200
Message-ID: <20180722212010.3979-12-afaerber@suse.de>
References: <20180722212010.3979-1-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@imgtec.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: linux-mips@linux-mips.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180722212010.3979-1-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Ionela Voinescu <ionela.voinescu@imgtec.com>

Even if the chip select line is not controlled by the SPFI
hardware, the device select bits need to be set to specify
the chip select line in use for the hardware to know what
parameters to use for the current transfer.

Signed-off-by: Ionela Voinescu <ionela.voinescu@imgtec.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/spi/spi-img-spfi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index c845a505bae6..0d73d31a6a2b 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -438,6 +438,9 @@ static int img_spfi_prepare(struct spi_master *master, struct spi_message *msg)
 	u32 val;
 
 	val = spfi_readl(spfi, SPFI_PORT_STATE);
+	val &= ~(SPFI_PORT_STATE_DEV_SEL_MASK <<
+		 SPFI_PORT_STATE_DEV_SEL_SHIFT);
+	val |= msg->spi->chip_select << SPFI_PORT_STATE_DEV_SEL_SHIFT;
 	if (msg->spi->mode & SPI_CPHA)
 		val |= SPFI_PORT_STATE_CK_PHASE(msg->spi->chip_select);
 	else
-- 
2.16.4
