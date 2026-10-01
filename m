Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748673EEAE5
	for <linux-spi@vger.kernel.org>; Thu,  1 Oct 2026 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873170; cv=none; b=GVo5tWl6bNQ25f8F/ZG71OTwjrmImONdhyE3GsWgAI+95i6SDqawpiFtSaf3gzVWCz+7ZfU5zkPskIDnFJ4MrEwVCOqCQKOAk1cANg25XVe6PziMzYOk8k143EUVie2vadTdX5PWnfF4kLqyX5RqNsff30pLXNm6KqfEzG/8XTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873170; c=relaxed/simple;
	bh=UtM9rL4f9uuVv6cnGzLcfPBFoiU8UUCjOzGe6OIHUDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DcBV+a55owJe9GJiSNJzj4zE0oe2jCMnBKJQYX9rfgAz3k4NizRjlPrjdeM3opZzKKgrqcwjw5RA16ug2yfnLlbD7CH/7UwZ1PHK/x3sbuvPZTeY1W7uAGY68jXXHcdjP2U9RpLNPE1Cb2nxIGrrRBM2lAP4jgvyGgAtzDISKHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h13bTYPO; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h13bTYPO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E0DE54E41121;
	Thu,  1 Oct 2026 16:46:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AB7466035C;
	Thu,  1 Oct 2026 16:46:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 70CDA10328310;
	Thu,  1 Oct 2026 18:46:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790873164; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=J7VcLCjkbB4GWjPQlRT2rs76W4soWPFSlS5ezEneZuM=;
	b=h13bTYPOlfHQSJabahSgiuduOM9pkVDavbHx4FySMH1Qi8eO4JHu6ELopsWC2w0fQU6WSJ
	pyGI36KGNMkywQCagCNeN/19OmXxhS1KOxTYRmcA2PRR5N5d1ANpDfjsQWtjaJ74IM4IXO
	7zIOVYXZpuPAUywGiOkcokQ1qm4bLP+xHdnObH72HRF77aFJRVuHoNtt5ul+a/FQRvs+I+
	dRz17U+zpoV39NtpZoV/xzIrWDFGdEG4IBgFSgb0cAvFkjDE2505tACP602V9TCFxjfHzF
	pINUA57JWo8iGd6jLxY2LIgF1SVRjQiZTlSpKcJeIOxmVM1ZQqsgLyfMlRyLfQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 01 Oct 2026 18:45:57 +0200
Subject: [PATCH v2] spi: cadence-qspi: Prevent SPI NAND continuous reads
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-winbond-v7-0-rc1-cadence-cont-read-v2-1-703e040b2d07@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42Oyw7CIBREf6Vh7TWASqsr/8N0wePW3kRBKaKm6
 b+L1cStyzOTzJmRDRgJB7arRhYx00DBF5CLitle+yMCucJMcqn4SjRwJ2+Cd5Br4BCtAKsdeot
 gg08QUTswneaulptmvVWsDF0idvSYJYf2wxGvt+JKv7CnIYX4nI9k8U6/Tqn+cWZRKu6UVChcZ
 6TZmxDSifzShjNrp2l6AezWrU7rAAAA
X-Change-ID: 20260318-winbond-v7-0-rc1-cadence-cont-read-bfa0d7258496
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

TI AM62Ax errata i2351, entitled "OSPI: Direct Access Controller (DAC)
does not support Continuous Read mode with NAND Flash", explains that
the CS can be deasserted almost at any time during a transfer (basically
there is an interconnect arbitration every 1023 byte). This is an
expected internal behaviour of the controller, but this leads to
spurious CS deasserts. These are totally forbidden during SPI NAND
continuous read transfers, because they indicate an end of transfer and
the continuous read is then stopped on the flash side.

I initially tried to query the flash type and geometry to decide whether
to apply a spi message size limit (there is a spi helper for that) but
we cannot reliably get up to the MTD structure to discriminate if it is
a NOR or a NAND we are playing with (it is not relevant to limit SPI NOR
transfers, they are not affected). If we actually take this path, what
limitation shall we enforce? The errata mentions 1023B, this is super
low, less than a typical page size (about 2k or 4k, for most of them),
so this is not usable. On my side, I only observed this problem on a
2-page read in octal DTR mode with more than 12 dummy cycles. The
writesize summed with the oobsize could be a relevant boundary, but it
is still quite arbitrary. Hence, I opted for implementing a controller
capability flag, which then is used to decide whether the SPI NAND
continuous read feature can be enabled.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
TI errata i2351 explains there is a problem with CS handling, SPI NOR
are immune to the problem, but the CS being deasserted spuriously when
there is DMA arbitration on long accesses (every 1023 bytes), SPI NAND
continuous reads cannot be leveraged.

Link: https://www.ti.com/lit/er/sprz544c/sprz544c.pdf

I created a 2-page read setup for testing all variants available on a
W35N chip wired to this controller. I reliably observed all variants to
always (in my tests) report correct data, except the 8D-8D-8D
variant *when setting an extended number of dummy cycles* (>= 12, so 24
dummy bytes). In this case, I got the first 6144 bytes correct (over
8192), the rest being full of ones (0xFF), indicating the CS has likely
been deasserted there. This is not exactly 6 x 1023 bytes (?), but
close.
---
Changes in v2:
- Rebased on top of spi/for-next.
- Link to v1: https://lore.kernel.org/r/20260326-winbond-v7-0-rc1-cadence-cont-read-v1-0-0d626e1dfb2b@bootlin.com
---
I do not know if all flavours of this controller have the same
limitation, or whether it is integration specific. As I only found
mention of this errata for the AM62 processor, I opted for limiting the
flag to a single compatible.
---
 drivers/spi/spi-cadence-quadspi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index fe5b094f0b6b..fc0f2d52455e 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1742,6 +1742,12 @@ static const struct spi_controller_mem_caps cqspi_mem_caps = {
 	.per_op_freq = true,
 };
 
+static const struct spi_controller_mem_caps cqspi_am654_mem_caps = {
+	.dtr = true,
+	.per_op_freq = true,
+	.no_cs_assertion = true,
+};
+
 static int cqspi_setup_flash(struct cqspi_st *cqspi)
 {
 	struct platform_device *pdev = cqspi->pdev;
@@ -1799,6 +1805,8 @@ static int cqspi_probe(struct platform_device *pdev)
 	host->mode_bits = SPI_RX_QUAD | SPI_RX_DUAL;
 	host->mem_ops = &cqspi_mem_ops;
 	host->mem_caps = &cqspi_mem_caps;
+	if (of_device_is_compatible(pdev->dev.of_node, "ti,am654-ospi"))
+		host->mem_caps = &cqspi_am654_mem_caps;
 
 	cqspi = spi_controller_get_devdata(host);
 	if (of_device_is_compatible(pdev->dev.of_node, "starfive,jh7110-qspi"))

---
base-commit: 1518c0d3f67e728674194fb43911d6bd0ad3773a
change-id: 20260318-winbond-v7-0-rc1-cadence-cont-read-bfa0d7258496

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

