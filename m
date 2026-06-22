Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C70634028B
	for <linux-spi@vger.kernel.org>; Mon, 22 Jun 2026 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782150020; cv=none; b=fSR3Ohrz4d812nIvrGc7+mCElH1trtxjR5aOm5OJn8Ov6UNe6eb4ltWR6/6O5K9cX2g+MhrcT46d/iL+st4CmvKORufdTpkxIWlHCY2/I9RXwLfrIWCtdtSLXvnLBML1sFZsr05TrJer7m//X8pnHdht4naXtvaUl1Bn2M7zJUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782150020; c=relaxed/simple;
	bh=0o8tX7NYblXJ8x38gItH13YrOiLpoevtsbYIs/E0Lxs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KFcfEUYplZERqmPvzSbT6g4e9fCe6fMWoPhlruSONct46O5JsrsQiid5RwW+TqAyb8sg5vdSsy/y64LpiOiI+hOdhRyOFOsLCDgWjj+YxbcpAtf0kdB9tT3GumZuKgmFiNye2QfeqjmlUS7GnffndhhZp939Q1791e6yU2/hmho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3HnlVbZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3HnlVbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6E91F000E9;
	Mon, 22 Jun 2026 17:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782150018;
	bh=EaY0/bbZmARGswJHNm1N7hm6tnIKasDEZBFwVE3Yvfk=;
	h=Subject:From:Date:To;
	b=E3HnlVbZSJrE1rpMPikuqgeOxQydw9wza2rnoadoOnRla2yVUwzF0RE7Thce70ROd
	 PbIsVvuIXhNPAGaJW460/hzdyDU6zx1Oo8+EBbQfgrhdhkSPidMp5AkHQGXHkC2WMQ
	 3xI0X6mVEoZAue43qRc+9i7URibLTsQXqeaHsWYM+pHoqWu9ME5jC32Tlad7vePkN0
	 uRHg7x8eMPhyHhqruP3TiHKiTQj89G+4omkROx0sgAmfyUnNHCSNrOeLGbqqJIjGXj
	 7tIFOUBWUlYoiKWSmXMiYgsyKfOsdM+2BKMEx8KUk+ZhhAlLRl6a0bi1jzlEA2PvZm
	 lf9fCZ82QeklQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6B88E3930917;
	Mon, 22 Jun 2026 17:40:10 +0000 (UTC)
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
 <178215000912.1337004.10932055281260793075.git-patchwork-summary@kernel.org>
Date: Mon, 22 Jun 2026 17:40:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add support for StarFive JHB100 SPI
  Submitter: Changhuang Liang <changhuang.liang@starfivetech.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1113999
  Lore link: https://lore.kernel.org/r/20260619143443.22267-1-changhuang.liang@starfivetech.com
    Patches: [v2,1/2] spi: dt-bindings: snps,dw-apb-ssi: Add starfive,jhb100-spi
             [v2,2/2] spi: dw: Add support for snps,dwc-ssi-2.00a

Series: Add support for Synopsys DesignWare SSI controller version 2.00a
  Submitter: Changhuang Liang <changhuang.liang@starfivetech.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1110659
  Lore link: https://lore.kernel.org/r/20260612125856.8530-1-changhuang.liang@starfivetech.com
    Patches: [v1,1/2] dt-bindings: spi: snps,dw-apb-ssi: Add support for snps,dwc-ssi-2.00a
             [v1,2/2] spi: dw: Add support for snps,dwc-ssi-2.00a


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


