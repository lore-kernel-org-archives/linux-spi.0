Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115410;
	b=2JJV8xagKOUznqcxmtm/srhFfdbeRvnKvv4VUU95ZLFIzW83tHUZKfrgsykAwPtTHeWw
	 ZFPaAj8DHFB22ZF3xCT37UdKLaO1NsN70yY5MrqsGlyt7IpbUDaGQjhZmoxJZ1318tYY/
	 DztqEAqGStGzZIsaDT9+QSkp7mXyCaPNRTdRSoTsHr+bz8WiO/lJWzLCA8G44pm3CXGP8
	 FRCD1TRC92tu2AnzRXpr0B1l1x0tpb/x9dY/xyn1IU30aJn4mR7fki58AWQI3VQd7f+5G
	 CUzvJOk4aIUVRYzA3mzmrf3E6uBUqGRod6qRtS+dPe/j0Csliprl9TlCOCx/8qUUHIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AqdjgnKmmMIoNLYpRir+CTtV50ag4vDAldPfTLA3ruk=;
	b=h7umLsRtFa635l2lmG2pMAiO7xj8zsuhA1BS5tBNpmNSlQJ40l6UFVjRHcCJQJwDTDeG
	 48286ZRxhCRcB3eyC2T5pfG60c2tqQDb4bXLETIQy00Y8vtGzvYKzr5T8A5zup1KTZwJs
	 MQm6h8UdNibQmuueE6K8/E2K6HY3H9vKI5dAtJR5+VNZqcrbj+vZgl4FvoRbiMvLPXT8J
	 r1k65Dsz73p9sYl16fygYply5Zn4ELq4PjjNpm654gFauyzBdgL+VS+poOv5uTDgjSM5b
	 TWSjdfwvupi7Qy03J5BTcO7y36tAYTm0tW7iD1bUx7H7vBs2ySeMoLxQFRpDwPxvJBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q2YhFl1g;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E0360A2603
	for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2026 19:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88E0360A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q2YhFl1g
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b3a914e4c8so105331a91.0
        for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2026 11:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795115409; x=1795720209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AqdjgnKmmMIoNLYpRir+CTtV50ag4vDAldPfTLA3ruk=;
        b=Q2YhFl1gRg0pEZTfWcKdSChaxi03zDeKeWn+6UN77U1MC207fnvjmPAwiv+E9RUstL
         6LqedcqDpaujfYx/LQnOcARp5T1aelPwl3Yd63rGEBOGs4FJ7ktgtt5LiqZ6oPT8vox8
         LZgEEZaxgbVrlMRftKV1tfCnBLEoCz0dhaPWkPfj1kPnDba1W/6VgbcnUuJo0klaYV4M
         ak/Xc02VaqXsBd3vlkGAvESwy4NwUR+hJB0z4fag9SEdUbb3Eik5mMSD5vtTWZUHT6c4
         MuTA5Yqb4cRAWYjnH7/9qfck28Le7SsPXeJvhxmhzMV9Ujkio2wsbqHoCtbNn92r7OJW
         4ycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795115409; x=1795720209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AqdjgnKmmMIoNLYpRir+CTtV50ag4vDAldPfTLA3ruk=;
        b=O0pbT8cXb6jz8n2glJX7hP5D76cCu3H3oCKa+MkJOL4N0/PoGOM8OZ8j2aKvZsTq4L
         tYNfWeDuR7AcMxuvoF/CDtjdiF3nhg6VPN0A1UFC818BT99CPAkB4dtNBLXgBbkbRMri
         NBtU/0BWuKaAc1T6bVUOViw2H4f+kUR84TqDg9IJXujqzwEIY6dhPlksBXlJV1pJMBhM
         iyFt1JiP9JsQwnHwVdhxba7XN40ffxZk70RZvclGJXE7vSbgUL45RDvUJ/QJ6L0pgHf7
         y49x6EbtqFzo9MhkcxwmlqgDhftf/E5c3RA6auieRdtzz1yDPUdthlXUuLI7hRuF0f6f
         Msmw==
X-Gm-Message-State: APuU4Z+CX8X05kL8t/WPfemGKC0IY51nHuXgZWcmz3ERZoIA7XFVQBlO
	/vyiXLdKdfYpf6xKgSb5S65VDf0ydhgb8VO8P4tCCOAoDjBjUUvnEbAJ7OMTcTC3cPtR2g==
X-Gm-Gg: AZFdTZeYzVGunfH1oADNRZnas9/azDX/nkliTprUJjRH176136/OKSTgbJCou+ddsic
	m4yU3zY8rELNORRJ240hXJp4xbt+D2QJVVJm762YkmJWUNcEaIUZXj35VeduAzH9hBmsFL59lYN
	7IDS+a6DYjhzPqRJ5zukJQYMOD8LE1k8pN8sMrkw2F3p77IGULr8JyKyhvZBXyTkjIFmUeDkaCk
	InD8Fy24hKNQ5u9d93G6R3Z4PDipg7IAo97j+YUwFuls204GHy88yxkPcbxDp0Nqt8Sm2menS2g
	xWUyAdKHZEuIHYQdrnY9kEzT9IxC2thPZqJe9jNf36ZRSw0wHBO70+YO/Fua8IO+Alx8GJVxYWv
	sY3wnXeWo2pjXT2PQWBkJTjRWehZCia61thqimt8MfMpjcGUDzub4bQTP1qIyrZUuR/8oBaHmPU
	luCOqdwVbWVINXj1ng0GbEuXIZKub+rfUPExlixKwBI4uon6gBLycrJpi7Ewm1IHrc3huIF25JN
	UEhOf001x+oTRTraUMiUwraJ/JsDudnAMfpuJBjONDfpgFmwpRcpNyP5vtToRpsYpl+3NE8JOdk
	2ZxN0Cki1ll/XjaZrZpvJ4i/4vKVOB1xUVF5vRSzsBrnR7Gy5Nd7Q7cLKMWi+Zow0Nj/k323xiH
	QCUnQ6kqK4yLNtkSAMXy2OIOGIWQl2iemfx3diMGB+uwYTb8ChdaUe3nTtVrKeRw9DmzItvcWR0
	sNwx/NNa3wLBRdGLB1UBcAOVHcvH1bSsZTHCEAbv4c9xEx5lAkqy5+lsuBSV9Umc5NsVd11HWFb
	1WhrVaaWfdchaA=
X-Received: by 2002:a17:90b:3d4d:b0:3ac:7556:8eed with SMTP id 98e67ed59e1d1-3b41c956552mr262117a91.44.1795115408887;
        Thu, 19 Nov 2026 11:10:08 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d1361fsm3678174a91.6.2026.11.19.11.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 11:10:08 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH v3 2/2] spi: spi-ti-qspi: add a KUnit test for transfer error finalization
Date: Thu, 19 Nov 2026 19:10:01 +0000
Message-ID: <20261119191001.878454-3-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261119191001.878454-1-jctchan@gmail.com>
References: <20261119191001.878454-1-jctchan@gmail.com>
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

Add a KUnit test for ti_qspi_start_transfer_one() covering the transfer
error handling path.

On ARCH=um, the test emulates the TI QSPI controller MMIO registers
with logic_iomem and leaves QSPI_SPI_STATUS_REG returning zero so that
ti_qspi_poll_wc() times out with -ETIMEDOUT. A single spi_sync() call
verifies that:
- spi_sync() returns -ETIMEDOUT,
- msg.optimized is false (the message was finalized), and
- QSPI_INVAL was written to QSPI_SPI_CMD_REG (the frame was ended).

On configurations without CONFIG_INDIRECT_IOMEM or with CONFIG_HAVE_CLK
enabled, the test calls kunit_skip() without registering any device.

The test is not added to drivers/spi/.kunitconfig because building
SPI_TI_QSPI on UML or x86_64 requires CONFIG_COMPILE_TEST=y, which
would enable and alter many unrelated config options for every SPI
KUnit run. Run it with:

  ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/spi \
          --kconfig_add CONFIG_COMPILE_TEST=y \
          --kconfig_add CONFIG_SPI_TI_QSPI=y \
          --kconfig_add CONFIG_SPI_TI_QSPI_KUNIT_TEST=y

Developed with help from the Claude and Gemini AI assistants.

Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
v3: Rebased on spi/for-7.5; dropped the drivers/spi/Makefile change (already
    includes tests/) and left drivers/spi/.kunitconfig unmodified (pass
    CONFIG_COMPILE_TEST=y, CONFIG_SPI_TI_QSPI=y, and
    CONFIG_SPI_TI_QSPI_KUNIT_TEST=y via --kconfig_add instead); moved
    logic_iomem checks out of Kconfig depends and skipped via kunit_skip()
    when !INDIRECT_IOMEM || HAVE_CLK; removed the stale
    pm_runtime_get_noresume() calls (ti_qspi_remove() no longer calls
    pm_runtime_put_sync() after commit 8b8678d3e894); reduced the test to
    one fast KUNIT_CASE checking spi_sync() == -ETIMEDOUT, !msg.optimized,
    and QSPI_INVAL (removed async, recovery, and tautological m->status
    checks and the optional second MEM resource).
v2: Trimmed the comments.

 drivers/spi/Kconfig                   |  12 ++
 drivers/spi/tests/Makefile            |   1 +
 drivers/spi/tests/spi-ti-qspi-kunit.c | 172 ++++++++++++++++++++++++++
 3 files changed, 185 insertions(+)
 create mode 100644 drivers/spi/tests/spi-ti-qspi-kunit.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a7b343d124a9..7809acbac35b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1258,6 +1258,18 @@ config SPI_TI_QSPI
 	  This device supports single, dual and quad read support, while
 	  it only supports single write mode.
 
+config SPI_TI_QSPI_KUNIT_TEST
+	bool "KUnit test for TI QSPI controller driver" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y && SPI_TI_QSPI=y
+	default KUNIT_ALL_TESTS
+	help
+	  This option builds the KUnit test suite for the TI QSPI controller
+	  driver. It verifies that a transfer timeout finalizes the message
+	  with -ETIMEDOUT and writes QSPI_INVAL to end the frame. The test
+	  runs only where MMIO can be emulated (UML) and is skipped elsewhere.
+
+	  If unsure, say N.
+
 config SPI_TLE62X0
 	tristate "Infineon TLE62X0 (for power switching)"
 	depends on SYSFS
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
index 000000000000..30fb5771dcb9
--- /dev/null
+++ b/drivers/spi/tests/spi-ti-qspi-kunit.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+#include <linux/errno.h>
+#if IS_ENABLED(CONFIG_INDIRECT_IOMEM)
+#include <linux/logic_iomem.h>
+#endif
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+
+#define QSPI_SPI_CMD_REG	0x48
+#define QSPI_INVAL		(4 << 16)
+
+struct ti_qspi_test_ctx {
+	struct platform_device *pdev;
+	struct spi_device *spi;
+	struct spi_message msg;
+	struct spi_transfer xfer;
+	u8 tx[4];
+};
+
+static bool g_inval;
+
+static bool ti_qspi_can_run(void)
+{
+	return IS_ENABLED(CONFIG_INDIRECT_IOMEM) && !IS_ENABLED(CONFIG_HAVE_CLK);
+}
+
+#if IS_ENABLED(CONFIG_INDIRECT_IOMEM)
+static bool g_region_registered;
+static struct resource g_iomem_res = DEFINE_RES_MEM(0x30000000, 0x1000);
+
+static unsigned long ti_qspi_io_r(void *p, unsigned int off, int sz)
+{
+	return 0;
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
+static long ti_qspi_map(unsigned long o, size_t s,
+			const struct logic_iomem_ops **ops, void **p)
+{
+	*ops = &g_iops;
+	return 0;
+}
+
+static const struct logic_iomem_region_ops g_rops = {
+	.map = ti_qspi_map,
+};
+
+static int ti_qspi_suite_init(struct kunit_suite *s)
+{
+	int ret;
+
+	if (!ti_qspi_can_run() || g_region_registered)
+		return 0;
+
+	ret = logic_iomem_add_region(&g_iomem_res, &g_rops);
+	if (!ret)
+		g_region_registered = true;
+	return ret;
+}
+#else
+static int ti_qspi_suite_init(struct kunit_suite *s)
+{
+	return 0;
+}
+#endif
+
+static int ti_qspi_find_ctlr(struct device *d, void *data)
+{
+	*(struct spi_controller **)data = container_of(d, struct spi_controller, dev);
+	return 1;
+}
+
+static int ti_qspi_init(struct kunit *t)
+{
+	const struct resource res[] = {
+		DEFINE_RES_MEM(0x30000000, 0x1000),
+		DEFINE_RES_IRQ(1),
+	};
+	struct ti_qspi_test_ctx *ctx;
+	struct spi_board_info info = { .modalias = "ti-qspi-test" };
+	struct spi_controller *ctlr = NULL;
+	struct platform_device *pdev;
+
+	if (!ti_qspi_can_run())
+		return 0;
+
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
+		platform_device_unregister(pdev);
+		ctx->pdev = NULL;
+		KUNIT_FAIL_AND_ABORT(t, "Failed to create spi child device");
+	}
+
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
+	if (ctx->pdev)
+		platform_device_unregister(ctx->pdev);
+}
+
+static void ti_qspi_test(struct kunit *t)
+{
+	struct ti_qspi_test_ctx *ctx = t->priv;
+
+	if (!ti_qspi_can_run())
+		kunit_skip(t,
+			   "needs UML MMIO (CONFIG_INDIRECT_IOMEM) and no clock framework");
+
+	KUNIT_EXPECT_EQ(t, spi_sync(ctx->spi, &ctx->msg), -ETIMEDOUT);
+	/* Message must be finalized and unoptimized even when a transfer fails. */
+	KUNIT_EXPECT_FALSE(t, ctx->msg.optimized);
+	/* QSPI_INVAL must be written to terminate the frame on error. */
+	KUNIT_EXPECT_TRUE(t, g_inval);
+}
+
+static struct kunit_case ti_qspi_test_cases[] = {
+	KUNIT_CASE(ti_qspi_test),
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
+MODULE_DESCRIPTION("KUnit test for TI QSPI controller driver");
+MODULE_LICENSE("GPL");
-- 
2.56.0.679.gc527c65306-goog

