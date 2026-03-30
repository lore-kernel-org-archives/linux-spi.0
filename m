Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C793E8C44
	for <linux-spi@vger.kernel.org>; Mon, 30 Mar 2026 22:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911191; cv=none; b=A2iBGM89/8BKGWTak4dHaLnZ7JI1XL6ARdyrb4WAvbEY9M7RvTVqb6FE12ABtOoxeT+0KTT0shFHwEhyPUPfym4J5u2NiltWJ8gqvRDX1+7unpQu7dHLTUCuEOTBSeeJ8ABS+u42KefRgecIk8eFzmUoh0/VvuMfG0h0N8tiw2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911191; c=relaxed/simple;
	bh=KYdVhdP7IBRdTEeHohsqqxDgVl8TlocHJ16qUGy6zrs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=RPsaFsbD/A4C+/6Bvlpv2VuBKiDNCc0/kmiKDnYRzs0dawd11BtFcWsVEycXq1SNcwODlWRCT6KS9s+A9bK4MBbc3N1U1YxTVVH+rT8NXZ4ZXbjg88kwXhQfBxKWOA/MGUyiv667MwbiP7LWHc51JV8xTqKyxcsITZrUO9Uze3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOCbzO17; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOCbzO17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362FCC4CEF7;
	Mon, 30 Mar 2026 22:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774911190;
	bh=KYdVhdP7IBRdTEeHohsqqxDgVl8TlocHJ16qUGy6zrs=;
	h=Subject:From:Date:To:From;
	b=cOCbzO177aTFsI7wgYNZjVxTOXRDYpkcL900kPcLv+6sM/St/Yl4L97veDUKsuuy5
	 nzT4G6YV3wug1j7UkUts47NNcXhK5MXZIdes03iFQucu0TpC+GPkElLA1pBie58qy2
	 fFE2VXUFDr/bM16u2rBV9syX52T+DlYBRPB+h+atDK8ATZXGYHwudVKOid2taJZjIx
	 rsYB1cg0DwG8l+T94H6fZ1vpF6RWjKnZ7WL5t085unHQFD/ku5TCwo6iTw52BrBVrs
	 ByvGznOlEsrZfvoXh8cy02jn4UyegT/FuKNYPkxTO/3v3Evrm0Fkrx6EBqnSAtv7Gx
	 amRFSeInNQxMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 42A3D392FF83;
	Mon, 30 Mar 2026 22:52:55 +0000 (UTC)
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
 <177491117391.1971382.17492207046301942636.git-patchwork-summary@kernel.org>
Date: Mon, 30 Mar 2026 22:52:53 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1] spi: cadence-qspi: Fix exec_mem_op error handling
  Submitter: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1066378
  Lore link: https://lore.kernel.org/r/20260313135236.46642-1-ghidoliemanuele@gmail.com

Series: spi: stm32-ospi: two fixes
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1074005
  Lore link: https://lore.kernel.org/r/20260329-stm32-ospi-v1-0-142122466412@gmail.com
    Patches: [1/2] spi: stm32-ospi: Fix reset control leak on probe error
             [2/2] spi: stm32-ospi: Fix DMA channel leak on stm32_ospi_dma_setup() failure

Patch: spi: amlogic: spifc-a4: unregister ECC engine on probe failure and remove() callback
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1070504
  Lore link: https://lore.kernel.org/r/20260322-spifc-a4-v1-1-2dc5ebcbe0a9@gmail.com

Patch: [GIT,PULL] SPI fixes for v7.0-rc5
  Submitter: Mark Brown <broonie@kernel.org>
  Committer: Linus Torvalds <torvalds@linux-foundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1073751
  Lore link: https://lore.kernel.org/r/20260327185046.198D01AC5847@finisterre.sirena.org.uk

Patch: spi: stm32-ospi: Fix resource leak in remove() callback
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1074160
  Lore link: https://lore.kernel.org/r/20260329-ospi-v1-1-cc8cf1c82c4a@gmail.com


Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


