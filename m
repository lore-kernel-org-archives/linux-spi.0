Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51831E487
	for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 02:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773802614; cv=none; b=gMqSWngmwN0JEcvDipmJoKb8IwRXMtYqQoIIK6sjLzH/4D2g4XeqFAow6yYoEseydflaHCHBoTcItDLsoksb/rrn5Ft6seW7+5bQdpU8IzvixXeHKyyjmABxwcqseskBdtnAAq7y6Ba4xEixlNWY0gAaZiQQrrNRppxWw0SUGZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773802614; c=relaxed/simple;
	bh=Vwfy1NeUyMjUsE9OYNugu1ON/D8yv90vsWXcR0+Tekg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mE3q5v6odpk5d+3rqcGAdDenCQlsfrF+Tq175chIEmEP7TcjsYW88HTtRo7saT5cI/jOvhhifnWH+4nU193f6NhT+lOejIzYHwxH08PXWAkgoMBQlf0JXW2cW0wgG7789ZJM3lY0b3D4rMbd8fwl7Z2CoF2r2Fcjq2NpNN7IvEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IppIJ+5y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IppIJ+5y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C887C4CEF7;
	Wed, 18 Mar 2026 02:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773802614;
	bh=Vwfy1NeUyMjUsE9OYNugu1ON/D8yv90vsWXcR0+Tekg=;
	h=Subject:From:Date:To:From;
	b=IppIJ+5ygerBxO3XDPoBAndgqb4t26AbrNvr0DfPInueCJzg7Ex/Gh2yepf4lwkrr
	 g2EKv9oHrfIG6b64NMrKfHL4/AgCNTptM/ClDe80zc/1M7vICglNMMXnK2I+YhCCPH
	 huBPPX6bpofCPXjDDvrxLz2s0OcsQ1n2NAdJO2rYJNgGbvphFjHgH/DqN4wzm94rvG
	 CH0M7hdK4bv/mG+NgQKwXbC/+w7eu+Pf5GYaClIwadBVztewv8mAzwR5lBKHSVT2jF
	 Z+fbUxEzl3qryxl9KjsTUdr2k4CdhSE/GNuaDYBYWPcdY+FQ2HWsFJrwXb+MSbWRWg
	 2kJEpga2W43RA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0603808200;
	Wed, 18 Mar 2026 02:56:47 +0000 (UTC)
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
 <177380260618.104984.1112380551084673559.git-patchwork-housekeeping@kernel.org>
Date: Wed, 18 Mar 2026 02:56:46 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] cleanup in spi by use devm_clk_get_enabled (2026-03-18T02:39:54)
  Superseding: [v3] cleanup in spi by use devm_clk_get_enabled (2026-03-17T07:41:46):
    [v3,01/17] spi: axiado: Use helper function devm_clk_get_enabled()
    [v3,02/17] spi: bcm63xx-hsspi: Use helper function devm_clk_get_enabled()
    [v3,03/17] spi: bcmbca-hsspi: Use helper function devm_clk_get_enabled()
    [v3,04/17] spi: img-spfi: Use helper function devm_clk_get_enabled()
    [v3,05/17] spi: imx: Use helper function devm_clk_get_enabled()
    [v3,06/17] spi: npcm-pspi: Use helper function devm_clk_get_enabled()
    [v3,07/17] spi: orion: Use helper function devm_clk_get_enabled()
    [v3,08/17] spi: rockchip-sfc: Use helper function devm_clk_get_enabled()
    [v3,09/17] spi: sifive: Use helper function devm_clk_get_enabled()
    [v3,10/17] spi: slave-mt27xx: Use helper function devm_clk_get_enabled()
    [v3,11/17] spi: st: Use helper function devm_clk_get_enabled()
    [v3,12/17] spi: stm32-qspi: Use helper function devm_clk_get_enabled()
    [v3,13/17] spi: stm32: Use helper function devm_clk_get_enabled()
    [v3,14/17] spi: sunplus-sp7021: Use helper function devm_clk_get_enabled()
    [v3,15/17] spi: uniphier: Use helper function devm_clk_get_enabled()
    [v3,16/17] spi: zynq-qspi: Use helper function devm_clk_get_enabled()
    [v3,17/17] spi: zynqmp-gqspi: Use helper function devm_clk_get_enabled()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

