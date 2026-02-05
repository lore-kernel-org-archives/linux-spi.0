Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB514279DB3;
	Thu,  5 Feb 2026 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318433; cv=none; b=tn5isdi5RKz/RyPtJ+cKzW6wxqjOwWvOuZC/LpMXKV+lILN+NEVXdoyrdOl/P4gd5ExK6PV8qhuX+3Yw6REc961jEXtfi0BvYTrMjeocrAKs6k4Kk+GgDuPOZilQ1tgOx37kIopF0kfFASia4Kxn2cR3DAyQmZEWrw5wSBm3apc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318433; c=relaxed/simple;
	bh=ZF1/eWraTdRh/HPayH4ksIjBSYW3e23pssdwWw7UdTs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jRstfY/CREGVi3M3GARw1H7yrZZ93PWICcb/jaXhLq2CVxBbs3/APLUeIB1Pp+7hOquxyLXZ+ERxr6XJeC9hMYbAMdbSEcz6moLx2l0cM1Wb2s5jIORV1LiUFwz/RP50T2pFC/ASY3egtsK7bAvwGqXKOp3B/hqfcRe/mthSa1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rxs1sDHc; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rxs1sDHc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 020221A2C34;
	Thu,  5 Feb 2026 19:07:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BF0DE6074D;
	Thu,  5 Feb 2026 19:07:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 62FCB119D175D;
	Thu,  5 Feb 2026 20:07:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770318429; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=KTeTMB3O5osR3rrRni/7ouiJ09Dn2ufAokhrH7lIdiI=;
	b=Rxs1sDHcH47lcvuGsxttX2cuhHmXF87fgtHXC9t7Yr9JgMzK9GesHuyxJpzHVA0zbOOjAg
	hDup6LmZjvsCYrjr0IhBJG+5D76zbrYU52Tj5hgXZzbysHiXmZjgKWy9OC3GrfE1r9Z/rK
	KuDrcEPfMh/Ieqxb4k7ALu/SY+ZF7Or/Q77G5IS5FMAuNOZMCxlfVDO2VoxC5NSjDUHsOc
	iKlnUlgPEQxyPKfRxoBEfMG1Uz5M24hhofcsOjd/fB/JlokG0J7Of0wGc17qVrSFlgztpS
	NdVmDMI6s7zLlt3iLmcLCKFoGXVM+7bnj+P1t/4C05VQFwk+tBzx3jmoWqeVyw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH RFC 0/4] mtd/spi-mem: Enable DQS support
Date: Thu, 05 Feb 2026 20:06:57 +0100
Message-Id: <20260205-winbond-nand-next-phy-tuning-v1-0-5e7d3976f0f1@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MPQqEQAxA4atIagNxFkVsBQ9gu2wxatQ0UWZcf
 xDv7mjz4GveCZ6dsIciOsHxKl4mDUjiCNrR6sAoXTAYMhkZSnETbSbtUO0T3hecxwOXv4oOaG3
 DfUtJTh8DYTE77mV/91+oqxJ+13UDRwozE3MAAAA=
X-Change-ID: 20260205-winbond-nand-next-phy-tuning-aabefc018032
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, praneeth@ti.com, 
 u-kumar1@ti.com, p-mantena@ti.com, a-dutta@ti.com, s-k6@ti.com, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

For his PHY tuning series on the Cadence QSPI controller embedded in TI
SoCs, Santhosh needs to access the availability of the DQS (data strobe)
signal. This is a chip dependent capability, which may sometimes be
enabled.

Create a SPI memory flag for it, let the SPI NAND core set this flag
when it knows about the capability, and show how to use it from a SPI
controller driver.

This is an alternative at needing a DT property. Please note that there
are a few blind spots:
- the line may not be wired (this would be surprising, but can be
  flagged this time by a DT property)
- manufacturer drivers must enable the feature if it is
  available (especially for high speed DTR modes)
- this implementation is proposed for SPI NANDs only, if this proposal
  is accepted the same approach must be taken in SPI NOR.

Here is the original thread which lead to this series:
https://lore.kernel.org/linux-spi/87v7gbdwdh.fsf@bootlin.com/T/#ma79fc364d7b882a48dbdf47203dde75df4bb0ec4

This series was compile tested only at this stage. As DDR tuning does
not yet work on my board, I cannot make sure this change has a real
impact.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Miquel Raynal (4):
      spi: spi-mem: Flag DQS capability
      mtd: spi-nand: Set the DQS spi-mem capability if available
      mtd: spi-nand: winbond: Enable the DQS pin on W35N**JW series
      [DO NOT MERGE] spi: cadence-qspi: Retrieve DQS capability using the core helper

 drivers/mtd/nand/spi/core.c       |  4 ++++
 drivers/mtd/nand/spi/winbond.c    |  8 ++++----
 drivers/spi/spi-cadence-quadspi.c |  8 ++++++--
 drivers/spi/spi-mem.c             | 32 ++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h       |  1 +
 include/linux/spi/spi-mem.h       |  4 ++++
 6 files changed, 51 insertions(+), 6 deletions(-)
---
base-commit: c5884449d02575c7984000eb30d2a2971c7dfcc7
change-id: 20260205-winbond-nand-next-phy-tuning-aabefc018032

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

