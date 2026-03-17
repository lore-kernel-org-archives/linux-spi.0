Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1712F38E11E
	for <linux-spi@vger.kernel.org>; Tue, 17 Mar 2026 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773734209; cv=none; b=UQlUcqrFiNJGEugH8DhL01gbM3PGZS4sf5SuyVp1fMQVBtYqBwYEOGHFQAShHn7vyjtlc15g8MWkLQZ85r8EudQSCShJocZc6WKRZtRUCL43fz3m80P0A9Mv/fOuXYmLbf2v3rvGruS4wv4lzBvgCZBJXiHf9UzxDW0D4RZf3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773734209; c=relaxed/simple;
	bh=LW8g5duyPpAXGe1iV4heIdxfhiWq/VZYm6N8p+AnY3w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Gs6G4x7XzW+ekDiKKr6TyY4s6WRry9SiT+O6aTzdYHG1dX6LJNA6UndehU6I2oNO1Kip6iWH26VrAXV7fwz4Am+9a6LvK8zokq2JZZLsg7ZjiRCQ80v0m13v660z6YzoQGED992oN4+Z9AdCsMFbSjd2z6hFvB4u5uA+DFUSCRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbLhZqHR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbLhZqHR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DBDC4CEF7;
	Tue, 17 Mar 2026 07:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773734208;
	bh=LW8g5duyPpAXGe1iV4heIdxfhiWq/VZYm6N8p+AnY3w=;
	h=Subject:From:Date:To:From;
	b=NbLhZqHRXjh7ZPmX20d4x/Lyv5ZDcM3ccnGAjz2E3aNmm7SJHa7KLAbam3xiGImaa
	 lA7WtRYCc6Tnx0wgOAu9wrhKc1trwxmgX+CPCxE4+4wsFIxvq9fhDp1dg4txbicUXe
	 Y6wropCZSpT6qzgLP6IcsefwXb6z2ZdTqwuOyNJAkDIdaVvzgMz/1SeSJ90EkBwRir
	 NKkvZHTR1Inq+jrqOo/CrmWCEAS+5jnesqVk1i81MKrMFZXi7aT6y76UvLD+9dkcd5
	 tdwx4aIDeO7Uhu+9HPPmKKEiw9vaOkXe1mkaj77mBSNXv20RNnkoF2IjcHzowCLFId
	 bdMTSqLzykdzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D21E3808200;
	Tue, 17 Mar 2026 07:56:42 +0000 (UTC)
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
 <177373420105.3480844.300273473556279540.git-patchwork-housekeeping@kernel.org>
Date: Tue, 17 Mar 2026 07:56:41 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] cleanup in spi by use devm_clk_get_enabled (2026-03-17T07:41:46)
  Superseding: [v2] cleanup in spi by use devm_clk_get_enabled (2026-03-13T06:08:16):
    [v2,01/17] spi: axiado: Use helper function devm_clk_get_enabled()
    [v2,02/17] spi: bcm63xx-hsspi: Use helper function devm_clk_get_enabled()
    [v2,03/17] spi: bcmbca-hsspi: Use helper function devm_clk_get_enabled()
    [v2,04/17] spi: img-spfi: Use helper function devm_clk_get_enabled()
    [v2,05/17] spi: imx: Use helper function devm_clk_get_enabled()
    [v2,06/17] spi: npcm-pspi: Use helper function devm_clk_get_enabled()
    [v2,07/17] spi: orion: Use helper function devm_clk_get_enabled()
    [v2,08/17] spi: rockchip-sfc: Use helper function devm_clk_get_enabled()
    [v2,09/17] spi: sifive: Use helper function devm_clk_get_enabled()
    [v2,10/17] spi: slave-mt27xx: Use helper function devm_clk_get_enabled()
    [v2,11/17] spi: st: Use helper function devm_clk_get_enabled()
    [v2,12/17] spi: stm32-qspi: Use helper function devm_clk_get_enabled()
    [v2,13/17] spi: stm32: Use helper function devm_clk_get_enabled()
    [v2,14/17] spi: sunplus-sp7021: Use helper function devm_clk_get_enabled()
    [v2,15/17] spi: uniphier: Use helper function devm_clk_get_enabled()
    [v2,16/17] spi: zynq-qspi: Use helper function devm_clk_get_enabled()
    [v2,17/17] spi: zynqmp-gqspi: Use helper function devm_clk_get_enabled()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

