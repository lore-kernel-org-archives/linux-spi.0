Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637241;
	b=LE45AeLpkKHyX9p7RNlKKJOAcMGpGv/yMeleaMDmodV2ggwHLEu9xE8NkE+s0Kzbz9ue
	 b1cl7gpQi7uH+hU7xm7fvfbHzxmMsU+FUl1v1HJsnqqF9A4Sj+isl3RXPjB9xmnCvuFE7
	 CIvM+hR5lcfSIseyZylfyFP6S+Lei9BOAiJT9sLeiSOduQ6LCcVm9r/4rS1h9lwq6uWxx
	 fqFtgsxWdurGUTysdAwOMEe3oD5QCNJw6jviSPJwXjVseK+dQaH/g2DKW55gW4FC4ERJn
	 3J7WhqTgC17nH5BRj1IlHqDfXNG0iPlVn5XiJnRIe4gW+4W08MND+ibt+px2wJYO99Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JoDFM3MwLEMIQ6sfvwm1Vsr/8nL3ztz8pgXGsV8IQBk=;
	b=MmY2qijXThBfv84bRXPcXVXoBeRj2GxOhVvhktMnXaZNesBhIa8D5bxXBCtV0y4QNX5w
	 YtwAb2hxOJXpLrSd3GMJ2MdwJNUqZ53oY66Z8qOcq6xyNC1PcHgv/cG51M+lyoIQ3h8Sg
	 Vd9YEBoQvOnc4QoRixfdR7n2hZRj8hn6UIX1iNXSwMKEWiGoOCuclknHYz1LgntmlsVQ/
	 a8aLsdkW7lk1NbY/oGjObO3zgiGsuhe5gQXM2Ib1zTW8gg/h6QABLVZPfhzUZm1nhnP3c
	 d0v7kqRgbju+QBPIUpjHdc13yyn2XXsK9RZJYYo+I+MT6IRkTcfMae0anh4GRaXgu8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JbPsJTfg;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFBE608B070
	for <linux-spi@vger.kernel.org>; Mon,  2 Nov 2026 16:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDFBE608B070
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JbPsJTfg
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a058f74a54so1104049b3a.1
        for <linux-spi@vger.kernel.org>; Mon, 02 Nov 2026 08:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793637240; x=1794242040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JoDFM3MwLEMIQ6sfvwm1Vsr/8nL3ztz8pgXGsV8IQBk=;
        b=JbPsJTfgjxKJXNAkA5yjAvXgaNvEX5gBt2PtpvwA72tDtk+gfNT1hSnax3q5EsyzOQ
         fR8zcV0DzO8Ap3o4I8pY3v01VS6pcWh6cuzM6jtsVvxRtRRc43zusmy0FvlXdcbwKVai
         KhI2UKoPilCe7eYFkE0LnI6G9M+/wcxU3WC1SiC0XRF+SWbn9tcKqjc+Mpev+HmaAHJ+
         +3BTJf2K1e6FrT5UF5TvsusG3yBcJhzAv2iRmZpunr1kM6Grf5bK/z7CUUe8gPqd+t7z
         kV+e/AvgBoaa/kvMdVp6e87/NEsYGvDunTUgvqC+ed0yjJAiBBumvlOEbs+u01b95s+E
         6e1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637240; x=1794242040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JoDFM3MwLEMIQ6sfvwm1Vsr/8nL3ztz8pgXGsV8IQBk=;
        b=ObnY2lhkBv/gU2ox7x86tPL0xhE7aEGGqDdXHWKELQD51XbrZ1x7Ft9KC/NpZ2iEE5
         q29i+quO3D7Se9xXDdC54X5nNcS4nqVgqgbf7b2l/O2jE/xDQGA8WuLgJC1CR95JopuO
         cOXosPDmpBi4qQ8mNmy4bYq8PCH8CMb0jyIlwm//Vl2I0LUexJeQgRqatdw6vcO95bYh
         AvjCvgnQdg4huy/p7Lq3l15JMUe5TNSlDUPAIrfCTcFt/thM9E6nBJZ+DaX7kX6ddM7T
         vlcCP6C4xPKAhDsvT6Ph7EKULs62L1t/5zOVH65pcm5XNTr5l/aPR7Ua36vEzur+qKbY
         +ddA==
X-Forwarded-Encrypted: i=1; AKwUvBwT3ZuCIBQVmYht/TTLXpfPuzL7mI0YAalJsBlYN9Pzo3i6dRX5LBoQ86Vwm++Dy54OsWg1/zynkxI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBjHYlonQUCvC3B68PSqDxkpdASjGF3U5mi2XqjtoxdrkKJKQr
	49XVMPJpKHlU5qsmecKpqNWH15+Bv9NKsFALPkwfp+o2tLDokhIXi31r
X-Gm-Gg: AYBFou1o7ewPWwYIOPgvf5HNrqgmo/i6V8k1M6/XPUQwFLxHPtrBjtZbv5QdehBKKGp
	0tz+TSL6ob5Ly7HKiqFAhAOURWAuiDMIPcq0fiGhrsPrBO/Lwth8Gx+KOlx+gfsN9RGsAMpHVwV
	VJykxnC0w1ZtvtJcQKYOSfDaWBbW231SrSHxvwlsgE+3C1kaRz4MDMY/fXBH86okS5pVEtoGN6V
	LvkA6yMp+k1srBLqyeCtBnWFkTut+cCnaMgM/LelIrpayUx987rmIRRY40tDWxbFBlAPWfoP6d8
	QHfp01U6fmOru0WY1uNYOhzZWzV7+Wn3+MV3C61hifFZ3o9BYGNwOCTJdVd/kIfLd4l5pwyk/hE
	tP2QMftSBYTzHbrU20ystxfmqWILm9yObsze+TbyysJRspiMaJEYLKRDEESzZyNCtntk7H67y0M
	aRATQL3QjIoLBLfFVfrfUoWzhkXm913q/2uYSj9OaXkjDe8FPmDb06I0J5fqO969/kRSQJ2Z1Vp
	ml1WqLipcwBby52co8mnu6ljX3dd8JDX5GoIfJBnvjKP68QLSo95t4eoO8TRtXrDfF37OIv2LVP
	tIZW5sTqIZ4ybMkaKxq9n3DwAhWBvIbsfsTExte8PAMg2DGtjnVk1Gc+S1/hSAe8Q5RFBzITONF
	Si4SmOAOOXQ8VJvZTprx7cjQscA05h3Kk0GxaDOuI7s7STEzt5odHL/qypdBnt1tFIW+50voOuw
	KhYOkL2R5o73kHvyjjwyvJZBxG1yc3Eg==
X-Received: by 2002:a05:6a00:a0a:b0:886:15e3:df99 with SMTP id d2e1a72fcca58-8a9be48c00dmr8707781b3a.17.1793637239817;
        Mon, 02 Nov 2026 08:33:59 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d4092sm2184549b3a.41.2026.11.02.08.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:33:59 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH 09/14] spi: spi-mux: add KUnit tests for forwarding errors and settings
Date: Mon,  2 Nov 2026 16:30:18 +0000
Message-ID: <20261102163023.2574632-10-jctchan@gmail.com>
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

Assisted-by: Claude, Gemini
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
 drivers/spi/Kconfig                  |  14 +
 drivers/spi/Makefile                 |   1 +
 drivers/spi/tests/.kunitconfig       |   4 +
 drivers/spi/tests/Makefile           |   2 +
 drivers/spi/tests/kunit_spi_mux.dtso |  42 ++
 drivers/spi/tests/spi-mux-kunit.c    | 581 +++++++++++++++++++++++++++
 6 files changed, 644 insertions(+)
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
index 000000000000..53a4e490ddb2
--- /dev/null
+++ b/drivers/spi/tests/spi-mux-kunit.c
@@ -0,0 +1,581 @@
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
+/*
+ * Verify the CS and word delay values captured on the parent controller during
+ * the most recent transfer:
+ * @s:  expected cs_setup.value (ctx->last_s.value).
+ * @h:  expected cs_hold.value (ctx->last_h.value).
+ * @in: expected cs_inactive.value (ctx->last_in.value).
+ * @w:  expected word_delay.value (ctx->last_w.value).
+ *
+ * Baseline DT defaults from kunit_spi_mux.dtso:
+ * - ctx->mux_spi (spi@0):      (s = 1000 ns, h = 300 ns, in = 0, w = 0)
+ * - child[0] (device@0, 1 MHz): (s = 0,       h = 0,      in = 0, w = 0)
+ * - child[1] (device@1, 2 MHz): (s = 1500 ns, h = 100 ns, in = 700 ns, w = 0)
+ */
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
+	/*
+	 * Verify the mux semaphore was released after the failed transfer:
+	 * - Good situation (patched): spi-mux released the mux semaphore on
+	 *   error (spi_mux_select() failure or spi_async() failure), so
+	 *   mux_control_try_select() succeeds with 0.
+	 * - Bad situation (unpatched): ERR_LOCKED, ERR_ODD_LEN, and ERR_SETUP
+	 *   return early with the mux semaphore still held, so
+	 *   mux_control_try_select() fails with -EBUSY.
+	 */
+	KUNIT_ASSERT_EQ(test, 0, mux_control_try_select(ctx->mux, 0));
+	mux_control_deselect(ctx->mux);
+	/*
+	 * Verify the child caller's spi_message fields were restored:
+	 * - Good situation (patched): spi_mux_complete_cb() restored the child
+	 *   caller's spi, complete, and context pointers on spi_async()
+	 *   failure.
+	 * - Bad situation (unpatched): ERR_LOCKED and ERR_ODD_LEN return early
+	 *   after overwriting msg.spi = priv->spi,
+	 *   msg.complete = spi_mux_complete_cb, and msg.context = priv.
+	 */
+	KUNIT_EXPECT_PTR_EQ(test, ctx->msg.spi, spi);
+	KUNIT_EXPECT_PTR_EQ(test, ctx->msg.complete, &kunit_done);
+	KUNIT_EXPECT_PTR_EQ(test, ctx->msg.context, &ctx->done);
+	/*
+	 * Verify parent message optimization state was cleaned up:
+	 * - Good situation (patched): ctx->parent has max_transfer_size = 2,
+	 *   so when ERR_LOCKED fails inside spi_async(priv->spi, m) after
+	 *   __spi_optimize_message() splits the 4-byte transfer, spi_async()
+	 *   unoptimizes m (optimized = false, resources empty,
+	 *   opt_cnt == unopt_cnt).
+	 * - Bad situation (unpatched): spi_async() leaks the optimized state
+	 *   on -EBUSY, leaving msg.optimized == true, split transfers in
+	 *   msg.resources, and opt_cnt (1) != unopt_cnt (0).
+	 */
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
+	{ "bus_locked", ERR_LOCKED, -EBUSY },
+	{ "rejects_odd_len", ERR_ODD_LEN, -EINVAL },
+	{ "select_fails", ERR_SELECT, -EIO },
+	{ "parent_setup_fails", ERR_SETUP, -EIO },
+};
+
+struct spi_mux_delay_case {
+	const char *name;
+	u8 child;
+	struct spi_delay set_s, set_h, set_in, exp_s, exp_h, exp_in;
+};
+
+#define NS(v)	{ (v), SPI_DELAY_UNIT_NSECS }
+#define US(v)	{ (v), SPI_DELAY_UNIT_USECS }
+#define SCK(v)	{ (v), SPI_DELAY_UNIT_SCK }
+
+/*
+ * Each case exercises a distinct branch of spi_mux_merge_cs_delay() against
+ * mux_spi's DT baseline delays (s = 1000 ns, h = 300 ns, in = 0):
+ * 1. longer (child[1]): child[1] DT s = 1500 ns (> mux 1000 ns), runtime
+ *    h = 500 ns (> mux 300 ns), DT in = 700 ns (> mux 0 ns) -> selects child
+ *    delays (NS(1500), NS(500), NS(700)).
+ * 2. tie (child[0]): runtime s = US(1) (1000 ns, tied with mux NS(1000)),
+ *    h = 0, in = NS(200) -> on tie (child_ns > mux_ns is false), keeps mux's
+ *    NS(1000) unit/value, resets h to mux NS(300), and selects child
+ *    in = NS(200).
+ * 3. sck_zero (child[0]): runtime in = SCK(4) while mux in is 0 (!mux->value)
+ *    -> spi_delay_to_ns() returns -EINVAL (child_ns < 0), but because mux
+ *    delay is 0, passes through SCK(4).
+ * 4. sck_set (child[0]): runtime s = SCK(4) while mux s is non-zero
+ *    (NS(1000)), and h = NS(500) -> logs warning and falls back to mux
+ *    NS(1000) for s, while selecting NS(500) for h.
+ *
+ * Bad situation (unpatched): spi_mux_select() never copies CS delays from the
+ * child, leaving ctx->mux_spi at (NS(1000), NS(300), 0) for all 4 cases.
+ */
+static const struct spi_mux_delay_case spi_mux_delay_cases[] = {
+	{ "longer", 1, {}, NS(500), {}, NS(1500), NS(500), NS(700) },
+	{ "tie", 0, US(1), {}, NS(200), NS(1000), NS(300), NS(200) },
+	{ "sck_zero", 0, {}, {}, SCK(4), NS(1000), NS(300), SCK(4) },
+	{ "sck_set", 0, SCK(4), NS(500), {}, NS(1000), NS(500), {} },
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
+	/*
+	 * spi-mux skips mux_control_select() and spi_setup(priv->spi) when
+	 * priv->current_cs == spi_get_chipselect(spi, 0). Prime
+	 * priv->current_cs = 0 on child[0] so targeting child[1] (child = 1)
+	 * forces a channel switch that executes both mux_control_select()
+	 * (ERR_SELECT) and spi_setup(priv->spi) (ERR_SETUP).
+	 */
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
+	/*
+	 * Good situation (patched): spi_mux_transfer_one_message() finalizes
+	 * ctx->msg with p->exp (-EBUSY, -EINVAL, or -EIO).
+	 * Bad situation (unpatched): spi_finalize_current_message() is skipped
+	 * on all 4 error paths so spi_mux_test_send() times out (-ETIMEDOUT).
+	 */
+	KUNIT_ASSERT_EQ(test, ret, p->exp);
+	check_msg_restored(test, ctx, ctx->child[child]);
+	/*
+	 * In ERR_SETUP, spi_mux_select(child[1]) overwrites
+	 * priv->spi->max_speed_hz with child[1]'s 2000000 Hz before
+	 * spi_setup(priv->spi) fails:
+	 * - Good situation (patched): spi_mux_select() invalidates
+	 *   priv->current_cs = SPI_MUX_NO_CS on error, so transferring on
+	 *   child[0] re-applies 1000000 Hz.
+	 * - Bad situation (if priv->current_cs remained 0):
+	 *   spi_mux_select(child[0]) would see current_cs == 0 and return
+	 *   early, running child[0] at child[1]'s 2000000 Hz.
+	 */
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
+	/*
+	 * Transfer on child[1] with cs_hold = NS(500) first to overwrite
+	 * priv->spi->cs_hold with 500 ns, so when switching to child[0] whose
+	 * cs_hold.value == 0 (!child->value), the test verifies
+	 * spi_mux_merge_cs_delay() actively writes *dst = *mux (300 ns)
+	 * instead of leaving child[1]'s 500 ns stale.
+	 */
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
+	/*
+	 * Phase 1 & 2: Select child[0] (priv->current_cs = 0), then mutate
+	 * child[0]'s mode (SPI_CS_HIGH), max_speed_hz (500000), bits_per_word
+	 * (16), and cs_setup (1200 ns), call spi_setup(child[0]), and transfer
+	 * on child[0] again without switching channels:
+	 * - Good situation (patched): spi_mux_setup() sets
+	 *   priv->current_cs = SPI_MUX_NO_CS, forcing the next transfer on
+	 *   child[0] to re-apply (500000 Hz, 16-bit, SPI_CS_HIGH, 1200 ns) to
+	 *   the parent.
+	 * - Bad situation (unpatched): spi_mux_setup() leaves
+	 *   priv->current_cs == 0, so spi_mux_select(child[0]) returns early
+	 *   and the transfer runs with stale (1000000 Hz, 8-bit, 1000 ns)
+	 *   settings.
+	 */
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
+	/*
+	 * Phase 3: Switch child[1] -> child[0] -> child[1]:
+	 * - Good situation (patched): switching to child[1] applies child[1]'s
+	 *   merged CS delays (1500, 500, 700) and word_delay (2 us); switching
+	 *   back to child[0] (delays cleared to 0) restores the mux baseline
+	 *   (1000, 300, 0, 0); switching to child[1] again re-applies
+	 *   (1500, 500, 700, 2).
+	 * - Bad situation (unpatched): child[1]'s CS and word delays are never
+	 *   copied to priv->spi, so check_delays(test, ctx, 1500, 500, 700, 2)
+	 *   fails with (1000, 300, 0, 0).
+	 */
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
+	/*
+	 * Phase 4: Unbind spi-mux while child[1]'s (1500, 500, 700, 2) delays
+	 * are active on ctx->mux_spi, then re-attach spi-mux and transfer on
+	 * child[0]:
+	 * - Good situation (patched): the devm cleanup action
+	 *   spi_mux_restore_delays() restores ctx->mux_spi's original DT
+	 *   delays (1000, 300, 0, 0) on unbind so re-probing does not inherit
+	 *   child[1]'s delays as the new baseline.
+	 * - Bad situation (without spi_mux_restore_delays()): ctx->mux_spi
+	 *   retains (1500, 500, 700, 2) across unbind, poisoning
+	 *   priv->mux_cs_* on re-probe.
+	 */
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
2.56.0.317.g454f8302e1-goog

