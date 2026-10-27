Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793070247;
	b=fTPdx+nJpbiMermBtJapepJP4cl/vuAeOOSXPvjWc2opN9MM/GKt0QOBMSmLmcOOw9ov
	 2NZUh5Dgk9cTPW9Nb52xsL61PcNcKjB4vUe/Rhx69CRUE6WNkW2QSUFKauJtpypV97E5a
	 niF7H4iqCPuVtFrhf0I+9MuMdKQIf+1lL0/ucD1racUSdwUxFBKJlw30KcbJnE+oL1j8e
	 icBy6u+IhOOx41Y8nTz5v0Voov0V2CqpBOTB3OSJ2LUjJJCD0RIhHung3Q1spbAel8s6g
	 g0mXXW0eQ1vTx0iNRJrn8Gt/v+oeeb2Xf4CoDD+3JQ0CnldhBtxneP0fYvJwXfq2eEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793070247;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=22YTLRAH9LjslA5o5uxehmnrNAcub6Xlpqr3/Z1Z5io=;
	b=tSgG8n6m6PQN2JDjVfno2F0ducY0LCjDOHNW0La3jscmWjGjtscdKTC/G1tH08U/tNlS
	 ck4lu6WHun4R24bipYrdgEAQ/jz5IRBMcRxLbsuofAvpcItTmZPx5GXrlL0oQ0KnYrtGk
	 vFw9xrUuq51/f4+ojAgd7TRV55r3/Hh7v1kT6J80fjjziu7Neeutw4yUpPYmjX5wODH6w
	 SIZAsal17A5H5PZEWxJDCL0ntb8ltx2JcVgLVyl2Aed4XWt8G0xHIapvMo659l2HlfF6d
	 RCeOARLBZsGqL+S9pCtYEKsVrHLymEYAoBrzUj/4OAuvrSIbbyEeY9Y3iT2dko8bXKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=GoH4UUBN;
	arc=none smtp.remote-ip=162.62.58.216
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABC2606A31A;
	Tue, 27 Oct 2026 03:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ABC2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=GoH4UUBN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793070235; bh=22YTLRAH9LjslA5o5uxehmnrNAcub6Xlpqr3/Z1Z5io=;
	h=From:To:Cc:Subject:Date;
	b=GoH4UUBN6QEQpA1aNO0mPBPh+5d0lxcvSkbuoEv/Z1Xom0K6/0CLnxvB2GV6nkEnO
	 gs9Qqvjrw+gKz6iu3M6shHV0Okg6wbh84IbWlto5IMrXUUwLdKnrip1bThaQroyph1
	 E7coR6sCifn0Cpbc09Jl7D9tjZ5JFhtpmsW3dP9g=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id F43C6C8; Tue, 27 Oct 2026 11:03:52 +0800
X-QQ-mid: xmsmtpt1793070232tndvrffgn
Message-ID: <tencent_BD76E4D79B927123C43A26EADD37A5B95809@qq.com>
X-QQ-XMAILINFO: M2XWT1cfdefVcmYLZsx4+/L2+fbkJJgfAY8sd/H34rm4BHbvBvUkvFbNpEimKr
	 tMUgY3JrM8j2t5bxPOKok/cQnu0+98oOX1wZhw4kbWzlieDNsGc7G8IICb9TRVdwGAUuv6NLGsaB
	 Z+tWZAAlduOdM3x7xp8md07ot5soZHB7LXzyuJvAO0qVOz7ByptglYgfoC9JOjwjEkP6jQ4nuy3W
	 aDyltZ/mKO62idTaDEoto30y5RVSlZVmV4FCW4wVAspjNN/+oZ8EWaa72xRrh36WXtImA3Z/E1Ac
	 8TYuhZ065xVUEfEaNTOnDVZUDrqjzn5Ze+Yss9Dv55sJJJzwBO1vuKM+pwsNwKW0s1RHSp7SHmJh
	 wo4zlugSTH5KX92gtN6fCDtn2ORQOqPENjVsJ/MlJEE8sPI+z0pDeUSXku7IUsIYIt5ukcVEL/Ex
	 N0/LnJc/Ihw02PBsWaxT096Llup0Oir1w+f9iK6rmjzyC4qrzr/9C0M6Pi02UdJUcY94L7x4uMhx
	 KKfCWRkxoXKoBezgFgc+MmiwRNic3vLPTftQMZl608c5XCdD0/WMEBJR3NyU5Dadr0yZUwaYe+Od
	 md5Yv6+ZIS6CGbUCrbpOresHzNEyLVHykb1HEEQQWevpj5ILf/OIJSRJdz+MpKqMA9C8dhIUp/Na
	 8YIdAYAgFsi47ODhQzEnlTsVmpArDYo6nK16f6wVXgaQXiggA5Ak561PXyb4QFWuDRnATsXfDV6U
	 AptdN26MOuA/swjgGCb96XtKJ0148QY7rIRuVHCgS9wDNMnxDgqnoqmemvz1wSRYBrmSjkDlxtJJ
	 QwbOaoEsLL2jyX2KtWMDuN+yNltXUZtJbngkKgF//LlDGXnme/+nQVUPL1bTQbKZ0jWibMrn7/wg
	 IkFceJtUYUFwrjO6yI7MSRrEwZcyq8Ca3Mpf5uXsSl91OSGtTUQ4vNlLLSHzPO2emRV7bqHwyw8B
	 BenB1Xfv1uGGF7ZJCpEVVD37mEsIpwOFZtg2E1wkbeKDchBJI1/HYPaRIgb8UVPjFTMMyvpuYB48
	 vZhNDZWQmKBb+FjDJjVX9XicozFQ1UcIHb4K0wYL4DSF8uNjoMT8Up04ogjmmqg7NVLvDEbILQDH
	 cWD19oZSF4vnHEOQWtuYeqI/kR+HBoOZsnje3ImveOq9H6kP9q9M8krTux0j4ms7vyF/9uuAo6ml
	 EYj4Y=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: broonie@kernel.org,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH v5 0/3] Rust abstractions for the SPI driver subsystem
Date: Tue, 27 Oct 2026 11:03:49 +0800
X-OQ-MSGID: <20261027030352.615926-1-847807867@qq.com>
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

Changes since v4:
  - restrict the `max_speed_hz()`, `bits_per_word()` and `mode()`
    configuration accessors to `SpiDevice<Bound>` as well: an unbound
    `ARef<SpiDevice>` may race with a driver subsequently bound to the
    same device (e.g. spidev), which mutates the device configuration
    with plain, non-atomic writes (e.g. via `spi_setup()`). Found by the
    Sashiko automated review.

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
 rust/kernel/spi.rs              | 563 ++++++++++++++++++++++++++++++++
 samples/rust/Kconfig            |  11 +
 samples/rust/Makefile           |   1 +
 samples/rust/rust_driver_spi.rs |  66 ++++
 9 files changed, 681 insertions(+)
 create mode 100644 rust/helpers/spi.c
 create mode 100644 rust/kernel/spi.rs
 create mode 100644 samples/rust/rust_driver_spi.rs

-- 
2.43.0

