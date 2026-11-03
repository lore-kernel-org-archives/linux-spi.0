Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746304;
	b=a3DG4jy8pTbLxz7imrRKVmFXlCPHVwtLOiK2YlBjpFadwyLjWo3eE8fT6wLcvVP5Bn/b
	 9OpUPox5BY+15fd18zouJBAwVL8nNqivWfczShspRGAe5ReL8lkstp/D8nnoVoxgKMsEy
	 QEPN6q2C+p+U0ECNoW0lf+ds1KboQ+aG23YgKV/GDiI8jXFOBwTjiXQPsY0Z/lAxboDzK
	 H5GHRRpilZuIUb6reytVd071TvPxAlp3Mn+48+sdJCQZGeC8m1cmA6VP0qP0M5K3TH6tD
	 t1mRQud+tSoVw9f8sqiqpdD3yqAKJ7TAQIjmXXFgCuKnJejufIg13OGR052uzCrnMKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k84Xck1lQeIV22I9surTxcp1kLsruu69Cn5iRjglYY4=;
	b=zG+ko1I7ixRUXRvUjGSEO0QRb9nOMGZZ5Ry9ByO8RPDQvQD+aWIILL+NLTpicwJ4gUrz
	 DeKwA4MJBZUyEJ6xA+lCoHgH0s46UgrGDvUO9EsxxkkJ6Cy7RiU3cUrOUb9YIX+OpaVd7
	 Tmq6x+hUS7XEE5YFwhDo4LobHIz6EhSHoN6vxpTbQT+4Jr+aVegz3WHqoiuV1zMNdxF1+
	 GBHC/JhsRncqHWGSCYb4xrfLvMF0yrbXmXjyT/MzofJdfeIsiO9DJjKSEQKrz6W0qnuGu
	 C81NP7yq4fHBYEteC8q7AFWnjZG0O3X42kbGj9bnAeaovNyJRE9sWyD0YoTG/lgcErw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KN8YYBAu;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A390E606A328
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 22:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A390E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KN8YYBAu
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so101393a91.1
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 14:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746303; x=1794351103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k84Xck1lQeIV22I9surTxcp1kLsruu69Cn5iRjglYY4=;
        b=KN8YYBAuOKx/lnBsMsJBvbtvz6WCEoBUtE8hIKDkxuzlqVBQQSpjdh0FByJM9ApJgC
         DuLJFczQ6z2euNMX0Jqn0X6LPGtmzXpUGEb0ciwPH0HGhqMDPZAxuzM9UdVSWn0gcQng
         MRcfiKpdsx3ji5YMjw10Blclpp0RslA8O21dq2T0OEMoiIqxofGHcBokySzsN+5bvuMz
         za4plQ0Gr4GVUjoIsK3sPqGDHE1FFolQ1wmT8yL1aIJrmVeTGtCHMN8tKr2QRy5CwNab
         BQqHGfZtJIdw4jXv7QxkL2wKVXKpNBcwaW4KrhUeFoKKbETcUKYG5OTav+YUZvfRK/Zk
         5c0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746303; x=1794351103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k84Xck1lQeIV22I9surTxcp1kLsruu69Cn5iRjglYY4=;
        b=Uc4nQ8NCQFdfXzXv7PW3cVsfq8bbFTz2qgnvQBg81GDt72n1LtGNhBnQldoRIXrzaa
         lP0UF7CeeS+46lIAFP4/0bcC8Fx9AxFwPdJ5tu25r6L30zjlvw9Tlxo1Ekrtna2pBZFx
         yHnhgI0+dI7MG9jo5m4uK7mOW3RVpAXY9aXgdDHypXSo7TFOfG04x9nTAnsTZ5mjHb5u
         N6nxk+ElQ1ohCuiuBkFieagXr5IOezzZug6W2n3ITUZUb7rTANnZTf6oc3wZsdqrcDII
         D24Q3uiMQUzxp7iuh6+P5i074SW1YprDK/27BOSo4QoaNlDxEZxK5CYPF9vx/qZR9X/N
         Lj4A==
X-Gm-Message-State: APuU4Z/VYWAyvS5px08e7sfydVrU6jOqh2DTrgHed/K2HFtmjpeN73VP
	yY3n7NqlrIeagKNXi6GY+AqOlaDCcotgXdjE55kd/QyehzOzLWZjoEHaDLEAagUqA6xS27/U
X-Gm-Gg: AYBFou2r/53qgunO3vgM7Uc5Mu+oQCWJWORKtp3Md1aF4p6ozjKjVytFLrC9rXzb5k3
	MNqK6yHGAxgPeyjzlIXvxyT3Dw/kR6zyhVCWP0tre9eWJmIFivJr7+E9jNjNLkl3zaeVC71ytyr
	HKKyn+hnTG1C0zmwp5gfwk+tfUd4hUhNSRN2uXdYAxumRUMOroVtbeTko9vigBJ18s5ur5E1o7X
	itTUN2ftdf+ufl8TFFobIm6q4ifZp7ATlJC4HZTwkgugukhG0m6CkhtDuHWL4SJpzJMnuZ6qcX2
	Fqv5zrfDGhA9H3QXG23PeF1DgdDUBz4R0FjKCEYMcFEOBk3X3jLVUAYVn4d6JzjLCavrwysn8CD
	CRjOP5Jcw45uDJCaxRtkUFDDfkf4Un8vkP/6UhOKkp4QBmQwj6v5R5mFPAhk0Bbp53szKcjXIbI
	4SPlEMMz6vDNhyJBcCZF2sBNBnYKEKdsKjhAQQgj+sXK3oxNMQjZw3KQ5Vs33oJwLB6tRGe4sR4
	7aNTaJuHciCJaE+KstDkKO/5JnTuDfB4NAt9Fn4EwjnR9ARIQqjSsVkTNW2IdiosaPWnu9ThLSM
	4jwoc1aLvChUCfsA/qsFnHGcfvoCAhxiE+n01fbOCJIa+pUZqzFBreSroCiAHH7y8LVou0p4qUx
	oM/QENTHIvItUW6Bb5AuqbxuLeIph2IHexPpj6+1AUmSEW6EbRo/A+NgxqrUSgsKMBVAQUhFjwH
	RByBgoGVm2DNg6v/YsqebE/mFVWflsCywY9XBb4nM3HAZpQ91hJBHfwfbsA3d2qerxMg==
X-Received: by 2002:a17:90b:5870:b0:3ad:6090:a189 with SMTP id 98e67ed59e1d1-3ae8983e2f3mr10808328a91.45.1793746302896;
        Tue, 03 Nov 2026 14:51:42 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09449bff2sm913217a91.9.2026.11.03.14.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:51:42 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH v2 2/2] spi: spi-ti-qspi: add KUnit tests for transfer error finalization
Date: Tue,  3 Nov 2026 22:51:16 +0000
Message-ID: <20261103225116.3624270-3-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103225116.3624270-1-jctchan@gmail.com>
References: <20261103225116.3624270-1-jctchan@gmail.com>
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

Developed with help from the Claude and Gemini AI assistants.

Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
v2: Trimmed the comments.

 drivers/spi/Kconfig                   |  12 ++
 drivers/spi/Makefile                  |   1 +
 drivers/spi/tests/.kunitconfig        |   4 +
 drivers/spi/tests/Makefile            |   1 +
 drivers/spi/tests/spi-ti-qspi-kunit.c | 188 ++++++++++++++++++++++++++
 5 files changed, 206 insertions(+)
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
index 000000000000..fd75d5d3ab89
--- /dev/null
+++ b/drivers/spi/tests/spi-ti-qspi-kunit.c
@@ -0,0 +1,188 @@
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
+	KUNIT_EXPECT_EQ(t, spi_sync(s, m), exp);
+	KUNIT_EXPECT_EQ(t, m->status, exp);
+	/* Message must be finalized and unoptimized even when a transfer fails. */
+	KUNIT_EXPECT_FALSE(t, m->optimized);
+	/* QSPI_INVAL must be written to terminate the frame on both success and error. */
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
+	/* Exercise the queued kworker path via spi_async() on transfer timeout. */
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
2.56.0.385.gac671c819a-goog

