Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DD2492196
	for <linux-spi@vger.kernel.org>; Fri, 14 Aug 2026 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786733462; cv=none; b=JbIZaQey7ptDuIdKgFBX+qbWT5Xdm/3LWgM7KHjT7aeWgs74lkZr/t2UnKajPo3epDPvyxfxsIG1HOcbK5HVPZGgvRNBpSqeNx/PCpaHz6r/lkd1ITTkBJ8AVeoJA3T4cF/DyYkaguTnNBGwRmBXo+ghsiQGyT9iDIdYXAtqjiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786733462; c=relaxed/simple;
	bh=Ly+JcCJJBjarCZ+L6Vg654EhgMS8thQGFV8u9SUbJnA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Vuv3DWc+nt2NNba95/jqzdsWaIlaQQV+hZRGgw9r32TIn2yo5G5ixv7tXO/UwlKDBbyC64fetBfLPkoSO/8zLm/fY3sr0E+rOHqVaU3bvj+w3wtGLMjT26oA7HeZnw0zE7IjSYZv+fSjLJR8BEuDCN2eDF91LWlwrZPQJKzHQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7jDcdA3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7jDcdA3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7321F00A3D;
	Fri, 14 Aug 2026 18:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786733461;
	bh=vkgQH/P8LKKnXt1V2Mz7czywy0B++PJ/jhMG5oaBPVI=;
	h=Subject:From:Date:To;
	b=Z7jDcdA3LG8wjCeH5Yn4fM3I8D403Vf8nUaVuP6AG4prqCq64VydWMAyU7SX/drVi
	 CZC9rx5d92OFyCDZq3tP52uK5MjCmb4xOq/CVO8nCVy7rZ4diwO+S3rl/hHibn3qre
	 riZpmWjLPyxFEF1DGWdjdlUIuaKmvaIdBbuMtxzlSVABYEcIoVGakHjZYT8DbTBzs1
	 m5mDjXHYFQVPZpnA6uCtyceNM+4hNNtc9FCqSxC0P/xMGTyU1TRzEUkaZz4xUp5BiY
	 ddz/4APyWUvpEc2oCh678HMoZRXMIF8Aqd52ZBXlOgsHu61H49/qts0Wr8z1JJaBmp
	 sR7No5BowrSQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 963FB392445A;
	Fri, 14 Aug 2026 18:50:16 +0000 (UTC)
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
 <178673341515.3915421.11059317836767652909.git-patchwork-summary@kernel.org>
Date: Fri, 14 Aug 2026 18:50:15 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: Fix DMA mapping ownership on partial map failure
  Submitter: Honghui Jiang <jiang_hh2019@163.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1145805
  Lore link: https://lore.kernel.org/r/20260814031419.43378-1-jiang_hh2019@163.com
    Patches: [v2,1/4] spi: Fix DMA mapping ownership on partial map failure
             [v2,2/4] spi: Move __spi_unmap_msg() before __spi_map_msg()
             [v2,3/4] spi: Clear current DMA devices when unmapping a message
             [v2,4/4] spi: Add KUnit coverage for DMA mapping error paths

Series: spi: ma35d1-qspi: Improvements and DTR support
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1145220
  Lore link: https://lore.kernel.org/r/20260813-perso-ma35d1-upstream-qspi-v1-0-b217b9870eb1@bootlin.com
    Patches: [1/5] spi: ma35d1-qspi: Remove redundant reset operation
             [2/5] spi: ma35d1-qspi: Move speed setting to bus configuration
             [3/5] spi: ma35d1-qspi: Allow several command bytes
             [4/5] spi: ma35d1-qspi: Add DTR support
             [5/5] spi: ma35d1-qspi: Use the existing update helper

Patch: [v2] spi: dt-bindings: sun6i: Add compatibles for A733's SPI controllers
  Submitter: Jerome Brunet <jbrunet@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1144993
  Lore link: https://lore.kernel.org/r/20260812-allwinner-a733-spi-support-v2-1-937bff0fa78e@baylibre.com

Patch: spi: dw: Remove shadowed dws in dw_spi_setup()
  Submitter: Liang Hao <haohlliang@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1146030
  Lore link: https://lore.kernel.org/r/20260814114235.31281-1-haohlliang@gmail.com


Total patches: 11

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


