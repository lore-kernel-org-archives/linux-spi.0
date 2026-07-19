Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A628413DDAE;
	Sun, 19 Jul 2026 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784464784; cv=none; b=IEj0/+nxQVA0u3VOMHpADJBGMYMdUpE/65xagsivupXER9hT0UqZ77KH/edR/w+G61/T6tm+3fOBDQr656eoERDzm1NFUMfOSQKZNh11686Xc5D0SEFR8Rdp7PzmdNPnDL3YtqT9EiGGFdYDi75KhMnTOvG0JaZthu4MpttvTLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784464784; c=relaxed/simple;
	bh=dhgTkua3muK0POm5dY/s1rnuNKTQdiFPhqylYaFeyXw=;
	h=Message-ID:From:To:Cc:Subject:Date; b=hreTKy76bmBNoeATPDillah/XCrVJR/2vIhN7jrBQZhpwnF4HjVSH6IT1Yodt+j3slaMYDhpAQ5PZA7E/Y9JvSXAoH8vc1igSBSYw4HD9IwDwk0nTZk04UN69Hd8PrK02EgSZ+1jdss+ZYawAqm+kvqhx+2FVakNcOw8ExxjqLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGrcUokC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGrcUokC"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B369A1F000E9;
	Sun, 19 Jul 2026 12:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784464783;
	bh=ybTV+9ryQ6ZNMUQ4OILDKzS8rfLC8/qKuUtaLQW8bXI=;
	h=From:To:Cc:Subject:Date;
	b=XGrcUokC6nC/C+6b9ytqEtLsJ6cMpZPiltOHvT/8TbTSy81QSbgeavQv5IvLArXKl
	 SG2OIqdUibeKnWsTIQQ/d88nwt5wQTiUxvC+rAhz2Z7bIeL1PKFqw4svo/C4ueKllj
	 HJEzhtv34lFO4FlyAwclkkwm87p+JENzRiqVXeUUMDet2fxzgKe+uW5ZPFIljhmRi8
	 sy0ZLNOrNMseB+z0bJu7bDOq/MJ59IhXqFPOk4numzIKroqndjzxQlVi0o7oXOH3xa
	 CofXqxA+9R9iaUF+gZ9FFygTvnSj4jzQ/UwITxJPbROSxFgAIspY84wqMsO/tnET+G
	 dlIa8rADQ6jQw==
Message-ID: <3aee33eeb68bc75cc295997d3b1c182f@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.2-rc3
Date: Sun, 19 Jul 2026 13:39:35 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit a13c140cc289c0b7b3770bce5b3ad42ab35074aa:

  Linux 7.2-rc3 (2026-07-12 14:16:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.2-rc3

for you to fetch changes up to e919ca35a6e84b5adf085da9ffa1544c01d4ce1e:

  spi: cadence-quadspi: Fix indirect write timeout when DMA read mode is enabled (2026-07-14 12:54:50 +0100)

----------------------------------------------------------------
spi: Fixes for v7.2

A couple of fairly routine driver fixes, nothing too remarkable.

----------------------------------------------------------------
Srikanth Boyapally (1):
      spi: cadence-quadspi: Fix indirect write timeout when DMA read mode is enabled

Wang YuWei (1):
      spi: dw-dma: Wait for controller idle before completing Tx

 drivers/spi/spi-cadence-quadspi.c | 12 ++++++++----
 drivers/spi/spi-dw-dma.c          |  3 ++-
 2 files changed, 10 insertions(+), 5 deletions(-)
