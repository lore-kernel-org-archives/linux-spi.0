Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794037263;
	b=Ox3WhSowgO1dnLCwM3zIjKuQ6X3OuzRs0ZfonF3WBxwRXK2XDHW5sy6Ry19L6jE5VG0D
	 vQaLSaPqgmfWGtTpdAJrh96GoJTQXBT55kxxaHp9vvVPFWVoRavhMErVBz2cRS6aC8vMn
	 rdpMdpgPnMucOIC0AY/wD7hXWxhXHvkVgZph63P+qXRnI5dYcf2D2GWlU4DrahooKXUzH
	 F5AVgfMtMQ087cz97OHZc0dCpWfS5f3XBo3rcMhEpD1isfo+eYjuBMScvnYtK9KdbQtul
	 qtqCSk8iR2TbLAugT76/X/Q8bC3Y6UZ4+dsoW0l0JWah1flaZFi0XiE1QBnlTOH/4kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794037263;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=m4WdsZ+dd9CjNuD0qnEVVIzMdiUI1dVj2Pcrp2Tms3s=;
	b=WID7YM4EsgD0Z3IqFzwKOdnMEso1t87qZluBqYJPiSYixz808L/48VcYTYY2mTaAEFWm
	 1JKXaDhU/aUCzGzCy63ans8QXfPlSrHIg0+LMFL9alYuQvLf9M7UbaOtLiGJRe2macTEQ
	 5IrtHhaIbQ2jzK8JcjSfRLk2d2EYdoM5fl2erv29qtjIeUIHcBgKIK07BVh0m7apZL3k1
	 YCoqA22t4+Rju1LsGtbvwefcPMBWxtGCB3pFvWUqCj7KELqyOezA2/2LVnj4eol6IODzg
	 Pbdvtwlub4UercqdMqbiPR1FNu0ln8XGwmQYyqcJD+ZIkf626SFZXnlFtHwo6kKsrRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OW6VrksQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4477B606A330;
	Sat,  7 Nov 2026 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OW6VrksQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B1E1F0089F;
	Sat,  7 Nov 2026 07:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794037263;
	bh=m4WdsZ+dd9CjNuD0qnEVVIzMdiUI1dVj2Pcrp2Tms3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OW6VrksQXOjGUDXro8BF5YBSyqC8MlsCfpd56vuTQtlfniOZOgM6mCKxaE7diaWFE
	 RYG6pqq96YAs3Vgn888EmXaYSdXztexHP30hL9BgqBeJTnKYy/UNuHD9v6JCJANHJ7
	 4b3sQdhW4ltoTdUFg2ghqgyxM09PWNmg75xokF4CFPWW2ASIDR2aDPex2NHZwVVDvD
	 ixBGETX/DurL5v2AtzKL0ShhmO27X1lIqpKiU2Sf7tf0Wc7wVpqj4hcskznxKl9Gwz
	 i/UlVii6cTyshrnzLujLFahQDEL+2QvuFBrWBm+d1sw8W27uCSZ9JEnLVKMdl8b9Ke
	 M174WzqqcDBVQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Fei Xie <fei.xie@horizon.auto>
Subject: [PATCH 2/3] spi: cadence-xspi: Support dmaengine for sdma io copy
Date: Sat,  7 Nov 2026 15:20:43 +0800
Message-ID: <20261107072044.17574-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107072044.17574-1-jszhang@kernel.org>
References: <20261107072044.17574-1-jszhang@kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

use dmaengine to do sdma io copy, performance improvement depends on
the memcpy dmaengine, maybe significant, maybe trivial, but no matter
the dmaengine performance is powerful or not, the cpu usage is reduced
a lot.

For example, on a dual CA55 platform, test with looping the following
cmd:
dd if=/dev/mtd0 of=/dev/null bs=8192

Before the patch:
cpu usage is nearly 50%, which means one CA55 is full loaded with
the sdma io copy.

After the patch:
cpu usage is between 0 ~ 1%

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-cadence-xspi.c | 139 ++++++++++++++++++++++++++++++++-
 1 file changed, 137 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 3687853e4ce4..d9996ec42edd 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -4,6 +4,8 @@
 
 #include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
@@ -19,12 +21,14 @@
 #include <linux/bitfield.h>
 #include <linux/limits.h>
 #include <linux/log2.h>
+#include <linux/mm.h>
 #include <linux/bitrev.h>
 #include <linux/util_macros.h>
 
 #define CDNS_XSPI_MAGIC_NUM_VALUE	0x6522
 #define CDNS_XSPI_MAX_BANKS		8
 #define CDNS_XSPI_NAME			"cadence-xspi"
+#define CDNS_XSPI_DMA_TIMEOUT_MS		5000
 
 /*
  * Note: below are additional auxiliary registers to
@@ -334,6 +338,10 @@ struct cdns_xspi_dev {
 	int cur_cs;
 	unsigned int sdmasize;
 	unsigned int sdma_xfer_len;
+	struct dma_chan *dma_chan;
+	dma_addr_t dma_addr;
+	struct completion dma_complete;
+	bool dma_error;
 
 	struct completion cmd_complete;
 	struct completion auto_cmd_complete;
@@ -355,6 +363,122 @@ struct cdns_xspi_dev {
 	int current_xfer_qword;
 };
 
+static void cdns_xspi_dma_cleanup(void *data)
+{
+	struct cdns_xspi_dev *cdns_xspi = data;
+
+	dma_unmap_resource(dmaengine_get_dma_device(cdns_xspi->dma_chan),
+			   cdns_xspi->dma_addr, cdns_xspi->sdmasize,
+			   DMA_BIDIRECTIONAL, 0);
+}
+
+static int cdns_xspi_dma_init(struct cdns_xspi_dev *cdns_xspi,
+			      phys_addr_t sdma_phys)
+{
+	struct device *dev = cdns_xspi->dev;
+	struct dma_chan *chan;
+	struct device *dma_dev;
+	dma_addr_t dma_addr;
+
+	/* The Marvell overlay has additional SDMA access-width restrictions. */
+	if (cdns_xspi->driver_data->mrvl_hw_overlay)
+		return 0;
+
+	chan = devm_dma_request_chan(dev, "memcpy");
+	if (IS_ERR(chan)) {
+		if (PTR_ERR(chan) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_dbg(dev, "DMA unavailable, using CPU transfers\n");
+		return 0;
+	}
+	if (!dma_has_cap(DMA_MEMCPY, chan->device->cap_mask)) {
+		dev_dbg(dev, "DMA channel does not support memcpy, using CPU transfers\n");
+		return 0;
+	}
+
+	/* Map the aperture once; only the RAM buffer changes between transfers. */
+	dma_dev = dmaengine_get_dma_device(chan);
+	dma_addr = dma_map_resource(dma_dev, sdma_phys, cdns_xspi->sdmasize,
+				    DMA_BIDIRECTIONAL, 0);
+	if (dma_mapping_error(dma_dev, dma_addr)) {
+		dev_dbg(dev, "Failed to map SDMA aperture, using CPU transfers\n");
+		return 0;
+	}
+
+	cdns_xspi->dma_chan = chan;
+	cdns_xspi->dma_addr = dma_addr;
+	init_completion(&cdns_xspi->dma_complete);
+
+	return devm_add_action_or_reset(dev, cdns_xspi_dma_cleanup, cdns_xspi);
+}
+
+static void cdns_xspi_dma_callback(void *data, const struct dmaengine_result *result)
+{
+	struct cdns_xspi_dev *cdns_xspi = data;
+
+	cdns_xspi->dma_error = result->result != DMA_TRANS_NOERROR || result->residue;
+	complete(&cdns_xspi->dma_complete);
+}
+
+/* -EAGAIN means no DMA was issued, so the caller can use the CPU path. */
+static int cdns_xspi_dma_transfer(struct cdns_xspi_dev *cdns_xspi,
+				  size_t len, bool read)
+{
+	struct dma_chan *chan = cdns_xspi->dma_chan;
+	dma_addr_t port_addr = cdns_xspi->dma_addr;
+	enum dma_data_direction dir = read ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+	void *buf = read ? cdns_xspi->in_buffer : (void *)cdns_xspi->out_buffer;
+	struct dma_async_tx_descriptor *desc;
+	struct device *dma_dev;
+	dma_addr_t buf_addr;
+	dma_cookie_t cookie;
+	int ret = -EAGAIN;
+
+	if (!chan || len < cdns_xspi->dma_data_width ||
+	    len > cdns_xspi->sdmasize || !virt_addr_valid(buf))
+		return -EAGAIN;
+
+	dma_dev = dmaengine_get_dma_device(chan);
+	buf_addr = dma_map_single(dma_dev, buf, len, dir);
+	if (dma_mapping_error(dma_dev, buf_addr))
+		return -EAGAIN;
+	if (!is_dma_copy_aligned(chan->device, port_addr, buf_addr, len))
+		goto unmap;
+
+	desc = dmaengine_prep_dma_memcpy(chan, read ? buf_addr : port_addr,
+					 read ? port_addr : buf_addr, len,
+					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc)
+		goto unmap;
+
+	reinit_completion(&cdns_xspi->dma_complete);
+	cdns_xspi->dma_error = false;
+	desc->callback_result = cdns_xspi_dma_callback;
+	desc->callback_param = cdns_xspi;
+	cookie = dmaengine_submit(desc);
+	if (dma_submit_error(cookie)) {
+		dmaengine_terminate_sync(chan);
+		goto unmap;
+	}
+	dma_async_issue_pending(chan);
+
+	if (!wait_for_completion_timeout(&cdns_xspi->dma_complete,
+					msecs_to_jiffies(CDNS_XSPI_DMA_TIMEOUT_MS))) {
+		dmaengine_terminate_sync(chan);
+		dev_err(cdns_xspi->dev, "SDMA %s DMA timeout\n", read ? "read" : "write");
+		ret = -ETIMEDOUT;
+	} else if (cdns_xspi->dma_error) {
+		dmaengine_terminate_sync(chan);
+		ret = -EIO;
+	} else {
+		ret = 0;
+	}
+
+unmap:
+	dma_unmap_single(dma_dev, buf_addr, len, dir);
+	return ret;
+}
+
 static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 ctrl_stat;
@@ -502,6 +626,7 @@ static int cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 sdma_size, sdma_trd_info;
 	u8 sdma_dir;
+	int ret;
 
 	sdma_size = readl(cdns_xspi->iobase + CDNS_XSPI_SDMA_SIZE_REG);
 	sdma_trd_info = readl(cdns_xspi->iobase + CDNS_XSPI_SDMA_TRD_INFO_REG);
@@ -513,6 +638,10 @@ static int cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 			sdma_size, cdns_xspi->sdma_xfer_len);
 		return -EINVAL;
 	}
+	ret = cdns_xspi_dma_transfer(cdns_xspi, sdma_size,
+				     sdma_dir == CDNS_XSPI_SDMA_DIR_READ);
+	if (ret != -EAGAIN)
+		return ret;
 
 	switch (sdma_dir) {
 	case CDNS_XSPI_SDMA_DIR_READ:
@@ -543,6 +672,8 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE, CDNS_XSPI_WORK_MODE_STIG),
 	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
 
+	reinit_completion(&cdns_xspi->cmd_complete);
+	reinit_completion(&cdns_xspi->sdma_complete);
 	cdns_xspi->set_interrupts_handler(cdns_xspi, true);
 	cdns_xspi->sdma_error = false;
 
@@ -580,9 +711,9 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 			return -EIO;
 		}
 		ret = cdns_xspi->sdma_handler(cdns_xspi);
-		if (ret) {
+		if (ret || cdns_xspi->sdma_error) {
 			cdns_xspi->set_interrupts_handler(cdns_xspi, false);
-			return ret;
+			return ret ?: -EIO;
 		}
 	}
 
@@ -1277,6 +1408,10 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	}
 	cdns_xspi->sdmasize = resource_size(res);
 
+	ret = cdns_xspi_dma_init(cdns_xspi, res->start);
+	if (ret)
+		return ret;
+
 	cdns_xspi->auxbase = devm_platform_ioremap_resource_byname(pdev, "aux");
 	if (IS_ERR(cdns_xspi->auxbase)) {
 		cdns_xspi->auxbase = devm_platform_ioremap_resource(pdev, 2);
-- 
2.55.0

