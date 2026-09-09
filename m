Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF375678E5
	for <linux-spi@vger.kernel.org>; Wed,  9 Sep 2026 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962325; cv=none; b=O9l7vdOjaOnITrXmg99I41pmGwpQSI86/ybDsQLCo4HwgVydil/aY3ROKtOlIJzXGwOhIY1z1+r3+AHmKGYiGKG+HGdrH/WejtaDGMz+bmPc9LnvBbi85RQg75JvU7BtUQjL64Ut/y5w/zuxaCRrMrV1YDe3LIc5AgUzukMoJWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962325; c=relaxed/simple;
	bh=Kgecw06Ta0Ygts+lYTEPcmV6YejRI6vxIpcaPU8GSJA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=eoNAYbsZMnIrLtdI7D+8NTATwwwusWQ7vs3w6gmUQAwaICtL7AiGoFn34C9hswt0J83t+ThC37+/GXZYBsfqbrCew6sWDiyOjrsIo2r+WUXsgZJrJcjKHhnK7b4DicHw39vfDLUFFgzzMLXO7/4CNpdxW8jkG4bHpOGWuaHvDeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hf7cXAps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hf7cXAps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24481F00A3D;
	Wed,  9 Sep 2026 13:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788962323;
	bh=vcn05nE4kQctRWFLSddF0HVqjiodayZHgAHtQjllK8c=;
	h=Subject:From:Date:To;
	b=Hf7cXApsoRb8Zn0eEbtXUHxgSQ3+SSFz/eCCAZz7rA+dW/JSfuOBqPbSAdix7q80t
	 WaFb5gARMMMfc0nATKZqRxd1cqsw7kQ8Fo148FGMznAhv/0l1oJK3mzfQU6rR4TbpH
	 J3xk6F+yhGxNkpA+GLTUF37w08TW5AsUil+vCgDmE6gJio4bPWc3p66jcGU1oVsgck
	 ZZwPtvg+ils6IYdMPbsz91yJhhDvk626ePD4yAOfrDSvmCBZP9obwvjZVcr4DDrW/V
	 CG6BRI3oUNxKjFDWHvAEXKOl5wQ73TFNQfgLIOXe8NgLYVEUe/R9e39BEyw47Qajns
	 cbSAcf3G1Jebw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19843380A942;
	Wed,  9 Sep 2026 13:57:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <178896226176.411381.16815447365989241907.git-patchwork-housekeeping@kernel.org>
Date: Wed, 09 Sep 2026 13:57:41 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: realtek: Add support for RTD1625 SPI NOR Flash Controller (2026-09-09T12:56:59)
  Superseding: [v3] spi: realtek: Add support for RTD1625 SPI NOR Flash Controller (2026-09-08T11:16:38):
    [v3,1/2] dt-bindings: spi: Add Realtek RTD1625 SPI support
    [v3,2/2] spi: spi-mem: Add Realtek SPI NOR flash controller driver

Checked 161 series in 2.70 seconds.
This project currently has 16447 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

