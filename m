Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079736;
	b=BWknNtzxYiJx/P0lkYlsvmxSkF8T8Z2kzK3kfBHwEa3ZXcZMMkxJxTVzgs5UaLHmjM4e
	 oGWDQBm2qroyc1lSCIIYrQaVmNn5lN1kr5Si41JpBDEriW2hisMwOMODPCmbjty+yOJ5w
	 cNsPEOS8gAnQun+cjqQz0V2+sHRzajmFeRq+AX3uwe7cPf6Cv+ULCs55sA02+GWwgig/T
	 HGdGt5lj5JVSgfsfSbGisdMwdkBK8RGg5YfXqkXSQYx+QVeB1zDUec2ou1CTOOoO3S9NV
	 whwFFnS8oG2OtBBGE3iSxMTZQcYb7xYf11yLh1XMKUwb+5UsuINuwUFiei6u/TZqJ8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079736;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=dN8Vr7gtSzLg9qBS46kA1gUkJYUDEDKR9O7aX1C9b/A=;
	b=EfmYI6C6joPPjncaD8nw4uNGGd5lQbZgiN++t9+71jIiyH/BIkVYgSPp5HAA4T+hCRaq
	 oeqhe1oaL5K4aKbXKaSMjFlsPvNABu535A1lNp868uOsUjNesriuL61DfA5+hjsNB1NBX
	 VlDb+68WczqgALRK6gyzLiRs4WQAXymeiZnc4d9OBmvuCJV4thTzSsYawG3edcm9ZpPKx
	 T2ECgbqCy4pPCqpTMQjFu3LE5mFtZDFSX1JmyiNuqy+QC8FOOteFX3/DOtgjS0rG34nE+
	 9P0PfTF50hLZWqkm8uelrd7WcRxPg2ZI/1ryJBR0vP6myy/G+0UC8TZa1Se+ATXJo3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=slqQy5df;
	arc=none smtp.remote-ip=203.205.221.164
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E979C606A31A;
	Tue, 27 Oct 2026 05:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E979C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=slqQy5df
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793079732; bh=dN8Vr7gtSzLg9qBS46kA1gUkJYUDEDKR9O7aX1C9b/A=;
	h=From:To:Cc:Subject:Date;
	b=slqQy5df+2J00CEUaUFpeFD/c+YT0XAlzCIeoAme1WVwmg6TRMXZStqZatZFqrwV9
	 dGtNE4i9WS6/VegPNvqBUt8hRXZzt6cbK2U8JeNtIUuJ8v+6WAgkC+4tSjD/cDpz9e
	 sQfhmGUPVr5kvBal12vksqg/q0IVbteYyAasnEE8=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.198])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id A89B7814; Tue, 27 Oct 2026 13:42:09 +0800
X-QQ-mid: xmsmtpt1793079729t81vrrph1
Message-ID: <tencent_2588854DF4B99B4897B3F4CAFF3461E14A0A@qq.com>
X-QQ-XMAILINFO: NAUIJqpQ8r9OIFaT9bbWR+M/JdoND+f/ChC9JDVJKF+TruZpAgTaiS2HUEv23t
	 RRqPZslgZA8zUEQRoj3ck/LfbKv7u6+yU2ORKneHku1X7S2VZdYZNDOisoTZJ3COsZQjwdr/iM9Y
	 PMV4J6RyQt4pf6n5sF4m3KR413xq1yS5msHI1ub11YB7EN4dpUt+abPu+2ApRhLkW0r+mDXe0Q8n
	 g3vPNMdtTA6rF4Ot8asjPU2enG69TVVWSMdNrasojfhUPm16NUOKutiCxciDuxJhiDHVlFodne2g
	 BDFTYCn1ywj4Ji4HY4YWebeqPcDL4Hi69PMWwjc6esYlE+upIcnbG7hx0Lg8G9H69qD68a1qg0ri
	 vGTYFLSFCTNSgOMTzyCqPWOGGIN98d71S8I8SssnoiB1j6lqIDp3xUrg3ZDfcDQG0e77B7Be0mSn
	 9VsZG7Sq8GQGF7lHRH71oVn274eAf2Re3wgOLJNecVUW/pXbfX8H9YFwlghXLzTr/9BfNwr3tJiV
	 xLknCx3R0GqcUx7XPH+qmGkYm6Fa1/Y5drNILUfZrHDH2oEUJnJe4s/wSV2la2aewwYoxnVTQsjd
	 m+zx9iDtBawmzWS5qsh2twerUw3sDPycv80SiF/j2xBTEL6ebA8SFUL2HwEI/a8sfX/1z8p7l4JM
	 Y6ZKTgSQcHrgLvzB8AjGG7BWpwYJewAkJd7BfFxBajouYO5a4qyK3jknkq8NqSQwGQelPUCmfvqv
	 mUFIKL8HQHLHbM1C4RK9D149jus3oQaAzGUaMOqHvnv0ILZ2uKnhMJVXuIRUMxEdCIIPTYKBWspZ
	 WvbFvLdzBwvKLGeNZA1uJn0kfGpuJuQQHsvICPcRNeEmCkCS+FYfY3apfmUc/9GbswVNKyPTvk7y
	 bICkiDRSUWQ5gtTlmFRJOk5TeQcfLZjJibnzhReZjgmmhoJIzT96GIrRaa4Bf6jPByQpvz5IZJ4Z
	 G6JjXzt3lboJMXo/G0dmIAQJaJ3BtHAAe73hVBq7A5DkJ/zLmYCUTEoHE3h//j2usXkoUpq19KdQ
	 4WZFA+2RZxw9PB3YS3UORAF0+l+Nqc55x5FfFSdy5ect0E6AuPf3XqqCPDlIYIBUGeGOcxstI8rX
	 0x+PKmk5QhEQKfogwh092Mnmxw6YJcoesj06/tgzcG+pzldcykfjwUJeFiKg==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: broonie@kernel.org,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH v6 0/3] Rust abstractions for the SPI driver subsystem
Date: Tue, 27 Oct 2026 13:42:06 +0800
X-OQ-MSGID: <20261027054209.904654-1-847807867@qq.com>
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

Changes since v5:
  - validate in `write_then_read()` that the sum of the two buffer
    lengths fits in `u32`: the C core's spi_write_then_read() sums the
    two lengths as `unsigned int` when selecting and sizing its bounce
    buffer, so two ~2GiB slices would wrap the sum to zero and select
    the preallocated `SPI_BUFSIZ` buffer, which then overflows on the
    copy. Found by Karl Mehltretter.

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
 rust/kernel/spi.rs              | 570 ++++++++++++++++++++++++++++++++
 samples/rust/Kconfig            |  11 +
 samples/rust/Makefile           |   1 +
 samples/rust/rust_driver_spi.rs |  66 ++++
 9 files changed, 688 insertions(+)
 create mode 100644 rust/helpers/spi.c
 create mode 100644 rust/kernel/spi.rs
 create mode 100644 samples/rust/rust_driver_spi.rs

-- 
2.43.0

