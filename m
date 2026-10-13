Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E242314A9E;
	Tue, 13 Oct 2026 14:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900870; cv=none; b=svt808AWQ56KOsmXH8ZkwRzpPKFZ2hz0gc4BzpN+hnXU+x8Ud6Y49z6sp4jJTxPNyp0Be4xahN3nVbml4tcCNEhttMBPwtQkwO9dCboJL5kMYSiZeZS9Jp5MvJXBNdl3xHIpekZsp/PtnIf66MHkAj0PuDcKtirwAhtwCmYMNGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900870; c=relaxed/simple;
	bh=rk39nM05IcvfwZSF/mNztAqyIfZs0lEJ0j23nxyeI3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qhrVKYbWqEwmXSLMIrP5w9nsZQq2r6PYjhJAkcQ16BkRRtEStR/dFF29JEtn517x+oFNKbnJ8KR24/35TQDwOuKTfBL7aUXJ9Vk5H1a7TrNbjOCEt+shHeFKDxOyMjlMKp8757I4sRjva2NOc8jnesvuYPcgfk0clSsEZgFdf/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zMARofIf; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zMARofIf"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DFFD44E41209;
	Tue, 13 Oct 2026 14:14:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B164E60362;
	Tue, 13 Oct 2026 14:14:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 57A9F11D71685;
	Tue, 13 Oct 2026 16:14:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791900861; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=M7v3OFxHD5HFJWdU0x370CW7QUMAdlkfUri/wCjcHM4=;
	b=zMARofIf6k6WEWO/oIkTaOA/apZzy1x5XguuWVQqZ0qBf1XjstgNfeCRed2uT9kqGMN7JU
	MN2vIRYBxV5wNZ/EqDNRbLovAeLFQi+om0v2PuT1xyAQyCeFBHqY9Cl1iwrWS/SffHQH1P
	L42dOP3EHhNxjEjOBpd0fpn3s01MDtcpyRcnJJyRSCfjE5v6iS3h1DS7ifYzFdttyutjBe
	zCYwV2naDwgqQuNYCIeNmBiRva0rTp1Qj5VFvcBwvIV3MRrpmbW+r9guIRQhX5vLCyviVE
	KOG1XZZRrKhKZMpDrNCidJE4lfn7hR2lGHRS630wuQ08h8nQ/12ZNv4bgp1zsw==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v2 0/7] spi: Add support for panic mem writes
Date: Tue, 13 Oct 2026 16:13:43 +0200
Message-ID: <20261013141350.189996-1-paul.cercueil@bootlin.com>
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

Here is the v2 of my patchset that updates the MTD spi-nor code as well
as the spi-mem code, to add support for panic mem writes to a memory
partition configured as pstore.

Changelog:

 - Old patch [4/5] ("spi: cadence-xspi: Don't use infinite timeout in
   register poll") was dropped. The V2's [6/7] updates that code so
   there was little point in keeping the patch, especially since it
   was fixing a never-taken code path.

 - [1/7]: 
        - Don't call spi_mem_access_start/end on panic. We don't need to
          flush the SPI queue at that point, and we don't need to lock the
          mutexes.
        - Check that the SPI controller's PM status is active, and bail out
          otherwise.

 - [2/7]: New patch.
          Updates the spi-nor code to use the iopoll macros, to make it
	  easier to convert it to atomic-context polling later.

 - [3/7]: (was v1's [2/5])
        - Update spi_nor_wait_till_ready_with_timeout() to use
          poll_timeout_us_atomic() on panic
        - Alloc temp buffer with GFP_ATOMIC in spi_nor_octal_dtr_write()
          on panic
        - Bail out if nor->rww.ongoing_pe is set in spi_nor_panic_write()

 - [4/7]: New patch.
          Address an issue found by Sashiko, where we poll for a bit in
          the IRQ status register but never clear the bit back to 0.

 - [5/7]: (was v1's [3/5])
        - Make sure we only enable interrupts if not using polling mode

 - [6/7]:
        - Don't enable interrupts if doing a panic write
        - Use a new cdns_readl_poll() macro that will resolve to calling
          readl_relaxed_poll_timeout_atomic() when doing a panic write, or
          readl_relaxed_poll_timeout() otherwise.
        - Drop cdns_xspi->panic_write. We don't actually need to check it
	  in cdns_xspi_is_dll_locked(), because this code is never called
	  in the kernel panic path.

 - [4/7]: New patch.
          Update the dt-bindings to make the IRQ line optional.

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
 drivers/mtd/spi-nor/core.c                    | 111 +++++++++++++----
 drivers/spi/spi-cadence-xspi.c                | 116 +++++++++++-------
 drivers/spi/spi-mem.c                         |  35 +++++-
 include/linux/spi/spi-mem.h                   |   5 +
 5 files changed, 194 insertions(+), 74 deletions(-)

-- 
2.47.3

