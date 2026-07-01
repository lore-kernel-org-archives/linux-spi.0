Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF64A4219E4
	for <linux-spi@vger.kernel.org>; Wed,  1 Jul 2026 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903626; cv=none; b=JSsJwIQ5D7atkhTWck7zNzDN0EMKYBdc4HvgWsKuu/M6URbZbLXc6TvCIh6V+YByZEp6M+VW1V/O5S8bROYTX12FvnCSqsH8kAvYYiAA4aFPZryEcQ19nLK3EVTHzNLjF0Tc2m4c4tF6oLtsQ7muRPbl4xZwH+0W+SnZcpmROcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903626; c=relaxed/simple;
	bh=NkamYYCTDsRICfV01fPCxh8PeT9RoFefbp7snYgmX68=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=usnCvSmaljQhNLswq7DwHeUZKGHTGr6xC+RghD6aWeCym7pUvvF1lswj5IsIkIX2xR+ozpBMwhCE7/YLVQr7VzIfstaSO26nLfjhE6IsuKHPVNOnOG9XZqqoJHo5SNCMPsUj6gkq2sBMPH0r3fG87hMy6HSpIRIGfTeHNy0W0xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQ0gfmcz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQ0gfmcz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D7E1F000E9;
	Wed,  1 Jul 2026 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782903625;
	bh=n+c9PBhkzBlPTGArsh7qwCQdWIoe1WohJEKIFUf3xV8=;
	h=Subject:From:Date:To;
	b=PQ0gfmczrp8Z+CJ9BO290LMTyng5O/j2wFxzW082E1LLVtT/A2q2TWay6v06/9aVO
	 TwVKniM9afuZsFyXzGig0G7EsQkDDQiW9ZIU22VDkHPdht37bBUFof0lbM2ENTM18V
	 x63Cr9XwQCVkHyCxIGCTCoPPOLPJ2GTHzFMuGEmg5FOp9OrF26FVMqkaaeATmkiYQx
	 xFeWuP7bK0V7epYTADp3YFfDC3+A57k6T+bnqhjx4jDCdzp2xniKhH3prTPHspzdGH
	 +FbXG+udmeLWA+GVv4x3348wxVv240+QS1r7llL8ZCDmtNTyuijl3/RKUpo/M89oOd
	 bbdIiCWaTrGUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A25392667F;
	Wed,  1 Jul 2026 11:00:10 +0000 (UTC)
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
 <178290360872.584743.10642074973605622875.git-patchwork-summary@kernel.org>
Date: Wed, 01 Jul 2026 11:00:08 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: ARM: dts: renesas: r9a06g032-rzn1d400-eb: Enable SPI and FRAM
  Submitter: Wolfram Sang <wsa+renesas@sang-engineering.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1117269
  Lore link: https://lore.kernel.org/r/20260626180326.9593-1-wsa+renesas@sang-engineering.com
    Patches: [v4,1/4] spi: dt-bindings: snps,dw-apb-ssi: drop superfluous RZ/N1 entry
             [v4,2/4] spi: dt-bindings: snps,dw-apb-ssi: add 'power-domains' property

Patch: spi: rzv2h-rspi: Fix DMA transfer error handling for signal interruption
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1117249
  Lore link: https://lore.kernel.org/r/20260627-rspi-v1-1-170c93ee14da@gmail.com

Patch: ARM: dts: renesas: r9a06g032-rzn1d400-eb: Enable SPI and FRAM
  Submitter: Wolfram Sang <wsa+renesas@sang-engineering.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1114882
  Lore link: https://lore.kernel.org/r/20260622174806.74450-5-wsa+renesas@sang-engineering.com


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


