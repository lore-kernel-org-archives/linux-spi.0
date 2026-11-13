Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794535539;
	b=rwWPYGbfdupZ0KEdokYqriccyulesWWhOxgTP9FjmPcP0Hy/xD7TbPmd0c/9JJi6qxJw
	 xZ9FIluhGEbVwgAnusp0POJ2IIcsavMeDQwtXQ1gg5ufUnJd1/Z0p5hzMefZNmnPZNzHd
	 qZe2h7A3ibpSYFUljDeW6pYugpj7FhJ3H0nxxvkthEfmoRO/nfs4+aSQayQDnZGdaawCd
	 loF8aOmiMSQJ1LXkdBhliyl4QrUg0piYzIQ8QPwHT4eIGzrSr7iU/Dn1pYRmaibKSuWU9
	 RsfX/kVNGrzk7Ubv0gOezAOU5gk6oGcxVfPyvcLIGi9CfaD3pOzyH7VgW5vO9FBfcJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794535539;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SH2K0IZ23OkcIsFx4oDzQZl4/bONJGIjQlDJpj+NxWM=;
	b=MKLpn063oC61q04Zq/CJXnVLePLRsUOIBHnVi7ezvyNaQDnZiforL5nplrbmPBTT9teA
	 VDOMTi2zebz/ZRgGvog250okY1ElKy0c37NYZTLODRsBm+L1yBILxguNV0CvB5KQ9zUv6
	 yF+J6Y2jVihWeJ2o76OIdsTNN6+Ct6LyTUA0CTpOIbPyU6RB0STFAvxjDHORzYsPbOu5Z
	 Bq9yohwwxclbUN+/uA9aFq5reEMVvHL2BvZVjdcl0WlKiFOQlFDhU0mPBpyFjfTdpT3eR
	 8t8XgyXijrDjqwbPyTM33uwhf56ZxyUcWRGEtvQYAG70ecyr6eY9Tu2Nq7epT2QbkAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=o2DVsVr2;
	arc=none smtp.remote-ip=203.205.221.231
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00683606A321;
	Fri, 13 Nov 2026 02:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00683606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=o2DVsVr2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794535530; bh=SH2K0IZ23OkcIsFx4oDzQZl4/bONJGIjQlDJpj+NxWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o2DVsVr2bXciyM0axwI1PVL7O0wNwXgHNNUfXt529C6KJoIE+lcnie6tLdBuI2oaN
	 igwuU0jkdqyWClypcem160pEFn32+a5ovqnVhGJK7etDj9auHvyi7GZVaaPWk84CkB
	 LoO4NmLkuvMJORvMxFI0/jSj8nCXhS0pyMOJ97jI=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.198])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 15C15046; Fri, 13 Nov 2026 10:05:28 +0800
X-QQ-mid: xmsmtpt1794535528tu4vz4lwi
Message-ID: <tencent_097BA6F40A0B8FBC4C130C6EBF58F8048006@qq.com>
X-QQ-XMAILINFO: M2fYR77PcAoOryWMOI95lTS2XQ1GUjRLJALfPDTKR1XvLgssXEgvcmPsdXpuP/
	 cqUL6wPUFLlNYikMgHaO8/WUtdbH8Dt67L/dp+hzVDQ7dD8jM2GS71yEYjCXUJXcAiG5m8L/VlEk
	 V+0Q2yxMI7G4yt26DJ5HhNeEPegdbUHr4vuZ840/T0OuUrHxW7i+qdXyB2itcsM3WTnaCrloomXo
	 yPccmtpTPAYNjr/J9VG/DiylDyAh3w7qRKvLtzlTzhC3r++GA9F7ChYFbO2FzsGkl15pB5NFwUDz
	 Mh4QRkMgfCebUwSFVKphlx5iL2tNNMCIRCm3WPODBSUCinxxMXsyw/U0TbpUMAv2//MpqNUEUm3S
	 T6KeVX4o2XkdGgq8oZls6/SOb5GYIFJL01qhVRiG6Anl4bPze/WAtx0LvSAaIGKuHJtNy2YHNFFd
	 2Zu7C39XEcn41ZzR5a75tgn201PpapljTMCeeCXArK6DfDllrrZtUObtMorGQLnhAU2Ze0n95Xci
	 30TugJ0trxamuSKgjJU13+bdf05hFO8P2tW+Kx4X06M3I8qMASxI0xtSKBVRKn56yPTnPYY9OPhO
	 RtUIn7fhh3+M1iOZSxitseuBevqRJx622xsXLP2h+igRqJOAfFbg57vEPtgFztKkxVE5B25P50s0
	 yHNc23irOiZbeR6xeBxIFEuwFS8gvsD89FIWFLmnQPY1GEn7JIkW5lRmfU18G8kRi2dGBaFbwbar
	 z0Pp0xsFWM3+jGqou6lvtieKxlpEp2aBytqaSLSPdtQhfdax3dPTtxmZdY+/iLb+vAw0DXJ229mv
	 OysY9AolBucqxJ+tVfn2CvATcRBV7R4I4Q2cLZhWWcmTneyIIejzezQ3liU/ql7Zn114WtfhegTj
	 4TqkPZEfzLKjluYDFreI2NjVBrJJ5R/mwozdH6pfi+LIzUlLUDx8qbFscYgVAMLjV/HFWogU03LQ
	 +A0K9qJ/FV548aUvQt7CaGBIYP/Qe7BiBeuD89Uo4zJsyBMmFnxj2l/vE9T7S+ABQ3hpb39MGUuP
	 iYKNT6xZr6RfRVRWnL0X8Hgc8m3WdsJ0sYAPkboAW1pumvXHGxnA6YjpAllANA+m2pIPpvY0cxyE
	 yCGF92C7pLzWd0ytM=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	847807867@qq.com
Subject: [PATCH v7 0/3] rust: spi: add SPI driver abstractions
Date: Fri, 13 Nov 2026 10:05:28 +0800
X-OQ-MSGID: <20261113020528.596830-1-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179451185979.339049.12323339081307899766.b4-review@b4>
References: <179451185979.339049.12323339081307899766.b4-review@b4>
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

Rework the device I/O to map onto the lower-level C APIs, as suggested
by Mark Brown [1]: instead of leveraging the C convenience wrappers
(spi_write(), spi_read() and spi_write_then_read()), all device I/O is
now built on a single `SpiDevice::transfer()` primitive that maps onto
spi_sync(). The convenience methods `write()`, `read()` and
`write_then_read()` remain as thin wrappers on top of `transfer()`.

`spi_sync()` requires DMA-safe transfer buffers and Rust slices may be
located anywhere (e.g. on the stack), so the Rust layer owns the
bounce-buffering: every transfer buffer is copied into a kmalloc'd
buffer before submission, and received data is copied back afterwards.
This removes the dependency on the C convenience wrappers (and their
helpers) entirely, and adds full-duplex support via
`Transfer::full_duplex()`, which the wrappers do not offer.

Changes in v7:
- Rework device I/O around a `transfer()` primitive that maps onto
  spi_sync(), per Mark Brown's review (patch 2).
- Drop the spi_write()/spi_read() helpers; add
  spi_message_init()/spi_message_add_tail() helpers instead (patch 1).

[1] https://lore.kernel.org/rust-for-linux/179451185979.339049.12323339081307899766.b4-review@b4/

Shuai Liu (3):
  rust: helpers: add SPI helpers
  rust: spi: add SPI driver abstractions
  samples: rust: add SPI driver sample

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/spi.c              |  26 ++
 rust/kernel/Kconfig.test        |  11 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/spi.rs              | 673 ++++++++++++++++++++++++++++++++
 samples/rust/Kconfig            |  11 +
 samples/rust/Makefile           |   1 +
 samples/rust/rust_driver_spi.rs |  66 ++++
 9 files changed, 792 insertions(+)
 create mode 100644 rust/helpers/spi.c
 create mode 100644 rust/kernel/spi.rs
 create mode 100644 samples/rust/rust_driver_spi.rs

-- 
2.43.0

