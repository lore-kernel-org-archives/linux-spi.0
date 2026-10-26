Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792996161;
	b=i8OlAYtPSrLyFmlACCGKFg9TQ5R9nK5f6AtA0QDAcmsyT6ct9T5r6N9ylIigh5Peja12
	 b8jKfjcsdvRe+qs7nRHwZbzdDpAKf13Og8GboQQ4aoKMMYiSuRNIWFkQaVdaqP1BSAAXy
	 GYd5kIAVoRVJcASTs58AzUwbu9Yz3vDCnDu9uKsthWY7jpv1uvS78HQW4BSSHgxfBUGW2
	 55axLjvHBEvkHV3V8SgZEgIlwZhM9HmMMCDATSR5phmUgBbgZrplEt/gk8w1ajWVAyNMq
	 Zabz9IuhIIRo4ubUV5qq2KkLLhkh9rejyGmGbbqO3qStb5Vma/lDkVWVn8vBk4TSKxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792996161;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8RyYZm8llqD2V8R9oo1RSAmQRMSykge59VnPnY+30KQ=;
	b=XdfK8NgNtToZZzogAUKd/ZPVzICVjUHiadyr3R1r/Zt99I8EuvCNgZRC/Gq2vH9CVFRC
	 BFN55L3qQsbLK6t+RjnqvOrfCINCInz7pAAnNeQKYa0PJ/qclK5Qr18hFe7zIjOtv9K9+
	 BTIglrL5atjruJGZC48z+vP51OFM9K4nvANGh91xn+mGLK3r+61pvGf6mI1QBLkINQE9F
	 SWFg1aqGcZLgNExKd8NkHo8z1QISbbLKIGf03dACVAMM3wFM5kHM4AeYET8iSbID2/zDK
	 08EKoKSqOt9/Ux8hrTifGwsRAs4xjF78bANJoovdOf6i0EGZAv0RYhgeJNKqquHAZ+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=llcgtd4a;
	arc=none smtp.remote-ip=162.62.58.216
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F658606A326;
	Mon, 26 Oct 2026 06:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F658606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=llcgtd4a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792996148; bh=8RyYZm8llqD2V8R9oo1RSAmQRMSykge59VnPnY+30KQ=;
	h=From:To:Cc:Subject:Date;
	b=llcgtd4ago/SZOiUMDefzDCnKpPsJfhrwJ+01srlATyKNGhGlgCk7vNY66etWsx+y
	 wXaOmmT4L+4mCzP4lZPHFSYDuMNZ3VPdSEjpaDpM7nVrKo6Vq2Ny9OFW2BekHkcobn
	 HdNxcgjh+V1/pa9N4yb6Ysw7gZ6cduJkauwoKBKc=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 74605611; Mon, 26 Oct 2026 14:29:06 +0800
X-QQ-mid: xmsmtpt1792996146tlym98x0w
Message-ID: <tencent_4135ADE14689514C50BAFB4BE3B184C8430A@qq.com>
X-QQ-XMAILINFO: MUl6Z5IrFzo7Z3+5/zE9HPIJH3xjqhepyZVuEH/jea4ip6QCTHM34rvW99mCB2
	 1fKi6nYDhl16Q05cKz75DiG7CfB9Zr19dAP9gpAUT9+Cgw9oMrl9KtME0yL6zQgLuDfqQprLqTnB
	 19exyS0cJCFprqWfr7tog6R+rCRZCPaLfihjFIUi8THrW1CyOIoWkkM5zPO/DyaAHsJ1Omhghe8t
	 4QCtttxA/PG1KT8fB8gRNiyov438PZV3bZJGBFoLELrWk4VTt2HDlGCvJYIGhUL/iEbz+BjRlohL
	 Wo2y5zGZr7EOUOzVaeT1wq8Drxxn8AIIX7hW5QiK+oKkICPF8fRWOExkUrRuTeXSeh3e8AsL4GD5
	 yhcqd2mJn4Eo56Bgn4AV2e4pK+uvMLRig7UqPslQK34B+Nc4iyhL9KE9A/fOXeARZu8AgA+NTNwD
	 0jSOgv5QXPPYjYQXeQa3lWpOAqkMaTe0a+Qtxwjtla4XdVdHEvQyPutEBz64lahVL06BJfPhl3LU
	 n/Oz9YTmMUlE5TTg7bLBCGZS8C5raoh57+bbyyY6y7FwcUazS/+ZR1xk8qltkDKkZp0U8g/5ye8N
	 giIr/6Yttc8qdet8J7Q7J7Ewe8rkyOIAylVURCnIjPaXykR7gGjgGp0e/4leNd5Bile6eX7eScUI
	 bKJBDE5+cZ/ZnuutT0ekMSXeB0goDE/fIyS9Ipap1oW4chvQlqnhFFnTGjXNLjDAeWXxWlAjedNR
	 g4bla7aAwPOwE/k4JP4n//k+ddSayAQMN6FjddMYGeOXU4AXKVEOtQWRHjjujmYA56Ke/TuX/tLl
	 cw1MVSOM+FzWsIWFFQtX/FyUvUaBWelx/qiL9yT3sdE+N/GPzg+J8ojC/4Tai+kgjAEluVvpJb3M
	 wU9PxAj4sDtT5DrhQ3mM1AkQEQiGhRjvF8eH9e36HGVLbeuEt6tFKsad+29t9CtuToej844rD+a2
	 DI4Jpxgl4pr6YRJtud9Q6T89zPkb+JBho6gVITphZZr3GbiC0MlMruL5+tsAYNktBvVY7iCtyNBa
	 Gu0eYyYerbMJZLrCLHJ6NyN7Ltaol7tCRCxMdXsnbvkXlZt4bGKcU/uTLUgK3x1SZglNWHppUaTy
	 xuquDFPow9yu+5JBhyo0APKJW01abfigsb7RN2y2P2qFybS4CAei3OlOklFQ==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: broonie@kernel.org,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH 0/3] Rust abstractions for the SPI driver subsystem
Date: Mon, 26 Oct 2026 14:29:02 +0800
X-OQ-MSGID: <20261026062905.6570-1-847807867@qq.com>
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

Note: this is a resend of the series initially sent to
spi-devel-general@vger.kernel.org, which does not exist; the SPI
subsystem list is linux-spi@vger.kernel.org, as per MAINTAINERS, and
the original send only reached the rust-for-linux list and the
Cc'd maintainers. Nothing has changed compared to the initial
send.

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
 rust/helpers/spi.c              |  21 ++
 rust/kernel/Kconfig.test        |  11 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/spi.rs              | 529 ++++++++++++++++++++++++++++++++
 samples/rust/Kconfig            |  11 +
 samples/rust/Makefile           |   1 +
 samples/rust/rust_driver_spi.rs |  66 ++++
 9 files changed, 642 insertions(+)
 create mode 100644 rust/helpers/spi.c
 create mode 100644 rust/kernel/spi.rs
 create mode 100644 samples/rust/rust_driver_spi.rs

-- 
2.43.0

