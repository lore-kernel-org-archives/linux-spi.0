Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.235
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794618474;
	b=s+CLXqJQfsHAsLhHILRUKtBYoXytoNaixIAUWM15WcpWiDHKjPsTiwfZfrYKCkSUpQK/
	 +qAfDtFYQqlUBAN/FbFBD8kkmyHK9Wkzsw789GZd+968/04gLxtnCdMfUUAwM5kg8W6Jh
	 z9VFhEx8jnY6i9k6X9dY9GB8G9R33hduJZYxUBsGxXRd5oOjB1v31pGpEwu4Et+ER1GUd
	 MMxlhzgWlcOHRktF6TVLDkC6FdKFtETrOfVAy+7oFkB5h4nJwQ+WozmtyOrrimnuizY85
	 y1kKZ98GBzAEWu8e9AsVnaHDdVSDvpHe22TCnO9kBzadbavNl4vyqF6G8VU8FwoLFXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794618474;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=adgGF6Y+EY3ng5J3ZlI+WZuzQBE8vUwfEB8/besoPZ4=;
	b=frZoGETVEb250bZnbgvB1qj6u+fdOWJe896imQAJIVE0n+anBL24XYFfX794oEvaTs6l
	 xf7cIZbF9YMiUkA2TtDf9+d71DdGCWWmo3Z63IgtSTare9acGqdyqogkMAd6fLFeTQo1v
	 FlNcfos1mnQ5aGAPl91Ai2zBqzMYJmbFr3QTJBkB1vWb3msE5ovkA2DTBpHY3rV5syI4A
	 AzMoN3/IpFWcuV+DzbxuT1gjKPzMqZOqkO3wlRBtFPlKVigO+SonKDhETWQ2CmN/3Ypbq
	 js274wKlPJBpj56SyNHa0sK+WobX8EYcXeZlUZVU29Wzx64EW34H5n+zDef83vXaVMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=l5rFfQGe;
	arc=none smtp.remote-ip=203.205.221.235
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEF5606A329;
	Sat, 14 Nov 2026 01:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEEF5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=l5rFfQGe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794618470; bh=adgGF6Y+EY3ng5J3ZlI+WZuzQBE8vUwfEB8/besoPZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l5rFfQGezJgUnMEFMtKhnPo4DHriawD/RJODPWF5yplUE1E2Iz70Xh3AfOqqWeBix
	 ul0D9yU1nk+wog/KgpgIs93/viC0aC4ZQb/9Q3wyQ89qioTBkvHoXR8SnDgRsaKEi3
	 lvF6WrI3yfa9gPIgjVPxIuI5YXflLlk8HTp74T5A=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.198])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 1EE0C051; Sat, 14 Nov 2026 09:07:46 +0800
X-QQ-mid: xmsmtpt1794618468tnd51rlub
Message-ID: <tencent_680CDC69A5435998E4719B6A703BC5642609@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnL1Z87h18sMZq0bBCUkQExEEnScCwaGf0corEwkj50uT7kLFjLro
	 lBQ2Cer9TfBCWLP9TzIBLzi1xEG+BF9n6pK7oSipBLItfB88/iClrYKxLiXiJdtpLtrIbeGwGx9s
	 baWlHtnuxdeELqCb7d8HFp7Cp+zPkICPF00zPcoWveisTVR2NOuk5zP8JXGQhw8Z0rSVGxM2hwUa
	 +u0afhsyNkjvMTB2fV3vP30qUYz95sNktBkZtxusGcRGqoy95iL0DBMA2RGGbUbvHDf6Pc3pPhfp
	 cAtU1bW7OFhziLyG4cTtqaYfsxUrLQaXngMsFP4C8UsFXU0sHWsxoSSWJ7vEEeCMBdNBFdoIpLz1
	 0kv33kAa+N+YGWwN8AZVUATOCHczYBtU2sREaCNYuLHK2uN8VMSBbz2k6P9OJR8v63HpwprWI3Y7
	 Chu71dC13887vynVt2lug5JgrBijDjKTUGpgG1yDMFzYJ0WiQlGasXv3osAfIB91c+WbOFzmzcAh
	 g/7z6azSkUI9anAnybNoxI0/46MlzylV29mSCCReIQVcyM/RfgYPyWg5vSTTZR9Gy+1G7OTiKq2J
	 0YguEhB4tRgLKpCKL/ElQ5my3v/2G9mDdWm2mWbYyPno19t8SGCrq8KsYTugbtZdZap/UdJT3Hul
	 23QGqeN6TuNQAPs49+K4vUJHQhZWqwD/gLGdIF5YutC6HsW+dYSiZeJJhq7OuvXHkTImcDuh+4sC
	 EsT3cQTm3RrAkGcrQBAo1/oKn6/YApTbiUGkqZbTHP5opJXWXn4r5sBaYRmWgoCBYFUTfQUX4IvA
	 5XfQSz7Pt1mnF+KLBiBG4ZsNCYY5jo7ojHSgEo973DUr14OyYtMd8Bt4WbAwjn/69B0azlPmwu3S
	 VHqxexuK2b6qo/TEhDpB/u/IynHdFGXc4SiKba19Q2xdH0OK1LK6BmuhTtVSVmKWeqWR/SQvPhcF
	 C3w1LxjRGdPQ3pETwEQkZEdnPXfaif7dRXHgxSvVuqPewAG3x1WvSpUyQuzWR4dOK3w6c5SsL8z4
	 KchNfNHp73ZM3+KJMcf8yXeJ8eiV20e/oDeiCj44GF9ZmikPiPRQcnRBkotIq/9HEDXsnQ9npWMf
	 ErO+HBFOiRQFtOFZSOVcSrYJx7SGHa6gb+6MKU
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	847807867@qq.com
Subject: [PATCH v8 3/3] samples: rust: add SPI driver sample
Date: Sat, 14 Nov 2026 09:07:45 +0800
X-OQ-MSGID: <20261114010745.82389-3-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114010745.82389-1-847807867@qq.com>
References: <tencent_5FBF490F375F4C66A2C8DD421A8E8542FE05@qq.com>
 <20261114010745.82389-1-847807867@qq.com>
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
index 31d62533ef25f..f99bf52654a15 100644
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
index b986b681cde5a..efe04638a990b 100644
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
index 0000000000000..7eee7b7357947
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

