Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8B0385D96;
	Wed,  5 Aug 2026 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942937; cv=none; b=RGEb3XBMQxHsnX7G0bsG22qp+nFRAYJb1SH76dqgcgjWoDeGtkwarI8IAftMSg91KKbr9mxoyzr/9bUtPp6iCXkdbzSVKPKazPdJPSODCvt2ZIJGIELRAISJYIOIWQNDe0LzkwPoSWfS0FaIAoXJM3GTVLBUzJowcjZeLucgoHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942937; c=relaxed/simple;
	bh=sWqg2miyxhKcQbMo4qn/4ZhbbzkPvSAAemgAgall708=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9Ghl4HwTahQiH5bcUEZfZEtUZuWlWNiGwnPt8xtOv/euq9gtOglU1PF0D1GQ1OOl2AiQpUnc8pCgkb13PlhQ/l1u7QVBRxiH6ho9Hxm0BNmBu3vs0wXJy8cLP/MGRt2O7KjGU3yiriaEVRrKjqw9z8OAmFiF0dwnKN8WVo3HpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CXhuuMNP; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CXhuuMNP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Wu
	bxkFpTcFAJiLLjpbs1C7VMK6M2WQSz1T0tlTgSueI=; b=CXhuuMNPNzTSOGZjZY
	ZdHGfFbpwCLgN92ON5VJS9Eo6O9ZdQCMsWq2WMkqfUVptFc5iZAelGpAl2sSXvnQ
	BtwCrsVqv5u5nCth0hHdjwSSyfbzuYRCizhca958J8FKspnkEEAQoL9wK//VuuhC
	pU759TKiscp36go+gcQyDfVXQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3H31xU3Nq02g5AA--.30422S4;
	Wed, 05 Aug 2026 23:15:02 +0800 (CST)
From: Honghui Jiang <jiang_hh2019@163.com>
To: broonie@kernel.org
Cc: andy@kernel.org,
	andriy.shevchenko@linux.intel.com,
	fancer.lancer@gmail.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Honghui Jiang <jiang_hh2019@163.com>
Subject: [PATCH 2/2] spi: Add KUnit coverage for DMA mapping error paths
Date: Wed,  5 Aug 2026 23:14:56 +0800
Message-ID: <20260805151456.756579-3-jiang_hh2019@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805151456.756579-1-jiang_hh2019@163.com>
References: <20260805151456.756579-1-jiang_hh2019@163.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H31xU3Nq02g5AA--.30422S4
X-Coremail-Antispam: 1Uf129KBjvAXoWfGF1rGw4DuF4ftr15Gw18Grg_yoW8GF1UAo
	W2gF43Jw4rWryxGFZrJr1kGFya9a1v9Fs8Zr4kArs8Za4xtrWaqr1xJa43uF9IqF1fCF97
	Gas5t347XFs0qF1fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTippBDDUUUU
X-CM-SenderInfo: xmld0whbkkjiirz6il2tof0z/xtbC9RZpqWpzU3Y4ewAA3c

Add KUnit tests for the __spi_map_msg() error paths.  The tests verify
that mappings created before a later TX or RX failure are unwound, their
flags are cleared, and cur_{tx,rx}_dma_dev point to the device used for
the mapping.

Include the tests from spi.c so they can call the static mapping helpers
without adding test hooks to the production path.  A zero-length
transfer makes SG allocation fail with -EINVAL, providing deterministic
failure injection without additional fault-injection support.

Two guard cases cover successful map/unmap and a message which requires
no mapping.

Run the tests with:

  ./tools/testing/kunit/kunit.py run --arch=x86_64 \
      --kunitconfig=drivers/spi/.kunitconfig 'spi_core_error_path*'

Signed-off-by: Honghui Jiang <jiang_hh2019@163.com>
---
 drivers/spi/.kunitconfig      |   4 +
 drivers/spi/Kconfig           |  11 ++
 drivers/spi/spi.c             |   4 +
 drivers/spi/tests/spi_kunit.c | 301 ++++++++++++++++++++++++++++++++++
 4 files changed, 320 insertions(+)
 create mode 100644 drivers/spi/.kunitconfig
 create mode 100644 drivers/spi/tests/spi_kunit.c

diff --git a/drivers/spi/.kunitconfig b/drivers/spi/.kunitconfig
new file mode 100644
index 000000000..4f88fe164
--- /dev/null
+++ b/drivers/spi/.kunitconfig
@@ -0,0 +1,4 @@
+CONFIG_KUNIT=y
+CONFIG_SPI=y
+CONFIG_SPI_MASTER=y
+CONFIG_SPI_KUNIT_TEST=y
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 8782514bb..96351a4dc 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -48,6 +48,17 @@ config SPI_MASTER
 
 if SPI_MASTER
 
+config SPI_KUNIT_TEST
+	bool "KUnit tests for the SPI core" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y && HAS_DMA
+	default KUNIT_ALL_TESTS
+	help
+	  Run the SPI core's KUnit tests, covering the DMA mapping error
+	  paths of the message map/unmap state machine.
+
+	  If unsure say N.
+
+
 config SPI_MEM
 	bool "SPI memory extension"
 	help
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 05a852494..42e337c54 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -5146,3 +5146,7 @@ static int __init spi_init(void)
  * include needing to have boardinfo data structures be much more public.
  */
 postcore_initcall(spi_init);
+
+#ifdef CONFIG_SPI_KUNIT_TEST
+#include "tests/spi_kunit.c"
+#endif
diff --git a/drivers/spi/tests/spi_kunit.c b/drivers/spi/tests/spi_kunit.c
new file mode 100644
index 000000000..7a7e9e932
--- /dev/null
+++ b/drivers/spi/tests/spi_kunit.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for the SPI core DMA mapping error paths.
+ *
+ * Included from spi.c so the tests can drive the static
+ * __spi_map_msg()/__spi_unmap_msg() state machine directly, without adding
+ * any indirection to the production mapping path.  Same arrangement as
+ * drivers/scsi/scsi_lib.c and lib/kunit/executor.c.
+ *
+ * The invariant under test:
+ *
+ *   When __spi_map_msg() returns an error, no transfer in the message may
+ *   still claim a DMA mapping.  Any transfer that was mapped before the
+ *   failure must have an empty SG table and a cleared *_sg_mapped flag.
+ *   ctlr->cur_{tx,rx}_dma_dev must identify the device used for this map,
+ *   rather than a device retained from an earlier message.
+ *
+ * That invariant is what makes the subsequent
+ * spi_finalize_current_message() -> spi_unmap_msg() -> __spi_unmap_msg()
+ * pass a no-op.  Without it, __spi_unmap_msg() unmaps again using
+ * ctlr->cur_{tx,rx}_dma_dev, which __spi_map_msg() only publishes after the
+ * whole loop succeeds -- so it is NULL on the controller's first
+ * DMA-mapped message.  dma_unmap_sg_attrs() dereferences that device before
+ * it ever looks at nents, so the second unmap is a NULL dereference
+ * regardless of the sgt having been emptied.
+ *
+ * How the failure is injected: a transfer with len == 0 makes
+ * spi_map_buf_attrs() compute sgs = DIV_ROUND_UP(0, desc_len) = 0, and
+ * __sg_alloc_table() rejects nents == 0 with -EINVAL.  That is instant,
+ * arch-independent and warning-free.  It is a test artifice standing in for
+ * any real map failure (-ENOMEM from sg_alloc_table(), -EIO from swiotlb
+ * exhaustion, -EINVAL from an unmappable buffer); the core's error handling
+ * does not depend on which one occurred.
+ */
+
+#include <kunit/device.h>
+#include <kunit/test.h>
+
+#define SPI_TEST_LEN		256
+#define SPI_TEST_XFERS		2
+
+struct spi_test_ctx {
+	struct spi_controller	*ctlr;
+	struct spi_device	*spi;
+	struct device		*dma_dev;
+	struct device		*stale_dma_dev;
+	struct spi_transfer	xfer[SPI_TEST_XFERS];
+	struct spi_message	msg;
+	void			*buf[SPI_TEST_XFERS * 2];
+};
+
+static bool spi_test_can_dma(struct spi_controller *ctlr,
+			     struct spi_device *spi,
+			     struct spi_transfer *xfer)
+{
+	/* Opt every transfer into the core DMA mapping path. */
+	return true;
+}
+
+/*
+ * A bare kzalloc'd controller is enough: __spi_map_msg() and
+ * __spi_unmap_msg() only touch can_dma, dma_tx, dma_rx, dma_map_dev,
+ * max_dma_len and cur_*_dma_dev.  Leaving dma_tx/dma_rx NULL makes both
+ * directions resolve to dma_map_dev, so there is no need to fake dmaengine
+ * channels, and ctlr->dev is never dereferenced.  Skipping
+ * spi_alloc_host()/spi_register_controller() keeps the fixture free of
+ * device and queue lifecycle.
+ */
+static struct spi_test_ctx *spi_test_ctx_new(struct kunit *test)
+{
+	struct spi_test_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	ctx->dma_dev = kunit_device_register(test, "spi-core-error-path");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->dma_dev);
+	ctx->stale_dma_dev =
+		kunit_device_register(test, "spi-core-stale-dma-device");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->stale_dma_dev);
+
+	/* Real masks keep either device safe if a failing assertion aborts. */
+	KUNIT_ASSERT_EQ(test, 0,
+			dma_coerce_mask_and_coherent(ctx->dma_dev,
+						     DMA_BIT_MASK(64)));
+	KUNIT_ASSERT_EQ(test, 0,
+			dma_coerce_mask_and_coherent(ctx->stale_dma_dev,
+						     DMA_BIT_MASK(64)));
+
+	ctx->ctlr = kunit_kzalloc(test, sizeof(*ctx->ctlr), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->ctlr);
+
+	ctx->spi = kunit_kzalloc(test, sizeof(*ctx->spi), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->spi);
+
+	ctx->ctlr->can_dma = spi_test_can_dma;
+	ctx->ctlr->dma_map_dev = ctx->dma_dev;
+	/* spi_register_controller() would do this; we are not registering. */
+	ctx->ctlr->max_dma_len = INT_MAX;
+
+	ctx->spi->controller = ctx->ctlr;
+	spi_message_init(&ctx->msg);
+	ctx->msg.spi = ctx->spi;
+
+	return ctx;
+}
+
+static void *spi_test_buf(struct kunit *test, struct spi_test_ctx *ctx,
+			  unsigned int slot)
+{
+	KUNIT_ASSERT_LT(test, slot, ARRAY_SIZE(ctx->buf));
+
+	ctx->buf[slot] = kunit_kzalloc(test, SPI_TEST_LEN, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->buf[slot]);
+
+	return ctx->buf[slot];
+}
+
+/*
+ * Pin cur_*_dma_dev to a different valid device before the failing map.  This
+ * emulates state retained from an earlier message and lets the test verify
+ * that __spi_map_msg() publishes the device which owns the new mappings.
+ * It also keeps an unfixed tree from dereferencing NULL while reporting the
+ * regression.  ASSERTs abort the case before cleanup can use the stale device.
+ */
+static void spi_test_pin_stale_dma_devs(struct spi_test_ctx *ctx)
+{
+	ctx->ctlr->cur_tx_dma_dev = ctx->stale_dma_dev;
+	ctx->ctlr->cur_rx_dma_dev = ctx->stale_dma_dev;
+}
+
+static void spi_test_assert_dma_devs_published(struct kunit *test,
+					       struct spi_test_ctx *ctx)
+{
+	KUNIT_ASSERT_PTR_EQ(test, ctx->ctlr->cur_tx_dma_dev, ctx->dma_dev);
+	KUNIT_ASSERT_PTR_EQ(test, ctx->ctlr->cur_rx_dma_dev, ctx->dma_dev);
+}
+
+static void spi_test_assert_nothing_mapped(struct kunit *test,
+					   struct spi_test_ctx *ctx,
+					   unsigned int nr_xfers)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr_xfers; i++) {
+		KUNIT_ASSERT_FALSE_MSG(test, ctx->xfer[i].tx_sg_mapped,
+				       "xfer[%u] still claims a TX mapping after __spi_map_msg() failed",
+				       i);
+		KUNIT_ASSERT_FALSE_MSG(test, ctx->xfer[i].rx_sg_mapped,
+				       "xfer[%u] still claims an RX mapping after __spi_map_msg() failed",
+				       i);
+		KUNIT_EXPECT_PTR_EQ(test, ctx->xfer[i].tx_sg.sgl, NULL);
+		KUNIT_EXPECT_EQ(test, ctx->xfer[i].tx_sg.orig_nents, 0U);
+		KUNIT_EXPECT_EQ(test, ctx->xfer[i].tx_sg.nents, 0U);
+		KUNIT_EXPECT_PTR_EQ(test, ctx->xfer[i].rx_sg.sgl, NULL);
+		KUNIT_EXPECT_EQ(test, ctx->xfer[i].rx_sg.orig_nents, 0U);
+		KUNIT_EXPECT_EQ(test, ctx->xfer[i].rx_sg.nents, 0U);
+	}
+}
+
+/*
+ * xfer0 maps TX and RX; xfer1's TX map fails.
+ *
+ * This exits __spi_map_msg() through the bare `return ret` after the TX
+ * spi_map_buf_attrs() call, which has no rollback code at all -- not even
+ * the ad-hoc one the RX branch has.  xfer0 is left fully mapped with both
+ * flags set and cur_*_dma_dev unpublished.
+ *
+ * This is the deterministic real-world shape: a driver whose second transfer
+ * hands over a buffer the core cannot map (e.g. a static const payload table
+ * after a kmalloc'd command byte) hits it with no memory pressure at all.
+ */
+static void spi_later_tx_fail_rolls_back_earlier(struct kunit *test)
+{
+	struct spi_test_ctx *ctx = spi_test_ctx_new(test);
+	int ret;
+
+	ctx->xfer[0].tx_buf = spi_test_buf(test, ctx, 0);
+	ctx->xfer[0].rx_buf = spi_test_buf(test, ctx, 1);
+	ctx->xfer[0].len = SPI_TEST_LEN;
+
+	ctx->xfer[1].tx_buf = spi_test_buf(test, ctx, 2);
+	ctx->xfer[1].rx_buf = NULL;
+	ctx->xfer[1].len = 0;			/* forces -EINVAL */
+
+	spi_message_add_tail(&ctx->xfer[0], &ctx->msg);
+	spi_message_add_tail(&ctx->xfer[1], &ctx->msg);
+
+	spi_test_pin_stale_dma_devs(ctx);
+
+	ret = __spi_map_msg(ctx->ctlr, &ctx->msg);
+	KUNIT_ASSERT_EQ(test, ret, -EINVAL);
+
+	spi_test_assert_dma_devs_published(test, ctx);
+	spi_test_assert_nothing_mapped(test, ctx, SPI_TEST_XFERS);
+
+	/* Only reached once the invariant holds: cleanup must be a no-op. */
+	KUNIT_EXPECT_EQ(test, 0, __spi_unmap_msg(ctx->ctlr, &ctx->msg));
+}
+
+/*
+ * xfer0 maps TX and RX; the RX-only xfer1 then fails to map.
+ *
+ * The old RX failure branch attempts to unmap xfer1's never-mapped TX table,
+ * then returns without rolling back xfer0 or publishing cur_*_dma_dev.
+ */
+static void spi_later_rx_fail_rolls_back_earlier(struct kunit *test)
+{
+	struct spi_test_ctx *ctx = spi_test_ctx_new(test);
+	int ret;
+
+	ctx->xfer[0].tx_buf = spi_test_buf(test, ctx, 0);
+	ctx->xfer[0].rx_buf = spi_test_buf(test, ctx, 1);
+	ctx->xfer[0].len = SPI_TEST_LEN;
+
+	ctx->xfer[1].tx_buf = NULL;
+	ctx->xfer[1].rx_buf = spi_test_buf(test, ctx, 2);
+	ctx->xfer[1].len = 0;			/* forces -EINVAL */
+
+	spi_message_add_tail(&ctx->xfer[0], &ctx->msg);
+	spi_message_add_tail(&ctx->xfer[1], &ctx->msg);
+
+	spi_test_pin_stale_dma_devs(ctx);
+
+	ret = __spi_map_msg(ctx->ctlr, &ctx->msg);
+	KUNIT_ASSERT_EQ(test, ret, -EINVAL);
+
+	spi_test_assert_dma_devs_published(test, ctx);
+	spi_test_assert_nothing_mapped(test, ctx, SPI_TEST_XFERS);
+
+	KUNIT_EXPECT_EQ(test, 0, __spi_unmap_msg(ctx->ctlr, &ctx->msg));
+}
+
+/*
+ * Happy-path guard, so a fix that unwinds too eagerly cannot pass: a fully
+ * mappable message must still map both directions, publish both devices, and
+ * unmap cleanly.
+ */
+static void spi_map_success_publishes_dma_devs(struct kunit *test)
+{
+	struct spi_test_ctx *ctx = spi_test_ctx_new(test);
+	int ret;
+
+	ctx->xfer[0].tx_buf = spi_test_buf(test, ctx, 0);
+	ctx->xfer[0].rx_buf = spi_test_buf(test, ctx, 1);
+	ctx->xfer[0].len = SPI_TEST_LEN;
+
+	spi_message_add_tail(&ctx->xfer[0], &ctx->msg);
+
+	ret = __spi_map_msg(ctx->ctlr, &ctx->msg);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_TRUE(test, ctx->xfer[0].tx_sg_mapped);
+	KUNIT_EXPECT_TRUE(test, ctx->xfer[0].rx_sg_mapped);
+	KUNIT_EXPECT_PTR_EQ(test, ctx->ctlr->cur_tx_dma_dev, ctx->dma_dev);
+	KUNIT_EXPECT_PTR_EQ(test, ctx->ctlr->cur_rx_dma_dev, ctx->dma_dev);
+
+	KUNIT_EXPECT_EQ(test, 0, __spi_unmap_msg(ctx->ctlr, &ctx->msg));
+
+	KUNIT_EXPECT_FALSE(test, ctx->xfer[0].tx_sg_mapped);
+	KUNIT_EXPECT_FALSE(test, ctx->xfer[0].rx_sg_mapped);
+	KUNIT_EXPECT_PTR_EQ(test, ctx->xfer[0].tx_sg.sgl, NULL);
+	KUNIT_EXPECT_PTR_EQ(test, ctx->xfer[0].rx_sg.sgl, NULL);
+}
+
+/*
+ * The "no transfer has been mapped, bail out with success" path: a message
+ * whose only transfer has neither buffer maps nothing and must still return
+ * success with no flags set.
+ */
+static void spi_map_nothing_is_success(struct kunit *test)
+{
+	struct spi_test_ctx *ctx = spi_test_ctx_new(test);
+	int ret;
+
+	ctx->xfer[0].tx_buf = NULL;
+	ctx->xfer[0].rx_buf = NULL;
+	ctx->xfer[0].len = SPI_TEST_LEN;
+
+	spi_message_add_tail(&ctx->xfer[0], &ctx->msg);
+
+	ret = __spi_map_msg(ctx->ctlr, &ctx->msg);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	spi_test_assert_nothing_mapped(test, ctx, 1);
+}
+
+static struct kunit_case spi_core_error_path_cases[] = {
+	KUNIT_CASE(spi_later_tx_fail_rolls_back_earlier),
+	KUNIT_CASE(spi_later_rx_fail_rolls_back_earlier),
+	KUNIT_CASE(spi_map_success_publishes_dma_devs),
+	KUNIT_CASE(spi_map_nothing_is_success),
+	{}
+};
+
+static struct kunit_suite spi_core_error_path_suite = {
+	.name = "spi_core_error_path",
+	.test_cases = spi_core_error_path_cases,
+};
+
+kunit_test_suite(spi_core_error_path_suite);
-- 
2.43.0

