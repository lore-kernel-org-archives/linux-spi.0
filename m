Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009878;
	b=xXLkeBsis1GQF59ZdIYr4av/IVcn+ypuwnUVb30uah0UyVOg/Apr0J45FRNzfZXGewXn
	 Et7u4u9PVHwSa95TwDWRaVX1v4ZaeInT+0cc1Td0hXtonLTacsew7ecetqXsXsZUP3PRh
	 aLQNuN1QQbCHFZmcaiI2ShURIbK4CrU0UPuV5Idd1v59T2+oWw1bKZ9r01R0OqF7l8e++
	 MoRe+IgFQOFTuO3LkaZP8f41g8FFWx+3EBJtDZS9LuxtUz/memjKNrEvId43FGcLkMM1z
	 kdaynMTnXClE5o9UvITVnGsMbpOI/+5qEMxGkq7fui2NyrO8E4F7+uehfjJq+KKKvBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009878;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=dofLdoq/FX5LcFWXmVZ2KGGrdPoi7WVPv5HdMsM5SSo=;
	b=pQvl/E6wy03WC1uRZhXs0gnyzIP3VwuzgU8gg74DqB9Mzf4vO0wz4tiUr8o7QUDx7M9P
	 5ezKMW77gtwjfvQSf8OdDmYDQz5dSCix7ibbxziZfe1HGa59XNZga9UZGNxkBAV3LDbA+
	 iQApg6+g/zRNZFx39pcMtenWS+XFF3+sXJ1F/t6QXYt94dc7gtxqvJUAbcehdR+Wxc3n1
	 9z1D0O2LU7eSpRC5x8/I8JnjY2I+KZd49DU4YAtfG1glHiMFatp8yRxTAgYWkgJMKaG32
	 g3w/YlV2tKTzUm7gvIQA6eqeauyMGu7K2zAxiObY7cwxDV14pFnYeAAX4zyd/q7SEgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=xKkGfpWO;
	arc=none smtp.remote-ip=162.62.58.211
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B18606A31B;
	Mon, 26 Oct 2026 10:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63B18606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=xKkGfpWO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793009870; bh=dofLdoq/FX5LcFWXmVZ2KGGrdPoi7WVPv5HdMsM5SSo=;
	h=From:To:Cc:Subject:Date;
	b=xKkGfpWO5RaVsXu055YoBGM4ka7y8u/CQWvuzdK07+a1b+W4zddFslpYz3odG92GE
	 Q2HKN8rqT2Djjb5M0Nrkneb1ONd3Fn7IzQ6R3V2MuAiWofAitjGVJsgDMgRrgY+Xgf
	 3OZC6hIp00teMdPkhgky+zDv1y/9VrX0M/b2soI4=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 46F8F47C; Mon, 26 Oct 2026 18:17:47 +0800
X-QQ-mid: xmsmtpt1793009867tvq41u3ay
Message-ID: <tencent_CBD24B2CACF2244DF8B871628B1347EEFD08@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+DnzPIKPAW7nQATMjFhg3EFaFFq0bfjoqfne8fwjfyJEZP3/bEV
	 Hi+7tUlMwKfazFf7B8Qh9ZX0Ug0DnzRaI84NNd44LyW6Jv6+SA7wmas3AQ5jLboqQtWyjjakVvQ5
	 jmTl1Tlpl4ENKPBeiobUeEmAAnHrToyF1IyD2/HPrtCjP3NTglz6x7QQRT8crw/HPW1yAQUCXMCq
	 SJclOo3SUa/NksSYeAVhdCzLAGccWJauPO54PUqia698fHZBUZPgccQVDxhP9Et1EG4pvCIiID1y
	 dBZSpIkBnFk2nZSQ32WmmIHCpaq9SF3S7xKoXEAGuuxVtINAmZNu9OVs3usdpuv4chML6BxnEYEC
	 XmNmeWvi2bvGE0gDhyuYVul8R/OUBsOkajU5UK5g1i/MIqg6DjiIuEbUHJVHL5apFcKi6iXW9eEQ
	 U+5ui27+ccK12lSlhLez5F8FRH85/z36VU/ORyfMERJOOwgZU1SjbI50cdonxhOUq9ry/TSQktcW
	 COeAfYBX9PgGnTTvkYqLrL/wkC2a6/Yc/W97y0I0z5/CHMB6+kcNF6wRUNgWFJ3ZVpvx0blVCjV8
	 ix1nUIjzTbwgb+WIs4ppzgRiYPwF7z7VyvRfHtd1OumgzeK79boY2z+cFwAfVKokyD/GJEvWwW1I
	 KMVYmdRXpI1CthxgpdtXgX6e6trm9GJ2JRVtrMBOP5HQmlSJuEzFy3cPZ0a+vu5VFtt1iiL6EaTB
	 5FRxsf+QXM5phJCPbRKYsRYTl1m1jVv/hJMkllMiCQ9Q7qgzkpH2X3/O5IyLIcLtIMq7QvFp9eF0
	 fWudaji3kgyOcQaph8075QVoZLh1S9aYOnow/s51DoBV9lAlB7ZGP/0fPsQGyLsi1ljlEKw0Bd+W
	 JvKYnEzWpmZj+YZm2ak0RZFxr0LOzZNqkRmpSX6gM4RgxJOaM4jqpOvCUxEJls1I5D6Y3SmxPbTr
	 Sx0CXi/LK6K1WXx8IUNte2s074esNv42mqWJUIgaVrvCkZ+t3Vac35S828suqI8pATJ+j6YKVXjt
	 HHQ+fnT6CYogwyVyZhl/JF5UqDAicX8RQCdYNZLA1jzt8t/YnX8NxbkPV4bZKyDLgUXCSiEh8mUv
	 1J6ayTkUluD1CBACI3abJiIK4O5A==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: broonie@kernel.org,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH v2 0/3] Rust abstractions for the SPI driver subsystem
Date: Mon, 26 Oct 2026 18:17:44 +0800
X-OQ-MSGID: <20261026101747.126903-1-847807867@qq.com>
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

Changes since v1:
  - guard rust/helpers/spi.c with CONFIG_SPI and only build the module
    in lib.rs when CONFIG_SPI is enabled, fixing a link error with
    CONFIG_RUST=y and CONFIG_SPI=n
  - fix the match data lookup order in probe_callback(): OF/ACPI match
    data first, then the SPI id table, matching the C core's
    spi_get_device_match_data()
  - copy data into DMA-safe bounce buffers in write(), read() and
    write_then_read(); the SPI core requires transfer buffers to be
    DMA-safe, while caller-provided slices may be located anywhere
    (e.g. on the stack)

The first three changes were found by the Sashiko automated review; the
remaining findings (null handling in spi_id_info() and length overflow
in write_then_read()) turned out to be false positives, as both cases
are already handled.

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
 rust/kernel/spi.rs              | 558 ++++++++++++++++++++++++++++++++
 samples/rust/Kconfig            |  11 +
 samples/rust/Makefile           |   1 +
 samples/rust/rust_driver_spi.rs |  66 ++++
 9 files changed, 676 insertions(+)
 create mode 100644 rust/helpers/spi.c
 create mode 100644 rust/kernel/spi.rs
 create mode 100644 samples/rust/rust_driver_spi.rs

-- 
2.43.0

