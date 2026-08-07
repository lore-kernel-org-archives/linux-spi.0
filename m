Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE03A39CD16;
	Fri,  7 Aug 2026 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114022; cv=none; b=P32CrFBHsN5dfaCCWjulXAWJfQsUiJFbBRjkNh592qsw7OaEj3BU0m/ITtrF7T+0C5ov2fvrqZ1jDP+lwyr6Ljpapew2dp9sjMhSbqC+Nlfgh66g7NTodpQ/Un3KA3vOpFFISlhB1uCF2t+1T9fWFvyX9fcfrVrKO44lOXQWP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114022; c=relaxed/simple;
	bh=X/T3PsDg8tdK+nw23JOmOBzymNkQC6jUJHhCLZMbRQ0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NMbXkbGE2l4sh2rcBPLx8UgYzxHbPQUq2LYsUwFG+RuGSg6kSPD7jiiTnTivtO9oTENIKb1e95KpodHu+grktlTy4gxnyQHL2mCpujp8kbWlOyfIFIVa+blrtZcK8eSaXoJWTxLLa3pAayhe002qRKhZqupiEiR3mkUc/LF69mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kZw213R+; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kZw213R+"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1E3151A14B1;
	Fri,  7 Aug 2026 14:46:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E0876603F0;
	Fri,  7 Aug 2026 14:46:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D3C2311C37A53;
	Fri,  7 Aug 2026 16:46:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786114013; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=3U7zmB0jNuLDEjK8WDzNya+qqpQQtuz/BAdCFoUahL0=;
	b=kZw213R+pTzitdHxqYdmusyT/SFJdxWZGvTmo5T0FkB4h0rJV/xIfT2hnPXaPyJoy73c/w
	D+hhlaZEYHZc1LktNKpEGCcLUyVuCH83SLa/xmuef4A/Fnf0jitiHMxx9Z367A8UjDVk9G
	SP8HykE7mV0aNEnmYwilLFAZYqdk7+494ZGc8EM+i0O6vC/O3D6K5CEuY7PVupKZdddjbA
	zvKXpv3dXrxjEs63ZAwBZK1yaK+GiQwmw/YzCi0nlTrYcNr+E0DwOcpEA4IHfi28M8HXWW
	C1fqJZnkWNcP7X2T0vPDCMtoSWebdD3hGs04nmZLvBZlnG5tfPMxS7SRbotksg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 0/3] mtd/spi-mem: Enable DQS support
Date: Fri, 07 Aug 2026 16:46:46 +0200
Message-Id: <20260807-winbond-nand-next-phy-tuning-v2-0-73595e89d6e3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0K6dkxbAqgr7mFYFJjCJDolbUUI4
 e4WTuDmJ+8v3ttEQE8YxCPbhMeZAjlOoC+Z6EbDAwL1iYWWupRaFvAlbh33wOYYXCJM4wrxw8Q
 DGNOi7aS6yVyLpJg8WlpO/bNJPFKIzq9nbVbH+6d4ViChwKrP71VppVV161x8EV879xbNvu8/H
 GkA4coAAAA=
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
SoCs, Santhosh initially needed to access the availability of the DQS
(data strobe) signal. This is a chip dependent capability, which may
sometimes be enabled.

Create a SPI memory flag for it, let the SPI NAND core set this flag
when it knows about the capability, and expect manufacturer drivers to
enable it for octal needs when the chips are compatible.

This is an alternative at needing a DT property. Please note that there
are a few blind spots:
- the line may not be wired (this would be surprising, but can be
  flagged this time by a DT property)
- manufacturer drivers must enable the feature if it is
  available (especially for high speed DTR modes)
- this implementation is proposed for SPI NANDs only, if this proposal
  is accepted the same approach may be taken in SPI NOR.

Here is the original thread which lead to this series:
https://lore.kernel.org/linux-spi/87v7gbdwdh.fsf@bootlin.com/T/#ma79fc364d7b882a48dbdf47203dde75df4bb0ec4

This series was compile tested only at this stage. As DDR tuning does
not yet work on my board, I cannot make sure this change has a real
impact.

Mark, as agreed, you can take the spi-mem patch through spi for this
cycle, and I will pick up the remaining spi-nand patches after the merge
window.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Changes in v2:
- Dropped the RFC prefix.
- Rebased on top of v7.2-rc1.
- Dropped the spi patch for now, just allowing to use DQS on a few
  Winbond SPI NANDs (can be improved later).
- Link to v1: https://lore.kernel.org/r/20260205-winbond-nand-next-phy-tuning-v1-0-5e7d3976f0f1@bootlin.com

---
Miquel Raynal (3):
      spi: spi-mem: Flag DQS capability
      mtd: spi-nand: Set the DQS spi-mem capability if available
      mtd: spi-nand: winbond: Enable the DQS pin on W35N**JW series

 drivers/mtd/nand/spi/core.c    |  4 ++++
 drivers/mtd/nand/spi/winbond.c |  8 ++++----
 drivers/spi/spi-mem.c          | 32 ++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h    |  1 +
 include/linux/spi/spi-mem.h    |  4 ++++
 5 files changed, 45 insertions(+), 4 deletions(-)
---
base-commit: 6f787fd9f19e4e1bc80d3eee1a394eb65defdff7
change-id: 20260205-winbond-nand-next-phy-tuning-aabefc018032

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

