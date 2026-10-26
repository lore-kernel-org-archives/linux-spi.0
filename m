Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792996165;
	b=FkjUkTuVqKAxVxLjVZCGRWgQdCND3/vEA1NxeMWz8599yTzl/wUHdw9GnHGm0gIHZmFe
	 YBNBlvD9iDW7uba/F4vO3IZCtuxk4azVYSPCtDYZdOnXcShrKqeX2p1wRbSuj+plQkUMY
	 MaRGcnwmd6cxchbGfwxACujC2wiUhm2V5mXL3MCdCusNmUqNmfqjSbH4j2hrEc6Jp3Zyh
	 zKViJfGDsvH1XC0FJg6CZO3OEPkHxkJDAq3SgxeuxKfPiURCkFJRpZIAP8K6MHOARjddE
	 qn9senn6JAT59WxiixRSjE8HkDkF5MDjCRYx8gqn/YSPAxV/+wi8bONchobxQahcGZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792996165;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UIOLNzeNMeOGOabzPa1El9g7evCOREjpW/YIP8YMHZA=;
	b=aiI10Ug4K1KvdPaK028viGs1FO3OayfhnsB2uoBuEPzCNUForhXL9n0RbHD8G5qbo5Fg
	 yyAIrJIo2iwu2qzf4UkOoVOrpjs6ogN+BpnS6EczAneaPjaYWhVEnf6MYKFJZRZBlCowb
	 /qQwIY7qK+2iPkdpix+GQGtlcyJbtynz047pkn4o1JSNsFvUJsPd8qRp8gQHYzX/tQ1n9
	 O0XDtQOAkLyo4axw0BmpiqobzLBxj98/IbBPHKC2u8L15c/vBuBuaGaLoQzMiaH8fsAId
	 XFJPenqium4F2ZAPa3w7A53w56/yHXBPGWNi8faRILUOP0ptCqmRLFii0iMNRjpbttA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=B+D4mfuW;
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3CB606A327;
	Mon, 26 Oct 2026 06:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E3CB606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=B+D4mfuW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792996152; bh=UIOLNzeNMeOGOabzPa1El9g7evCOREjpW/YIP8YMHZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B+D4mfuWZwejbyhEbPchcB/Mb2tOYvz3PE5hDh88EVHr8xTDz6X8XowJ9LwX512EV
	 JMiudvoqOMQEVC3xwQeCJjkUbuf+weiUBGWIxuNCnN+Sn+Lu4PtacgSS6LFYBLUrlD
	 bbTP+5Gw8U3SKKwCpW2fFagmyPpRqdMSwKlRp7RI=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 74605611; Mon, 26 Oct 2026 14:29:06 +0800
X-QQ-mid: xmsmtpt1792996149to3bkqui2
Message-ID: <tencent_4E8EF2C44D25B82762941326EECBD24B2C08@qq.com>
X-QQ-XMAILINFO: MKtwbAJV2ynyWRS1B5URR39Po+ZfVHd1UZ4UwcEkkwvQBUiBsmJtFklkHsQnoG
	 K3ZgKh5F5InbzUfhdJdHQ8uJeJ9fzoJCETUcgHCnmBMVurivJpZ9FTjMpitOCgB36hmMn6EB0aHe
	 uRuBhrZZD5PVxBv1frx9WsToakVLFrmGABZJsu+W9xSTpCnGOcL2Jx4PvKVkkcTXxu8+/GBCpI/U
	 qKLsmHEleTPodsBw2bAnwT19cwO1XVkeWx/F4wNgCTicq6BJzm6twKwXZvJjoxX2dNmliKj6XzJ+
	 cJoFDhoWje1YhQ6VXJtdlbXM7UHj13s4K1wOU7YpcQUFGp78XFMX8RF2KLoI1AYq4F4oPVj7G11p
	 0x39Vz72CcoqhN5gUZFW1X1LfP1edWu4iZ8MXU/H87WApqgQJxpgHWcDWc/kxP9Ra3nyBk2PrBAg
	 wIgcmERexCjlnNIMV/RgAPYXd3Eib3uruglbW8vwG1wQeltHHk+/siWaUqpN41oyvj/T4Ypug/q5
	 6r3p4m5nrq4VABjJJOQETSgztG1zSTih523rdO6+SjndgATAK0uhBWRPRtIfiiAjZooYHSYp7Hik
	 hPK7xasTrRNk0RHEgJEf+SwQrLK3DBhZSO/CUXhXF9/ZXREesIZRbRqYPU5kUDQR7FkbjoHPc05B
	 83TSeyFLyBMyiXh01eTWXJXRGZwL3ncQneIJ6BRVZgy6MtZ4Lr2pwKq3tcoaxD4pjXgUZnQnVXsW
	 gZxtz7jugX+FSl2Q92axaeSH51ficNP/UgSIhIvPfpgS0AT6WPZv/AaMgQ311cnWoewLJPn6Abxn
	 Wp6N+Iip0n4q8gYWNQGIw+DlKZM6PUdD/mu4av/L3fkOZXyWnp7u8Deav7EvSwpdHDr+xDEWsY/e
	 6u70hx/A9dj7mmNxo9UdFqbZjj2jTHmviIwNHhqPXTrTJ0ihrl0jZ/DjmuopHS734vmqWRp9eki0
	 8v5EBt75RIH2SBEGZ7UKVkaCJeMpXE/OXnGRcI5Vafr5lZZ09Q8sR9ZlF+yQ/t4m5mUh3nk0YxNv
	 y6e+RoV4tlXlJdaB2vXOQzyj6ob7GFW89UblHJv+If1IP2a88mmotEkfmBhunkJMXrN/XAFs6EFg
	 wptDp5qgEd+SdEY7Dvf7yxSaOgv5NKCYSg9VhM5BY9OsZg0qQ0J3W+59W28yILHMolXY5+wKjvqd
	 XelRYUoYfbb4ywXYbHMpsOYArf
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: broonie@kernel.org,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH 3/3] samples: rust: add SPI driver sample
Date: Mon, 26 Oct 2026 14:29:05 +0800
X-OQ-MSGID: <20261026062905.6570-4-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026062905.6570-1-847807867@qq.com>
References: <20261026062905.6570-1-847807867@qq.com>
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

Add a sample driver for the Rust SPI abstractions to demonstrate their
usage.

Signed-off-by: Shuai Liu <847807867@qq.com>
---
 samples/rust/Kconfig            | 11 ++++++
 samples/rust/Makefile           |  1 +
 samples/rust/rust_driver_spi.rs | 66 +++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 samples/rust/rust_driver_spi.rs

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 31d62533ef25..f99bf52654a1 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -84,6 +84,17 @@ config SAMPLE_RUST_DEBUGFS_SCOPED
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DRIVER_SPI
+	tristate "SPI Driver"
+	depends on SPI=y
+	help
+	  This option builds the Rust SPI driver sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_driver_spi.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_DRIVER_I2C
 	tristate "I2C Driver"
 	depends on I2C=y
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index b986b681cde5..efe04638a990 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_SAMPLE_RUST_DEBUGFS)		+= rust_debugfs.o
 obj-$(CONFIG_SAMPLE_RUST_DEBUGFS_SCOPED)	+= rust_debugfs_scoped.o
 obj-$(CONFIG_SAMPLE_RUST_DMA)			+= rust_dma.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_I2C)		+= rust_driver_i2c.o
+obj-$(CONFIG_SAMPLE_RUST_DRIVER_SPI)		+= rust_driver_spi.o
 obj-$(CONFIG_SAMPLE_RUST_I2C_CLIENT)		+= rust_i2c_client.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
diff --git a/samples/rust/rust_driver_spi.rs b/samples/rust/rust_driver_spi.rs
new file mode 100644
index 000000000000..7eee7b735794
--- /dev/null
+++ b/samples/rust/rust_driver_spi.rs
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust SPI driver sample.
+
+use kernel::{
+    device::Core,
+    of,
+    prelude::*,
+    spi, //
+};
+
+struct SampleDriver;
+
+kernel::spi_device_table! {
+    SPI_TABLE,
+    <SampleDriver as spi::Driver>::IdInfo,
+    [(spi::DeviceId::new(c"rust_driver_spi"), 0)]
+}
+
+kernel::of_device_table! {
+    OF_TABLE,
+    <SampleDriver as spi::Driver>::IdInfo,
+    [(of::DeviceId::new(c"test,rust_driver_spi"), 0)]
+}
+
+impl spi::Driver for SampleDriver {
+    type IdInfo = u32;
+    type Data<'bound> = Self;
+
+    const SPI_ID_TABLE: Option<spi::IdTable<Self::IdInfo>> = Some(&SPI_TABLE);
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+
+    fn probe<'bound>(
+        sdev: &'bound spi::SpiDevice<Core<'_>>,
+        info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound {
+        let dev = sdev.as_ref();
+
+        dev_info!(dev, "Probe Rust SPI driver sample.\n");
+        dev_info!(dev, "max_speed_hz: {}.\n", sdev.max_speed_hz());
+        dev_info!(dev, "bits_per_word: {}.\n", sdev.bits_per_word());
+        dev_info!(dev, "mode: {:#x}.\n", sdev.mode());
+
+        if let Some(info) = info {
+            dev_info!(dev, "Probed with info: '{}'.\n", info);
+        }
+
+        Ok(Self)
+    }
+
+    fn shutdown<'bound>(sdev: &'bound spi::SpiDevice<Core<'_>>, _this: Pin<&Self>) {
+        dev_info!(sdev.as_ref(), "Shutdown Rust SPI driver sample.\n");
+    }
+
+    fn unbind<'bound>(sdev: &'bound spi::SpiDevice<Core<'_>>, _this: Pin<&Self>) {
+        dev_info!(sdev.as_ref(), "Unbind Rust SPI driver sample.\n");
+    }
+}
+
+kernel::module_spi_driver! {
+    type: SampleDriver,
+    name: "rust_driver_spi",
+    authors: ["Shuai Liu"],
+    description: "Rust SPI driver",
+    license: "GPL v2",
+}
-- 
2.43.0

