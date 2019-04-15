From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V3 5/9] spi: export spi core function spi_set_cs
Date: Mon, 15 Apr 2019 14:30:30 -0700
Message-ID: <1555363834-32155-6-git-send-email-skomatineni@nvidia.com>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch exports spi_set_cs of the spi core to allow SPI masters
to use when gpio based chip select is needed.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi.c       | 3 ++-
 include/linux/spi/spi.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 59b1e57cae74..fa70e595f17a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -773,7 +773,7 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
 
 /*-------------------------------------------------------------------------*/
 
-static void spi_set_cs(struct spi_device *spi, bool enable)
+void spi_set_cs(struct spi_device *spi, bool enable)
 {
 	if (spi->mode & SPI_CS_HIGH)
 		enable = !enable;
@@ -801,6 +801,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 		spi->controller->set_cs(spi, !enable);
 	}
 }
+EXPORT_SYMBOL_GPL(spi_set_cs);
 
 #ifdef CONFIG_HAS_DMA
 int spi_map_buf(struct spi_controller *ctlr, struct device *dev,
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index fc4d21b4c2e4..c7ca95f26725 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -973,6 +973,7 @@ extern int spi_async(struct spi_device *spi, struct spi_message *message);
 extern int spi_async_locked(struct spi_device *spi,
 			    struct spi_message *message);
 extern int spi_slave_abort(struct spi_device *spi);
+extern void spi_set_cs(struct spi_device *spi, bool enable);
 
 static inline size_t
 spi_max_message_size(struct spi_device *spi)
-- 
2.7.4
