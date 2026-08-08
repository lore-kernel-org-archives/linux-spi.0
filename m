Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021CD2EB0F
	for <linux-spi@vger.kernel.org>; Sat,  8 Aug 2026 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786207260; cv=none; b=G8NyMho43mCRCR4Krb1cbi+apgq781M0qOiy2kUOAeBoZoptXf27bluGrWcm9b7TXHg8D6hmTCOtzSsNeSEF5AZRlwLa5nX42L0OUE4ZvOD3qpiHuoc3IKr9lIUvGlExYyiOiEi7RA+x3XMJOZ8fWPGazDQelmfv/9GZurL8tF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786207260; c=relaxed/simple;
	bh=+Hk2mEUuvaF6RMrhPSgp2hDFhI/L6pWdivuo+tFvmzQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=iEO3NTi4EI2qrt1qHlpAzWzJ7z6MTAY5N+IAOeuiR23xZ2DPIG0PhjRob+407OGb2MZ14OoiA10mgLtOaZYAyskBdJKjf8ZjXbS3tOr6axMuMIUaDYC4LNThIL+fZWK7LsAMInehVy+w+93aFsboPOK8So7aNqIe8MUHlFe4CU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrRUebUE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrRUebUE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94601F000E9;
	Sat,  8 Aug 2026 16:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786207258;
	bh=k6Mcr5aQy+XnVu5UYGxdwkVLMPQu1MLYIJVPJnXI+2A=;
	h=Subject:From:Date:To;
	b=VrRUebUEnTjdHXCyiDh4WfltVSLCjg3QIiYJjSnyuKMtpoJYatZVaq9FDrPsmrk6f
	 8EWDCMRyrx4bZFJaoO+GPdOBbcJHg3vUIatp0xKKWU+P5jypSoWZuXfRDMBg5N7bRX
	 gFAZ+WXyRXPKMu5zhDPhOwGLIXgq5fL3ihVLlwTYM346kbwTsdcN7X6DRXo5h8uUcg
	 UDnFO7Ql6zCMT4L2uFC20nUDtP9ALw/cWYIHt70LNzCG58xfxOzQv51tZE1zzI/ALI
	 9Km9wz3zHNn9GJ2z3Sa1tXuRoHVw0hFR+9hR6uLUPx+XScnW3AgEk6mp8qPT5rBGyD
	 hXCEJmUlPUcIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D356E380CFEA;
	Sat,  8 Aug 2026 16:40:17 +0000 (UTC)
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
 <178620721646.2697641.1252295433954763908.git-patchwork-summary@kernel.org>
Date: Sat, 08 Aug 2026 16:40:16 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: use modern PM macros
  Submitter: Jisheng Zhang <jszhang@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1139491
  Lore link: https://lore.kernel.org/r/20260803142003.12857-1-jszhang@kernel.org
    Patches: [01/39] spi: atmel-quadspi: use modern PM macros
             [02/39] spi: amlogic-spifc-a1: use modern PM macros
             [03/39] spi: at91-usart: use modern PM macros
             [04/39] spi: axiado: use modern PM macros
             [05/39] spi: bcm-qspi: use modern PM macros
             [06/39] spi: bcm63xx-hsspi: use modern PM macros
             [07/39] spi: bcmbca-hsspi: use modern PM macros
             [08/39] spi: cadence: use modern PM macros
             [09/39] spi: coldfire-qspi: use modern PM macros
             [10/39] spi: dln2: use modern PM macros
             [11/39] spi: dw-pci: use modern PM macros
             [12/39] spi: spi-fsl-dspi: use modern PM macros
             [13/39] spi: fsl-espi: use modern PM macros
             [14/39] spi: fsl-lpspi: use modern PM macros
             [15/39] spi: qcom-geni: use modern PM macros
             [16/39] spi: img-spfi: use modern PM macros
             [17/39] spi: loongson: use modern PM macros
             [18/39] spi: meson-spifc: use modern PM macros
             [19/39] spi: mt65xx: use modern PM macros
             [20/39] spi: mtk-nor: use modern PM macros
             [21/39] spi: mxic: use modern PM macros
             [22/39] spi: omap2-mcspi: use modern PM macros
             [23/39] spi: orion: use modern PM macros
             [24/39] spi: pl022: use modern PM macros
             [25/39] spi: spi-qcom-qspi: use modern PM macros
             [26/39] spi: qup: use modern PM macros
             [27/39] spi: rockchip-sfc: use modern PM macros
             [28/39] spi: rockchip: use modern PM macros
             [29/39] spi: s3c64xx: use modern PM macros
             [30/39] spi: slave-mt27xx: use modern PM macros
             [31/39] spi: sprd: use modern PM macros
             [32/39] spi: sunplus-sp7021: use modern PM macros
             [33/39] spi: syncuacer: use modern PM macros
             [34/39] spi: tegra114: use modern PM macros
             [35/39] spi: tegra20-sflash: use modern PM macros
             [36/39] spi: tegra20-slink: use modern PM macros
             [37/39] spi: tegra210-quad: use modern PM macros
             [38/39] spi: topcliff-pch: use modern PM macros
             [39/39] spi: zynqmp-gqspi: use modern PM macros


Total patches: 39

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


