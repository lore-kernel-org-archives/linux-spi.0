Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637239;
	b=BrqT3qtJlDHKIon52MGFH+ocQvx2wNVPFgArFL6b0ogJr1Vj8qgMJc5MpbGupmwzuZkb
	 GfutHgY+h0tOXoKuL3ORCPi5GDYEw8sO7yVnaFwao5Ga9WNphvYLeAvMt7t62A20kjoEO
	 Q9XeC/j9bjlJEAP928dS5RjXXrIZ1MXK08KW3mkmeWZpadZ023/BghtXckyrOoZw/NgCJ
	 PpOhLGMOyasM4FF16fZPpePmyB/HOqI/ppskYfe+PjsKnuz3cZMnQV4OnMMz13etnhQ7I
	 X9HPOA9JqX5Fwfbkz0hMrKuoMmlhGY2TG1Fbd0zUzj5KJvRxq6cBAzXD2jy7BNX11YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KNJXY6X/EGadzYt3ifYvKvxHMNIVW9Gn2FSPEggKSCU=;
	b=U7/t1KI2Dztryo66aEpSLGxoR2cR2r/L5DeTswdA7S2UGjwNZBUIgWqEzMfNCdUdaw7h
	 dKiJ8qI5y/bjfVlo573ThBvhz5nfrKySsOVWQeKEN4YhE1CSI4Aflx/bOgPp268qsmgO+
	 kVFTkHrEHJL+Bm1e8e8d0ZEfG+NC9BUZjNYmTuCUc0iYPoHitA3pm2pnMHaR5EeYRnotj
	 3Q/DaVG/P+QuKl8/KGLhs7WUtEWAt1vRXRh5ywut7BVdcN2i/IqAhQjvV7WZC4lrWTHG/
	 8FfqVA2V+AUMLQ5wkoyuzovdPX9EPBkj1HjStEsPGctAwHJAYi2NPMv9Gq6sCyICmSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iZrljja3;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945960A0CB2
	for <linux-spi@vger.kernel.org>; Mon,  2 Nov 2026 16:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7945960A0CB2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iZrljja3
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a070781f63so1290299b3a.1
        for <linux-spi@vger.kernel.org>; Mon, 02 Nov 2026 08:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793637239; x=1794242039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KNJXY6X/EGadzYt3ifYvKvxHMNIVW9Gn2FSPEggKSCU=;
        b=iZrljja3aEPYCx2korFUE5CwBWeE+mUXxJS2Bm/GmjjXPmU9yX4R7kIGqn2iuxa+s4
         dWJHrRoTTHSGbxMb5qkv+K37Ebx0nF8fe8WApORJvnRKtgUUsjnBLTvZE8d2ZKhnzPzy
         T04xmjbmckfd0jsfZCrn2Pac21RnFdVMUJd0akmXeYAnJbgGoKkW0nMIlROV8dzD7fEy
         3IpAngC6TuElWX5FcV2/H8O+bTjPzuMo8bJuXiRVNZTrXR0vZUZr6ZNwoCzm06+LyVBm
         ttgz2GpWTsaI6tKt5dPFAUCsziAumcaqM95OIgGKbOhnKF0xEUd/0h0dFlsm6SKzTDqS
         mtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637239; x=1794242039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KNJXY6X/EGadzYt3ifYvKvxHMNIVW9Gn2FSPEggKSCU=;
        b=QX7G6lmeEZheTb+xZtirgS9mT2w7eTPgLOsftMa291WsdJexv4wSHqtkucCmJkYsBn
         c3qDfOPbXGRHno7r8B09sqevrM66dCDAG34OZkG5h7sz+UwMsmVadaKSblzwOcXSGVIC
         fYu3HrVdz7eph8/ImFUS1QGzU9TCo5qm7NMmBFjUuT5U5dBZ51tmceiQQEdwAlWWHZeT
         aKs012muJN81ZFRC7uz4FJYCzl+iEkoc45Wu0DVIVTfcrMzmGi30sN4Dt10f4ePfJ8aJ
         s5v3vL+yCRUn2rIV9xHD4YwwsWgcOod1kBcz1HqEGc4p7jZGLCUXtRUonAl9VCfx9c3n
         d3pA==
X-Forwarded-Encrypted: i=1; AKwUvByC4jjIELZGgjboPaP/VGFx/qf5yxTo33uk+ZzwqEPRE08gdzboVqiTNeptts6FULltitlBfcbJHCM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9lg2YvEQeKFEDUWai80Dbqd6QCR8PLH5sBnfciHbn2cr9LU+Nx
	1Ax3XZvS82PYB2exFvi3d7xGnrqltvBpP3bVe7by81XJx0Da7yJ8DIqc
X-Gm-Gg: AYBFou1Vmj8fxr0hhfhfzXS3LsyMXscMB25SV9Yr/gSvrt3NBTE4AhwLfV87PeVlK9T
	x4lq0VrxB7NP7o1LbVaJiEhiYsfQ+L2ZWa3NEX79aHlNoj04wBkczKcWDwioIKqq9N6ws2hI/Ga
	MyGDyY7Gf5M6gRxCer+zBM/FKSRtGcQaf61gHW5M3XIcb3EX/5dyzNW7uyf/4tjWk2mu/Hix37k
	O9mce998hmje3p1zjrpwAu8quVGlHuuUConi4APy3BqNq1RtyVVNb1jWx55Frgcl51+xGJS341x
	eTg4dOHjgVKVu5y1ryXmZ3JuoDvFkKFh7wFztcj1XjK+CV4kHQ8uOZrGRCENrRdLzGnvHKD6IhV
	YVzzENN4e3YeNZTjrRT/UqusnWD8qND/6/slnEagYXGW+qsSS+pwaDPnpCk3BiW6uszc1F2LwW6
	wTmP7oSGjI89H3yOLLP1+8hpn8qgsuOoVV8PeTBiC6mXUo7Y3/275q/fGman64ZVlFvxsz/F8Eg
	869fuB+/WVGkGOrSQdERddWUA8vN02W72T1AXj6mz++tasm3llZBANIUgj0UJWJ4xSgq68yFUyD
	Xu5wIixYXn/aaAtaxA9PlzyVqcXO7RAhs9u0yFJwSuVrzTqzDopXgb9JIjWLugFY2DsCS4meHe8
	iMWRc1RI1X5aKzVtslV3bWndaH1+Qp2gi9sGyJsHkUXEoU81ALc48AY6hK9FfKfk64a5U7iETCz
	dWD8Z+/+0a0RXJtVtxFSKcdxWSW5WdkQ==
X-Received: by 2002:a05:6a00:2406:b0:89f:d254:7c74 with SMTP id d2e1a72fcca58-8a9bdcc5a22mr8832328b3a.9.1793637238797;
        Mon, 02 Nov 2026 08:33:58 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d4092sm2184549b3a.41.2026.11.02.08.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:33:58 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH 08/14] spi: spi-ti-qspi: add KUnit tests for transfer error finalization
Date: Mon,  2 Nov 2026 16:30:17 +0000
Message-ID: <20261102163023.2574632-9-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
In-Reply-To: <20261102163023.2574632-1-jctchan@gmail.com>
References: <20261102163023.2574632-1-jctchan@gmail.com>
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

From: Joseph CT Chan <josephctchan@google.com>

Add KUnit tests for ti_qspi_start_transfer_one() covering the transfer
error handling path.

On ARCH=um, emulate the TI QSPI controller MMIO via logic_iomem:
- ti_qspi_test: verify that queued and synchronous transfers hitting a
  ti_qspi_poll_wc() write completion timeout complete with -ETIMEDOUT,
  that QSPI_INVAL is written to end the frame, and that subsequent
  transfers succeed cleanly once QSPI_SPI_STATUS_REG reports QSPI_WC.

Assisted-by: Claude, Gemini
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
 drivers/spi/Kconfig                   |  12 ++
 drivers/spi/Makefile                  |   1 +
 drivers/spi/tests/.kunitconfig        |   4 +
 drivers/spi/tests/Makefile            |   1 +
 drivers/spi/tests/spi-ti-qspi-kunit.c | 225 ++++++++++++++++++++++++++
 5 files changed, 243 insertions(+)
 create mode 100644 drivers/spi/tests/spi-ti-qspi-kunit.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a7b343d124a9..feb9265b7d0f 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1258,6 +1258,18 @@ config SPI_TI_QSPI
 	  This device supports single, dual and quad read support, while
 	  it only supports single write mode.
 
+config SPI_TI_QSPI_KUNIT_TEST
+	bool "KUnit test for TI QSPI controller driver" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y && SPI_TI_QSPI=y && INDIRECT_IOMEM && !HAVE_CLK
+	default KUNIT_ALL_TESTS
+	help
+	  This option builds the KUnit test suite for the TI QSPI controller
+	  driver. It verifies that transfer timeout errors are properly
+	  finalized with -ETIMEDOUT and that QSPI_INVAL is written to the
+	  command register.
+
+	  If unsure, say N.
+
 config SPI_TLE62X0
 	tristate "Infineon TLE62X0 (for power switching)"
 	depends on SYSFS
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index d4a806b46b2c..24497d3936f6 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_SPI_SPIDEV)		+= spidev.o
 obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
 obj-$(CONFIG_SPI_DMA_KUNIT_TEST)	+= tests/
 obj-$(CONFIG_SPI_CORE_KUNIT_TEST)	+= tests/
+obj-$(CONFIG_SPI_TI_QSPI_KUNIT_TEST)	+= tests/
 
 # SPI master controller drivers (bus)
 obj-$(CONFIG_SPI_AIROHA_SNFI)		+= spi-airoha-snfi.o
diff --git a/drivers/spi/tests/.kunitconfig b/drivers/spi/tests/.kunitconfig
index f781425d258e..354bafc42c2b 100644
--- a/drivers/spi/tests/.kunitconfig
+++ b/drivers/spi/tests/.kunitconfig
@@ -1,4 +1,8 @@
 CONFIG_KUNIT=y
+CONFIG_KUNIT_UML_PCI=y
 CONFIG_SPI=y
 CONFIG_SPI_MASTER=y
 CONFIG_SPI_CORE_KUNIT_TEST=y
+CONFIG_COMPILE_TEST=y
+CONFIG_SPI_TI_QSPI=y
+CONFIG_SPI_TI_QSPI_KUNIT_TEST=y
diff --git a/drivers/spi/tests/Makefile b/drivers/spi/tests/Makefile
index 6dbf53643619..a5a8fc9435d4 100644
--- a/drivers/spi/tests/Makefile
+++ b/drivers/spi/tests/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_SPI_DMA_KUNIT_TEST) += spi-dma-kunit.o
 obj-$(CONFIG_SPI_CORE_KUNIT_TEST) += spi-core-kunit.o
+obj-$(CONFIG_SPI_TI_QSPI_KUNIT_TEST) += spi-ti-qspi-kunit.o
diff --git a/drivers/spi/tests/spi-ti-qspi-kunit.c b/drivers/spi/tests/spi-ti-qspi-kunit.c
new file mode 100644
index 000000000000..71ec2464a34a
--- /dev/null
+++ b/drivers/spi/tests/spi-ti-qspi-kunit.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+#include <linux/completion.h>
+#include <linux/jiffies.h>
+#include <linux/kthread.h>
+#include <linux/logic_iomem.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/spi/spi.h>
+
+#define QSPI_SPI_CMD_REG	0x48
+#define QSPI_SPI_STATUS_REG	0x4c
+#define QSPI_WC			BIT(1)
+#define QSPI_INVAL		(4 << 16)
+
+struct ti_qspi_test_ctx {
+	struct platform_device *pdev;
+	struct spi_device *spi;
+	struct spi_message msg;
+	struct spi_transfer xfer;
+	struct completion done;
+	u8 tx[4];
+};
+
+static bool g_err, g_inval, g_region_registered;
+static struct resource g_iomem_res = DEFINE_RES_MEM(0x30000000, 0x2000);
+
+static unsigned long ti_qspi_io_r(void *p, unsigned int off, int sz)
+{
+	return (off == QSPI_SPI_STATUS_REG && !g_err) ? QSPI_WC : 0;
+}
+
+static void ti_qspi_io_w(void *p, unsigned int off, int sz, unsigned long val)
+{
+	if (off == QSPI_SPI_CMD_REG && (val & QSPI_INVAL))
+		g_inval = true;
+}
+
+static const struct logic_iomem_ops g_iops = {
+	.read = ti_qspi_io_r,
+	.write = ti_qspi_io_w,
+};
+
+static long ti_qspi_map(unsigned long o, size_t s, const struct logic_iomem_ops **ops, void **p)
+{
+	*ops = &g_iops;
+	return 0;
+}
+
+static const struct logic_iomem_region_ops g_rops = {
+	.map = ti_qspi_map,
+};
+
+static int ti_qspi_find_ctlr(struct device *d, void *data)
+{
+	*(struct spi_controller **)data = container_of(d, struct spi_controller, dev);
+	return 1;
+}
+
+static void kunit_done(void *p)
+{
+	complete(p);
+}
+
+static int ti_qspi_init(struct kunit *t)
+{
+	const struct resource res[] = {
+		DEFINE_RES_MEM(0x30000000, 0x1000),
+		DEFINE_RES_MEM(0x30001000, 0x1000),
+		DEFINE_RES_IRQ(1),
+	};
+	struct ti_qspi_test_ctx *ctx;
+	struct spi_board_info info = { .modalias = "ti-qspi-test" };
+	struct spi_controller *ctlr = NULL;
+	struct platform_device *pdev;
+
+	g_err = false;
+	g_inval = false;
+	ctx = kunit_kzalloc(t, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(t, ctx);
+	t->priv = ctx;
+
+	pdev = platform_device_register_simple("ti-qspi", -1, res, ARRAY_SIZE(res));
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(t, pdev);
+	ctx->pdev = pdev;
+
+	device_for_each_child(&pdev->dev, &ctlr, ti_qspi_find_ctlr);
+	if (!ctlr) {
+		platform_device_unregister(pdev);
+		ctx->pdev = NULL;
+		KUNIT_FAIL_AND_ABORT(t, "TI QSPI controller device not found");
+	}
+
+	ctlr->max_speed_hz = 50000000;
+	ctx->spi = spi_new_device(ctlr, &info);
+	if (!ctx->spi) {
+		pm_runtime_get_noresume(&pdev->dev);
+		platform_device_unregister(pdev);
+		ctx->pdev = NULL;
+		KUNIT_FAIL_AND_ABORT(t, "Failed to create spi child device");
+	}
+
+	init_completion(&ctx->done);
+	memcpy(ctx->tx, "ABCD", sizeof(ctx->tx));
+	ctx->xfer.tx_buf = ctx->tx;
+	ctx->xfer.len = sizeof(ctx->tx);
+	spi_message_init_with_transfers(&ctx->msg, &ctx->xfer, 1);
+	return 0;
+}
+
+static void ti_qspi_exit(struct kunit *t)
+{
+	struct ti_qspi_test_ctx *ctx = t->priv;
+
+	if (!ctx)
+		return;
+	if (ctx->spi)
+		spi_unregister_device(ctx->spi);
+	if (ctx->pdev) {
+		pm_runtime_get_noresume(&ctx->pdev->dev);
+		platform_device_unregister(ctx->pdev);
+	}
+}
+
+static void check_sync(struct kunit *t, struct spi_device *s, struct spi_message *m, int exp)
+{
+	g_inval = false;
+	/*
+	 * Good situation (patched): ti_qspi_start_transfer_one() sets
+	 * m->status = status (exp, either -ETIMEDOUT on error or 0 on
+	 * recovery) before calling spi_finalize_current_message(host), and
+	 * spi_sync() returns m->status.
+	 * Bad situation (unpatched): on transfer error (exp == -ETIMEDOUT),
+	 * ti_qspi_start_transfer_one() returns early without updating
+	 * m->status or finalizing the message, leaving m->status stuck at
+	 * -EINPROGRESS (-115), which __spi_sync() returns on the noqueue path.
+	 */
+	KUNIT_EXPECT_EQ(t, spi_sync(s, m), exp);
+	KUNIT_EXPECT_EQ(t, m->status, exp);
+	/*
+	 * Good situation (patched): spi_sync() calls
+	 * spi_maybe_optimize_message() at entry (setting m->optimized = true
+	 * while the transfer is in flight), and ti_qspi_start_transfer_one()
+	 * calls spi_finalize_current_message(host) on both success and error
+	 * paths, which runs spi_maybe_unoptimize_message() and resets
+	 * m->optimized = false before spi_sync() returns.
+	 * Bad situation (unpatched): when qspi_transfer_msg() fails with
+	 * -ETIMEDOUT, ti_qspi_start_transfer_one() returns early without
+	 * calling spi_finalize_current_message(host), so
+	 * spi_maybe_unoptimize_message() never runs and m->optimized remains
+	 * stuck at true after spi_sync() returns.
+	 */
+	KUNIT_EXPECT_FALSE(t, m->optimized);
+	/*
+	 * Good situation (patched): ti_qspi_start_transfer_one() writes
+	 * QSPI_INVAL to QSPI_SPI_CMD_REG (g_inval = true) in its epilogue to
+	 * terminate the hardware frame even when a transfer fails.
+	 * Bad situation (unpatched): the early return on error skips writing
+	 * QSPI_INVAL, leaving g_inval == false.
+	 */
+	KUNIT_EXPECT_TRUE(t, g_inval);
+}
+
+static void ti_qspi_test(struct kunit *t)
+{
+	struct ti_qspi_test_ctx *ctx = t->priv;
+	unsigned long timeout;
+
+	g_err = true;
+	check_sync(t, ctx->spi, &ctx->msg, -ETIMEDOUT);
+
+	/*
+	 * Exercise the queued kworker path via spi_async() with g_err = true:
+	 * - Good situation (patched): ti_qspi_start_transfer_one() finalizes
+	 *   the failed message, completing ctx->done, setting
+	 *   ctx->msg.status = -ETIMEDOUT, resetting ctx->msg.optimized = false,
+	 *   and writing QSPI_INVAL (g_inval = true).
+	 * - Bad situation (unpatched): skipping spi_finalize_current_message()
+	 *   never signals ctx->done (causing wait_for_completion_timeout() to
+	 *   time out) and leaves ctx->msg.optimized == true.
+	 */
+	ctx->msg.complete = kunit_done;
+	ctx->msg.context = &ctx->done;
+	g_inval = false;
+	reinit_completion(&ctx->done);
+	KUNIT_ASSERT_EQ(t, spi_async(ctx->spi, &ctx->msg), 0);
+
+	timeout = wait_for_completion_timeout(&ctx->done, msecs_to_jiffies(4000));
+	kthread_flush_worker(ctx->spi->controller->kworker);
+	if (!timeout)
+		KUNIT_FAIL_AND_ABORT(t, "ti-qspi async transfer timed out");
+
+	KUNIT_EXPECT_EQ(t, ctx->msg.status, -ETIMEDOUT);
+	KUNIT_EXPECT_FALSE(t, ctx->msg.optimized);
+	KUNIT_EXPECT_TRUE(t, g_inval);
+	/* Clear the injected fault and verify a subsequent transfer succeeds. */
+	g_err = false;
+	check_sync(t, ctx->spi, &ctx->msg, 0);
+}
+
+static int ti_qspi_suite_init(struct kunit_suite *s)
+{
+	int ret = g_region_registered ? 0 : logic_iomem_add_region(&g_iomem_res, &g_rops);
+
+	g_region_registered = !ret;
+	return ret;
+}
+
+static struct kunit_case ti_qspi_test_cases[] = {
+	KUNIT_CASE_SLOW(ti_qspi_test),
+	{}
+};
+
+static struct kunit_suite ti_qspi_test_suite = {
+	.name = "spi_ti_qspi",
+	.suite_init = ti_qspi_suite_init,
+	.init = ti_qspi_init,
+	.exit = ti_qspi_exit,
+	.test_cases = ti_qspi_test_cases,
+};
+
+kunit_test_suite(ti_qspi_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for TI QSPI controller driver");
+MODULE_LICENSE("GPL");
-- 
2.56.0.317.g454f8302e1-goog

