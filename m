Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794536759;
	b=Exfc1Pu8sD8+pQqu5ElczQ6t1RkmTHs3iMNcWKCzSMRDs/GnmYttvEtAmQEJfDFC0irq
	 wlGRb/tim0RZdoPhamFd+c3n3ajq7pJgPpmdOmf1h3X+8CGe4T4UBsYi70xF2fQYPIRHp
	 Yxvp7G+f6sFKbHFWBjYJsByod8iNK79t/tm07/y/aBLwDkgyZfG87wgmmKH1lnBYjEZuv
	 KhHsksYgbfsAURu6k8j1CdGZAOdg3jeyFHDI7n4R/QWAfTuTOmock8dQ6c9aTAWbvX0sS
	 H5Xtcpx+iHnENBQRaL7pHvxkCRZTT9nOJ5EC33YtaXK4qL9IWi+HLwQ6A+F+nbiZB1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536759;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=adgGF6Y+EY3ng5J3ZlI+WZuzQBE8vUwfEB8/besoPZ4=;
	b=ymnIBu1iBOWmbWjlErwNVLUx2wO1kzMdwPgnclvOytQn66aMK1TdorDGY+CVV0/dhFLb
	 XO39rCicb9HTvbQZcYjYXA3KuYx52odtmAWZBuF+XV1L8AO7b3mxO+gZ0CAmOADxuGN/D
	 7R5FC5S6aguNeAOcIpOcafP+dNE2UJ7cdlg5g2APSJ1vs3BW5mnfApVpWq9flp9P4c0MX
	 Gt4Ptbi7kGpAKAVa3T8HOp+S+eyRSbNytSV2Kd58rm7b3rzl8jE3AKl3Q4ClYbc44ZBPX
	 YeNq0YDr0UgSW/qNboHgVRT1+KXxEkadHusagstv7OMzc8Knpb6ENK34FkIWjy3boNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=RCMvMO36;
	arc=none smtp.remote-ip=203.205.221.173
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65229606A33E;
	Fri, 13 Nov 2026 02:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65229606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=RCMvMO36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794536756; bh=adgGF6Y+EY3ng5J3ZlI+WZuzQBE8vUwfEB8/besoPZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RCMvMO36qYYcEpAD9mpgGKIahsLHCNjzgvbhT2dXqi26xjeusKrMuB5G304neiXOe
	 gOSdv/3phI0PK4lomBgz5B4EH6M+/p7LzZNkJURjcBCymUOWlCYF5M6OdcwqcvKHEh
	 4ldP5EhqFLu1GsM+/ywlNB57Aa9cwkSqePCkce+s=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 67422604; Fri, 13 Nov 2026 10:25:52 +0800
X-QQ-mid: xmsmtpt1794536754t6v10ca43
Message-ID: <tencent_D36E88294D0CB9BB49A3B1FCC8B734F5E20A@qq.com>
X-QQ-XMAILINFO: ORr8VBNiK85PeI187XCv97bJSC/4fF38Q/ubbH3a0YQU/0lYU4Bwe1fl5s4Muh
	 oAYFZjpmV+Ngaq/IfK90t3FZ7KobFC++z8bBD5PSYJA3PIhSvB1UN65aPr5zpwqJ7ezORksG9FzF
	 e10AkFCyVlmH8bu8E/mQZsk3yH1A6CYI1TDz206ZcShlrPRm+GutnLqRzNClzzAlzQD4I16kQUzS
	 GYCHzc5UxOMWFXgbeBoTzqgoam0yznb66q/jkgCxogYkpnFEosTDmS5Qx0XhLJ10P/xOvNEieqOj
	 VBZbqN/RCLsKgq2Gfik9QwWERFrwvOgsMq0Wh/TY8Uub5cO7+s5FHttMDvhcay3suMUz3/dnOvJl
	 LmxeKMKK2CFWCT1Ce3eZijl/GQdeQbAj+YBiWS9LG4t6quoTKOye5oVZs7vJdlRt28obVeS1P8f6
	 QOV8DrE8am6iU0MSvVJeBey7xdYclbXXdyR4CBC8gtPb7WxC26qULWwpTeUo+t7NVVsV3e3j8PMn
	 vafEduO72mFnrzeVlO965OKk/mASqgon2fDKOXTnlmyk1gLdmI6zz05zn4qM9CkCz8EnQLYLuANK
	 22a2VOPLI8CpVXrKE3a+LeP1UtxWWvtMi6w6tniYZMtONVOW1GZrp6bAZxzu0xhFdXXZV3thjKGO
	 KGfL0v012fd9Ldm0gINqIU3ydJprALkz8pcIkQaDGMDhcYb3XPaiE2+ZxbTrEg0bKRUkU7Ez9cMj
	 48bjpmT6icfCzpfJKhDJmAVEAIrj7lnd6Gwmm1WfAUOvWiQJ6g6/UBAZjWXJH0rZS9JHAmCgUxah
	 IJ922kB0C2ed0qQYwtVuxJjU40INFMEvNkkWpp4YFxxEmPmspLr2+9zaPswiDdYN0Lg7ebJBVxXw
	 wkVdL/dvIwSc9OWVIUHlD+5FYq9Wice/Og2CJgQZeO2pos/fiE1uEzKuVZvByik3iCh9642S9ixg
	 mxhTz+HNLEzEfo/ePTHRoK6NcnSvWdJfeYf0lhIfjfJmJMjn6vNluu/dKuouFWjk3od8x1kPMOzA
	 WdQ1KNU3cwiEjYPkammXpxMGdB4Pjsf7BLIGmXjunGe/fZyEWg+qyI1mlQUXrHpk8cpkX4s6dv23
	 LWBjG8GCU4Mw/vj+d7C+kEVO2Ei49fMvaKbTKfjqx8ubN1BCrhFmsA8hGQnNoYlL6KDyMd
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	847807867@qq.com
Subject: [PATCH v7 3/3] samples: rust: add SPI driver sample
Date: Fri, 13 Nov 2026 10:25:52 +0800
X-OQ-MSGID: <20261113022552.601873-3-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113022552.601873-1-847807867@qq.com>
References: <tencent_097BA6F40A0B8FBC4C130C6EBF58F8048006@qq.com>
 <20261113022552.601873-1-847807867@qq.com>
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

