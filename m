Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079745;
	b=amLT7/z1vYv/th8I5xaErfQQxHrf9Y+/uQtPABUEjdyYlYkgWgJTWc2JWJzmBclgnGf4
	 2vu/V8WKpVrbZ8lTMDb5wf7CXTAhwZuz4V9/nPq2hp9ukWPLqMfRKsDr7VfR0Rvude2sm
	 PSlIRQlOYBjGSQGWps0Om9EMVXCi8qMqLVqWqVadQDtiG0nh8Ag5EHLrrk3rmUFRCspUc
	 ao5dwfZOV9dTuJj3VkDHPREGXRNmkoyOMMRemTSDdE2+BFnxYQxb7TYen0n3YIMS5Ly0+
	 00POYeXsssgfrNXbmggR1RLYjAeUcqU2oYJuZ8DzD6iSRNhoWBjZd1L3J0lhPZLsCxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079745;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UIOLNzeNMeOGOabzPa1El9g7evCOREjpW/YIP8YMHZA=;
	b=za5rCK3ffudQVBwYFGp4VxkBtL2b9tpox5KCfs2vnnp4WOBGipWHGJxqwRQ419OfhQpU
	 0/OVbznBqyFxBXH5Art2CpQNiGm2SCfJxYVpD5bKWuYyQtvM6+GblGPOTQu77kvwm5B4s
	 r3LzGEvjbWL28efwtG2DoqKu2pyeWAQC1lElONfUi9po1ACsFtUVjj20j4PLQsH7MG/6o
	 eNC3pN8IOIWot4j05UWfcme2L24xBdp2vi8fLcBfiMpqtfVBooC5ZrviqMuf1jYmESfM6
	 XPYewjudhxpqLHG56Lrz3qoK9yDGGkIyJgDboE1p5orZGKmWxWiEffeRPfeyHXHEf0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=hOt14t5g;
	arc=none smtp.remote-ip=203.205.221.221
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9EB606A328;
	Tue, 27 Oct 2026 05:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C9EB606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=hOt14t5g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793079735; bh=UIOLNzeNMeOGOabzPa1El9g7evCOREjpW/YIP8YMHZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hOt14t5g2gHkjw+pJKS6yQoJsgl+Qw1mg6sdN6JHeh7itzw6bB9qWxHSjQwg0yRPs
	 mEN2c8DIwBixNIq8CVFOqe5iCjhTc3w9lvJ+jTCpA5jC9/lh9Os1fpWogUkCX45Ne4
	 /z9g3gg/ooPCJIGT8Kts9MN0EnzDMHhO6DHSJN4c=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.198])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id A89B7814; Tue, 27 Oct 2026 13:42:09 +0800
X-QQ-mid: xmsmtpt1793079733tdfc6lwjf
Message-ID: <tencent_EC3FB2E0C9BB3715E3A688654CB0B9B7480A@qq.com>
X-QQ-XMAILINFO: M5g+bqkaOkZDfQ3SxfRfXPH8yxJAePHWhJqeUQrwtM1BoyASWYU0jAdRDH8ppj
	 fXpQH1vKAc+HzCu5y/orOaK2xAFhqGpbwb6xoNENCzwgQDeI3KykuY2vKlPNr4yanG7rq5c56Jsh
	 tCqg8GzckZ0ieBKLIcUgEVflXUafDVBHlgAYtjlQ4Sz60k8wtV+VbwPY1sVCRlIJfV0LqmZUpB4x
	 tBGdvDHl5tJlUYR47XK8zvZPe7pnM0e/dYG4+AqTgx1suBVH8n04Z/W+76CGcLfxqMDbdaDr0pxk
	 qcsZucCUR3BBXxmGUze/Aypxf5Vx8e8ThF6LCZgwgRbOoF6YAmNEiPrwESaSpn9nlJckzehYPuqI
	 F1on4VJCDlVPsKD631mg5lBQNlBLovJ2vlJzBEBjGHuz8l7KGzo72Z1rR1yDwaL8MEpExRaBNE0R
	 usfjMHMKeWCfAIff6WRYOK/i+6kO2A2lKU0UV+nIMKRYmPAZHzsco15wSMV6iwg3ELfORHoavpLF
	 9Q8ICJMrJtlii9PT3kGjENTBx/agHHE5voS0XIz6Y0acwkAjTj3VQe2ea/RKexVJdIvBmVxaak9T
	 W0MHbQzcHsS8+qcbK6wfg7/AkiebCGApaXkcxmS1JS5QOV0RkXyMHphmEVL0AwTThv0obGxEPPJH
	 YqtsBZXo5AVq1jD11lzJ+UoeGIYO41vkafUTVmjdEeMgff5SV6b2rs0XacDxOlJohmsIWeBURhQO
	 W5WibQ7AK68gdFat+XLUVUoGsDL6ZTKlQQP7KGO9YFQmAc2IfvzkzxTaZUFQzGIx5IwyF1oG8/s+
	 vER5O7cROGbCLC12R/Aqcf+fm4g4mhw1D2AK/54LWHMDNSxbqcNQYkBtMsh4P8+5fp0q0o0uhuxp
	 2SBfhrA6SXJ5PAKhIMEHd9MvNdjYYlJ2KrWSHY+7FU6YLcLOYJTH33Ene+XeJx7YZwiXauQMb8VK
	 6nVzO6QGn1uAQFYi28Dql0aSkzbJ/oN7EkfadepOVC2DhTIByNBKfmSzEsVHmnVOA20WZqP0iya8
	 NNAKzIs4us7S8h27bZRL851SleClHHdLyvOYjKxiGv7rdla9lQJIjexqW7TUqCe8mK29pFUJDqMU
	 L/Fsb3FFOPf3VIIO8dWN8qhSERYumaaYkTAhyT8B5tx/ewHgneQJxZkItvvKyGmZ2uiA7VzX1sQx
	 BdVF/teP5R+/gB8Q==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: broonie@kernel.org,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH v6 3/3] samples: rust: add SPI driver sample
Date: Tue, 27 Oct 2026 13:42:09 +0800
X-OQ-MSGID: <20261027054209.904654-4-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027054209.904654-1-847807867@qq.com>
References: <20261027054209.904654-1-847807867@qq.com>
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

