Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746418;
	b=xbuBGW9m9YsnMki0qgCRyd27KC1vK1zx3Zteqo8x8QcDK8K68jbpzoayUbH94pRYb4qO
	 ktF4gsyhadfReKvaJS3gP+jkKXY6asDfmDjmhAk6ImIpNzW0jfV2aGmHcsQBqog+BMrMt
	 K6zkf8R8yrIMLfNKzaMHgmCZbvTGMHHFivcgpoBCPlfoTsCnXFgyvv0wVLwi16O+xgWmQ
	 uP3hsZmfA04p35dj/1gEKUdqR4DUnIkmI7ZehT7MhO7UjWYxNjSrm+yrC2/w2NcNaqwY5
	 4awUG3WtxihdgfixtIWlf2TZ6RjKIpDIIRM1jAgARKnNSTPCGrSJqb4S0PsrNNzOxIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CR/Cs9UL5OxtULXmy6WYVgst3KLQYUEeGcV7oN6m2ys=;
	b=pRx5M6UK/dj86mEdYFowRXMVVCdYAmgxOyO9DBO7znv15Uk7PNlzj60/hA3Httvw4pqm
	 jbCKSaZPgsX7R7HwXxrT2JvOZrxrWUMy3d82aFciitixPGm07BF7O4sVbwPr6oBgECmxb
	 4WLLWvRBV6I7xxTolOfOppclTo11P906LJ3ehKaYsb+juFLQqtvk3+DG64K2+drB958xk
	 GHtxh2T6jx208Ca6Ve40hdE/53ooOZmiMYVQatISmB2a5KbeDLXTIQWcEwnHHOyq9WfIW
	 2SVgI9q1NFHt8EZGEiIQo7C+FFYzfcqZ+O0Fu65TOcZL9Ix5ARxwQGF6nV3smrK1O0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ASm0MTPj;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DEB606A324
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 22:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24DEB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ASm0MTPj
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b0960fdde9so76000a91.0
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 14:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746417; x=1794351217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CR/Cs9UL5OxtULXmy6WYVgst3KLQYUEeGcV7oN6m2ys=;
        b=ASm0MTPjINU5syKlJJWQNOnENlD5lUlyjXlv7SXArtrg2CI36rBXgihbnosJy7ZZQp
         Teqrgn6nYaW1XoiQ1dQFZ+VgmMm5T1hruQAzL0sU9Kk50bhjPbCgd1r8Jt3Fxd7IWjfY
         H+HjIBmRpIXS+6zmkBNID/tHt50YwPgGL+Oh62Wn5ubX2uTZLUpWQAVHF6+TkbObT8eU
         0d4F8P13BX3hnBzXZE/UHN5St0kaSxQVHxyuzN9Z5PqqkIZC6/r6j56yYHOQj/20SSiC
         yPpce/CN+45pfhnrqFByCygSqGE14hqQ3SftkeaIne0iyP5h5EFucnPD/7AikAz9NjUI
         swmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746417; x=1794351217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CR/Cs9UL5OxtULXmy6WYVgst3KLQYUEeGcV7oN6m2ys=;
        b=QdWMqek2UEJHxZNSFAD0eRs4UR92fZmRFhmdpFVpYJ/PtAoFflFU2SRxhd8pi+fmOg
         D2Nn9Gf5bqPBFNc/s5UZVY+mIfQVZcPV7uHBD9CzS6KkU3inGuL/wOJNwC8NW/AxUgT2
         AJqLnp2hFcZgLnYWRhaj8lwefJypvqRtRXYgZFLEZqFCDClFivxDTgyzaZJO6XpGwDC3
         qvvU4i1ra5cq6cr6Fu/p/Ox/LNXK1b1b1g7r8s5WgHJ+dVD3+23ROgsFFJQuZExC/nyP
         M6SkdUyXhF1iq68rduvXAYt4Ci7trCsGOd9P1B7pwA4Acf3OA+Sef8kp33TY0dwGZ+Eb
         ufrQ==
X-Gm-Message-State: APuU4Z8eVI/fcshrYi7D0blyEoFBCJCmGjcYo229IqipEeGQJQI0NM8q
	GkgxzON+M/76eCiMfmgenG/v1Ut3N+Eygui8EdqHTwRc+9zn2AFnesHA
X-Gm-Gg: AYBFou0JoLUqzWzR/PL+uUW4gJfeNdRgMZcR6l3R/0JzVY36HYsGVWQ8sLNt06u9/xH
	XD26c8bdTjR/JWpZhtpi+aayRrhMtWke7mqGV36Hj4kiPXzlqT4icG2Y5SgAhnVMdqvOQp3fant
	xeqLEub3ymJJHhihUS9Ya4BCIlZ8CKjpk+cWvMoA8DpzNB4rCs/WD1vCp+RBQHyzAREnOkrgPtd
	ukqBfjXIObN91vyPx7qwW56Xw1pZeNCVjpK6GrsiU/zb3p7f80L2OsnA7UUW7TY+AWCOooRGfG+
	ujaoEckKhrphwnop7uCrIACKuZnE/RfX1q9XBoP/xwd+mFpAAJuddc2+29DWM42lpdtDDaRquq4
	8UTEMN3M66sYntdWuQ88Tefzfg2JIZZBQdx6H2EWhzz8HM37U2NEB0dgGB5uH9q2xp9vSpVcjtj
	P+NfLNuWHrMhc7qiK5vLF4inc3qDzpa78rSKVgLm5GXySSolE64es05XAthhcesb+FTRudAbqzk
	QJxWfs09A+T1YYouz3sRk1HatERnCiu8O80QcvwNtGbMe/Pt+T1FcUZ+9au7u8ys4lUP8cuD1AC
	Za1sRnfWPfxb5Mlu+9tDpPyXGP2Stp8Pac9yLwgOi41tVhoZIsW77Z5KMouKf8LhWchaXY868ID
	lMvIMaXuGkox5/O7oIjA1K5L5aHKu2Yc5jwvKhYFFVhkQHm5NVHVGNNndiPLk3a1vD3Gqp8QWoq
	GBFSmdzuxjnN9I7ukxlYb0EpgiJvNDhpGmPvUIVlP3fINJFEslGq7wx7lS8GaAdyzhJg==
X-Received: by 2002:a17:90a:f615:b0:3b0:9317:5849 with SMTP id 98e67ed59e1d1-3b093175caamr488318a91.1.1793746417026;
        Tue, 03 Nov 2026 14:53:37 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c896cc6sm6096249a91.9.2026.11.03.14.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:53:36 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH v2 5/5] spi: spi-mux: add KUnit tests for forwarding errors and settings
Date: Tue,  3 Nov 2026 22:53:08 +0000
Message-ID: <20261103225308.3633046-6-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103225308.3633046-1-jctchan@gmail.com>
References: <20261103225308.3633046-1-jctchan@gmail.com>
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

Add a KUnit test suite (spi_mux) with a Device Tree overlay that
instantiates a fake mux controller, a fake parent SPI controller, the
real spi-mux driver, and two child SPI devices.

The suite covers three areas:
- spi_mux_error_test: forwarding errors (locked parent bus, invalid
  transfer length, mux select failure, and parent spi_setup() failure),
  verifying that the message is finalized, the mux is released, the
  caller's message fields and optimize state are restored, and
  subsequent transfers succeed.
- spi_mux_cs_delay_test: CS setup, hold, and inactive delay merging
  across ns, us, and SCK units, including zero-value SCK delays.
- spi_mux_settings_lifecycle_test: re-applying child mode, speed,
  bits_per_word, and delay changes after spi_setup(), switching
  between children with different delays, and restoring the spi-mux
  device's own delays on driver unbind.

Developed with help from the Claude and Gemini AI assistants.

Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
v2: Designated initializers for the test tables, trimmed the comments.

 drivers/spi/Kconfig                  |  14 +
 drivers/spi/Makefile                 |   1 +
 drivers/spi/tests/.kunitconfig       |   4 +
 drivers/spi/tests/Makefile           |   2 +
 drivers/spi/tests/kunit_spi_mux.dtso |  42 +++
 drivers/spi/tests/spi-mux-kunit.c    | 506 +++++++++++++++++++++++++++
 6 files changed, 569 insertions(+)
 create mode 100644 drivers/spi/tests/kunit_spi_mux.dtso
 create mode 100644 drivers/spi/tests/spi-mux-kunit.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index feb9265b7d0f..9a36bf9cf94f 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1386,6 +1386,20 @@ config SPI_MUX
 	  to be chip selects on this controller. It is still necessary to
 	  select one or more specific mux-controller drivers.
 
+config SPI_MUX_KUNIT_TEST
+	tristate "KUnit tests for spi-mux" if !KUNIT_ALL_TESTS
+	depends on KUNIT && SPI_MUX && OF_OVERLAY
+	select DTC
+	default KUNIT_ALL_TESTS
+	help
+	  Build KUnit tests for the SPI multiplexer driver. A device tree
+	  overlay adds a fake parent controller, a test mux chip and an
+	  spi-mux device with two children. The tests check that a message
+	  which cannot be forwarded is completed with an error and releases
+	  the mux, and that child settings and delays reach the parent.
+
+	  If unsure say N.
+
 #
 # There are lots of SPI device types, with sensors and memory
 # being probably the most widely used ones.
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 24497d3936f6..9826626995a9 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
 obj-$(CONFIG_SPI_DMA_KUNIT_TEST)	+= tests/
 obj-$(CONFIG_SPI_CORE_KUNIT_TEST)	+= tests/
 obj-$(CONFIG_SPI_TI_QSPI_KUNIT_TEST)	+= tests/
+obj-$(CONFIG_SPI_MUX_KUNIT_TEST)	+= tests/
 
 # SPI master controller drivers (bus)
 obj-$(CONFIG_SPI_AIROHA_SNFI)		+= spi-airoha-snfi.o
diff --git a/drivers/spi/tests/.kunitconfig b/drivers/spi/tests/.kunitconfig
index 354bafc42c2b..1631a16ce6ec 100644
--- a/drivers/spi/tests/.kunitconfig
+++ b/drivers/spi/tests/.kunitconfig
@@ -6,3 +6,7 @@ CONFIG_SPI_CORE_KUNIT_TEST=y
 CONFIG_COMPILE_TEST=y
 CONFIG_SPI_TI_QSPI=y
 CONFIG_SPI_TI_QSPI_KUNIT_TEST=y
+CONFIG_OF=y
+CONFIG_OF_OVERLAY=y
+CONFIG_SPI_MUX=y
+CONFIG_SPI_MUX_KUNIT_TEST=y
diff --git a/drivers/spi/tests/Makefile b/drivers/spi/tests/Makefile
index a5a8fc9435d4..0ec04ecd4d55 100644
--- a/drivers/spi/tests/Makefile
+++ b/drivers/spi/tests/Makefile
@@ -3,3 +3,5 @@
 obj-$(CONFIG_SPI_DMA_KUNIT_TEST) += spi-dma-kunit.o
 obj-$(CONFIG_SPI_CORE_KUNIT_TEST) += spi-core-kunit.o
 obj-$(CONFIG_SPI_TI_QSPI_KUNIT_TEST) += spi-ti-qspi-kunit.o
+obj-$(CONFIG_SPI_MUX_KUNIT_TEST) += spi-mux-kunit-test.o
+spi-mux-kunit-test-y := spi-mux-kunit.o kunit_spi_mux.dtbo.o
diff --git a/drivers/spi/tests/kunit_spi_mux.dtso b/drivers/spi/tests/kunit_spi_mux.dtso
new file mode 100644
index 000000000000..48e72ba8e217
--- /dev/null
+++ b/drivers/spi/tests/kunit_spi_mux.dtso
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	tmux: kunit-spi-mux-chip {
+		compatible = "test,spi-mux-kunit-chip";
+		#mux-control-cells = <0>;
+	};
+
+	kunit-spi-mux-parent {
+		compatible = "test,spi-mux-kunit-parent";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		spi@0 {
+			compatible = "spi-mux";
+			reg = <0>;
+			spi-max-frequency = <1000000>;
+			spi-cs-setup-delay-ns = <1000>;
+			spi-cs-hold-delay-ns = <300>;
+			mux-controls = <&tmux>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			device@0 {
+				compatible = "test,spi-mux-kunit-child";
+				reg = <0>;
+				spi-max-frequency = <1000000>;
+			};
+
+			device@1 {
+				compatible = "test,spi-mux-kunit-child";
+				reg = <1>;
+				spi-max-frequency = <2000000>;
+				spi-cs-setup-delay-ns = <1500>;
+				spi-cs-hold-delay-ns = <100>;
+				spi-cs-inactive-delay-ns = <700>;
+			};
+		};
+	};
+};
diff --git a/drivers/spi/tests/spi-mux-kunit.c b/drivers/spi/tests/spi-mux-kunit.c
new file mode 100644
index 000000000000..f1661bb19f31
--- /dev/null
+++ b/drivers/spi/tests/spi-mux-kunit.c
@@ -0,0 +1,506 @@
+// SPDX-License-Identifier: GPL-2.0
+// KUnit tests for spi-mux error handling and settings forwarding.
+#include <kunit/of.h>
+#include <kunit/platform_device.h>
+#include <kunit/test.h>
+#include <linux/completion.h>
+#include <linux/jiffies.h>
+#include <linux/kthread.h>
+#include <linux/mux/consumer.h>
+#include <linux/mux/driver.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+
+#define PFX "/kunit-spi-mux-parent/spi@0"
+
+struct spi_mux_test_ctx {
+	struct mux_control *mux;
+	struct spi_controller *parent;
+	struct spi_device *child[2], *mux_spi;
+	int opt_cnt, unopt_cnt, mux_err, setup_err;
+	u32 last_speed_hz, last_mode;
+	u8 last_bpw;
+	struct spi_delay last_w, last_s, last_h, last_in;
+	struct spi_transfer xfer;
+	struct spi_message msg;
+	struct completion done;
+	u8 tx[4];
+};
+
+static struct spi_mux_test_ctx *g_mux_ctx;
+
+static void kunit_done(void *p)
+{
+	complete(p);
+}
+
+/* DT defaults: mux_spi (1000, 300, 0, 0), child[1] (1500, 100, 700, 0). */
+static void check_delays(struct kunit *test, struct spi_mux_test_ctx *ctx,
+			 u16 s, u16 h, u16 in, u16 w)
+{
+	KUNIT_EXPECT_EQ(test, ctx->last_s.value, s);
+	KUNIT_EXPECT_EQ(test, ctx->last_h.value, h);
+	KUNIT_EXPECT_EQ(test, ctx->last_in.value, in);
+	KUNIT_EXPECT_EQ(test, ctx->last_w.value, w);
+}
+
+static void check_d(struct kunit *test, struct spi_delay d, struct spi_delay exp)
+{
+	KUNIT_EXPECT_EQ(test, d.value, exp.value);
+	KUNIT_EXPECT_EQ(test, d.unit, exp.unit);
+}
+
+static void check_msg_restored(struct kunit *test, struct spi_mux_test_ctx *ctx,
+			       struct spi_device *spi)
+{
+	kthread_flush_worker(spi->controller->kworker);
+	kthread_flush_worker(ctx->parent->kworker);
+	/* Mux semaphore must be released after a failed transfer. */
+	KUNIT_ASSERT_EQ(test, 0, mux_control_try_select(ctx->mux, 0));
+	mux_control_deselect(ctx->mux);
+	/* Child caller's spi_message fields must be restored. */
+	KUNIT_EXPECT_PTR_EQ(test, ctx->msg.spi, spi);
+	KUNIT_EXPECT_PTR_EQ(test, ctx->msg.complete, &kunit_done);
+	KUNIT_EXPECT_PTR_EQ(test, ctx->msg.context, &ctx->done);
+	/* Parent message optimization state and split transfers must be cleaned up. */
+	KUNIT_EXPECT_FALSE(test, ctx->msg.optimized);
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->msg.resources));
+	KUNIT_EXPECT_EQ(test, ctx->opt_cnt, ctx->unopt_cnt);
+}
+
+static int spi_mux_test_chip_set(struct mux_control *mux, int state)
+{
+	return g_mux_ctx ? READ_ONCE(g_mux_ctx->mux_err) : 0;
+}
+
+static const struct mux_control_ops spi_mux_test_chip_ops = {
+	.set = spi_mux_test_chip_set,
+};
+
+static int spi_mux_test_parent_opt(struct spi_message *msg)
+{
+	if (!g_mux_ctx)
+		return -ENODEV;
+	g_mux_ctx->opt_cnt++;
+	return 0;
+}
+
+static int spi_mux_test_parent_unopt(struct spi_message *msg)
+{
+	if (!g_mux_ctx)
+		return -ENODEV;
+	g_mux_ctx->unopt_cnt++;
+	return 0;
+}
+
+static int spi_mux_test_parent_setup(struct spi_device *spi)
+{
+	if (!g_mux_ctx)
+		return -ENODEV;
+	return xchg(&g_mux_ctx->setup_err, 0);
+}
+
+static void spi_mux_test_parent_set_cs(struct spi_device *spi, bool enable)
+{
+	if (!g_mux_ctx)
+		return;
+	g_mux_ctx->last_mode = spi->mode;
+	g_mux_ctx->last_s = spi->cs_setup;
+	g_mux_ctx->last_h = spi->cs_hold;
+	g_mux_ctx->last_in = spi->cs_inactive;
+}
+
+static int spi_mux_parent_xfer(struct spi_controller *c, struct spi_device *s,
+			       struct spi_transfer *x)
+{
+	if (!g_mux_ctx)
+		return -ENODEV;
+	g_mux_ctx->last_speed_hz = x->speed_hz;
+	g_mux_ctx->last_bpw = x->bits_per_word;
+	g_mux_ctx->last_w = x->word_delay;
+	return 0;
+}
+
+static size_t spi_mux_test_parent_max_transfer_size(struct spi_device *spi)
+{
+	return 2;
+}
+
+static int spi_mux_test_probe(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr;
+	struct mux_chip *chip;
+
+	if (!g_mux_ctx)
+		return -ENODEV;
+	if (of_device_is_compatible(pdev->dev.of_node, "test,spi-mux-kunit-chip")) {
+		chip = devm_mux_chip_alloc(&pdev->dev, 1, 0);
+		if (IS_ERR(chip))
+			return PTR_ERR(chip);
+		chip->ops = &spi_mux_test_chip_ops;
+		chip->mux[0].states = 2;
+		g_mux_ctx->mux = &chip->mux[0];
+		return devm_mux_chip_register(&pdev->dev, chip);
+	}
+	ctlr = devm_spi_alloc_host(&pdev->dev, 0);
+	if (!ctlr)
+		return -ENOMEM;
+	ctlr->bus_num = -1;
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_CS_WORD;
+	ctlr->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
+	ctlr->max_transfer_size = spi_mux_test_parent_max_transfer_size;
+	ctlr->setup = spi_mux_test_parent_setup;
+	ctlr->set_cs = spi_mux_test_parent_set_cs;
+	ctlr->transfer_one = spi_mux_parent_xfer;
+	ctlr->optimize_message = spi_mux_test_parent_opt;
+	ctlr->unoptimize_message = spi_mux_test_parent_unopt;
+	g_mux_ctx->parent = ctlr;
+	return devm_spi_register_controller(&pdev->dev, ctlr);
+}
+
+static const struct of_device_id spi_mux_test_match[] = {
+	{ .compatible = "test,spi-mux-kunit-chip" },
+	{ .compatible = "test,spi-mux-kunit-parent" },
+	{}
+};
+
+static struct platform_driver spi_mux_test_driver = {
+	.probe = spi_mux_test_probe,
+	.driver = {
+		.name = "spi-mux-kunit-driver",
+		.of_match_table = spi_mux_test_match,
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
+	},
+};
+
+KUNIT_DEFINE_ACTION_WRAPPER(spi_mux_test_put_dev, put_device, struct device *);
+
+static struct spi_device *spi_mux_test_find_dev(struct kunit *test, const char *path)
+{
+	struct device_node *np = of_find_node_by_path(path);
+	struct device *dev = bus_find_device_by_of_node(&spi_bus_type, np);
+
+	of_node_put(np);
+	KUNIT_ASSERT_NOT_NULL(test, dev);
+	KUNIT_ASSERT_EQ(test, 0, kunit_add_action_or_reset(test, spi_mux_test_put_dev, dev));
+	return to_spi_device(dev);
+}
+
+static int spi_mux_test_init(struct kunit *test)
+{
+	struct spi_mux_test_ctx *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	test->priv = ctx;
+	g_mux_ctx = ctx;
+	init_completion(&ctx->done);
+	ctx->xfer.tx_buf = ctx->tx;
+	ctx->xfer.len = sizeof(ctx->tx);
+	spi_message_init_with_transfers(&ctx->msg, &ctx->xfer, 1);
+	ctx->msg.complete = kunit_done;
+	ctx->msg.context = &ctx->done;
+	KUNIT_ASSERT_EQ(test, 0, kunit_platform_driver_register(test, &spi_mux_test_driver));
+	KUNIT_ASSERT_EQ(test, 0, of_overlay_apply_kunit(test, kunit_spi_mux));
+	ctx->child[0] = spi_mux_test_find_dev(test, PFX "/device@0");
+	ctx->child[1] = spi_mux_test_find_dev(test, PFX "/device@1");
+	ctx->mux_spi = to_spi_device(ctx->child[0]->controller->dev.parent);
+	return 0;
+}
+
+static void spi_mux_test_exit(struct kunit *test)
+{
+	struct spi_mux_test_ctx *ctx = test->priv;
+
+	if (ctx) {
+		if (ctx->child[0])
+			kthread_flush_worker(ctx->child[0]->controller->kworker);
+		if (ctx->parent)
+			kthread_flush_worker(ctx->parent->kworker);
+		if (ctx->mux) {
+			int ret;
+
+			ctx->mux_err = 0;
+			ret = mux_control_try_select(ctx->mux, 0);
+			if (!ret || ret == -EBUSY)
+				mux_control_deselect(ctx->mux);
+		}
+	}
+	g_mux_ctx = NULL;
+}
+
+static int spi_mux_test_send(struct kunit *test, struct spi_device *spi,
+			     unsigned int len, u8 bpw)
+{
+	struct spi_mux_test_ctx *ctx = test->priv;
+	int ret;
+
+	reinit_completion(&ctx->done);
+	ctx->xfer.len = len;
+	ctx->xfer.bits_per_word = bpw;
+	ctx->xfer.speed_hz = 0;
+	ctx->xfer.word_delay = (struct spi_delay){ 0 };
+	ctx->msg.status = -EINPROGRESS;
+	ctx->msg.actual_length = 0;
+	ctx->msg.spi = spi;
+	ret = spi_async(spi, &ctx->msg);
+	if (ret)
+		return ret;
+	return wait_for_completion_timeout(&ctx->done, msecs_to_jiffies(5000)) ?
+		ctx->msg.status : -ETIMEDOUT;
+}
+
+static int spi_mux_test_send_locked(struct kunit *test, struct spi_device *spi,
+				    struct spi_controller *parent,
+				    unsigned int len, u8 bpw)
+{
+	int ret;
+
+	spi_bus_lock(parent);
+	ret = spi_mux_test_send(test, spi, len, bpw);
+	spi_bus_unlock(parent);
+
+	return ret;
+}
+
+static void send_4b(struct kunit *test, struct spi_device *spi)
+{
+	struct spi_mux_test_ctx *ctx = test->priv;
+
+	KUNIT_ASSERT_EQ(test, 0, spi_mux_test_send(test, spi, 4, 0));
+	kthread_flush_worker(spi->controller->kworker);
+	kthread_flush_worker(ctx->parent->kworker);
+}
+
+static void check_sync_resend(struct kunit *test, struct spi_device *spi, u32 exp_hz)
+{
+	struct spi_mux_test_ctx *ctx = test->priv;
+
+	ctx->xfer.len = 4;
+	ctx->xfer.bits_per_word = 0;
+	ctx->xfer.speed_hz = 0;
+	ctx->msg.spi = spi;
+	KUNIT_EXPECT_EQ(test, 0, spi_sync(spi, &ctx->msg));
+	KUNIT_EXPECT_EQ(test, ctx->msg.actual_length, 4);
+	KUNIT_EXPECT_EQ(test, ctx->last_speed_hz, exp_hz);
+}
+
+enum spi_mux_err_type {
+	ERR_LOCKED,
+	ERR_ODD_LEN,
+	ERR_SELECT,
+	ERR_SETUP,
+};
+
+struct spi_mux_err_case {
+	const char *name;
+	enum spi_mux_err_type type;
+	int exp;
+};
+
+static const struct spi_mux_err_case spi_mux_err_cases[] = {
+	{
+		.name = "bus_locked",
+		.type = ERR_LOCKED,
+		.exp = -EBUSY,
+	},
+	{
+		.name = "rejects_odd_len",
+		.type = ERR_ODD_LEN,
+		.exp = -EINVAL,
+	},
+	{
+		.name = "select_fails",
+		.type = ERR_SELECT,
+		.exp = -EIO,
+	},
+	{
+		.name = "parent_setup_fails",
+		.type = ERR_SETUP,
+		.exp = -EIO,
+	},
+};
+
+struct spi_mux_delay_case {
+	const char *name;
+	u8 child;
+	struct spi_delay set_s, set_h, set_in, exp_s, exp_h, exp_in;
+};
+
+#define NS(v)	{ .value = (v), .unit = SPI_DELAY_UNIT_NSECS }
+#define US(v)	{ .value = (v), .unit = SPI_DELAY_UNIT_USECS }
+#define SCK(v)	{ .value = (v), .unit = SPI_DELAY_UNIT_SCK }
+
+static const struct spi_mux_delay_case spi_mux_delay_cases[] = {
+	{
+		.name = "longer",
+		.child = 1,
+		.set_h = NS(500),
+		.exp_s = NS(1500),
+		.exp_h = NS(500),
+		.exp_in = NS(700),
+	},
+	{
+		.name = "tie",
+		.child = 0,
+		.set_s = US(1),
+		.set_in = NS(200),
+		.exp_s = NS(1000),
+		.exp_h = NS(300),
+		.exp_in = NS(200),
+	},
+	{
+		.name = "sck_zero",
+		.child = 0,
+		.set_in = SCK(4),
+		.exp_s = NS(1000),
+		.exp_h = NS(300),
+		.exp_in = SCK(4),
+	},
+	{
+		.name = "sck_set",
+		.child = 0,
+		.set_s = SCK(4),
+		.set_h = NS(500),
+		.exp_s = NS(1000),
+		.exp_h = NS(500),
+	},
+};
+
+static void spi_mux_err_desc(const struct spi_mux_err_case *p, char *desc)
+{
+	strscpy(desc, p->name, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(spi_mux_err, spi_mux_err_cases, spi_mux_err_desc);
+
+static void spi_mux_delay_desc(const struct spi_mux_delay_case *p, char *desc)
+{
+	strscpy(desc, p->name, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(spi_mux_delay, spi_mux_delay_cases, spi_mux_delay_desc);
+
+static void spi_mux_error_test(struct kunit *test)
+{
+	const struct spi_mux_err_case *p = test->param_value;
+	struct spi_mux_test_ctx *ctx = test->priv;
+	int child = (p->type == ERR_SELECT || p->type == ERR_SETUP);
+	int len = (p->type == ERR_ODD_LEN) ? 3 : 4;
+	u8 bpw = (p->type == ERR_ODD_LEN) ? 16 : 0;
+	int ret;
+
+	/* Prime child[0] so child[1] forces a channel switch and parent setup. */
+	if (p->type >= ERR_SELECT) {
+		send_4b(test, ctx->child[0]);
+		ctx->mux_err = (p->type == ERR_SELECT) ? -EIO : 0;
+		ctx->setup_err = (p->type == ERR_SETUP) ? -EIO : 0;
+	}
+
+	if (p->type == ERR_LOCKED)
+		ret = spi_mux_test_send_locked(test, ctx->child[child], ctx->parent, len, bpw);
+	else
+		ret = spi_mux_test_send(test, ctx->child[child], len, bpw);
+
+	ctx->mux_err = 0;
+	ctx->setup_err = 0;
+	if (ret == -ETIMEDOUT) {
+		kthread_flush_worker(ctx->child[child]->controller->kworker);
+		kthread_flush_worker(ctx->parent->kworker);
+	}
+	KUNIT_ASSERT_EQ(test, ret, p->exp);
+	check_msg_restored(test, ctx, ctx->child[child]);
+	/* Failed setup on child[1] must invalidate current_cs so child[0] re-applies 1 MHz. */
+	if (p->type == ERR_SETUP)
+		check_sync_resend(test, ctx->child[0], 1000000);
+	check_sync_resend(test, ctx->child[child], child ? 2000000 : 1000000);
+}
+
+static void spi_mux_cs_delay_test(struct kunit *test)
+{
+	const struct spi_mux_delay_case *p = test->param_value;
+	struct spi_mux_test_ctx *ctx = test->priv;
+	struct spi_device *spi = ctx->child[p->child];
+
+	/* Prime child[1] cs_hold = 500 ns first to verify child[0] resets cs_hold to 300 ns. */
+	if (!p->child) {
+		ctx->child[1]->cs_hold = (struct spi_delay)NS(500);
+		send_4b(test, ctx->child[1]);
+	}
+	spi->cs_setup = p->set_s.value ? p->set_s : spi->cs_setup;
+	spi->cs_hold = p->set_h.value ? p->set_h : spi->cs_hold;
+	spi->cs_inactive = p->set_in.value ? p->set_in : spi->cs_inactive;
+	send_4b(test, spi);
+	check_d(test, ctx->last_s, p->exp_s);
+	check_d(test, ctx->last_h, p->exp_h);
+	check_d(test, ctx->last_in, p->exp_in);
+}
+
+static void spi_mux_settings_lifecycle_test(struct kunit *test)
+{
+	struct spi_mux_test_ctx *ctx = test->priv;
+	struct device *dev = &ctx->mux_spi->dev;
+	struct spi_device *spi = ctx->child[0];
+
+	/* Live spi_setup() on the active child must invalidate current_cs and re-apply settings. */
+	send_4b(test, spi);
+	KUNIT_EXPECT_EQ(test, ctx->opt_cnt, 1);
+	KUNIT_EXPECT_EQ(test, ctx->unopt_cnt, 1);
+	spi->mode ^= SPI_CS_HIGH;
+	spi->max_speed_hz = 500000;
+	spi->bits_per_word = 16;
+	spi->cs_setup = (struct spi_delay)NS(1200);
+	KUNIT_ASSERT_EQ(test, 0, spi_setup(spi));
+	send_4b(test, spi);
+	KUNIT_EXPECT_EQ(test, ctx->last_speed_hz, 500000);
+	KUNIT_EXPECT_EQ(test, ctx->last_bpw, 16);
+	KUNIT_EXPECT_TRUE(test, !!(ctx->last_mode & SPI_CS_HIGH));
+	KUNIT_EXPECT_EQ(test, ctx->last_s.value, 1200);
+	spi->cs_setup = (struct spi_delay){};
+	KUNIT_ASSERT_EQ(test, 0, spi_setup(spi));
+	/* Switching between children must merge CS delays and forward word_delay. */
+	ctx->child[1]->cs_hold = (struct spi_delay)NS(500);
+	ctx->child[1]->word_delay = (struct spi_delay)US(2);
+	ctx->child[1]->cs_inactive = (struct spi_delay)NS(700);
+	send_4b(test, ctx->child[1]);
+	KUNIT_EXPECT_EQ(test, ctx->last_bpw, 8);
+	check_delays(test, ctx, 1500, 500, 700, 2);
+	send_4b(test, ctx->child[0]);
+	check_delays(test, ctx, 1000, 300, 0, 0);
+	send_4b(test, ctx->child[1]);
+	check_delays(test, ctx, 1500, 500, 700, 2);
+	kthread_flush_worker(spi->controller->kworker);
+	kthread_flush_worker(ctx->parent->kworker);
+	ctx->child[0] = NULL;
+	ctx->child[1] = NULL;
+	/* Unbinding spi-mux must restore mux_spi's own DT delays before re-probing. */
+	device_release_driver(dev);
+	KUNIT_EXPECT_EQ(test, ctx->mux_spi->cs_setup.value, 1000);
+	KUNIT_EXPECT_EQ(test, ctx->mux_spi->cs_hold.value, 300);
+	KUNIT_EXPECT_EQ(test, ctx->mux_spi->cs_inactive.value, 0);
+	KUNIT_EXPECT_EQ(test, ctx->mux_spi->word_delay.value, 0);
+	KUNIT_ASSERT_EQ(test, 1, device_attach(dev));
+	ctx->child[0] = spi_mux_test_find_dev(test, PFX "/device@0");
+	ctx->child[1] = spi_mux_test_find_dev(test, PFX "/device@1");
+	send_4b(test, ctx->child[0]);
+	check_delays(test, ctx, 1000, 300, 0, 0);
+}
+
+static struct kunit_case spi_mux_test_cases[] = {
+	KUNIT_CASE_PARAM(spi_mux_error_test, spi_mux_err_gen_params),
+	KUNIT_CASE_PARAM(spi_mux_cs_delay_test, spi_mux_delay_gen_params),
+	KUNIT_CASE(spi_mux_settings_lifecycle_test),
+	{}
+};
+
+static struct kunit_suite spi_mux_test_suite = {
+	.name = "spi_mux",
+	.init = spi_mux_test_init,
+	.exit = spi_mux_test_exit,
+	.test_cases = spi_mux_test_cases,
+};
+
+kunit_test_suite(spi_mux_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for spi-mux");
+MODULE_LICENSE("GPL");
-- 
2.56.0.385.gac671c819a-goog

