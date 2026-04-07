Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214603D091F
	for <linux-spi@vger.kernel.org>; Tue,  7 Apr 2026 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580687; cv=none; b=GV7nPOuGJPM7BuvKdWMMwJIexa7TmCLrfAvfFkUv2LxlN48ju4gfZZBK6NRTsgxYiKGPpYpRgert6Marr9G8Cayk+K8FuWjR4Zf8WRcx5yGhWUV58jwBAN3B2y8KBbwbixNTPhjPX2o+IoxHJHDX88KPMrWCe1BlwhmNgodSsMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580687; c=relaxed/simple;
	bh=REfsHZzTCA2zub6f9gqk5WJrabw1c/CnW5Q6z+GHmDI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=W1kE0oITWT/klLwDCJiqT53y9kVsoAOOXKP/qq9nuJqv7aFoZFCdGlKIwkOLYiA2S0k4PUulAybCXxrDNQlnX0ULi7S6oDEcZoHyib76y1on6KL3cDZBLhC8lUOhlGQKU5vnMokCSOfhORaNBo3EqkKJhou5gAwCeHwdZHo6lzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcmLVBmY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcmLVBmY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F45C116C6;
	Tue,  7 Apr 2026 16:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775580686;
	bh=REfsHZzTCA2zub6f9gqk5WJrabw1c/CnW5Q6z+GHmDI=;
	h=Subject:From:Date:To:From;
	b=CcmLVBmYn3mktd+Uj3ZNCW3q5wnKu6POG8t34HNymVsEaQlP5wTTtabUpQ2TaGA3x
	 y3jyocIDqiSm0schfP+9ohallSOO9IA/DFy7LoA1dlEs179oFxyPLuKS7EFKw8oeTH
	 leL9bx44l2GUrEMBXrFteIvSdDLS4yeLXKvTMItt5jmvhHcsIISu4Tu41EkZkzHVOu
	 CyK1VoVgM/gPZ7nl204OICTUTK0CsSzdspu523mkVFPL3OS/cT5f1/zPUW5g/jQuv9
	 s+f5h5ycMPv3AGQFkRc+uSaekcY5wP/RHL6Y/wqsGNGfzoE0u3dUiP0o+FzHTyO1Kh
	 GXNwLrP1q28tA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BCB123809A31;
	Tue,  7 Apr 2026 16:51:05 +0000 (UTC)
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
 <177558066433.4071193.14752476687340878967.git-patchwork-summary@kernel.org>
Date: Tue, 07 Apr 2026 16:51:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: spi-fsl-lpspi: various cleanup and enhancement patches
  Submitter: Marc Kleine-Budde <mkl@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1069411
  Lore link: https://lore.kernel.org/r/20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de
    Patches: [spi-next,v2,01/11] spi: spi-fsl-lpspi: adapt to kernel coding style
             [spi-next,v2,02/11] spi: spi-fsl-lpspi: fsl_lpspi_set_watermark(): use FIELD_PREP() to encode FIFO Control register
             [spi-next,v2,04/11] spi: spi-fsl-lpspi: fsl_lpspi_set_cmd(): use mode from struct fsl_lpspi_data::config::mode
             [spi-next,v2,05/11] spi: spi-fsl-lpspi: fsl_lpspi_set_cmd(): remove obfuscated and obsolete assignment of TCR_CPOL and SPI_CPHA
             [spi-next,v2,06/11] spi: spi-fsl-lpspi: fsl_lpspi_set_cmd(): use FIELD_PREP to encode Transmit Command register
             [spi-next,v2,07/11] spi: spi-fsl-lpspi: fsl_lpspi_setup_transfer(): remove useless spi_transfer NULL pointer check
             [spi-next,v2,08/11] spi: spi-fsl-lpspi: fsl_lpspi_can_dma(): directly assign return value to fsl_lpspi->usedma
             [spi-next,v2,09/11] spi: spi-fsl-lpspi: fsl_lpspi_reset(): convert to void function
             [spi-next,v2,10/11] spi: spi-fsl-lpspi: fsl_lpspi_write_tx_fifo(): simplify while() loop check
             [spi-next,v2,11/11] spi: spi-fsl-lpspi: make struct lpspi_config::mode u32

Patch: [V2] spi: zynq-qspi: Simplify clock handling with devm_clk_get_enabled()
  Submitter: Pei Xiao <xiaopei01@kylinos.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1078057
  Lore link: https://lore.kernel.org/r/24043625f89376da36feca2408f990a85be7ab36.1775555500.git.xiaopei01@kylinos.cn

Series: cleanups in spi
  Submitter: Pei Xiao <xiaopei01@kylinos.cn>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1077220
  Lore link: https://lore.kernel.org/r/cover.1775273351.git.xiaopei01@kylinos.cn
    Patches: [1/4] spi: mtk-snfi: unregister ECC engine on probe failure and remove() callback
             [2/4] spi: uniphier: Simplify clock handling with devm_clk_get_enabled()

Patch: spi: uniphier: Simplify clock handling with devm_clk_get_enabled()
  Submitter: Pei Xiao <xiaopei01@kylinos.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1077984
  Lore link: https://lore.kernel.org/r/b2deeefd4ef1a4bce71116aabfcb7e81400f6d37.1775546948.git.xiaopei01@kylinos.cn

Patch: [GIT,PULL] SPI fixes for v7.0-rc6
  Submitter: Mark Brown <broonie@kernel.org>
  Committer: Linus Torvalds <torvalds@linux-foundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1077052
  Lore link: https://lore.kernel.org/r/155f5413c87935ce30a4a00cce806386@kernel.org


Total patches: 15

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


