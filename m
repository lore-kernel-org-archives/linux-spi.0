Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AD430C174;
	Mon,  3 Aug 2026 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767222; cv=none; b=DuilDEQbweQ0iYgjpZZADMRUm7PaeiHyo2xZhiPH2JrHPu0hrYtM4+w3f8Cn2RQo0WPOT0c2U27tLMecRLnOGDm7S4WHB0Lry6iWYicbqM3Vp9dZCSDRUNxExxeLiUJCgwPVxwkx0vK/9Z3u4bYz++gzQfBbsWKFokmnD67BREA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767222; c=relaxed/simple;
	bh=98AtLbOBNIesQnhTFQpfQthQeTTJ93GTv1q2aa42wNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dkxivYeA4wVCkpiXP6ObmhKmDU+8v3XwcvU0XxFRDAE8hl0fNJdvCBNeyrbUpIXoQVwxYMxaYnzCsPieNpZC5xuCfN8gGmtQEGUyfxh/6IB3HS8rVaRPduBj1+rDA8iHjr2t+9thpaeoydOyihzPFRYB90tjPQ4Pyx7cPBdXRo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zpi75SpI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zpi75SpI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADD11F000E9;
	Mon,  3 Aug 2026 14:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785767221;
	bh=wsKM3LxVnoqRO6Sne/m33oYQsGLMAl707FLmbgt6ROE=;
	h=From:To:Cc:Subject:Date;
	b=Zpi75SpINPdYKLozcJO73KxnhYghgsRENoStlDB8VIL5LaaOmDF4cZwlXBC2fsYdE
	 4k0aH5ju3xeI/6N50DZPQ7eEyLYrqrQ2VnLhuATvZrqYWm87p7GgAClls0cNfqO0pR
	 e6nitnEXJXrGf8hxMKJ7lqidOciqUF+PEsTOjg/30zuSVgPnkuZKJTu3aS960u2AEi
	 ZyrmyCQsWH1ZKBzWQbAUh4zYGey9MCSy1+I2ywTrky2fxmyFEqtx/hi1qWTenxT/E5
	 Yd0662G8+44Ql59c2bXSH0v7nZ4+RGhAkgtscBuE+d4AKYK1CzOb4s9sS4R/XKA39R
	 vHbMXlpwlXfXA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] spi: cadence-xspi: remove 64BIT dependency
Date: Mon,  3 Aug 2026 22:07:24 +0800
Message-ID: <20260803140728.12747-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, cadence-xspi depends on 64BIT. This dependency isn't from
cadence xspi controller itself, but from marvell support code and 64bit
slave dma interface performance optimization.

This series tries to remove the 64BIT dependency.
patch1 is the preparation patch to move some code so we can group
marvell support code together. No functionality change.
patch2 and patch3 remove the two causes of 64BIT dependency.
patch4 finally removes the 64BIT Kconfig dependency.

Jisheng Zhang (4):
  spi: cadence-xspi: group marvell support code together
  spi: cadence-xspi: put marvell support code under CONFIG_64BIT
  spi: cadence-xspi: only use readsq/writesq under 64BIT
  spi: cadence-xspi: remove 64BIT Kconfig dependency

 drivers/spi/Kconfig            |   2 +-
 drivers/spi/spi-cadence-xspi.c | 475 +++++++++++++++++----------------
 2 files changed, 246 insertions(+), 231 deletions(-)

-- 
2.53.0

