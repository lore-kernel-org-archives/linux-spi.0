Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637238;
	b=UF9o356upyZpQHgx3P4y1fxFksEHm7c44lkgUmdyLgU3bgJx4E44IdCXHoC1naKMRpF/
	 Iv8ig0yNpYmpgjuCCNzPTCcg8QSkvSOkewidvzjVkDHK8ReDD6XFhXyo2fWfX45e8CrDd
	 6hIwftp/06VpTxZBNM3kVkQRG2VN0ndW++es3BDdaSar152uB4Nx2CUCogZJVVF/PS3cY
	 4ITHG592tQzImnvzJ6zZDEPwZ2JO/JwS/I1j9/l4KTuFIgUlwmFQG/TlWcDtFtORysyhT
	 zRsnG9AsXwRVfh8+/v5+ERAkyIi3C9T4noOLV8ewzyFLcP1leNVh/GWybCFWAunwxGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fUcLggNgP9bEghXuq6AerM8vFf1Y/cll58lTL1x1iAc=;
	b=Qn3cFiLYlwyR+M4P7G/4meopIUdzNcFpqFM0McV583rjGh+EXJpFNalKMB9VDVk5ctif
	 izBP+Rf1+jsrj0FzJpa9QnR56bbtuZK4fE8a5eOm5D5XC32GMchCjx057AuuZu/M3lDf2
	 yse9SpiEXTJB0fkIdA3VxXgCdQ5abxkpRJNAGoQDXLYILqvEscsJkGtfmcQyUjPcnZJDu
	 6Xgcnr4iPIzNUcG4PVpOHbsfEfD8WVJWeq5VCLGWA1Aa2knBL086hVaLAF+Hl/iJBI7BW
	 OeVXQh7MNFL64mTp2bZHScBd/5KjrDkTx7WGrRFl6gZdo1j3QcfJywWUWhPYTUoHJqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lt9QZ67Y;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECCF60A0CAE
	for <linux-spi@vger.kernel.org>; Mon,  2 Nov 2026 16:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ECCF60A0CAE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lt9QZ67Y
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a06c60065fso2241825b3a.1
        for <linux-spi@vger.kernel.org>; Mon, 02 Nov 2026 08:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793637238; x=1794242038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fUcLggNgP9bEghXuq6AerM8vFf1Y/cll58lTL1x1iAc=;
        b=lt9QZ67YalcQWwBo3X5ojHeYEbM3qnwb16igaHz7JlYIi+qwamK4xZ4R3wMg/UopcM
         RmOwpL/IskN8R93GyeNNHLQ0jKjkjPhtjn7ZjZnDgsFI7pRFl6oschHJfcu/lOJwZZ3l
         gZifydiXcjewKJGZWPqz9mtSS3KA5w1ruD7fxfQyoPw0SwL6xkSKNEXlpL8KfN1FYL5D
         M1167Gu3r5EEs8aDsPMvvR1xSfWih24zyIy+ziefSjhgkDzfAuzP6BMyyv5J0HyKvzig
         2oFPMGx8zuoZ8IFosWB0Ebk0dnR+eaKtbTtL/UAml6IzPgV7Jj0+Z5MOseDdMKGIYHHg
         pJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637238; x=1794242038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fUcLggNgP9bEghXuq6AerM8vFf1Y/cll58lTL1x1iAc=;
        b=iGOw7N43qSnQ6heNX7siQVnVqRjNPRVThiaqCh8IYSA1ljonj1d5EXHSXf9ZJQLmfG
         T99MwjVOwKvqie3GUBUW4u2nUtbwo+iSsZXjbQrO+xevUAr729V7AtMWbC+qXjHNyOeJ
         f8h5dms/VhUkZtdAELQq7N7GZhjlfe9oz/m2ETH2TNmftyWDDsuU8rvg5TwkRKax1o0w
         Jul/1lDZ7upwJoT0eucK7fd3Xmjbx1zU0ecOXhqapp8gZ0hBf7jUV1+hTEtktZVvQxdP
         hmxGhtnJME4DaQ+Ez8Y6kXuI/ARUqd0/Q3P1BTY5xsu4VQsWqYYHmI/e1qlnu3YsJQ5X
         Mw3g==
X-Forwarded-Encrypted: i=1; AKwUvBwWoXDO5boQbEriSmtbuSFYGnGEdmtcwGGwaY2GYojCfeZJB6F3+i+d7Ql+r1LgFJ+IBOr2aq2NIws=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jsmXpGaMrPSy0G135YjEM/b7ADN6B0DldQnfoyOrm/b/veODM
	UdEwVqmOt/8sxscC+9sI3rm60gOd6UynqKaiyeRAFH6KH2yVuTcWRmA+
X-Gm-Gg: AYBFou3k0uxNHtU9wPq2w/bBqe447XSRhXa1cBT6BaZxA+6pyA/gXcXedivy5rwNAiT
	QeSqbQeWhdRPaodyQJYIEL8ATHBT2c3VzuFk3XGFqECFQRmYnm1/gG0bZPzgNxKuXxUAlshftTn
	cIIUm7p+qS9shvfyHhr30lmozMBa7iL7MBfWMsupyUqDpDkpmHNqqs6Xkc6w7dwt3MjObSFoe/K
	6/wUXPKc4MQN3qtiaO2UkmN8BV7mFQUCBw1qTYKKg/PMYKjM9r0L35cRqgdnoamSn98t0Wb9EH/
	aqukpingcLokNEXqBd+3b/GGr3Xnj3XcAStkKPK+xOUCXCCSBX8gj7GrYPBgOmOPMD1/HzEUiHy
	qtdnGFl62MhiTj19brcT4RbfB9y01Yc82wK62aZNK0n5d6ne1qhObsxW+dprdslIBtsVz7nVGiT
	jvP07gAok4ciQwcST8Uj47JriYm5TGLSR07OEJ891y/iyA8PcdvrnuTyfIvzV9wRSfXw68sWfcz
	ORHgxt8LD7BxX4/7TaI3RJl+D/OYeBhuoqoOA0SmC0AIsAlQR6qxSALovzUTUZfO/mc4zw+7Dd/
	W7FnOAhaZDBufGsuyOdKrp1s3L1s4WNPgd0nBnMT/VD3ZYUqDzVvoN6wpuOst3Z3+5z6uyc+oqA
	O93cqsfWGkATb2xZB6/g8JEdHpQ7or0JrPHtEuJd8sWpC4Be3aN0Jh+yMPovR7lVeAZn0nflCDX
	xaLAsQ8mADZfG6mIxqUoNfg+XaXmC+uQ==
X-Received: by 2002:a05:6a00:a882:b0:8a0:76ea:36e0 with SMTP id d2e1a72fcca58-8a9bdebcc2amr7374097b3a.40.1793637237720;
        Mon, 02 Nov 2026 08:33:57 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d4092sm2184549b3a.41.2026.11.02.08.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:33:56 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH 07/14] spi: add KUnit tests for message optimize state on queue errors
Date: Mon,  2 Nov 2026 16:30:16 +0000
Message-ID: <20261102163023.2574632-8-jctchan@gmail.com>
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

spi_async() and spi_sync() optimize a message before they queue it. If
queuing fails, for example because another device holds spi_bus_lock()
on the controller, because mem_ops rejects the message, or because the
controller is suspended, the message is never finalized, and finalizing
is where the core normally unoptimizes it.

Add KUnit tests with a fake controller that counts its optimize_message()
and unoptimize_message() calls, splits transfers across a 2-byte boundary
to exercise msg.resources, and tracks msg.opt_state. The tests cover both
async and sync queue errors, verify split transfers are cleaned up and
opt_state cleared, check that a message optimized by the peripheral
driver is left alone on error, and check that a successful spi_sync()
optimizes and unoptimizes the message exactly once on both queued and
unqueued paths.

Without "spi: unoptimize message when queuing it fails" the queue error
cases fail with unoptimize_count == 0, msg.resources leaked, and
msg.optimized still true; the other cases pass.

Tested with KUnit on ARCH=um: all cases pass with the fixes in this series
applied. Builds with W=1 on x86_64.

Assisted-by: Claude, Gemini
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
 drivers/spi/Kconfig                |  13 ++
 drivers/spi/Makefile               |   1 +
 drivers/spi/tests/.kunitconfig     |   4 +
 drivers/spi/tests/Makefile         |   1 +
 drivers/spi/tests/spi-core-kunit.c | 308 +++++++++++++++++++++++++++++
 5 files changed, 327 insertions(+)
 create mode 100644 drivers/spi/tests/.kunitconfig
 create mode 100644 drivers/spi/tests/spi-core-kunit.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 49088e5886d3..a7b343d124a9 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1398,6 +1398,19 @@ config SPI_DMA_KUNIT_TEST
 
 	  If unsure say N.
 
+config SPI_CORE_KUNIT_TEST
+	tristate "KUnit tests for SPI core message optimize state" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Build KUnit tests for the SPI core message optimize state. The tests
+	  register a fake controller and check that spi_async() and spi_sync()
+	  undo the optimization of a message they fail to queue, that a
+	  message optimized by the peripheral driver is left alone, and that a
+	  successful transfer optimizes and unoptimizes exactly once.
+
+	  If unsure say N.
+
 config SPI_LOOPBACK_TEST
 	tristate "spi loopback test framework support"
 	depends on m
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index b493f50b93e3..d4a806b46b2c 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_SPI_OFFLOAD)		+= spi-offload.o
 obj-$(CONFIG_SPI_SPIDEV)		+= spidev.o
 obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
 obj-$(CONFIG_SPI_DMA_KUNIT_TEST)	+= tests/
+obj-$(CONFIG_SPI_CORE_KUNIT_TEST)	+= tests/
 
 # SPI master controller drivers (bus)
 obj-$(CONFIG_SPI_AIROHA_SNFI)		+= spi-airoha-snfi.o
diff --git a/drivers/spi/tests/.kunitconfig b/drivers/spi/tests/.kunitconfig
new file mode 100644
index 000000000000..f781425d258e
--- /dev/null
+++ b/drivers/spi/tests/.kunitconfig
@@ -0,0 +1,4 @@
+CONFIG_KUNIT=y
+CONFIG_SPI=y
+CONFIG_SPI_MASTER=y
+CONFIG_SPI_CORE_KUNIT_TEST=y
diff --git a/drivers/spi/tests/Makefile b/drivers/spi/tests/Makefile
index 26689e0cb28a..6dbf53643619 100644
--- a/drivers/spi/tests/Makefile
+++ b/drivers/spi/tests/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_SPI_DMA_KUNIT_TEST) += spi-dma-kunit.o
+obj-$(CONFIG_SPI_CORE_KUNIT_TEST) += spi-core-kunit.o
diff --git a/drivers/spi/tests/spi-core-kunit.c b/drivers/spi/tests/spi-core-kunit.c
new file mode 100644
index 000000000000..e1578f2f8eb3
--- /dev/null
+++ b/drivers/spi/tests/spi-core-kunit.c
@@ -0,0 +1,308 @@
+// SPDX-License-Identifier: GPL-2.0
+// KUnit tests for the SPI core message optimize state.
+#include <kunit/device.h>
+#include <kunit/test.h>
+#include <linux/completion.h>
+#include <linux/errno.h>
+#include <linux/jiffies.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+
+struct spi_core_test_ctx {
+	struct spi_controller *ctlr;
+	struct spi_device *spi;
+	int optimize_count, unoptimize_count;
+	bool bad_opt_state;
+	struct spi_transfer xfer;
+	struct spi_message msg;
+	struct completion done;
+	u8 tx[4];
+};
+
+static int spi_core_test_optimize(struct spi_message *msg)
+{
+	struct spi_core_test_ctx *ctx = spi_controller_get_devdata(msg->spi->controller);
+
+	ctx->optimize_count++;
+	msg->opt_state = ctx;
+	return 0;
+}
+
+static int spi_core_test_unoptimize(struct spi_message *msg)
+{
+	struct spi_core_test_ctx *ctx = spi_controller_get_devdata(msg->spi->controller);
+
+	ctx->unoptimize_count++;
+	if (msg->opt_state != ctx)
+		ctx->bad_opt_state = true;
+	return 0;
+}
+
+static int spi_core_test_xfer_one(struct spi_controller *ctlr, struct spi_message *msg)
+{
+	struct spi_transfer *xfer;
+
+	list_for_each_entry(xfer, &msg->transfers, transfer_list)
+		msg->actual_length += xfer->len;
+	msg->status = 0;
+	spi_finalize_current_message(ctlr);
+	return 0;
+}
+
+static int spi_core_test_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	return -EOPNOTSUPP;
+}
+
+static const struct spi_controller_mem_ops spi_core_test_mem_ops = {
+	.exec_op = spi_core_test_exec_op,
+};
+
+static size_t spi_core_test_max_transfer_size(struct spi_device *spi)
+{
+	return 2;
+}
+
+static void kunit_done(void *p)
+{
+	complete(p);
+}
+
+static struct spi_core_test_ctx *spi_core_test_ctx_new(struct kunit *test, bool mem_only)
+{
+	struct spi_board_info info = { .modalias = "spi-core-kunit", .max_speed_hz = 1000000 };
+	struct device *dev = kunit_device_register(test, "spi-core-kunit");
+	struct spi_controller *ctlr;
+	struct spi_core_test_ctx *ctx;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	ctlr = devm_spi_alloc_host(dev, sizeof(struct spi_core_test_ctx));
+	KUNIT_ASSERT_NOT_NULL(test, ctlr);
+	ctx = spi_controller_get_devdata(ctlr);
+
+	ctx->ctlr = ctlr;
+	ctlr->bus_num = -1;
+	ctlr->num_chipselect = 1;
+	ctlr->max_transfer_size = spi_core_test_max_transfer_size;
+	ctlr->optimize_message = spi_core_test_optimize;
+	ctlr->unoptimize_message = spi_core_test_unoptimize;
+	ctlr->mem_ops = mem_only ? &spi_core_test_mem_ops : NULL;
+	ctlr->transfer_one_message = mem_only ? NULL : spi_core_test_xfer_one;
+	KUNIT_ASSERT_EQ(test, 0, devm_spi_register_controller(dev, ctlr));
+	ctx->spi = spi_new_device(ctlr, &info);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->spi);
+	init_completion(&ctx->done);
+	/*
+	 * Pair a 4-byte dummy TX buffer with max_transfer_size = 2 so
+	 * __spi_optimize_message() splits the 1 transfer into two 2-byte
+	 * transfers tracked in msg.resources, allowing check_state() to
+	 * verify that spi_res_release() undoes transfer splitting.
+	 */
+	ctx->xfer.tx_buf = ctx->tx;
+	ctx->xfer.len = sizeof(ctx->tx);
+	spi_message_init_with_transfers(&ctx->msg, &ctx->xfer, 1);
+	ctx->msg.complete = kunit_done;
+	ctx->msg.context = &ctx->done;
+	return ctx;
+}
+
+enum spi_core_err_mode {
+	ERR_NONE,
+	ERR_BUS_LOCKED,
+	ERR_MEM_OPS,
+	ERR_SUSPEND,
+};
+
+struct spi_core_err_param {
+	const char *name;
+	enum spi_core_err_mode mode;
+	int exp;
+	bool use_sync;
+	bool pre_opt;
+	bool must_async;
+};
+
+static const struct spi_core_err_param spi_core_err_cases[] = {
+	{ "bus_locked_async", ERR_BUS_LOCKED, -EBUSY },
+	{ "suspend_async", ERR_SUSPEND, -ESHUTDOWN },
+	{ "mem_ops_sync", ERR_MEM_OPS, -ENOTSUPP, true },
+	{ "pre_opt_locked", ERR_BUS_LOCKED, -EBUSY, false, true },
+	{ "pre_opt_mem_ops_sync", ERR_MEM_OPS, -ENOTSUPP, true, true },
+	{ "sync_success", ERR_NONE, 0, true },
+	{ "sync_success_queued", ERR_NONE, 0, true, false, true },
+};
+
+static void spi_core_err_desc(const struct spi_core_err_param *t, char *desc)
+{
+	strscpy(desc, t->name, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(spi_core_err, spi_core_err_cases, spi_core_err_desc);
+
+/*
+ * Verify cumulative controller optimize/unoptimize callback counts and the
+ * current optimization state of ctx->msg:
+ * @opt:   expected cumulative ctlr->optimize_message() count
+ *         (ctx->optimize_count).
+ * @unopt: expected cumulative ctlr->unoptimize_message() count
+ *         (ctx->unoptimize_count).
+ * @state: expected current optimization state of ctx->msg:
+ *         - true:  currently optimized (msg.optimized == true,
+ *                  msg.opt_state == ctx, split-transfer resource present in
+ *                  msg.resources, and 2 split transfers in msg.transfers).
+ *         - false: unoptimized (msg.optimized == false, msg.opt_state == NULL,
+ *                  msg.resources is empty, and original 1 transfer restored).
+ */
+static void check_state(struct kunit *test, struct spi_core_test_ctx *ctx,
+			int opt, int unopt, bool state)
+{
+	KUNIT_EXPECT_EQ(test, ctx->optimize_count, opt);
+	KUNIT_EXPECT_EQ(test, ctx->unoptimize_count, unopt);
+	KUNIT_EXPECT_FALSE(test, ctx->bad_opt_state);
+	KUNIT_EXPECT_EQ(test, ctx->msg.optimized, state);
+	KUNIT_EXPECT_EQ(test, !ctx->msg.opt_state, !state);
+	KUNIT_EXPECT_EQ(test, list_empty(&ctx->msg.resources), !state);
+	KUNIT_EXPECT_EQ(test, list_is_singular(&ctx->msg.transfers), !state);
+}
+
+static int spi_core_test_send_locked(struct spi_device *spi, struct spi_message *msg)
+{
+	int ret;
+
+	spi_bus_lock(spi->controller);
+	ret = spi_async(spi, msg);
+	spi_bus_unlock(spi->controller);
+
+	return ret;
+}
+
+static void spi_core_queue_error_test(struct kunit *test)
+{
+	const struct spi_core_err_param *p = test->param_value;
+	struct spi_core_test_ctx *ctx = spi_core_test_ctx_new(test, p->mode == ERR_MEM_OPS);
+	int exp = p->exp, ret;
+
+	ctx->ctlr->must_async = p->must_async;
+	if (p->pre_opt)
+		KUNIT_ASSERT_EQ(test, spi_optimize_message(ctx->spi, &ctx->msg), 0);
+	if (p->mode == ERR_SUSPEND)
+		KUNIT_ASSERT_EQ(test, 0, spi_controller_suspend(ctx->ctlr));
+
+	if (p->mode == ERR_BUS_LOCKED)
+		ret = spi_core_test_send_locked(ctx->spi, &ctx->msg);
+	else if (p->use_sync)
+		ret = spi_sync(ctx->spi, &ctx->msg);
+	else
+		ret = spi_async(ctx->spi, &ctx->msg);
+
+	if (p->mode == ERR_SUSPEND)
+		KUNIT_ASSERT_EQ(test, 0, spi_controller_resume(ctx->ctlr));
+
+	KUNIT_EXPECT_EQ(test, ret, exp);
+	if (!exp) {
+		KUNIT_EXPECT_EQ(test, ctx->msg.actual_length, sizeof(ctx->tx));
+		/*
+		 * Normal error-free situation for the ERR_NONE control cases
+		 * (sync_success on the noqueue fast-path and
+		 * sync_success_queued on the kthread worker path):
+		 * - Expected: (opt = 1, unopt = 1, state = false).
+		 *   Meaning: spi_sync() optimized ctx->msg once before the
+		 *   transfer (opt = 1) and unoptimized it once on completion
+		 *   (unopt = 1), leaving ctx->msg unoptimized (state = false:
+		 *   msg.resources is empty and the single 4-byte transfer is
+		 *   restored).
+		 */
+		check_state(test, ctx, 1, 1, false);
+		return;
+	}
+
+	/*
+	 * Check message optimization state immediately after queuing fails
+	 * across the 5 error test cases:
+	 *
+	 * Group A: Core-optimized queue failures (p->pre_opt == false)
+	 *   1. bus_locked_async: spi_async() fails with -EBUSY while the bus
+	 *      lock is held by another caller.
+	 *   2. suspend_async: spi_async() fails with -ESHUTDOWN while the
+	 *      controller queue is stopped by spi_controller_suspend().
+	 *   3. mem_ops_sync: spi_sync() fails with -ENOTSUPP on a controller
+	 *      that only implements mem_ops (ctlr->transfer == NULL).
+	 *   - Expected (patched): (opt = 1, unopt = 1, state = false).
+	 *     Meaning: spi_async() / __spi_sync() optimized ctx->msg (opt = 1)
+	 *     before queuing failed, and spi_maybe_unoptimize_message() on the
+	 *     error path immediately unoptimized it (unopt = 1), restoring
+	 *     ctx->msg to the clean unoptimized state (state = false:
+	 *     msg.optimized == false, msg.opt_state == NULL, split transfers
+	 *     in msg.resources freed, and original 1 transfer restored).
+	 *   - Broken behavior watched for (unpatched): (opt = 1, unopt = 0,
+	 *     state = true).
+	 *     Meaning: spi_async() / __spi_sync() returned the queue error
+	 *     without calling spi_maybe_unoptimize_message(), leaving
+	 *     unopt = 0 and ctx->msg stuck in the optimized state
+	 *     (state = true: msg.optimized == true, msg.opt_state == ctx, and
+	 *     the 2 split transfers leaked on msg.resources).
+	 *
+	 * Group B: Caller pre-optimized queue failures (p->pre_opt == true)
+	 *   4. pre_opt_locked: caller pre-optimized ctx->msg via
+	 *      spi_optimize_message(), then spi_async() fails with -EBUSY.
+	 *   5. pre_opt_mem_ops_sync: caller pre-optimized ctx->msg via
+	 *      spi_optimize_message(), then spi_sync() fails with -ENOTSUPP.
+	 *   - Expected (patched): (opt = 1, unopt = 0, state = true).
+	 *     Meaning: the caller explicitly pre-optimized ctx->msg (opt = 1,
+	 *     msg.pre_optimized == true) before submission, so
+	 *     spi_maybe_unoptimize_message() on the queue error path must
+	 *     preserve the caller's pre-optimization (unopt = 0, state = true)
+	 *     until the caller explicitly calls spi_unoptimize_message() below.
+	 *   - Broken behavior watched for (if error cleanup unconditionally
+	 *     called __spi_unoptimize_message() instead of
+	 *     spi_maybe_unoptimize_message()): (opt = 1, unopt = 1,
+	 *     state = false).
+	 *     Meaning: the error path would prematurely destroy the caller's
+	 *     pre-optimized state, causing a double-unoptimize when the caller
+	 *     later calls spi_unoptimize_message().
+	 */
+	check_state(test, ctx, 1, p->pre_opt ? 0 : 1, p->pre_opt);
+	if (p->pre_opt)
+		spi_unoptimize_message(&ctx->msg);
+	if (p->mode == ERR_MEM_OPS)
+		return;
+
+	reinit_completion(&ctx->done);
+	KUNIT_ASSERT_EQ(test, spi_async(ctx->spi, &ctx->msg), 0);
+	KUNIT_ASSERT_NE(test, wait_for_completion_timeout(&ctx->done, msecs_to_jiffies(1000)), 0);
+	KUNIT_EXPECT_EQ(test, ctx->msg.status, 0);
+	/*
+	 * Normal error-free situation after retry for the retryable error
+	 * cases (bus_locked_async after spi_bus_unlock(), suspend_async after
+	 * spi_controller_resume(), and pre_opt_locked after
+	 * spi_unoptimize_message() + spi_bus_unlock()):
+	 * - Expected (patched): (opt = 2, unopt = 2, state = false).
+	 *   Meaning: resubmitting the same ctx->msg after the transient error
+	 *   clears optimizes it a second time (opt = 2) and unoptimizes it on
+	 *   completion (unopt = 2), leaving ctx->msg unoptimized
+	 *   (state = false).
+	 * - Broken behavior watched for (unpatched): (opt = 2, unopt = 1,
+	 *   state = false).
+	 *   Meaning: in bus_locked_async and suspend_async, the first failed
+	 *   attempt leaked ctx->msg in the optimized state (opt = 1,
+	 *   unopt = 0, state = true), so retrying the leaked message
+	 *   re-optimizes an already-optimized message (opt = 2) and only
+	 *   unoptimizes once when the retry completes (unopt = 1).
+	 */
+	check_state(test, ctx, 2, 2, false);
+}
+
+static struct kunit_case spi_core_optimize_cases[] = {
+	KUNIT_CASE_PARAM(spi_core_queue_error_test, spi_core_err_gen_params),
+	{}
+};
+
+static struct kunit_suite spi_core_optimize_suite = {
+	.name = "spi_core_optimize",
+	.test_cases = spi_core_optimize_cases,
+};
+
+kunit_test_suite(spi_core_optimize_suite);
+
+MODULE_DESCRIPTION("KUnit tests for SPI core message optimize state");
+MODULE_LICENSE("GPL");
-- 
2.56.0.317.g454f8302e1-goog

