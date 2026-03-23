Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D342BE644
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 22:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303819; cv=none; b=CPnn6a7i5TR4Utr/469sqakm64QtBBIdcFzGOV5m8Hc93VFRzPLFP0PlGyhet6l2Wc58Qt/oFWJ4hJ0TJmJukYNz2V8FU0v+Tu6xL3P2x+O5ZURzOlm4tD6Ui44ePNEMbUzpejUaETeMrdVg/8DjMdkOQsP2K6v5ubJKBIqpG6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303819; c=relaxed/simple;
	bh=mlM9eillJHG/OIysh7QqzL0SL8XgmxM/WElPfP9gbAs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=c+H88eQFTY0BL8OJuOYhAy3szgvNRUE16F9+t2WdxzP6xtpDOtvq2k4W3AS4D9ligtgAm3r/0H5zTzHHqFPmOl6uAHCmzC3wDNvF+NL0Dj76fdCqpWNhYFA44CTiRhC81xY2+e8ED8WEg5i8Na/HUWthEOxACq5eSozeLtLCBi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5W1UPfm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5W1UPfm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B416C2BC9E;
	Mon, 23 Mar 2026 22:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774303819;
	bh=mlM9eillJHG/OIysh7QqzL0SL8XgmxM/WElPfP9gbAs=;
	h=Subject:From:Date:To:From;
	b=p5W1UPfm+0shD1o8MPudS6KiLcp/dYN5rrB/jNlPn6ueVGYQ2ve6QEcBkBjOw2CRb
	 Aw8HQzPNnfM7MqalCCv7+pSyMzpfgqddu1g+KRNzhRGP01uX3kMRavJajRVqBjwQAX
	 jyw8G3JOJaRPj+V3OsEPZ2BbLjPClXqLfIdzNQHZ0Mw7+dSqhW0WzqGqb4Uxs1DjrW
	 KUzEoDZJpNuqCY6rOGaVW+5L7M5HNcvx4ifzxidsyMGuexYbRwu5n+ytYg4YZJhOgR
	 e+s29bwJQ9GcDucPknM4fSLkmmSFjIdlgOVC3ZKlwZC8VpwS/So7qdWkoEuHH5OHou
	 S5Zh48la6grVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7FBB13808200;
	Mon, 23 Mar 2026 22:10:08 +0000 (UTC)
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
 <177430380704.341600.7708020230766794037.git-patchwork-summary@kernel.org>
Date: Mon, 23 Mar 2026 22:10:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: cleanup in spi by use devm_clk_get_enabled
  Submitter: Pei Xiao <xiaopei01@kylinos.cn>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1068954
  Lore link: https://lore.kernel.org/r/cover.1773885292.git.xiaopei01@kylinos.cn
    Patches: [v5,01/17] spi: axiado: Simplify clock management with devm_clk_get_enabled()
             [v5,02/17] spi: bcm63xx-hsspi: Simplify clock handling with devm_clk_get_enabled()
             [v5,03/17] spi: bcmbca-hsspi: Simplify clock handling with devm_clk_get_enabled()
             [v5,09/17] spi: sifive: Simplify clock handling with devm_clk_get_enabled()
             [v5,13/17] spi: stm32: Simplify clock handling with devm_clk_get_enabled()
             [v5,14/17] spi: sunplus-sp7021: Simplify clock handling with devm_clk_get_enabled()

Patch: spi: pl022: update outdated references to pump_transfers()
  Submitter: Kexin Sun <kexinsun@smail.nju.edu.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1070293
  Lore link: https://lore.kernel.org/r/20260321105940.8143-1-kexinsun@smail.nju.edu.cn

Patch: spi: meson-spicc: Fix double-put in remove path
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1070489
  Lore link: https://lore.kernel.org/r/20260322-rockchip-v1-1-fac3f0c6dad8@gmail.com


Total patches: 8

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


