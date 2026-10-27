Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060420;
	b=OkF0s73S9MuKygt4/AXGYmCDQqn5P6Fi+PcIEIYK1V8vkV+R3MnJFEV5t+59RfPm0fy+
	 MLIz0y2UWq49QP69j+0eec+coFKrU2Z0ElpyRbECawHAsrDsstjhPwpq5A+aiSDZP6jH4
	 slnAG8ITdol6Dp043Z+UO6d2LckKs4BiZLCfXFHt88F9g329niCoHRSyN5PolrXrEFI5Z
	 /fz10yt6rChyOITn2yiO8IQ88fOKOuF04BKzcbsX1XN3pjpzfvKZB9lmUnNqeZDxvLxNW
	 vyvIXM7jNa3ukrOQy/3tap/X/0Ar+B1qeH3LVJvCCol+pivS10/40H2ssniHfSeRqgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060420;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=kNk1XQSQ50TGZ2viooJhP87WzCJSrdIThQUbw4hpN8s=;
	b=Jxnkqw2+7G1o3LwKnE8B7rmA0JTyJx+yeheuwvqXHrKRdCh7g2wkU2cmEfXK387ET30+
	 5nbU3qA+n8z/hYKUOn/7ghp1C8Fqlmo1S3BR1gRbG2VTAE+XphS6DKBflBbBqFo55p0p/
	 DFGtK56UaloBwDtRnNWb+xqQYAvfS4TrT8+0MENuWtxGOwQv2QX02Qc2FkqmiR6SWLj7t
	 seaLf5NFsloZ5u5X8UV64hLOvgaGRbpUnG9t250NcTF11coobC/Y69ZwScbV8ubFqjt1g
	 82fppugtotqoaijJmXpbEaF7yucw3ZhSobjxPNnzfGVg6vFGhe9jWiFdHT8nGC+aTuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=koEjDxs6;
	arc=none smtp.remote-ip=203.205.221.239
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1A8606A324;
	Tue, 27 Oct 2026 00:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC1A8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=koEjDxs6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793060410; bh=kNk1XQSQ50TGZ2viooJhP87WzCJSrdIThQUbw4hpN8s=;
	h=From:To:Cc:Subject:Date;
	b=koEjDxs60Hk8mAHuJJNpY1AmT9vY/v/t/xAboTm6hahjwu71CtRYUVfvreB7DSl2q
	 RtcSNzdj40k7WH7ZEMSs/MqItjrR1gxPlQwfpiKY+NeuncRTJ20xbEt+sBOSnGtIXF
	 jTf2OUuNspxZ5enL0vLthYNMx665r3DtN+NGfrFQ=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 50815682; Tue, 27 Oct 2026 08:20:08 +0800
X-QQ-mid: xmsmtpt1793060408t6qlgz2j2
Message-ID: <tencent_1A6955961D79F8A63ADC6831840934770707@qq.com>
X-QQ-XMAILINFO: N91PKLMQLILLhJlKV8TdvQvm6vrNOL0uAuZ+NClTizonNE+yleIpWnLDwCoupG
	 9UVKixHC8gN9RL4GGZA3p1n+bh/eYDZtk6/V+vsGa43SQO2MkqJGnydFhT52T7pCFQTpYfwjs3pA
	 6xqJWy0SDRUVIP5ZARhJFlX0lXcsY1b21pkiaWzKgwQfNlJ7oYX4FPszs9EIG6sgQZ13g0czLlK4
	 kYZtvWvMYR1a1LCnxvnvU38E1Jy2jvBN74XcuSitJ3IeoAuh9oHmUQvaxFZicTtWhECkomNd0XJa
	 Il8WgrpybbT/eWNPDNY0CnPfsOLxrwIuzNr1oHxAHQvsb7ZUaIIyYIYiqipEeG9Sa/m3rZ57PXIX
	 jjheRrQYZi06GT7NjT2dRJlVLo7i85dAWJ45XwjNaTh5EN3SnZnUXR0Iwy9NHXu6t4ybNwC5nRg1
	 hIwKO8uz4M+0I5mRaWPb2fkRwkeVnWc28+RdB6bIC4rLLBJAglAb9SfnWzeis34OrAioOVj5kxfX
	 2UT07MDazGuWVH2pv71E5l3WICwYKWno0tHw2i0kly6WSjKbqzukQNiYwGkjpAQN9Sl4nsl2+WVU
	 vawKTlSRO5MlzOfinE25Tc6YkrqsjJ6k8chJda/Vab9xj0WnFZ9s9DQJtyiXrZZfgxD8+zuIBUyZ
	 uIOkB4Bh0sbETGbPQ+1b2D3zzKpYlliA/GJLQjSPESnziTJX+o1MXECuplFqq37GdTdD0QLTjVpL
	 Z9QEH2PL/wFz7qf5ZxJRsbCAJH3YEJXOsaGHHmnEV+cDPTuHOcbbf/PsttcX3knk3dxuzEA9FjMY
	 i0SXO8bMzeVve/YlSV5eZQS9UlgYQ5ZBCLvuouMeDKkxTvvAZgF0yJKmbKFOjXyri/4ljrvkJLyd
	 j0BatwfprZITRoF7CGrxzWedzEVwWwuN16ioFVlCqAxSbt1RCp3rrNtAcnVb2TosjsCgQ7hUUwlH
	 KsfJG/owahG6B/pbKgOqLo+fav9fOf17DGtdyZrYPjHiRqZHKEDgJPnJQ/PcogEYThvg+zUghPmF
	 JaWNSP/su/bCZk+KdZda2nPv6tU+3pizKh320edSRzO23ofGrlnH1riBejs/s=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: broonie@kernel.org,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH v3 0/3] Rust abstractions for the SPI driver subsystem
Date: Tue, 27 Oct 2026 08:20:04 +0800
X-OQ-MSGID: <20261027002007.303020-1-847807867@qq.com>
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

Changes since v2:
  - use `info_unchecked_opt()` when reading driver data from the SPI id
    table, so that entries without driver data (e.g. `@none` tables) are
    handled gracefully instead of dereferencing a NULL driver_data
  - remove `SpiDevice::setup()`: it modifies device fields without
    holding the I/O mutex and can race with concurrent transfers, and
    it is of little use without corresponding setters
  - drop the bounce buffers in `write_then_read()`: the C core's
    spi_write_then_read() already copies both buffers into internal
    DMA-safe bounce buffers; `write()` and `read()` still bounce, since
    the core functions they call transfer the caller-provided buffer
    directly
  - add `Sync` for `SpiDevice<Bound>` so that device references
    obtained in `probe()` can be stored in driver data; I/O remains
    available from any device context, following the precedent of the
    other bus abstractions (e.g. `usb::Device`)

All of the above were found by the Sashiko automated review.

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
 rust/kernel/spi.rs              | 548 ++++++++++++++++++++++++++++++++
 samples/rust/Kconfig            |  11 +
 samples/rust/Makefile           |   1 +
 samples/rust/rust_driver_spi.rs |  66 ++++
 9 files changed, 666 insertions(+)
 create mode 100644 rust/helpers/spi.c
 create mode 100644 rust/kernel/spi.rs
 create mode 100644 samples/rust/rust_driver_spi.rs

-- 
2.43.0

