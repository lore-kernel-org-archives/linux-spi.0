Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A893D3E3D97
	for <linux-spi@vger.kernel.org>; Fri, 10 Apr 2026 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775842885; cv=none; b=gzyt5FVAhpP6ugReq0hwr3jDfte2XDXl6X4K38yya2qh+x4048QSJtG/r4/PKhfVxtEyYmKzp+nAhfxuQ8NcgNPZOxmVGytT2EDbmRPipQffIZC14lS4ggWbgv1FAYSu+cp9br5wWBNhBZAHF2lRwyoJM3WPZo2V5/VKgaVt+lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775842885; c=relaxed/simple;
	bh=DjB8MJz9hM1ym4gsm+HV6NLyMrS3qHCQChig7rUFz10=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uCM28J50T3C7/6V/P5MwyLD4SlWNLsa28qCMTuZTMg3Xy70eUagZi3OBscz45lWH0XOG067ErTEsyamY4ofTsNMsYM0jGH7xKnj114teAMgzairD/7QRV/uV7JppT4d9d39lCFAgRcLUoG6hQMRROZl31i3+U9DgwYU9DWjBn7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vT69zDeA; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vT69zDeA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E58221A3267;
	Fri, 10 Apr 2026 17:41:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AB56C603F0;
	Fri, 10 Apr 2026 17:41:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD7E410450081;
	Fri, 10 Apr 2026 19:41:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775842874; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Qa3dANP/wUXrWJWcHM3dhr+Gc2Tpco6bvezFZtBbQdE=;
	b=vT69zDeAndg5h0raB0P5pQzNrt6L8GftILEkWWHwb0H0lFBAAlBPYxRjgbavg9DxplhyPq
	4cZm2hsApHPgcSW9CHNBXPe+gGaTLqWOKM+fKY2iXd4puHOmrb/DkK6ydHXYMy+/zMlkyZ
	TqXrmSnexaI+SrzDWXJo9/P/71bb3g3xq3wsR8ifvFnzxEtLwUpu6X7mQXcRwKcgWDF8yG
	BaUxAWC3d/hDISCtQ1ZrvGaKvAGEl0M2Ui2mDZkZf+S5tORyHtFQ2PQ3ytPkdHKLGhBQH0
	rQFLlHeQ1QZh5P33xV9uBiG2SpgkN5VjQ8ZUQgHaUaq30SQy5GW4P2KznryiOA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/5] mtd/spi: Fix Winbond W35N02JW / W35N04JW support
Date: Fri, 10 Apr 2026 19:41:00 +0200
Message-Id: <20260410-winbond-6-19-rc1-oddr-v1-0-2ac4827a3868@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBtQqayuEi1Kp5qNxggVSHdPW
 r7F/xkSCVOCscogdHHiGAp0XYE7lrATsi8Go0ynGq3w5rDG4LFDPaA4jdF7Qbv0dh1617TGQWl
 PoY2f/zvN7/sBJVEAqWcAAAA=
X-Change-ID: 20260410-winbond-6-19-rc1-oddr-7a87b98c452c
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Pratyush Yadav <pratyush@kernel.org>
Cc: Steam Lin <STLin2@winbond.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Winbond chips W35N02JW and W35N04JW differ slightly from W35N01JW. As
they have more blocks, they require a couple more bits to fully address
the whole device. These address bits have been stuffed at the end of the
command cycles, which is non standard, and this is something I didn't
catch in the first place.

Stuffing these address bits there implies the creation of a new spi-mem
command template.

While testing, I realized one of my former patches in the Cadence
controller was totally wrong, so it needs to be reverted.

Mark, if it is not too late, you may want to pull in the first 2
patches, and I will apply the SPI NAND patches in a fixes PR after -rc1
is out.

Sorry for the mess :-)

Thanks,
Miquèl

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Miquel Raynal (5):
      spi: cadence-qspi: Revert the filtering of certain opcodes in ODTR
      spi: spi-mem: Add a packed command operation
      mtd: spinand: Add support for packed read data ODTR commands
      mtd: spinand: winbond: Set the packed page read flag to W35N02/04JW
      mtd: spinand: winbond: Fix ODTR write VCR on W35NxxJW

 drivers/mtd/nand/spi/core.c       | 24 +++++++++++++++++++++---
 drivers/mtd/nand/spi/winbond.c    |  6 +++---
 drivers/spi/spi-cadence-quadspi.c |  4 ----
 include/linux/mtd/spinand.h       |  7 +++++++
 include/linux/spi/spi-mem.h       |  8 ++++++++
 5 files changed, 39 insertions(+), 10 deletions(-)
---
base-commit: a2e786cb711f88509c39b82d8e5a7e52b169b1a6
change-id: 20260410-winbond-6-19-rc1-oddr-7a87b98c452c

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

