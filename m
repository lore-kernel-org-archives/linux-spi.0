Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524009;
	b=WBfJxSRYnRB4Z0cNpbeNPISlR69Py1tOWo6redUct7Qpu6gHgDrMVDaIkUGiOHaPUpV/
	 WYrGfhT7uwZhTJsSd5PBsIWyBRbWoz+NMuj1wiq59F/YMDgLeRFM9Xw05h5SKGmL+eWcf
	 esKJ3Xz8yCs+OeAjwtVH+uWcLa71ysDQi/db9Lp3IWs9i2to57Sxk0zn7iBXb2c7kd/sz
	 2RIa0t+SKgTMhySPR6vYezKdwKI1nbq7Xl4Sq7cZ7oAtNnJ4he/ZimuSX4XDUxGaIqRHp
	 vCMCCHANpteuLPFiwTymu9oMJXl2YtetzglgSdni909+DYly9IQrOct5UFRfyRUvRIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524009;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=+W0iME/rbf/DeVotBGyyQ7adH+5N0oW3OPUYPlmoYJo=;
	b=uHyBhpUUkQfvYXn32grBsV2eMXEdzDPNdiojynamnmIuLp7NuzoXQXTSb27z/r672kCC
	 1wDw/yffTUEK9ZPEgVZXbcrDO4HxFTnvU9Xzbh+eIEx970jJSr0Eb+yzMt9DQz0ic0Of9
	 qZcb8vYvVrdXtlU7zOFqzSelmeNL0jon5pIIT1xJMt/Cg8bigeCcXa/ZZDP9KyobzzKlC
	 e7/vndXXuP3TuLAd9DZppbaEF+Qd5V84kjQwVKFLkpjEvgpm9WzNvXvd5DKSwHa3ikw54
	 jTZDscvJPMKA7abfdGwAajnqmzTvTYXVLj6aSWwbbbNSjENfqxyVpJl8NmUGfrV5H5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SKMeg1pZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A361A606A31E
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SKMeg1pZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97C71F000C4;
	Tue, 24 Nov 2026 12:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795524008;
	bh=+W0iME/rbf/DeVotBGyyQ7adH+5N0oW3OPUYPlmoYJo=;
	h=Subject:From:Date:To;
	b=SKMeg1pZvzvJqYGhfwE2Inr8Ukp3P5Xobt4k6VZdbjcqWaMeu1yfZqx59nCbHiYnu
	 bOK3+TS39aBTs4SXsq2y2L0eB06z+LhSQx3qLaQX4r9kh8wMaInzvxMdlJ4w0yNq7n
	 l0T0u8pHT85qYjnul2pzDAo3zdcqhNNV4P2lIx2uAYAHa68AXtA9HRXqudqHM2tb2I
	 MHSgK7qwFHNH5M57QY2A38DY2kbDASYHFpEZavkvGwRJ+QknfUJYX0OsMLdpF04HVr
	 UHztm+0aXN3adrHlCr3KaNhUJZNhzRK2qgIYxahjQvkk2GbtIDPLi1rfYhgDRGKXQu
	 OSygzGCWYe0sQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B6B02393107F;
	Tue, 24 Nov 2026 12:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179552400721.3505021.4269714580435808064.git-patchwork-summary@kernel.org>
Date: Tue, 24 Nov 2026 12:40:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: spi-zynqmp-gqspi: Fix remove and IO-mode reads
  Submitter: Srikanth Boyapally <srikanth.boyapally@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1211917/
  Lore link: https://lore.kernel.org/r/20261115-qspi_14_11-v1-0-23425ed177bf@amd.com
    Patches: [1/5] spi: spi-zynqmp-gqspi: Factor out zynqmp_qspi_disable_hw()
             [2/5] spi: spi-zynqmp-gqspi: Mask the interrupt before gating clocks on remove
             [3/5] spi: spi-zynqmp-gqspi: Stop the controller fully on remove
             [4/5] spi: spi-zynqmp-gqspi: Drain RX FIFO on RXNEMPTY in IO mode
             [5/5] spi: spi-zynqmp-gqspi: Use IO mode if RX buffer is not cache-line aligned

Series: spi: sun6i: Add dual read support for the H616
  Submitter: Arun Iyengar <aiyengar1990@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1212291/
  Lore link: https://lore.kernel.org/r/20261116-spi-sun6i-h616-dual-read-v2-0-e0c66eb71e20@gmail.com
    Patches: [v2,1/2] spi: dt-bindings: sun6i: Allow Dual SPI and Quad SPI for the H616
             [v2,2/2] spi: sun6i: Add dual read support for the H616

Patch: spi: spi-qpic-snand: fix DMA unmapping on probe failure
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1211517/
  Lore link: https://lore.kernel.org/r/20261115-qpic-snand-v1-1-74df634096ee@gmail.com


Total patches: 8

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


