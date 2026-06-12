Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED56401495
	for <linux-spi@vger.kernel.org>; Fri, 12 Jun 2026 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283611; cv=none; b=hSU9of1fpsHiRTqGWDPCQqrLgr2IJY9DfU0HXPtBwAoMWuvQoE/cYHciULGMdZqdYPMDBYdS5CGq7Bp/91vlvlOcakZLNJKVEHdrrVXUJB0K4QmTpPo0bT59XN2hw7+UTu1msZizGOnrb9dM20C1xenCN8edT91JdCgefN2bPgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283611; c=relaxed/simple;
	bh=o2Gq5wmhT2J8r1xPCyqYDXLmoqo7NxqS1Jq9YUJAzHc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Kt6WPi01u20x6h6xMVlyB1kzOxb03uzPCr5O/+EmMLdS5/v9HsRs3WWhSWsVYAvSfP6bRlY2QNqd2RYEDbEbUyf4Jb17qtkSaPLl/9ohWOaDri8VoR1SLltQdoU3LdmI08A9RCDsJxku3iQs/ow24mFdLcW0yDYA/vxHH2ySJXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nc1mTBeM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nc1mTBeM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05F71F000E9;
	Fri, 12 Jun 2026 17:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781283609;
	bh=c+dgLXEE4aA7JFyQvBC8O+f5DOmOyXIDzBMUfxFSk3o=;
	h=Subject:From:Date:To;
	b=nc1mTBeMCBRx57BYEwH814B2pjidyMCPUOLDutXMmQV1OIVnicmpUNdJorWSLdaP3
	 lOz+JG6XcCq7VewXzHdw6MZ5LPuKKBcSe4mioYjoTW5OBzHj7UphS30GlpPbRBvFAO
	 B9XZ0EIwDeguzsZZathvb0ODRPLpu9xiYD7r5q/Ibj8XTjPs5L2qKZ/QqNWAumRiTG
	 oF1uYUp2AS0/2gpsGMK58VjUzT2Epy6XKHsLL/wgcBZNOKAwDuKgrnDUlL4/UA3beE
	 PG6iADyE298H01rrb9Yty7Oid8nOQiOGGyIqi8Qvx9tyqKGiiF0tOeC8kqqro039rh
	 aUReJOiODRBCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9EB4D39310BB;
	Fri, 12 Jun 2026 17:00:07 +0000 (UTC)
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
 <178128360645.752188.4250634744872834341.git-patchwork-summary@kernel.org>
Date: Fri, 12 Jun 2026 17:00:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: mtd: spinand: Winbond continuous read support
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Miquel Raynal <miquel.raynal@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1087653
  Lore link: https://lore.kernel.org/r/20260429-winbond-v6-18-rc1-cont-read-v3-0-0f38b3c229ad@bootlin.com
    Patches: [v3,01/11] mtd: spinand: Drop a too strong limitation
             [v3,02/11] mtd: spinand: Expose spinand_op_is_odtr()
             [v3,03/11] mtd: spinand: Drop ECC dirmaps
             [v3,04/11] spi: spi-mem: Transform the read operation template
             [v3,05/11] spi: spi-mem: Create a secondary read operation

Patch: [v2] spi: xilinx: use FIFO occupancy register to determine buffer size
  Submitter: Lars Pöschel <lars.poeschel.linux@edag.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1110579
  Lore link: https://lore.kernel.org/r/20260612105244.9076-1-lars.poeschel.linux@edag.com

Series: spi: spi-mem/mtd: spinand: Prevent SPI NAND continuous reads on am65/am62
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Miquel Raynal <miquel.raynal@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1073081
  Lore link: https://lore.kernel.org/r/20260326-winbond-v7-0-rc1-cadence-cont-read-v1-0-0d626e1dfb2b@bootlin.com
    Patches: [1/4] spi: spi-mem: Add a no_cs_assertion capability

Patch: spi: spi-mem: Fix spi_controller_mem_ops kdoc
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1110528
  Lore link: https://lore.kernel.org/r/20260612-perso-fix-no-cs-assertion-kdoc-v1-1-626b2d6d0d9b@bootlin.com


Total patches: 8

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


