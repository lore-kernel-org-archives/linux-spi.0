Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC74330C359;
	Mon, 10 Aug 2026 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374670; cv=none; b=kvnFGD2MEMcMZh8+p4TQKMz31Jvuaqc4fsEqqBT+iuxjH+CcilfgKHulNjrRkAkoxOHFpJeTlWBL7HQk4YSm8fCXL5mIUwn4nQGJlDE5wqLXIi0b5dArASDI8cX+Moa68msDLsaCZpvufLfoLssJKW5j5kyAk+0Py/Qzf1XO57g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374670; c=relaxed/simple;
	bh=++L+czqrya1OFA9jkWeDSF+qnsnSB+yuhXvXhD4vicg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fYXYXcXDkHNAFAa9rjQBebHyNg/sQOoftOT8dlGMQmiLUPWHYoDbkmgeEvvKsd1jnlW0vWvipLgbHiGvfZrlkowTEV84Lxi3wkroyEBpouc1S2W1KAJHPLOVeJ9TfXzOgDsLvax7hQNNX6Ob4mFJtYzigxtMb0q7R7pVRHopQrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eBNMLc/d; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eBNMLc/d"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id F283B4E411AA;
	Mon, 10 Aug 2026 15:11:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BEFA06033B;
	Mon, 10 Aug 2026 15:11:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B8FA211C4A9ED;
	Mon, 10 Aug 2026 17:10:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786374654; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=AYZpRo8QZhMYf4x7YOSDEZsDXhhJ8EVY0i30yMilJOk=;
	b=eBNMLc/duJnc6TnzbZ8bQ1kUtqiO/LiUXcrt31JmFMYAl2TXdxeKm12nIe4RdKiFJXOYUC
	pg0sxfPWv7xzXU5z657/tUxT0aPoqCpnwU+II9gmEa9IswhZs6pOqoMI5qfhrJm9bziLcf
	Z2KWDi2aEYuWQLx3ZASsusJSVj3zxYXrbdvIJikYu3rg1RhXpZLao1WUiuXVWsJ3IuXrgZ
	OkSKt6TBAgbTtDOjetLTDEliKTWcl3CRYFG1yKZ0OQUkLvFBCc0Q/0aQJmCuKpHKZJEVty
	uKp++9Tkq2Mp09NH4sB3Bc0EDBu3UHVS4+fPAK5UaRZpLMbodplgSynfhm0Rnw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 0/3] mtd/spi-mem: Enable DQS support
Date: Mon, 10 Aug 2026 17:10:41 +0200
Message-Id: <20260810-winbond-nand-next-phy-tuning-v3-0-a97c3a61e675@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NsQ6CMBDG8Vcxna052pSCk+9hHApc4RK9EkCEE
 N7dwmKcdLnkf8PvW0SPHWEvzodFdDhST4Fj6ONBlI3jGiVVsYUClYICI1/EReBKstsOToNsm1k
 OTyaupXMF+hKSDLQSkWg79DTt/PUWu6F+CN28r43J9v0THhMJ0qCtdG5TDz65FCEMd+JTGR5io
 0f14TKwPzgVOatNbjDLqxT1N7eu6xujhfhuGQEAAA==
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
Changes in v3:
- Rebased on top of linux-spi/for-7.3 and dopped all existing
  dependencies on the MTD bits.
- Link to v2: https://lore.kernel.org/r/20260807-winbond-nand-next-phy-tuning-v2-0-73595e89d6e3@bootlin.com

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
base-commit: 1ec281b42ee249cfe9bad52a54149de29ed6aa78
change-id: 20260205-winbond-nand-next-phy-tuning-aabefc018032

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

