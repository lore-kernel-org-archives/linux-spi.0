Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746106;
	b=qM7C06Fwu5sxzrQaSP5Nl82q54NEGgA2CP+qmO3J3oj7DjpFZRVNmZGWaZgpxMV5W512
	 wilqWwf/V65oc30aDQLOt2LN/nrIwHel4cAOb5ZpLCtl/qiuMM9vmyfLm+1GbQ12QPNlF
	 5b4adYXdBml9nxPk9Hm6SB3vbk2TF4ZzPbo9CeresvbVjv15KlYCZzdSJjG5W5UUu00cJ
	 vQ7ixsCQu2QqmQa+Idea/Kx6aZ5qwHeqz2wvzFZkgGumndeBdE2JQ2ck59BdNpr3YBBzB
	 KXQrQuEK8OMgSgwaJ+BPk16b46R3al8nw3iCjibdYRDcm/sjPaQSTfJkDMezEqNWeiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QH7MSGsWhPMkH24VgoU1l6uTIc9DDT/eidrBb6hSJ0w=;
	b=e6Tc1endNfPbyD/r2J7j1eRCehtMF20kihuwGhY9ADskd6jPbxUSgF/zwGPm1kF0g6hI
	 KXgGxCiSEoQ5R35A9dr0mAajt5KCHZ77Iv6mh3ObITSb7hMdG/y4vCYtLvrgfyBjcxyd7
	 iuCz8/weXn3OD43GpuoKS9e3x/gGgTMO5VzM8McDAjhQvp43PB7deDESJxeq3Cs8Py815
	 LfkThX5wVPGBd5oxP5AGkiuq8+ojGsWDxYxnvdPepV6v6QZyRymBU1we/6VnDoZHRkLtG
	 rXfWrlzhKz1xUobEiXW2RyFlYHdeQaxACT3KKg2B8nZCIneygjm8IRw+rWlxSpuw5Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SwlbBNhz;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7D0606A329
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 22:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC7D0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SwlbBNhz
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so120159a91.1
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 14:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746105; x=1794350905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QH7MSGsWhPMkH24VgoU1l6uTIc9DDT/eidrBb6hSJ0w=;
        b=SwlbBNhz613M3ze4NOUE9FZ9z8rUnCbqzQRitYsqg/LIow39A+bl/ODGYSsgf3evJX
         13FM23fM+NVMJKUK+wCS6J8JJMCC62AMPB4GHK8uWJrnbFkiwjmzej1xcOYOkRCrZYlE
         gzWHcyjhTtClZB6GejPkZ1OlxMZ4UWvjkX+FY2bCCedMWIzngojpafPvnNoIGyIHKfKu
         AmjUa83+y9prAlo5wm4j1Xx+gn4wzeWvOaRg3yWdK6+DLhOrqPlbM8gJl5mQmEh6Cuqh
         +3mJJ7wM/QZLX0/9n49I0LhBrUcoFswi/uHPVa7EA84vs3RsinONvsXn3aAE+bpNNusF
         7LAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746105; x=1794350905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QH7MSGsWhPMkH24VgoU1l6uTIc9DDT/eidrBb6hSJ0w=;
        b=NP6RHePvC8KV/d8hxKpRC/r00CFysZAjJnCyfvaO8OgCgeKOJS0buZNspfFSfWNFvo
         tBauYu7Q+p1eLktfkRbM50X4+meW5WWKxEMBSzbplafDTGX/HX2AcJPytc2vos2nLnuy
         HOauTtJb3jtgrF59q9rPA4u+ESZ+jg7eZQv4c1he0QirjnrFAyircBOYRu2MPFxe6bcQ
         +S17DepXni5KtE33h+v2F5UiteW0S8uTmgFhnL8gFHvYXBOKBWU4OUsX7MU7s22oVVle
         RfXryD1VSHKg0nDGK0/J8kbd25mH6/wPMh2IfTahOHfhZ64gKSiXrgztvTjOSFNyDIXG
         3e2A==
X-Gm-Message-State: APuU4Z91gLW5RyAMSLWVKtGm7neIJBGg3/wYIUl7eTfzY+y+d9X1COcq
	i78DU9fJHv58Gk5TG27OKqn+iW9JBYT3dWIDwFw6cRSjuiKfBSi1WklW
X-Gm-Gg: AYBFou0c1heUVNLa8pMeMl+FdTNhVVhuuImPjfVcwodgEJrL5lPDj4MI+5P4tchLQ2Z
	ET9LDapeH2Oe6UDZ4H8qQzLCG+0tj9BlbuhSoAd1k9RGGCcKxnY/jk8GdRmu9GVE09csCPuCWkT
	YkcTiet/UGogbMXnmNYfQd/fLJXrBspE0Bd3bTt7re1TXhxbOD0VCXf78YXt2yjYqYpxKQCZYaE
	xFWUoOGd9eeVyPcFyU4IqpBhIH5YyIlTbNwy/ht1weaCDHMLNNKyvrYnzTrbt7QYFAviHOs1MGU
	uwHWaxfXY46ThkRhBmqynHKip41Yj2yhTbTtpnvZIi1be0ERxIwSm44aVpC3pIAK1PFynNz8wlE
	esiCevovmg9EBaQ26qojB8cdKHquF+OmNFsSNOnf8Rsq+aURUjdM2dR88UHWL44lVPeAaU9jdMO
	IgtBOcIeqvjrkXe4bjjMb0tofdjjQN9sU+Z5BEex44YUELJkZySnZHucUnvmERTpQRHvviHpdx9
	m5QgnHLOCHaAN0ApmUMc00PafmQKX4cY8SBfv9pBUjhN8nxwPs5r8s5bFUilE92E2UojEOYrBH/
	qzaFzylNkaHz3OeuW7xcmK+EO+tfrwNWiKpZ0NuRwzKP1kHBzjWU7cuKI/Z2UGH/xbSyJzdFu8p
	jA6OYthDWkfOGVJnUr3L84UCTRzfOFkmyfcpHrKbzIQKBjaA4QHMrlASRJG2XA95kV/ixiwB0pM
	xrfkzfofC8xpQW/blw87KGW4kBiabI97OJP4XRNE7sm+slR4AU305i3AK7vXJHhuMQ2A==
X-Received: by 2002:a17:90a:e7d2:b0:3ac:4e18:2390 with SMTP id 98e67ed59e1d1-3ae895743d0mr12742742a91.7.1793746105331;
        Tue, 03 Nov 2026 14:48:25 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0982e9284sm129962a91.11.2026.11.03.14.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:48:24 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH v2 2/2] spi: add KUnit tests for message optimize state on queue errors
Date: Tue,  3 Nov 2026 22:47:53 +0000
Message-ID: <20261103224753.3610049-3-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103224753.3610049-1-jctchan@gmail.com>
References: <20261103224753.3610049-1-jctchan@gmail.com>
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
on the controller, because the controller's transfer() callback returns
an error, or because the controller is suspended, the message is never
finalized, and finalizing is where the core normally unoptimizes it.

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

Developed with help from the Claude and Gemini AI assistants.

Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
v2: Inject errors through a transfer() callback on the fake controller
instead of mem_ops, use designated initializers, and trim the comments.

 drivers/spi/Kconfig                |  13 ++
 drivers/spi/Makefile               |   1 +
 drivers/spi/tests/.kunitconfig     |   4 +
 drivers/spi/tests/Makefile         |   1 +
 drivers/spi/tests/spi-core-kunit.c | 262 +++++++++++++++++++++++++++++
 5 files changed, 281 insertions(+)
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
index 000000000000..5ddd6c574170
--- /dev/null
+++ b/drivers/spi/tests/spi-core-kunit.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0
+// KUnit tests for the SPI core message optimize state.
+#include <kunit/device.h>
+#include <kunit/test.h>
+#include <linux/completion.h>
+#include <linux/errno.h>
+#include <linux/jiffies.h>
+#include <linux/spi/spi.h>
+
+struct spi_core_test_ctx {
+	struct spi_controller *ctlr;
+	struct spi_device *spi;
+	int (*queued_transfer)(struct spi_device *spi, struct spi_message *msg);
+	int optimize_count, unoptimize_count;
+	int transfer_err;
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
+static int spi_core_test_transfer(struct spi_device *spi,
+				  struct spi_message *msg)
+{
+	struct spi_core_test_ctx *ctx =
+		spi_controller_get_devdata(spi->controller);
+
+	if (ctx->transfer_err)
+		return ctx->transfer_err;
+
+	return ctx->queued_transfer(spi, msg);
+}
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
+static struct spi_core_test_ctx *spi_core_test_ctx_new(struct kunit *test)
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
+	ctlr->transfer_one_message = spi_core_test_xfer_one;
+	KUNIT_ASSERT_EQ(test, 0, devm_spi_register_controller(dev, ctlr));
+	ctx->queued_transfer = ctlr->transfer;
+	ctlr->transfer = spi_core_test_transfer;
+	ctx->spi = spi_new_device(ctlr, &info);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->spi);
+	init_completion(&ctx->done);
+	/* 4-byte TX buffer with max_transfer_size = 2 splits into two 2-byte transfers. */
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
+	ERR_TRANSFER,
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
+	{
+		.name = "bus_locked_async",
+		.mode = ERR_BUS_LOCKED,
+		.exp = -EBUSY,
+	},
+	{
+		.name = "suspend_async",
+		.mode = ERR_SUSPEND,
+		.exp = -ESHUTDOWN,
+	},
+	{
+		.name = "xfer_err_sync",
+		.mode = ERR_TRANSFER,
+		.exp = -EIO,
+		.use_sync = true,
+		.must_async = true,
+	},
+	{
+		.name = "pre_opt_locked",
+		.mode = ERR_BUS_LOCKED,
+		.exp = -EBUSY,
+		.pre_opt = true,
+	},
+	{
+		.name = "pre_opt_xfer_err_sync",
+		.mode = ERR_TRANSFER,
+		.exp = -EIO,
+		.use_sync = true,
+		.pre_opt = true,
+		.must_async = true,
+	},
+	{
+		.name = "sync_success",
+		.mode = ERR_NONE,
+		.exp = 0,
+		.use_sync = true,
+	},
+	{
+		.name = "sync_success_queued",
+		.mode = ERR_NONE,
+		.exp = 0,
+		.use_sync = true,
+		.must_async = true,
+	},
+};
+
+static void spi_core_err_desc(const struct spi_core_err_param *t, char *desc)
+{
+	strscpy(desc, t->name, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(spi_core_err, spi_core_err_cases, spi_core_err_desc);
+
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
+	struct spi_core_test_ctx *ctx = spi_core_test_ctx_new(test);
+	int exp = p->exp, ret;
+
+	ctx->ctlr->must_async = p->must_async;
+	if (p->pre_opt)
+		KUNIT_ASSERT_EQ(test, spi_optimize_message(ctx->spi, &ctx->msg), 0);
+	if (p->mode == ERR_SUSPEND)
+		KUNIT_ASSERT_EQ(test, 0, spi_controller_suspend(ctx->ctlr));
+	if (p->mode == ERR_TRANSFER)
+		ctx->transfer_err = -EIO;
+
+	if (p->mode == ERR_BUS_LOCKED)
+		ret = spi_core_test_send_locked(ctx->spi, &ctx->msg);
+	else if (p->use_sync)
+		ret = spi_sync(ctx->spi, &ctx->msg);
+	else
+		ret = spi_async(ctx->spi, &ctx->msg);
+
+	ctx->transfer_err = 0;
+	if (p->mode == ERR_SUSPEND)
+		KUNIT_ASSERT_EQ(test, 0, spi_controller_resume(ctx->ctlr));
+
+	KUNIT_EXPECT_EQ(test, ret, exp);
+	if (!exp) {
+		KUNIT_EXPECT_EQ(test, ctx->msg.actual_length, sizeof(ctx->tx));
+		check_state(test, ctx, 1, 1, false);
+		return;
+	}
+
+	/* Core-optimized messages are unoptimized on queue error; pre-optimized stay optimized. */
+	check_state(test, ctx, 1, p->pre_opt ? 0 : 1, p->pre_opt);
+	if (p->pre_opt)
+		spi_unoptimize_message(&ctx->msg);
+
+	reinit_completion(&ctx->done);
+	ctx->msg.complete = kunit_done;
+	ctx->msg.context = &ctx->done;
+	KUNIT_ASSERT_EQ(test, spi_async(ctx->spi, &ctx->msg), 0);
+	KUNIT_ASSERT_NE(test, wait_for_completion_timeout(&ctx->done, msecs_to_jiffies(1000)), 0);
+	KUNIT_EXPECT_EQ(test, ctx->msg.status, 0);
+	/* Resubmitting the message after the transient error clears succeeds cleanly. */
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
2.56.0.385.gac671c819a-goog

