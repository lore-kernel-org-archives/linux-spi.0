From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: use sg_next for walking through the allocated scatterlist table" to the spi tree
Date: Tue, 22 Nov 2016 17:26:58 +0000
Message-ID: <E1c9EqQ-0005zU-D9@debutante>
References: <1479768603-15583-1-git-send-email-juan.gutierrez@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        juan.gutierrez@nxp.com, yibin.gong@nxp.com, fabio.estevam@nxp.com
To: Juan Gutierrez <juan.gutierrez@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479768603-15583-1-git-send-email-juan.gutierrez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: use sg_next for walking through the allocated scatterlist table

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 8dd4a0163e7315d196e54780591b7426fa78e1fa Mon Sep 17 00:00:00 2001
From: Juan Gutierrez <juan.gutierrez@nxp.com>
Date: Mon, 21 Nov 2016 16:50:03 -0600
Subject: [PATCH] spi: use sg_next for walking through the allocated
 scatterlist table

A null dereference or Oops exception might occurs when reading at once the
whole content of an spi-nor of big enough size that requires an scatterlist
table that does not fit into one single page.

The spi_map_buf function is ignoring the chained sg case by dereferenceing
the scatterlist elements in an array fashion. This wrongly assumes that
the allocation of the scatterlist elements are contiguous. This is true as
long as the scatterlist table fits within a PAGE_SIZE. However, for
allocation where the scatter table is bigger than that, the pages allocated
by sg_alloc might not be contigous.

The sg table can be properly walked by sg_next instead of using an array.

Signed-off-by: Juan Gutierrez <juan.gutierrez@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5787b723b593..2cfe67f73476 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -720,6 +720,7 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 	int desc_len;
 	int sgs;
 	struct page *vm_page;
+	struct scatterlist *sg;
 	void *sg_buf;
 	size_t min;
 	int i, ret;
@@ -738,6 +739,7 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 	if (ret != 0)
 		return ret;
 
+	sg = &sgt->sgl[0];
 	for (i = 0; i < sgs; i++) {
 
 		if (vmalloced_buf || kmap_buf) {
@@ -751,16 +753,17 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 				sg_free_table(sgt);
 				return -ENOMEM;
 			}
-			sg_set_page(&sgt->sgl[i], vm_page,
+			sg_set_page(sg, vm_page,
 				    min, offset_in_page(buf));
 		} else {
 			min = min_t(size_t, len, desc_len);
 			sg_buf = buf;
-			sg_set_buf(&sgt->sgl[i], sg_buf, min);
+			sg_set_buf(sg, sg_buf, min);
 		}
 
 		buf += min;
 		len -= min;
+		sg = sg_next(sg);
 	}
 
 	ret = dma_map_sg(dev, sgt->sgl, sgt->nents, dir);
-- 
2.10.2
