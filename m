Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4121466B08;
	Fri, 16 Oct 2026 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146600; cv=none; b=PjtRoByzre1lzpopoTfeQj6LsQ5lFIYOLiREiru8goOIeOuHB1LySI19CIi9F7xDw4PenTdiktUmFzSQ2VMRGq/eyxaHku/Fnz83HYr5VSaY+xw+aJd1BH3OlflZx5w+HxzWlxqXTO+96fxQyyaqEpKpig4gacX50niBPtDixno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146600; c=relaxed/simple;
	bh=LmNVKal/87PaP4vDAoIL61Tc3xXRyyeCao0wfOThjxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gx4SfTxN36sdRqths2qq+zAM/7sfCmL2z8LBHTekCYnIT+2x/CTRfU+eR2mjOB7RJe6PVcl9V9nElYih29vgStTrp/p87RmkIcvbMDboE8VMOvSErr0RN6PRRcAZrn/m4IRIAw/ohfJNpqFosz2kGU/fWDwKKOhZ0g7wup53Z/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OcMHITjU; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OcMHITjU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D03384E41248;
	Fri, 16 Oct 2026 10:29:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9AD276075D;
	Fri, 16 Oct 2026 10:29:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1BAE510328BE6;
	Fri, 16 Oct 2026 12:29:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792146592; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=AnONk402nSGH39bSlb7WuXw5UGd8Kv5D12l+z58J9pE=;
	b=OcMHITjUB8VCMoR1QyeRahsOpar2RSGvrYL3SG51c3aDKhjF+9tWxtMw0g+Cx1p2ygnyoY
	fBY4M9gOc5OrsC54TtUe0wZxs2ipTKJShDNs6jUdLEv0tWFpkacWRTTvOvAcahhcaxAUtY
	KjyI6Oebe9aY1AvZpYblnquVP2b8jRpndMDvjMc75N/Ena3S2dwljkHMDUj02pXdRd3jbb
	Zj3LVytxitBdFIX3YK7ldDgR77vGiihjhHvU25nkhWmtpDL4Wj5K1hgrUHb8zP771A+hnm
	6y036Rx5Imw4cg4kfFTpRg/l2Ykg6bVdPgM/AZjbHsoTygD20c7U7HvLN+A1NA==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Mark Brown <broonie@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v4 0/7] spi: Add support for panic mem writes
Date: Fri, 16 Oct 2026 12:29:10 +0200
Message-ID: <20261016102917.171095-1-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Here is the v4 of my patchset that updates the MTD spi-nor code as well
as the spi-mem code, to add support for panic mem writes to a memory
partition configured as pstore.

This revision adds a workaround in mtd/spi-nor to avoid a call to
kmalloc(), and fixes a kernel doc mismatch.

Changelog:

 - [2/7]:
        - Also update kernel doc for new 'timeout_ms' parameter

 - [3/7]:
        - kmalloc() is not safe in panic context; reuse boucebuf instead

 - Patch [1/7] and 4->7 unchanged since v3.

Cheers,
-Paul

Tanmay Jagdale (7):
  spi: spi-mem: Add support for panic mem writes
  mtd: spi-nor: Wait for NOR ready with poll_timeout_us()
  mtd: spi-nor: Add support for panic writes
  spi: cadence-xspi: Clear "SDMA ready" IRQ flag after polling
  spi: cadence-xspi: Add irq-less support
  spi: cadence-xspi: Add support for panic writes
  spi: dt-bindings: cadence: Make XSPI's IRQ line optional

 .../devicetree/bindings/spi/cdns,xspi.yaml    |   1 -
 drivers/mtd/spi-nor/core.c                    | 128 ++++++++++++++----
 drivers/spi/spi-cadence-xspi.c                | 114 +++++++++-------
 drivers/spi/spi-mem.c                         |  42 +++++-
 include/linux/spi/spi-mem.h                   |   5 +
 5 files changed, 209 insertions(+), 81 deletions(-)

-- 
2.47.3

