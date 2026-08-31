Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90B83EDAB5;
	Mon, 31 Aug 2026 12:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788177955; cv=none; b=DZbXoN0iSG62BQwcWLmbEXAO19QixfEqBwZi8dzGKRGNINRBzSSOkDCV1FfLaSUPyBRSinB77zD3d8vqEoijUo3LP/2e5zLS4/UAsLylOG0Fr3FD8ck2TIn6HaYP05zzdqUTnFm9Qi/OdnuWhFh/lowadNQuhX/FWj0UrcJz/EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788177955; c=relaxed/simple;
	bh=XxFUu38Xpgfw5uH5rLWH9TFddXTQwTMb/VoPXqh4zDg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QEH2HUTkXsoffEk8F80i2eJPLjZTOzgAb92G5EpB4Y01yfQlm5qYlrd/Hq/vk3gMyTT07UoqIXo6tmuL5OAjCKImzbnzQY+eaX3piKd4DpXg5WhykmJZhqPVMJtuYOFUt/7LV9pfDjQ0Gl4srttyCo0nOKrg9N1UbOQ/GlwbEmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+ryOt03; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+ryOt03"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78E85C2BCFA;
	Mon, 31 Aug 2026 12:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788177955;
	bh=XxFUu38Xpgfw5uH5rLWH9TFddXTQwTMb/VoPXqh4zDg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=X+ryOt03BB1jPRalL1D3wyFTALCNSTR5yS0hol8CLvk33vXg4u1uRqLoT8TwjrL5U
	 sxco6/sk9UAvG5TT0Xg+CMKi5xj00SSFx44U6ylYOitRV0Bl9lP9FgwVqBp95HxoFj
	 wkK9fJKAEJ9jzulPNZYPISxBLfy7+YC+ZUCm1diDtfg1eULCA4ubHyoi1qt/9xjXyv
	 1tcPD+4iBeisR0vBup5kbVWydTvWexc+/dQqqPlD7XUrxMRigAO5DxL0LSyeQO3rlc
	 Ps716HahqbpaqyJpK/5M/QOTERxM7GTAaDpEEGhKJQLfdCqC1pDDTrCF2eCGTMKI68
	 qUVEhmSiJh2fQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FBBC624A4;
	Mon, 31 Aug 2026 12:05:55 +0000 (UTC)
From: Tobias Jakobsen via B4 Relay <devnull+tjakobsen84.protonmail.com@kernel.org>
Subject: [PATCH v2 0/2] Report platform enforced SPI flash write protection
Date: Mon, 31 Aug 2026 14:05:50 +0200
Message-Id: <20260831-spi-nor-platform-lock-v2-0-6cc75b909241@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7RgYCYIr72FYNG2RidBppoRoC
 He3cgGX7yX//Q2SV/YJbsUG6ldOLCEDnQqwowlPj+wyA5XUlC11mCJjEMU4mWUQnXES+0JnTNf
 WzlB7JcjbqH7g99F99JlHTovo57hZq5/9V1wrLNG6S0Ou7qra0z2qLBJmw9PZygz9vu9faEJow
 78AAAA=
X-Change-ID: 20260829-spi-nor-platform-lock-daa984da2872
To: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, Tobias Jakobsen <tjakobsen84@protonmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788177954; l=2977;
 i=tjakobsen84@protonmail.com; s=20260829; h=from:subject:message-id;
 bh=XxFUu38Xpgfw5uH5rLWH9TFddXTQwTMb/VoPXqh4zDg=;
 b=/WgtaKN2ADvM0QeWuHKb3ySKNZE5CmbRyLgubMeA7/eyVSw4ZV/2Ju6IJBu28eNc+wlFzOJ4a
 4vSqtOyrh7sBVXfGyhA7NfddNMQpC1KTfQ/V2CVJObg2N1gJ4hk49RE
X-Developer-Key: i=tjakobsen84@protonmail.com; a=ed25519;
 pk=UREd6cisfwsFIDP455nUH6Ysx+ZDGnAVE9nGmKzm1Ks=
X-Endpoint-Received: by B4 Relay for tjakobsen84@protonmail.com/20260829
 with auth_id=986
X-Original-From: Tobias Jakobsen <tjakobsen84@protonmail.com>
Reply-To: tjakobsen84@protonmail.com

MEMISLOCKED currently answers only from the flash chip's own block
protection bits. On platforms where write protection is enforced
elsewhere -- an Intel PCH SPI controller with protected range registers
being the common case -- those bits say nothing about what is actually
enforced, and are typically left clear.

The result is that MEMISLOCKED either fails with -EOPNOTSUPP, or, once
the chip gains SPI_NOR_HAS_LOCK, confidently reports a range as unlocked
while the controller is refusing writes to it. As more chips gain lock
flags over time, the second case replaces the first, so the wrong answer
spreads rather than the missing one.

Patch 1 lets a platform supply an is_locked() callback through struct
flash_platform_data, which spi-nor prefers over the chip's own bits. It
is inert on its own: nothing sets the callback, so every existing
platform keeps the behaviour it has today, and the series stays
bisectable.

Patch 2 adds the only user, spi-intel, which already computes protected
range state at probe but has had no way to expose it since the SPI MEM
conversion removed its visibility of the MTD device.

Full before/after numbers from a Coffee Lake NUC are in patch 2. Only
the Intel PCH path is functionally tested; the flash.h change is an
append-only addition and all existing users of that struct use
designated initialisers, so they are unaffected.

This came out of a discussion about fwupd reporting the BIOS region as
unlocked on Intel PCH systems:
https://bugzilla.kernel.org/show_bug.cgi?id=221927

Tooling disclosure, per Documentation/process/generated-content.rst:
this series was produced with the help of an LLM assistant in an
interactive session. All code was tested, results reviewed and can be
defended.

Question for the maintainers: this straddles MTD and SPI, so I do not
know which tree it should go through. Happy to resend in whatever shape
suits.

Signed-off-by: Tobias Jakobsen <tjakobsen84@protonmail.com>
---
Changes in v2:
- Reuse the protected range register decoding via a new helper instead
  of duplicating it (Mika Westerberg)
- Drop an unhelpful comment in intel_spi_is_locked() (Mika Westerberg)
- Add an Assisted-by tag and a tooling disclosure in the cover letter
- Link to v1: https://lore.kernel.org/r/20260829-spi-nor-platform-lock-v1-0-cd362d4914e2@protonmail.com

---
Tobias Jakobsen (2):
      mtd: spi-nor: allow the platform to supply write protection state
      spi: spi-intel: report controller enforced write protection

 drivers/mtd/spi-nor/core.c | 52 +++++++++++++++++++++++++++++++++--
 drivers/spi/spi-intel.c    | 68 ++++++++++++++++++++++++++++++++++++++++++----
 include/linux/spi/flash.h  | 12 ++++++++
 3 files changed, 124 insertions(+), 8 deletions(-)
---
base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
change-id: 20260829-spi-nor-platform-lock-daa984da2872

Best regards,
-- 
Tobias Jakobsen <tjakobsen84@protonmail.com>


