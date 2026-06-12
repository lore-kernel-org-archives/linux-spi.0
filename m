Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF001340401;
	Fri, 12 Jun 2026 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781286754; cv=none; b=r0DcYqtRU/OA6RMGoVQcOdHc75GS5rYxotB0epe+QRYsc9ZW4T2WX47FWzTgx4S0wkkAkwQuurzQpmn+kx9tyRhIt22FLG47+jh2gg/DJu4c+3KxmJrNmRsOBvDdawOHjIix2vQrvkfNutY001JbegFRizV5ytlMh6ACcXNq/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781286754; c=relaxed/simple;
	bh=/LrOQPeSe0R+S5HmUfRs0QkEFSttimwt5DvPYE/ncu8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=gul9GIwhAr9cF7fvdsgA57gmrKlkSXkQyFBbRSLE8cG4cTFQl1TtAA1V029ExnkNhMRn2FJvWGEsPguafgsa/pH2CjA4IGvWDZfRHofLa80fneJ5RYudvhzuy+HThbt5P2gIZHmwt3b11grfCOt/+r7PVsG4lsIcxCgsc6Q7AOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGJKSXzj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGJKSXzj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D141F000E9;
	Fri, 12 Jun 2026 17:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781286753;
	bh=UtkZD6W8CPcH1wcVoHbwOGSOi6AxGc7KI6MAYErX8kU=;
	h=From:To:Cc:Subject:Date;
	b=aGJKSXzjzOokOlUyTR4d+S/UPI7EF9iQZfxi9Gpd+3EgQqQVaJI1wJRxvKrc+F3YP
	 YRSKZ6Cgc1R4M+Vz0UOyrCuidfActVv1sZNapAt3ZX71Qfe2ditqQDvRQusac0SdHD
	 wIM6qe8OhdzhFaIQ0eN1R+/jy62t1z3xYvVXs51yz9QAbRXkVnfA4GG8ncbeBfkubj
	 lk71yX9WXWGyzMntEaBX29HouNCjydqBKXx0ERd/0P3dxaowbliXo5KPJHUCWHZKEE
	 DR2xc3hZM3RQMZF5fnkYdyNemMU617khLdeDoOINmUNfArmyAOTSfWQJt3nzjQJbLx
	 AJ6552qQaBdcA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 46F121AC5AC5; Fri, 12 Jun 2026 18:52:31 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.1-rc7
Date: Fri, 12 Jun 2026 18:52:25 +0100
Message-Id: <20260612175231.46F121AC5AC5@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 79378db6a86c7014cce40b65252e6c18f5b8bcc2:

  spi: spi-mem: avoid mutating op template in spi_mem_supports_op() (2026-05-28 13:49:00 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.1-rc7

for you to fetch changes up to 3c60184e39b57e5efe664fe8540cdbc1bc7ea899:

  spi: dw: fix race between IRQ handler and error handler on SMP (2026-06-10 00:07:39 +0100)

----------------------------------------------------------------
spi: Fixes for v7.1

A couple of driver specific fixes for v7.1, a small targetted fix for
hardware error handling on DesignWare controllers and another for
handling of custom chip select managmenet on Qualcomm GENI controllers.

----------------------------------------------------------------
Peng Yang (1):
      spi: dw: fix race between IRQ handler and error handler on SMP

Viken Dadhaniya (1):
      spi: qcom-geni: Fix cs_change handling on the last transfer

 drivers/spi/spi-dw-core.c   |  2 ++
 drivers/spi/spi-geni-qcom.c | 27 +++++++++++++++++++--------
 2 files changed, 21 insertions(+), 8 deletions(-)
