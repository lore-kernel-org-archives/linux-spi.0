Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794535443;
	b=F1TRCj87gtBSJklYfz6HEjyn5t3MpcDmXRV5Vt+blD+LK/BkMnajZ+naPMH8uoH6sPYN
	 TEW6tGjOGl5NeZ/LLgf7T0O2Xw+Kze9ix0lzpEInCi86NJJR2Vua09B1BR/P1r1rWY+tH
	 SEkdEnW7gunS1GuQIl32J++N7sO+0g87bnkQag8+ug1lu1dcRXj6uvAyI8DiZiAnv5apt
	 Pa+0OVYHh5cY7eWUHwnz1/001vn84YzSoQmeYV3ZHdW7A3L8/vRMqXu8p0iQWwrYNrjBq
	 8oD4O117LVnOu4lz/a6SKiSknaVOPRq1WXxklxDqCOYU1P0WB92oKaDVpvrlwh+x6xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794535443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EAJPgAmiQCZuUyfZVuOd0lRrBF3seO/tiIT4viAPVF8=;
	b=GB2IaLMtcZbZDyG8r73j6JCDVxN+oVBb0S2eCiaw721bXTHrH6uYHYj//eFefaXSA3NM
	 EHhtfAmczNSCOCyopvR54GkwzWxZJm9ZI1GAiXLPWF7GL3FuR1nHlB3ULyMtZ1vm8HbhM
	 3kgA18vgteOahjs3uKtGlvWlUtGOkodIifjH23HDm2/dMlj3/CAxDtFn2N9+DCLip+8bd
	 0Vu6hGf/5BSlznjP0HwhtgBPv7bpsELtESd8NeoGxwMkFjmbQPfpNLU4p8XvHvsFGieCH
	 FvSMt53ThNTeJT8WmB6seahwP5Npzt0HPefufCXPDpnTWZedQrgB6GLYfD5tYh5niGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cw1034tV;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B403B606A334
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 02:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B403B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cw1034tV
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b17cf2fa0aso815813a91.0
        for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 18:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794535442; x=1795140242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EAJPgAmiQCZuUyfZVuOd0lRrBF3seO/tiIT4viAPVF8=;
        b=Cw1034tVG0GAiUO16hx+Dk1YlimXLKkkgEz23Dn7elM2lXfMQr1fEwjyhRtvIFJ3H9
         6WMBqnN5lGZUqFdI8ZVCBS3/hwY2NPBt4Z8NdScr3JoXZfD6hUePlQPpUDw0SKDztJCF
         zIEkdKtRnZENXOz/3fFZqLE05F7DcUlRmypnD/mPkq0xEmr0hZcW1gmpaHPo8p5Xjg1g
         77aRcLMH/YUlQDk1ozzXtGho6tkR3EKUnQcoNjqT1VdRHLtNc+Nn+BtkRcEddAMhHH/m
         ZZH9KVUORUQ/RpKpMauCOkfMQuwSrJpw4VD0iQuI76Yhf/2GBmOSUG7KCuNGvJBVEJUf
         PWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794535442; x=1795140242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EAJPgAmiQCZuUyfZVuOd0lRrBF3seO/tiIT4viAPVF8=;
        b=iwsgVI9ZaMV2NpT5Vtc3c7aucSmryRxC4UxptJEzklufMYtVMqZA/V+ToKLmXramEP
         8tSVDqVX0A3h1m4QVOdq6T5BPFGkQWMi0AyQAIokHlglqlIP0gZjnjMx6Vi2HJjxQybt
         3pr6fk08cBd5hyEAH9PC0JH8VRYL96MASHQqFJT8j0LV1bdBhiWugj4Jlm3ZFDUAXnri
         K71a/EGK1lbL4TXmApHxA6hKEXnWSwMyVMLhPpqcrW4LIfgG5ybmvFnmFblyS9Magu0+
         aIU0Ikk7LxiAakizPW/SWK2Vhb6jPxxY9hcaAuFRwceEU/RDbFoIEa0b7Hj5TDhu+b1T
         a7FQ==
X-Gm-Message-State: APuU4Z+HVfifhDlr18YmaixTKjsZwNVxO0GBzkPzKiZE4UmUXZ4Ps5fj
	czP0IABL4OpyZVeZN500bFS5qtxMKEF0MHxL7KOjJ8kfHzYjxmakcrnaPsCLSO7i
X-Gm-Gg: AYBFou1BETr2YdrG5/D3D52GQAVGtbUTfgQnMmYY3nVbngMc5NOaOmAoqx7RrcCkBtA
	cV88oFIUuLTbBSLbNR+eXswinwbN8dYO+DhLVtlTFZDSvsrsTCGBsyTNeGxePM8bHnDpA0W7bLx
	aZ4PdaZOmxwZCxPUd5APQbB5wSHnHGO1tGgd9xNSeYIwvh95yyJExKghgMGn44HAi9bBYiTLtUW
	xnnp3xiJmUE2S9xcFY/GyTr3BSb2miOKWlu7pcPexKJRjWgqIvKclrpcXSPemBOC0FcDrCEGcjr
	yMNnLbsUCOffTQPCHQ8FhmlSekQ0VrT/9X+6g6QDpMGmDYdcNg4VGW+psuEq5iRT2I87QfFqy3D
	PZHSdHexirHs96rVnHet/HG/qbTEahm1XAgKirU7p09Kvpi2IAV1gdTyqC2ONkBB3ZqFfFZdb5k
	Qb9+XHCyKIUnqJ+sCyI+U5LZkH2HvWeNhBOIDb5VOMH0+reSO3sbqAWzRXEwhTjkqcucU696bya
	JyfL0h3qJrXaKGdfLoynoPOzDYNMyoZTZziyF6YWcM6Kc3+yS0SlR7mUCVj6eia9pTT6LsuXnJP
	fUJOtY4ZiAoSn2wJSWE6Tb/GU/Nt3Wc6a2V9DZAbs0wxzrUYhb08+Pf4dZAM9EBPE00VH7MEd1h
	MqlcFBeuMJLvqOWkwzrfpXMfRAmTqckkLg3SJjdkqqZb/SenwfCaW1fFfiJO1nhTvPsdmNFJncY
	Bo1UkAtWnCdRMWoo5CReClmgdG2CkO5zq3zja87Hwp1+ZOTyFGEpVXkXQDzMZtfapRBfWc
X-Received: by 2002:a17:90b:2245:b0:3ab:24b2:9016 with SMTP id 98e67ed59e1d1-3b1b0b8c09dmr763871a91.25.1794535441670;
        Thu, 12 Nov 2026 18:04:01 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (145.247.125.34.bc.googleusercontent.com. [34.125.247.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d04336sm7167618a91.7.2026.11.12.18.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 18:04:01 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH v3 2/2] spi: add KUnit tests for message optimize state on queue errors
Date: Fri, 13 Nov 2026 02:03:52 +0000
Message-ID: <20261113020352.1741295-3-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261113020352.1741295-1-jctchan@gmail.com>
References: <20261113020352.1741295-1-jctchan@gmail.com>
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

Include drivers/spi/tests from drivers/spi/Makefile unconditionally,
since tests/Makefile already checks the config symbol of each test, and
add the test to drivers/spi/.kunitconfig so that

  ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/spi

runs it together with the DMA tests.

Tested with KUnit on ARCH=um: all cases pass with the fixes in this series
applied. Builds with W=1 on x86_64.

Developed with help from the Claude and Gemini AI assistants.

Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
v3: Include drivers/spi/tests unconditionally from drivers/spi/Makefile,
and add the test to the existing drivers/spi/.kunitconfig instead of a
new drivers/spi/tests/.kunitconfig, as Mark suggested.
v2: Inject errors through a transfer() callback on the fake controller
instead of mem_ops, use designated initializers, and trim the comments.

 drivers/spi/.kunitconfig           |   1 +
 drivers/spi/Kconfig                |  13 ++
 drivers/spi/Makefile               |   2 +-
 drivers/spi/tests/Makefile         |   1 +
 drivers/spi/tests/spi-core-kunit.c | 262 +++++++++++++++++++++++++++++
 5 files changed, 278 insertions(+), 1 deletion(-)
 create mode 100644 drivers/spi/tests/spi-core-kunit.c

diff --git a/drivers/spi/.kunitconfig b/drivers/spi/.kunitconfig
index 07fa092c8fd0..83f91d52dd20 100644
--- a/drivers/spi/.kunitconfig
+++ b/drivers/spi/.kunitconfig
@@ -2,3 +2,4 @@ CONFIG_KUNIT=y
 CONFIG_SPI=y
 CONFIG_SPI_MASTER=y
 CONFIG_SPI_DMA_KUNIT_TEST=y
+CONFIG_SPI_CORE_KUNIT_TEST=y
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
index b493f50b93e3..b6ab37271555 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_SPI_MUX)			+= spi-mux.o
 obj-$(CONFIG_SPI_OFFLOAD)		+= spi-offload.o
 obj-$(CONFIG_SPI_SPIDEV)		+= spidev.o
 obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
-obj-$(CONFIG_SPI_DMA_KUNIT_TEST)	+= tests/
+obj-y					+= tests/
 
 # SPI master controller drivers (bus)
 obj-$(CONFIG_SPI_AIROHA_SNFI)		+= spi-airoha-snfi.o
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
2.56.0.506.g506a7eabc5-goog

