Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FFE31E83B;
	Sat, 29 Aug 2026 01:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787965478; cv=none; b=dLXPvk2mhv8vM9LFoHtK6W58sQamTTUMh0rhTmwb3tatdlCvOJgUY4tlMdCW2iqiHg0jKc8vTIvfi9QNU766ylwLMzLwnxQwOElojy7fcyOPUVCN2qlnrSAmaaJj2VKBtKc0eQaFJJuRSOeaEGLbTLLU64d8RYj0lvD5uilokSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787965478; c=relaxed/simple;
	bh=VPYJCxBeblxwAcDG8IcpAjTqQ9gl1z3gbn2Vowk/qYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lTueYOcO3XbtuPT6GllDhrg9MDeVxMFhN9aymalk/L8c/cG2HgSFzHiLIqWTAcgH7Dwf6OcwkC3LH6NqTGXlAIuS/LP764bhdUz6vQhnAM5P630KTRcHvg6+t0Cs6Qnrf+ym+mW9SMDOx2nGAGc8aClFAs0ru2xIVmnGUhOJelc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdqngOCq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdqngOCq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B207CC4AF0B;
	Sat, 29 Aug 2026 01:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787965477;
	bh=VPYJCxBeblxwAcDG8IcpAjTqQ9gl1z3gbn2Vowk/qYA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cdqngOCqNcn2SOi1ZDpPRWhAEB6clKAcxLf34Fvs7+dDegdgQwrcEQtNf4oScRFBq
	 xLRoMrSoLaufjlApx9PlpCDOFUDEPdhTGMD41c68wB6ZKRESdDi22rM5QUU629Lhro
	 m2eeXhhL1pykDoh9TJGwCZ/ZK3QIftqyyoCn83/xK8aebcKf+aqfNUCsqYaSvLKcYm
	 mz2XdeTKESVl2uGHzyeFVHPyBcGNO+43A2insNndee8cv1O8+ClnzxW7auC9EL9YI/
	 WtDkFmWniwgd4qdCwD9J4eQJkbeU3kA0nbLHaOB+9m7j6WGlm7B00jcMBO39uyu8DH
	 5oAG+I8MNSVaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92067C61DCB;
	Sat, 29 Aug 2026 01:04:37 +0000 (UTC)
From: Tobias Jakobsen via B4 Relay <devnull+tjakobsen84.protonmail.com@kernel.org>
Date: Sat, 29 Aug 2026 03:04:33 +0200
Subject: [PATCH 2/2] spi: spi-intel: report controller enforced write
 protection
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-spi-nor-platform-lock-v1-2-cd362d4914e2@protonmail.com>
References: <20260829-spi-nor-platform-lock-v1-0-cd362d4914e2@protonmail.com>
In-Reply-To: <20260829-spi-nor-platform-lock-v1-0-cd362d4914e2@protonmail.com>
To: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, Tobias Jakobsen <tjakobsen84@protonmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787965476; l=3457;
 i=tjakobsen84@protonmail.com; s=20260829; h=from:subject:message-id;
 bh=gtEEAKizpcnWW1tUrFGFb4Gr6XQwi2idSgfJOzM3heg=;
 b=NKpDKeAa95+S/284Or3ncZbzcN15LrGx+vzGVdClOGc8pkjWpxqzTfoSd/t2Xh3BYsdjWFifP
 ZKP2wx74Y9TDUGvCbybWdMm80iFd8N0wmmI0YnQGudh7Ex0EkMAjC9u
X-Developer-Key: i=tjakobsen84@protonmail.com; a=ed25519;
 pk=UREd6cisfwsFIDP455nUH6Ysx+ZDGnAVE9nGmKzm1Ks=
X-Endpoint-Received: by B4 Relay for tjakobsen84@protonmail.com/20260829
 with auth_id=986
X-Original-From: Tobias Jakobsen <tjakobsen84@protonmail.com>
Reply-To: tjakobsen84@protonmail.com

From: Tobias Jakobsen <tjakobsen84@protonmail.com>

On Intel PCH platforms write protection is enforced by the controller's
protected range registers, not by the flash chip's block protection
bits, which are typically left clear. The SPI MEM conversion left
spi-intel without visibility of the MTD device, so it cannot supply MTD
locking operations directly.

Pass a write protection query through struct flash_platform_data, which
spi-intel already uses to hand the partition layout to spi-nor.

Note this asks the opposite question to intel_spi_is_protected(): rather
than whether a flash region contains a protected range, it asks whether
the queried range is itself entirely covered by one, which is what the
MTD layer means by locked.

Tested on a Coffee Lake i5 with PR0 covering 0x860000-0xffffff and
FLOCKDN set, querying MEMISLOCKED over four ranges:

                               PR0 range  whole chip  in PR0  below PR0
  unpatched                       -95        -95       -95      -95
  chip lock flags only              0          0         0        0
  patched, no chip lock flags       1          0         1        0
  patched + chip lock flags         1          0         1        0

The whole chip and below-PR0 columns stay unlocked because only
0x860000-0xffffff is covered by a protected range.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221927
Signed-off-by: Tobias Jakobsen <tjakobsen84@protonmail.com>
---
 drivers/spi/spi-intel.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 7494b921a..667291979 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -1223,6 +1223,46 @@ static bool intel_spi_is_protected(const struct intel_spi *ispi,
 	return false;
 }
 
+/*
+ * Unlike intel_spi_is_protected(), which asks whether a flash region contains
+ * any protected range, this asks the opposite: whether the given range is
+ * itself entirely covered by a write protected range. That is what the MTD
+ * layer means by "locked".
+ */
+static bool intel_spi_is_range_protected(const struct intel_spi *ispi,
+					 unsigned int base, unsigned int limit)
+{
+	int i;
+
+	for (i = 0; i < ispi->pr_num; i++) {
+		u32 pr_base, pr_limit, pr_value;
+
+		pr_value = readl(ispi->pregs + PR(i));
+		if (!(pr_value & PR_WPE))
+			continue;
+
+		pr_limit = (pr_value & PR_LIMIT_MASK) >> PR_LIMIT_SHIFT;
+		pr_base = pr_value & PR_BASE_MASK;
+
+		if (base >= pr_base && limit <= pr_limit)
+			return true;
+	}
+
+	return false;
+}
+
+static int intel_spi_is_locked(struct spi_device *spi, loff_t ofs, u64 len)
+{
+	struct intel_spi *ispi = spi_controller_get_devdata(spi->controller);
+
+	if (!len)
+		return 0;
+
+	/* Protected range registers work in 4k units */
+	return intel_spi_is_range_protected(ispi, ofs >> 12,
+					    (ofs + len - 1) >> 12);
+}
+
 /*
  * There will be a single partition holding all enabled flash regions. We
  * call this "BIOS".
@@ -1395,6 +1435,12 @@ static int intel_spi_populate_chip(struct intel_spi *ispi)
 
 	intel_spi_fill_partition(ispi, pdata->parts);
 
+	/*
+	 * The protected range registers address the first chip, so only it can
+	 * be queried this way.
+	 */
+	pdata->is_locked = intel_spi_is_locked;
+
 	memset(&chip, 0, sizeof(chip));
 	snprintf(chip.modalias, 8, "spi-nor");
 	chip.platform_data = pdata;

-- 
2.53.0


