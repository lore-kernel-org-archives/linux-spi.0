Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564244014AD
	for <linux-spi@vger.kernel.org>; Thu, 26 Mar 2026 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542371; cv=none; b=kac4s1hsN8Af6ULd9Rh8iKGiJu6cKxiMqKhN7uGseKRsBAmbixwpidLmuisfwqRguQYXZItzvlO00xSQLv5ouDT44QCto5NT04JRKtC7BMWmOQCwrU6fhNTA6b45DVySJwC3Fcwl1pV7AecdYgHKucu3U/gceEsCZVUgPccs454=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542371; c=relaxed/simple;
	bh=hmF46yDqeZnZKE0ZgpFaeKOhze6gXqRkDP0CjmpdmBk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iBZdKgEcgwFH0E8lsXu+zwhae0LTwervmoYND5nlmjN1evh/MczzG3fEmewJ4M3sWu/hxy+6+5biq7rRcEaWx74cmV4H8UydQ/akhkH72HQtuvxNCVJAuU+3AkI0s2U3xu3pGu3k7dcSYEX5IoVBHOJlXfFqYosg8jBteoY1a7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VPdoqyIZ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VPdoqyIZ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8EC5D1A3003;
	Thu, 26 Mar 2026 16:26:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 52D0B601FA;
	Thu, 26 Mar 2026 16:26:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5055210450C91;
	Thu, 26 Mar 2026 17:26:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774542366; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Gv6+pU3gWouDpRuPiASiArS42OSpTvuqTUpZgZA6vk0=;
	b=VPdoqyIZ5nvjGSuFsWRZIIh4niMRjcvS8/2w5GiZsYj+SXr2Kvurpc84GGz2mUjT/490G4
	LQGmuE4m+wFhsJ8gSF4ZlZKjMWWJtAUXZ1AC2RU7tADgoWsNJ0pDI4EqTgybIOH6nz2Jr8
	APUdCIoomEBtmIHPPQUwKRhdE+FjZb8ihHvUlqTW0YkpL7a80Q+7ZWLlr0PvCQR9QpbCQv
	AVCvqw7fqJotsREfl3m5l5Pny/tBhxdgVsyUwUUTV1yUcEpNGUK65Um7rR04/+DkH5NPzg
	99GXMr+L+ybFWkF8y/waUwFzxzGKAsWD4SkQHyEL8JOXhxpc5Wt+di+EYnIQCA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 00/11] mtd: spinand: Winbond continuous read support
Date: Thu, 26 Mar 2026 17:25:47 +0100
Message-Id: <20260326-winbond-v6-18-rc1-cont-read-v2-0-643de97a68a3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33Nyw6CMBCF4VchXTumU6CgK9/DsKAXZRLtmJZUD
 eHdrSRuXf5n8Z1FJB/JJ3GsFhF9pkQcSqhdJew0hqsHcqWFkqpFJRt4UjAcHGQN2EO0CJbDDNG
 PDrRuugM6Z5SuRREe0V/otennofREaeb43s4yftef2/51M4IEicY2va7RdvXJMM83CnvLdzGs6
 /oBuP4Gq8gAAAA=
X-Change-ID: 20251204-winbond-v6-18-rc1-cont-read-664791ddb263
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Hello,

SPI NAND continuous read support has already been added a few releases
ago, but only Macronix chips were benefiting from this support. Winbond
chips also have a continuous read feature, which is slightly more
complex to use in the scope of the Linux kernel, because they these
chips expect a different read from cache operation once in continuous
mode.

In order to be more flexible, this series changes the logic behind
dirmaps. Direct mappings used to be very static, not flexible. I am
proposing to change this and turn them in to slightly more dynamic
interfaces, where for instance we can:
- Enable/disable the correction (was previously handled by creating yet
  another pair of direct mappings per target).
- Select one or another variant for the cache operations.

I propose to name the variants available in a direct mapping "primary"
and "secondary", and let the upper layer (SPI NOR or SPI NAND) point to
the one that needs to be used for the operation. Controller drivers
should not really care about this change, expect the fact that they
should not keep a static representation of the template on their
side. Because of that, I am creating a capability boolean to flag
drivers that support this capability (the flag is ignored in the
nodirmap case).

This series is now sent as v2 following a former RFC (link below).

Here is a benchmark with the faster Winbond chip I have, W35N02JW on a
TI AM62a7 LP SK featuring the Cadence QSPI controller, clocked at
25MHz. Speed gain for a 10-page read is about +32% in octal SDR mode,
+47% for a 10-page read in octal DTR mode and up to +83% for a entire
block read!

    1S-8S-8S, no continuous read:

       64 page read speed is 15058 KiB/s

    1S-8S-8S, with continuous reads:

       1 page read speed is 15058 KiB/s
       2 page read speed is 15058 KiB/s
       3 page read speed is 16800 KiB/s
       4 page read speed is 17066 KiB/s
       5 page read speed is 18461 KiB/s
       6 page read speed is 18461 KiB/s
       7 page read speed is 19384 KiB/s
       8 page read speed is 19692 KiB/s
       9 page read speed is 19384 KiB/s
       10 page read speed is 20000 KiB/s
       11 page read speed is 20000 KiB/s
       12 page read speed is 20000 KiB/s
       13 page read speed is 20800 KiB/s
       14 page read speed is 20363 KiB/s
       15 page read speed is 20000 KiB/s
       16 page read speed is 19692 KiB/s
       32 page read speed is 19692 KiB/s
       64 page read speed is 19692 KiB/s

    8D-8D-8D, no continuous read:

       64 page read speed is 23272 KiB/s

    8D-8D-8D, with continuous read:

       1 page read speed is 23272 KiB/s
       2 page read speed is 23272 KiB/s
       3 page read speed is 28000 KiB/s
       4 page read speed is 32000 KiB/s
       5 page read speed is 34285 KiB/s
       6 page read speed is 34285 KiB/s
       7 page read speed is 36000 KiB/s
       8 page read speed is 36571 KiB/s
       9 page read speed is 36000 KiB/s
       10 page read speed is 34285 KiB/s
       11 page read speed is 36666 KiB/s
       12 page read speed is 40000 KiB/s
       13 page read speed is 41600 KiB/s
       14 page read speed is 37333 KiB/s
       15 page read speed is 40000 KiB/s
       16 page read speed is 36571 KiB/s
       32 page read speed is 42666 KiB/s
       64 page read speed is 42666 KiB/s

On the Nuvoton platform, the speed gain is real, even though it is less
impressive:

       1 page read speed is 1802 KiB/s
       2 page read speed is 1882 KiB/s
       3 page read speed is 1938 KiB/s
       4 page read speed is 1939 KiB/s
       5 page read speed is 1935 KiB/s
       6 page read speed is 1967 KiB/s
       7 page read speed is 1968 KiB/s
       8 page read speed is 1969 KiB/s
       9 page read speed is 1968 KiB/s
       10 page read speed is 2000 KiB/s
       11 page read speed is 2000 KiB/s
       12 page read speed is 2000 KiB/s
       13 page read speed is 2000 KiB/s
       14 page read speed is 2000 KiB/s
       15 page read speed is 2000 KiB/s
       16 page read speed is 2000 KiB/s
       32 page read speed is 2000 KiB/s
       64 page read speed is 2000 KiB/s

Thanks!
Miquèl

---
Changes in v2:
- Rebased on v7.0-rc1.
- Collected tags.
- I manually tested the integrity of the data by manually disabling all
  possible variants one after the other using a 2 page read scenario. All
  worked except the fastest 8D-8D-8D variant (the first one in the list)
  which triggered the CS deassert issue on the Cadence controller. This
  issue is orthogonal to this patchset, a follow-up series will be sent
  to disable continuous reads on this controller.
- All continuous read variants for the W25NxxJW chips have been tested
  on the MA35D1 platform (which lead to several fixes) and the
  W35NxxJW chips have been tested on TI AM62a7 LP SK.
- Several changes have been operated in the core to stabilize the
  feature when a secondary op is used.
- A couple of helpers have been created to cleanup the winbond.c driver.
- Link to v1: https://lore.kernel.org/r/20251205-winbond-v6-18-rc1-cont-read-v1-0-01bc48631c73@bootlin.com

---
Miquel Raynal (11):
      mtd: spinand: Drop a too strong limitation
      mtd: spinand: Expose spinand_op_is_odtr()
      mtd: spinand: Drop ECC dirmaps
      spi: spi-mem: Transform the read operation template
      spi: spi-mem: Create a secondary read operation
      mtd: spinand: Use secondary ops for continuous reads
      mtd: spinand: winbond: Ensure chips are ordered by density
      mtd: spinand: winbond: Add support for continuous reads on W35NxxJW
      mtd: spinand: winbond: Create a helper to write the HS bit
      mtd: spinand: winbond: Create a helper to detect the need for the HS bit
      mtd: spinand: winbond: Add support for continuous reads on W25NxxJW

 drivers/mtd/nand/spi/core.c    | 135 ++++++++++++------
 drivers/mtd/nand/spi/winbond.c | 317 ++++++++++++++++++++++++++++++++---------
 drivers/mtd/spi-nor/core.c     |  22 +--
 drivers/spi/spi-mem.c          |  32 ++++-
 include/linux/mtd/spinand.h    |  16 ++-
 include/linux/spi/spi-mem.h    |   8 +-
 6 files changed, 399 insertions(+), 131 deletions(-)
---
base-commit: 5d7371a86963bad9f0bfdff7d6d56bbdeae75468
change-id: 20251204-winbond-v6-18-rc1-cont-read-664791ddb263

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

