Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792434613;
	b=HzI0/GrFQPtUhXpDcioGzZF7X3zZ6WkJGTRTivFDneBKVa0qRbDrO/fxvm7QdAALIH/I
	 tzcE3kodPjzr0+R/LDei4VEDqMtC2d5q4dAUG2uhE5cLBdHVRoS6dN68grITu5XKlDVVj
	 yWdtgWvOh2pjDLsjy7PQ6NxYAs0iJhE7DvLPRGOqedQK/Nkc9WOjAgWtM5fpNm2XzEokl
	 Y1z2sXtvh17TkRG97vXrdi6Fmg/+/WyfWi/lfr7bY0YtjMrO0mG6Lz0bgO2fsFo9+64dj
	 kwsvtDzJzWcA9vu5CHW4FaxnnaZ7MFp1OxGEQreUfNnTOAB4uKgNC3Zr8Rml3SKfy3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792434613;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=clP0TuBeUe0fenY8A06JZ3d+7Ra5kmfh43fdpq4OpVc=;
	b=o+2AMNuSi6qKbh5LxoMb97721/5MRP6OYnIFnazX/Q28GnFddR/0EZfkstimXmPkuh7I
	 H96sR1X0s6DZljGSdIKfaiGZd/ON5Mnd2k8ij8EUmSwWVo+3tM4k3FTb3QNJKkKmt+INm
	 tY4FAYYvQNTtKrwdglYlQkluidVtzm2G4fbhfQXlvuOVMr9bXdwtM8ozVnoxic/AlI3GU
	 FGdjhSLTzjx/n+r43WJ9gcxh4yQcrlib1fmlGqamwF76GuB1v5K4BKC2bbB5aDXiP0Jil
	 LUPIB/EmfJEVQybzDr4cvZHD+FYCE+WQ3YMGCVR7z5jxCzkDK5art4fpZw1r4I26S+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TWgMLcw1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0914F606A321
	for <linux-spi@vger.kernel.org>; Mon, 19 Oct 2026 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TWgMLcw1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19191F000C4;
	Mon, 19 Oct 2026 18:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792434612;
	bh=clP0TuBeUe0fenY8A06JZ3d+7Ra5kmfh43fdpq4OpVc=;
	h=Subject:From:Date:To;
	b=TWgMLcw1PvP0+Vn1tQqoAO/8giB7Lh/SKGCvN0jWW96+olZwfqIEqw8LYc9Lf/9es
	 /sI/O2CE/e5Dh/ftriyLQwAg5/9njD3TX8aCECXJyqnBQ8NWg80sAbmv8dciM4+tuR
	 1siqANce+ZFihUcYumLa10EKG7pqCHQjR8g2erUEYz3UPJIXtrRuyX5RkWfSvl1OpD
	 mZwwEyQ3gmRcrA6zV47zu6ec7hNaXL38kBVwBJKTYX+y26TUP28QhxBspOZMrhhaDc
	 Dyt/kt/exWHSLqvJewILRQSJQndRzGHW9TdnkPVj/st+9SMIcoJ0M0qCymZkiYdDRO
	 1WOshSquJTDBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 79D32392447A;
	Mon, 19 Oct 2026 18:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179243461093.2802112.12319789885680768668.git-patchwork-summary@kernel.org>
Date: Mon, 19 Oct 2026 18:30:10 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: amd: fix len==0 underflow and FIFO overflow
  Submitter: Weibin Liu <liuwb@xiaopeng.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1185568/
  Lore link: https://lore.kernel.org/r/20261014-spi-amd-fifo-fix-v1-1-9fec9ab753e8@xiaopeng.com

Series: spi: axi-spi-engine: fix stale SYNC IRQ pending
  Submitter: Jonathan Santos <Jonathan.Santos@analog.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1180849/
  Lore link: https://lore.kernel.org/r/cover.1791361360.git.Jonathan.Santos@analog.com
    Patches: [v3,1/2] spi: axi-spi-engine: fix stale SYNC IRQ pending
             [v3,2/2] spi: axi-spi-engine: fix stale SYNC IRQ pending in trigger_enable

Series: spi: replace strcpy(), sprintf() and simple_strtoul() with strscpy(), snprintf() and kstrtoul()
  Submitter: Aayush Kumar <code@aayushk.dev>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1182465/
  Lore link: https://lore.kernel.org/r/20261009133609.579046-1-code@aayushk.dev
    Patches: [1/5] spi: butterfly: Use strscpy() instead of strcpy()
             [2/5] spi: lm70llp: Use strscpy() instead of strcpy()
             [3/5] spi: tle62x0: Use kstrtoul() instead of simple_strtoul()
             [4/5] spi: omap2-mcspi: Use snprintf() instead of sprintf()
             [5/5] spi: s3c64xx: Use snprintf() instead of sprintf()

Series: spi: use kstrtoul() and snprintf()
  Submitter: Aayush Kumar <code@aayushk.dev>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1182875/
  Lore link: https://lore.kernel.org/r/20261010083504.26261-1-code@aayushk.dev
    Patches: [v2,1/3] spi: tle62x0: Use kstrtoul() instead of simple_strtoul()
             [v2,2/3] spi: omap2-mcspi: Use snprintf() instead of sprintf()
             [v2,3/3] spi: s3c64xx: Use snprintf() instead of sprintf()

Series: spi: dw: use threaded interrupt
  Submitter: Jisheng Zhang <jszhang@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1179738/
  Lore link: https://lore.kernel.org/r/20261005151739.25233-1-jszhang@kernel.org
    Patches: [v5,1/4] spi: dw: remove useless dws->transfer_handler check
             [v5,2/4] spi: dw: remove duplicated "!rx_len && !tx_len" handling from dw_spi_irq
             [v5,3/4] spi: dw: restore previous irq handling behavior when !ctlr->cur_msg
             [v5,4/4] spi: dw: use threaded interrupt and optimize the threaded ISR

Patch: spi: dt-bindings: spi-qpic-snand: Add IPQ9650 compatible
  Submitter: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1187039/
  Lore link: https://lore.kernel.org/r/20261016-ipq9650_spi_nand-v1-1-d341a76559b1@oss.qualcomm.com

Patch: spi: jcore: fix divide-by-zero when speed_hz is zero
  Submitter: Weibin Liu <liuwb@xiaopeng.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1185658/
  Lore link: https://lore.kernel.org/r/20261014-spi-jcore-divzero-v1-1-a8205d30f2d1@xiaopeng.com

Series: spi: use sysfs_emit() in bcm63xx-hsspi and bcmbca-hsspi
  Submitter: Aayush Kumar <code@aayushk.dev>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1182466/
  Lore link: https://lore.kernel.org/r/20261009133631.579644-1-code@aayushk.dev
    Patches: [1/2] spi: bcm63xx-hsspi: Use sysfs_emit() instead of sprintf()
             [2/2] spi: bcmbca-hsspi: Use sysfs_emit() instead of sprintf()

Patch: [v3] spi: omap2-mcspi: handle DMA setup failures
  Submitter: Sahaj Chaudhari <sahaj123.sc@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1186159/
  Lore link: https://lore.kernel.org/r/20261015064341.1100422-1-sahaj123.sc@gmail.com

Patch: spi: npcm-fiu: limit UMA data_size to the 16-byte staging buffer
  Submitter: Weibin Liu <liuwb@xiaopeng.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1186047/
  Lore link: https://lore.kernel.org/r/20261015-npcm-fiu-uma-datasize-v1-1-7dee91cadee6@xiaopeng.com

Patch: spi: spi-qpic-snand: skip BBM copy on regular raw reads
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1179796/
  Lore link: https://lore.kernel.org/r/20261005-qpic-snand-skip-bbm-copy-v1-1-04f6aeda4044@gmail.com

Series: spi: cadence-xspi: two memory-safety fixes in the slave-DMA paths
  Submitter: Weibin Liu <liuwb@xiaopeng.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1175875/
  Lore link: https://lore.kernel.org/r/20260929081146.41041-1-liuwb@xiaopeng.com
    Patches: [1/2] spi: cadence-xspi: reject SDMA transfers larger than the requested length
             [2/2] spi: cadence-xspi: fix stack buffer overflow in the Marvell b0 path

Patch: [v2] spi: ch341: handle transfers without a TX or RX buffer
  Submitter: Weibin Liu <liuwb@xiaopeng.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1184386/
  Lore link: https://lore.kernel.org/r/20261013054339.77477-1-liuwb@xiaopeng.com

Patch: [v2] spi: cadence-qspi: Prevent SPI NAND continuous reads
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1177851/
  Lore link: https://lore.kernel.org/r/20261001-winbond-v7-0-rc1-cadence-cont-read-v2-1-703e040b2d07@bootlin.com

Patch: [v4] spi: tegra114: initialize native chip selects inactive
  Submitter: Abraham Zukor <abe@maticrobots.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1183099/
  Lore link: https://lore.kernel.org/r/20261010195503.623287-1-abe@maticrobots.com

Patch: [v2] spi: spi-pci1xxxx: quiesce DMA engines on transfer timeout
  Submitter: Weibin Liu <liuwb@xiaopeng.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1186850/
  Lore link: https://lore.kernel.org/r/20261016020036.1333548-1-liuwb@xiaopeng.com

Patch: spi: meson-spicc: fix invalid DMA unmap on mapping failure
  Submitter: Hongjian Dai <daihongjian@kylinsec.com.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1181623/
  Lore link: https://lore.kernel.org/r/35143466F2F5166F+20261008124704.87708-1-daihongjian@kylinsec.com.cn

Patch: [v2] spi: ljca: validate the response length before copying the data
  Submitter: Weibin Liu <liuwb@xiaopeng.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1184326/
  Lore link: https://lore.kernel.org/r/20261013031717.3933277-1-liuwb@xiaopeng.com

Series: spi: use devm_platform_ioremap_resource() in sh-hspi and jcore
  Submitter: Aayush Kumar <code@aayushk.dev>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1182458/
  Lore link: https://lore.kernel.org/r/20261009132421.557758-1-code@aayushk.dev
    Patches: [1/2] spi: sh-hspi: Use devm_platform_ioremap_resource()
             [2/2] spi: jcore: Use devm_platform_ioremap_resource()

Patch: spi: dw: Make dw_spi_update_config()
  Submitter: Jisheng Zhang <jszhang@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1183024/
  Lore link: https://lore.kernel.org/r/20261010151459.30560-1-jszhang@kernel.org

Patch: spi: bcm-qspi: reject oversized dummy bytes in mspi exec_mem_op
  Submitter: Weibin Liu <liuwb@xiaopeng.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1186051/
  Lore link: https://lore.kernel.org/r/20261015-bcm-qspi-dummy-bytes-v1-1-c319da3c2497@xiaopeng.com


Total patches: 34

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


