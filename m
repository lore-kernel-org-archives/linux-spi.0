From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 10/12] spi: spi-fsl-dspi: account for const type of of_device_id.data
Date: Tue,  2 Jan 2018 14:28:06 +0100
Message-ID: <1514899688-27844-11-git-send-email-Julia.Lawall@lip6.fr>
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This driver creates a number of const structures that it stores in the
data field of an of_device_id array.

The data field of an of_device_id structure has type const void *, so
there is no need for a const-discarding cast when putting const values
into such a structure.

Done using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/spi/spi-fsl-dspi.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 02d3ed7..0630962 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -903,10 +903,9 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 }
 
 static const struct of_device_id fsl_dspi_dt_ids[] = {
-	{ .compatible = "fsl,vf610-dspi", .data = (void *)&vf610_data, },
-	{ .compatible = "fsl,ls1021a-v1.0-dspi",
-		.data = (void *)&ls1021a_v1_data, },
-	{ .compatible = "fsl,ls2085a-dspi", .data = (void *)&ls2085a_data, },
+	{ .compatible = "fsl,vf610-dspi", .data = &vf610_data, },
+	{ .compatible = "fsl,ls1021a-v1.0-dspi", .data = &ls1021a_v1_data, },
+	{ .compatible = "fsl,ls2085a-dspi", .data = &ls2085a_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_dspi_dt_ids);
