Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5527D4A35
	for <linux-spi@vger.kernel.org>; Tue,  2 Jun 2026 11:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401220; cv=none; b=nuyTt9c9TDfHAQH1+2ZNOEQmQPpwIxUEhWLTW/HUPmrYWTYqAqt5Wvi4MvmL0KbjO4OD73iNXlWJOJ/g8shSeJ4lF79y/bwZOUIx80r61n4BfTZvJ5oZMGkogEtBJdh/JRk2Cg//ysON6BUM9/lYoM7A7uGoD4n1FuaVI3Q51MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401220; c=relaxed/simple;
	bh=bdlUrqEtf/SEp1PbOH+uw8cs8BbtUoPwNshhX4aPeqQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=A1QXUj0iVRrRmngaUT2o4JD4IfbqEwa0ZBTRXGstlJVfSIY4NwwuEyDOFLC1LGejNed36NO9BkaZLmCeTudKik6FzWDz/nV8O9jAdy0bAcMGSduMcJBCyVJmaWwZAxiiL0PNgLxbc4ktjGjgpsrxaOcsyt93zA2h2i4xaHvUWBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFIxH8+U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFIxH8+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C9B1F00893;
	Tue,  2 Jun 2026 11:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780401218;
	bh=KXkJl2Ope2U3Vmpd1lIzSvaJjwFG2z18bsDrAPoX+XI=;
	h=Subject:From:Date:To;
	b=aFIxH8+Ux/0S0IidywSuqGGud5WgKVtGmzRTCZg/bY6U2iszBzBCvKy21DYZoe6SO
	 HryPP0Gsj4xtCzev9gEG2vrxK3LJUNgCKEBI/qUeYuuGCDvdSWec/ceCIv61NJzdyu
	 +TGXkg6ylLF+88CnKtBh6RLSEUULa3OQsajrdrIvm5rT6iXsLD0hMznHgQHMyjmDlU
	 17ENWG2sb8/4uLFRk1zw6kk3SvUC8Vpmj70cK62JYpZASkdHgwItNPP6VvlsFolk4d
	 2IPyWVESaGZS5nkV3OX7/S204kys9BTlRDChORPUXuTNWFp9rZikUHWW/uvoCxBRUN
	 sV7LWx3cL6i1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C3893811A54;
	Tue,  2 Jun 2026 11:53:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <178040122072.405909.5261830381338974644.git-patchwork-summary@kernel.org>
Date: Tue, 02 Jun 2026 11:53:40 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: imx: replace dmaengine_terminate_all with dmaengine_terminate_sync
  Submitter: Carlos Song (OSS) <carlos.song@oss.nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1097296
  Lore link: https://lore.kernel.org/r/20260519104659.2794476-1-carlos.song@oss.nxp.com

Patch: [v2] spi: imx: replace dmaengine_terminate_all() with dmaengine_terminate_sync()
  Submitter: Carlos Song (OSS) <carlos.song@oss.nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1100243
  Lore link: https://lore.kernel.org/r/20260525062928.3191821-1-carlos.song@oss.nxp.com

Patch: [v3] spi: atmel: fix DMA channel and bounce buffer leaks
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1099361
  Lore link: https://lore.kernel.org/r/20260522-atmel-v3-1-23f8c6e6aa43@gmail.com

Series: spi: fsl-lpspi: fix DMA termination issues
  Submitter: Carlos Song (OSS) <carlos.song@oss.nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1100233
  Lore link: https://lore.kernel.org/r/20260525062357.3191349-1-carlos.song@oss.nxp.com
    Patches: [v3,1/2] spi: fsl-lpspi: replace dmaengine_terminate_all() with dmaengine_terminate_sync()
             [v3,2/2] spi: fsl-lpspi: terminate the RX channel on TX prepare failure path

Patch: [GIT,PULL] SPI fixes for v7.1-rc5
  Submitter: Mark Brown <broonie@kernel.org>
  Committer: Linus Torvalds <torvalds@linux-foundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1103147
  Lore link: https://lore.kernel.org/r/882ea35db619e3f9c74cca4619e9eede@kernel.org

Series: arm64: tegra: Enable DMA Support on Tegra194 QSPI
  Submitter: Aaron Kling <webgeek1234@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1100259
  Lore link: https://lore.kernel.org/r/20260525-tegra194-qspi-iommu-v2-0-a11c53f804b2@gmail.com
    Patches: [v2,1/2] spi: tegra210-quad: Allocate DMA memory for DMA engine

Patch: spi: fsl-lpspi: replace dmaengine_terminate_all with dmaengine_terminate_sync
  Submitter: Carlos Song (OSS) <carlos.song@oss.nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1097288
  Lore link: https://lore.kernel.org/r/20260519104517.2794390-1-carlos.song@oss.nxp.com


Total patches: 8

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


