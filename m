Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CFC331215
	for <linux-spi@vger.kernel.org>; Fri, 13 Mar 2026 06:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773385062; cv=none; b=u1dNkG7Al+FCt05XHnIaEFdBLVeJalS4RtucV7/0F2wKx2JRiBng1kEOO+QGMR3umYvXQfrdGNauI6BTumn9ZjOT/2kJAA2CXSfyU835W66McwtYXVmfa76ZFWvc6L9wQEJTbRUpQCV32O35V+S7s4PMsXiGm1A1KlAVvH6ONNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773385062; c=relaxed/simple;
	bh=rAP7CzXWyOUg4zZXTdoYMmrD2gLpLrmbbgsxamjlBYA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=rvymCg5M5SD6BcSkwD9Sfsrjf30pouZ7G/F8FOo3OtTnujk08EYw1m0IxfZtVXgs56sGUPwFNZqsmbW64u+KeOPgN6A1qmhEcDrgVa1wLHjQHjH4dgsivJVc3IhHZmIULVbma5N9poCGK7I2EMDwiltCMIJAp29as7bRB+Bi3+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q40rVbuk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q40rVbuk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86305C19421;
	Fri, 13 Mar 2026 06:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773385061;
	bh=rAP7CzXWyOUg4zZXTdoYMmrD2gLpLrmbbgsxamjlBYA=;
	h=Subject:From:Date:To:From;
	b=q40rVbukfO4rZPpKubpp05mvrjJwsq+T4Qy9JTEZBn8+6VEK7bLL8saIk3aXIAl/p
	 bbKpj7DG5HtK0DItKkLsvKaRAV0v2wfzJNHaZ7noYBLl4ksZDdCmszmaxed+zgDf4V
	 +1DXL1e1xJIxmtvshGidnNJBWfk2ELcEki3durHqIN/FQWgo14qZJJgPLT/xi+7lVw
	 3dpndXYVj7BTNK1CTNLwuSXK7XDvx+LKgAQ7FV9Nkla+I7OxS3cVpNr0t8azpobT9q
	 J3OoGh/eWS9a0wmGNp2lkNTSgycE+LARe2gMbmfmKDOAEBDyX1gFyZN92X7/RL3QjV
	 TsEd+0ni1amOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA2033808200;
	Fri, 13 Mar 2026 06:57:37 +0000 (UTC)
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
 <177338505635.728663.18185654558181048044.git-patchwork-housekeeping@kernel.org>
Date: Fri, 13 Mar 2026 06:57:36 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] cleanup in spi by use devm_clk_get_enabled (2026-03-13T06:08:16)
  Superseding: [v1] cleanup in spi by use devm_clk_get_enabled (2026-03-12T09:28:52):
    [01/17] spi: axiado: Use helper function devm_clk_get_enabled()
    [02/17] spi: bcm63xx-hsspi: Use helper function devm_clk_get_enabled()
    [03/17] spi: bcmbca-hsspi: Use helper function devm_clk_get_enabled()
    [04/17] spi: img-spfi: Use helper function devm_clk_get_enabled()
    [05/17] spi: imx: Use helper function devm_clk_get_enabled()
    [06/17] spi: npcm-pspi: Use helper function devm_clk_get_enabled()
    [07/17] spi: orion: Use helper function devm_clk_get_enabled()
    [08/17] spi: rockchip-sfc: Use helper function devm_clk_get_enabled()
    [09/17] spi: sifive: Use helper function devm_clk_get_enabled()
    [10/17] spi: slave-mt27xx: Use helper function devm_clk_get_enabled()
    [11/17] spi: st: Use helper function devm_clk_get_enabled()
    [12/17] spi: stm32-qspi: Use helper function devm_clk_get_enabled()
    [13/17] spi: stm32: Use helper function devm_clk_get_enabled()
    [14/17] spi: sunplus-sp7021: Use helper function devm_clk_get_enabled()
    [15/17] spi: uniphier: Use helper function devm_clk_get_enabled()
    [16/17] spi: zynq-qspi: Use helper function devm_clk_get_enabled()
    [17/17] spi: zynqmp-gqspi: Use helper function devm_clk_get_enabled()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

