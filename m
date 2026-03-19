Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DEA385509
	for <linux-spi@vger.kernel.org>; Thu, 19 Mar 2026 02:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889021; cv=none; b=ZG652IyD3gwIROEnZ9XQUZ0iBsi6GhBIMvugai6vcpRgCm5A/9U1HX8PjydOoqhNDjPtgjt/o3JkKYHm5DyfLZYQF/2Sf42qPOnmEJjTT+5nn5nJewCT6zc0F9pvjuKL+AFZwLY/BKhWXaOrruwOOMbdwU1lCyCIOd5uwntfPj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889021; c=relaxed/simple;
	bh=czh7XIDpgpK2WhHLZo1vVzobEo5o/xgZuI/SfQGYjwY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=rLdsp++0svlafsSbDt0GjmGYwkbcvSJ1xtu1Ycqrx3IysGPumCp5YaxM9Qo0q6V1SFnhoEv8yJoD5QUcAiE1pEvhC65Rdhf4pHEgJUhgVOcxHLvpFjTatyia5ZVX5tp2YJhgxo2vm8GyYHkZaqqJksBNvA6icDpFaHypozfR3Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9KRY6Wj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9KRY6Wj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84087C19421;
	Thu, 19 Mar 2026 02:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773889020;
	bh=czh7XIDpgpK2WhHLZo1vVzobEo5o/xgZuI/SfQGYjwY=;
	h=Subject:From:Date:To:From;
	b=F9KRY6WjoPM5Y9SEA+xHzOCRm73u79cunAb97HxmN224ROh/gWASkhcWZXJRgR761
	 Na/6uWh16Ifer/+chbCPOA7ndxKcv8z3IIzS255avhzA3dksxQUlVyuduOFAp5EYmU
	 MhG/Ies9Oi5FTpgV2pjdejrD5LYkVe2qHEGmr+f6WxMqGGqc3cL4jujD3Hm/CpIrNw
	 zMALt2GXI90WsjCoyvZE7MBxTWo/MKQMeHuGCmnOXdDQNZCB5bg9gCxTcqoTPmsB5r
	 VaNBa0+FWkn4Yj8Do9KFSZRk3bVDr35tfrkbxThiRDuy8KapC8VRgjOsuUVy4OzM0U
	 g+j33qZP2KccQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D623808200;
	Thu, 19 Mar 2026 02:56:53 +0000 (UTC)
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
 <177388901149.1004328.3726545741285463544.git-patchwork-housekeeping@kernel.org>
Date: Thu, 19 Mar 2026 02:56:51 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] cleanup in spi by use devm_clk_get_enabled (2026-03-19T02:04:01)
  Superseding: [v4] cleanup in spi by use devm_clk_get_enabled (2026-03-18T02:39:54):
    [v4,01/17] spi: axiado: Simplify clock management with devm_clk_get_enabled()
    [v4,02/17] spi: bcm63xx-hsspi: Simplify clock handling with devm_clk_get_enabled()
    [v4,03/17] spi: bcmbca-hsspi: Simplify clock handling with devm_clk_get_enabled()
    [v4,04/17] spi: img-spfi: Simplify clock handling with devm_clk_get_enabled()
    [v4,05/17] spi: imx: Simplify clock handling with devm_clk_get_enabled()
    [v4,06/17] spi: npcm-pspi: Simplify clock handling with devm_clk_get_enabled()
    [v4,07/17] spi: orion: Simplify clock handling with devm_clk_get_enabled()
    [v4,08/17] spi: rockchip-sfc: Simplify clock handling with devm_clk_get_enabled()
    [v4,09/17] spi: sifive: Simplify clock handling with devm_clk_get_enabled()
    [v4,10/17] spi: slave-mt27xx: Simplify clock handling with devm_clk_get_enabled()
    [v4,11/17] spi: st: Simplify clock handling with devm_clk_get_enabled()
    [v4,12/17] spi: stm32-qspi: Simplify clock handling with devm_clk_get_enabled()
    [v4,13/17] spi: stm32: Simplify clock handling with devm_clk_get_enabled()
    [v4,14/17] spi: sunplus-sp7021: Simplify clock handling with devm_clk_get_enabled()
    [v4,15/17] spi: uniphier: Simplify clock handling with devm_clk_get_enabled()
    [v4,16/17] spi: zynq-qspi: Simplify clock handling with devm_clk_get_enabled()
    [v4,17/17] spi: zynqmp-gqspi: Simplify clock handling with devm_clk_get_enabled()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

