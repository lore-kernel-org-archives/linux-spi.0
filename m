Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793067225;
	b=5igfh1Oe83oCJ1GLn9ENbv/pHq7OxRCbGpXDhkIQd+HGE+9nQmpXttTeV2KPh5jYPFFI
	 ztPYc1+I+x4eX77+t8tYiaDe5/lzQ3ELsYLS9m2yAg8DzVcioElIlBhbp0fJsFRcu667m
	 t5jU/a281wPL/EEuxeQcc3POFPLvboCOs0QzlyIQzjgZsAyHsawzZwDl0CRipH8UZfZFX
	 b2W3NsWQDE1amV2rbqW1TaSNyiXoPw587dueWBRYAwhh554cQn6cvPixkdbb1V9FGWKFC
	 RgDuMQRMCxfj/UmIB/2gpgmma9HWflKfzJyVAcWwoMwsJ+OFx8viftFvenAAolEMJUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793067225;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=RmJtGC7lZWBVFsRpSCnjAJjP8V8xYdU1wZ5Y0RxDQ9Q=;
	b=MS+7c8L1eF4NZSrCiBfTwejTWomwAODiydGfc9q/B5ZL9HlV0Qvi+X7EYcXp9FaRNJ+Q
	 S4juJjCGd+15h/gW/buDaR9QeKn5AtDn9a3pOxC29jG2so/9/w1/NRhhi7IsQ1uxmXu5e
	 ecUIFLUUsn1OW6e1T7Z/EFrg6kw/2OnIrwuOFqhke4g4azMQzIe3DMPqi2wRGDfsSsa9p
	 ifDC7/vQ2a73EFAjuJFbbbgEjQQ0oEymDJVFXffEh69rNNl8wi8vOtWR7TQXWrdWbt6rJ
	 GYCTdC1uqIwnNS7ZBw+CVggCzRX8HpUQ8KIbixkTnM6sY46pugbzPDudSwwYN6H5d1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=RQdENPVI;
	arc=none smtp.remote-ip=203.205.221.173
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2386606A337;
	Tue, 27 Oct 2026 02:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2386606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=RQdENPVI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793067214; bh=RmJtGC7lZWBVFsRpSCnjAJjP8V8xYdU1wZ5Y0RxDQ9Q=;
	h=From:To:Cc:Subject:Date;
	b=RQdENPVI6SKEFgncPwfdtIkjbyjVH0hk6vPIwRWA6eLOK962/+KxVsVAsvtl+PcRa
	 BVGmCTp0KWZDl/Rz62YAdkGtb5AH3vJ3s50MIXQMrpkKTasAtfG+oVxKt69FJZBfQS
	 fI/E6tgD9t90MEiSzTqYarmpjAlG4PIbh3pzGHA0=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.198])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 360172E7; Tue, 27 Oct 2026 10:13:32 +0800
X-QQ-mid: xmsmtpt1793067212tb4r0qixu
Message-ID: <tencent_CCF7B170CBDF37A5E3E689714FA4B99F4B0A@qq.com>
X-QQ-XMAILINFO: MEaKDlY90mahG/6K9q77Z7K2XhMokr2VzmPvrx4VWRLSoh+ja9cPPsIABsNno2
	 WjHwMpzn6/m5zGSxGW/FACfMjcWslhQd44cQktMNGMN+0MSK6BRIjJEOKB2gGaD2Hzau7f33PQVs
	 RqUC+U7Rj7+e88tEGrqnnkPNRlo7BtcGYjEcxLXQeNBlCyeJvaLJiB9nAEY7szEx7bDWzfmypMAy
	 XB8Zj0TycKbSdgove8HNnZn8xqh67VPp7a+PPcjGc91BFt3scPEy7qXUtFiffB60SShgiBTBl2Hu
	 zamiqg2sox/tglVlL9QHDZcR2b846N5hDUuV9rutC4NLELZaMBmSaLVr5IsqIHox7S8Yj/ZMpMIb
	 olEhe7moSTshxjvga5U3TWbd/mWRCxUtYuZkf18f+6xmbxWfDZNBbESmWrTI2PBXpgD3TS6Mnob9
	 iGhXWZykIPjE3KkMIiQUlV1neBvJ+7eQ70hEiRpKLW8RBS2N6kg+Fw+i0IQciu23quREpx7AowZU
	 tjBCER1jQrXYNK1nw21bR7gQQ03AQrq0qEu9r67rRLTG/KnRGOEC+UsNYypp48MQgd7PIzwubaol
	 Mm6Hv1w6hNna1O9Wl26bVtLt5xJiVEMdIr2ZJNEAgCaGzmqAj7G2DU3vXZjeI0vXn+VNZf6LjIav
	 7YnLIAbXyJIFmYVZu60L1qloBBGZ+tU3rfRXpFVfD+25WlmyKoFIs4OSkep9dWLsh424L4pn5IFF
	 pBYuCt22nuepbWokZEDDmLYT+zIsIWAD1dmgn01lJbL6lXXSioTMuIv6JEbDZXju2mZaCwP9Kjtx
	 H/GhALumQRqbRZxBt0I4XOSYxJekGSZ5m0OwCJ5BSidtQCz0nJ5v0LZg40+yPqKoGIPK86ecWJMJ
	 9WmfVMKg/5Aw301N6SIT4lUab6HDA+/c8ifMiE0eyGsDZqb+8VDXoDhCViMVjIy90uRDW+yWvpZj
	 vmFx9883BgO9oH4vn+xIg380hpsWJs91d6ZpNsuRFkocRXgZyfN/byAffXumS9Kn0JsVDHDjnJM0
	 KYWpvfen2kA5SKv2nWD4kj12YcYC6YC8QPUCkMvYjd2en3yfWtowmZdcw23pUoDxOM3BGSxUQp+a
	 eBiGZjTuI2BQQiVrrosVDwu6sETpChPYtGNs0Qe7J+fT+/H2M=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: broonie@kernel.org,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH v4 0/3] Rust abstractions for the SPI driver subsystem
Date: Tue, 27 Oct 2026 10:13:29 +0800
X-OQ-MSGID: <20261027021332.440224-1-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
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

Changes since v3:
  - restrict the `write()`, `read()` and `write_then_read()` I/O
    operations to `SpiDevice<Bound>`: an `ARef<SpiDevice>` may outlive
    the driver's unbind and the device's or controller's
    unregistration, and the SPI core's transfer path does not check the
    registration state, so performing I/O on an unbound device is not
    sound. Driver callbacks receive a `SpiDevice<Core>`, which
    dereferences to `SpiDevice<Bound>`, so I/O remains available inside
    the driver's callbacks. Found by the Sashiko automated review; this
    aligns the abstractions with the serdev and pci ones.

The Rust abstractions for several buses are already present in the
kernel (PCI, platform, I2C, USB, serdev, ...), but the SPI driver
subsystem is still missing such abstractions. This series adds them,
along with a sample driver demonstrating their usage.

To my knowledge, nobody is currently working on Rust SPI abstractions;
if someone already has work in progress, please let me know and I will
happily drop or rebase this series.

The abstractions follow the same layout as the existing I2C and serdev
abstractions: a `Driver` trait for drivers to implement, an `Adapter`
for driver registration, and a `SpiDevice` wrapping `struct spi_device`.
This first installment provides synchronous `read`, `write` and
`write_then_read` operations; message-based transfers (`spi_message` /
`spi_transfer`) can be added on top in a follow-up series.

One deviation from the I2C abstractions: `spi_match_id()` is not
exported to modules, so device id matching by modalias uses the
exported `spi_get_device_id()` instead, falling back to the OF and ACPI
tables.

The series is based on the current mainline tree (7.4 merge window) and
has been build-tested with CONFIG_RUST=y, including the KUnit tests and
doctests for the new abstractions. I do not have access to real SPI
hardware to run-test this series, but the included sample driver can be
used for that purpose.

Signed-off-by: Shuai Liu <847807867@qq.com>

Shuai Liu (3):
  rust: helpers: add SPI helpers
  rust: spi: add SPI driver abstractions
  samples: rust: add SPI driver sample

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/spi.c              |  25 ++
 rust/kernel/Kconfig.test        |  11 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/spi.rs              | 559 ++++++++++++++++++++++++++++++++
 samples/rust/Kconfig            |  11 +
 samples/rust/Makefile           |   1 +
 samples/rust/rust_driver_spi.rs |  66 ++++
 9 files changed, 677 insertions(+)
 create mode 100644 rust/helpers/spi.c
 create mode 100644 rust/kernel/spi.rs
 create mode 100644 samples/rust/rust_driver_spi.rs

-- 
2.43.0

