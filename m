Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283575;
	b=vEveL82wE9yhH9zk8ubjWcKpbRq0TsJVJoMNiKKe8pQ9Uu2elNulYvLPZH4vXXPSZPro
	 cX+twVv2h+NX86RWCfd5Th2OfQ3gilfMHNlou6izfPW1P+8v0ziMi+FsV2eKgsYCM3nSH
	 9XtDm5MPurUZK8iQBBJag46zj6j8s1SiKpNO/e8GejUkBNOePvtEQw+m0XPrGuSwCpe3c
	 VQAuuv83zMQBiWMX1dHoY2kKYwrFKFr+2PPIz3tVxowQHuXGI5952yhw6jGdqzZFUYcuL
	 M3EYQSYpwa5wvtZ8t7N02DwQOs9XUtFIwX2Usj8SnK22tX8G7LYfUgifcUlsSToLwLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283575;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=oMWsE8z+NI95ag1a8pMiK+JThTtUpTSQBTpm5tADZoA=;
	b=SshjPOk2bo9VCSx3KlU3vmmDqO3PZsIiQ0Pj2EMNkjaBvXokpnNbiI64omoEmaSwhbxD
	 PBPJFdrp/LmRc5Ykm1WavJQuJHG2TSfuUTdWOgZy0xmNH/2Spe2ChMhJF7n1w+wdsPb1q
	 17cVbJvs6I83JKy9icjWooT+nKtuVMeUfizVWbZOFFX7lmfyn/uTRkoTKm8rUhSvvm2+W
	 IpoOCNlQ2RBCAnhy0RI77ZPy4kiZM5SXLddZA0e+JL3ApDP2X7PbgSwL3HxJJ4j8r70wh
	 8bEA7wkRi05bbzytvo0yIdJkvfKuv1ro+wy7tcendWipXUT2IXW9KkW5VPP8TOjhu5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+cQ+Kxi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ED9606A31C
	for <linux-spi@vger.kernel.org>; Tue, 10 Nov 2026 04:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+cQ+Kxi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3681F0089F;
	Tue, 10 Nov 2026 04:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794283575;
	bh=oMWsE8z+NI95ag1a8pMiK+JThTtUpTSQBTpm5tADZoA=;
	h=Subject:From:Date:To;
	b=H+cQ+Kxis+wgXGW4SNjt4i1Z34sUZgFLjuxFBtIjI2Si8gKEK56Fll15kfkMmGINo
	 dS7bgdGJQFSSDqqwKzrvoqDHlYU/VqojgvSOrTZeLpwDo0K//EBrCdemUeo5BjCeeP
	 HO4nucFreCY4oLHP6xVjhqqMKMjNUj0FJv22c+5DTKIi1T7bQXEorRajbDDfURAMGL
	 imqrPvSrpa2np52pkh1eNY1eiMylZav4ULZcDFvcJilv23AI/dHWjt6RZUK97HR4u1
	 SNOmGN48qhbWgo+h1hmYpOScIRYN7zFszwbs2PgiufxvIE5Cg4ISVdZuIcu/EvVy4I
	 IuXGKuE2ATVdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 21112391AFE9;
	Tue, 10 Nov 2026 04:06:15 +0000 (UTC)
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
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179428357369.3652848.2637980509574879281.git-patchwork-housekeeping@kernel.org>
Date: Tue, 10 Nov 2026 04:06:13 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v11] spi: cadence-quadspi: add PHY tuning support (2026-11-05T10:58:17)
  Superseding: [v10] spi: cadence-quadspi: add PHY tuning support (2026-09-29T06:35:10):
    [v10,01/19] spi: dt-bindings: add spi-max-post-config-frequency-hz property
    [v10,02/19] spi: dt-bindings: add spi-phy-pattern-partition property
    [v10,03/19] spi: parse spi-max-post-config-frequency-hz into post_config_max_speed_hz
    [v10,04/19] spi: spi-mem: teach spi_mem_adjust_op_freq() about post-config ops
    [v10,05/19] spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
    [v10,06/19] spi: cadence-quadspi: move cqspi_readdata_capture earlier
    [v10,07/19] spi: cadence-quadspi: add DQS support to read data capture
    [v10,08/19] spi: cadence-quadspi: add PHY tuning support
    [v10,09/19] spi: cadence-quadspi: skip DDR PHY tuning for 2-byte-address ops (i2383)
    [v10,10/19] spi: cadence-quadspi: refactor direct read path for PHY support
    [v10,11/19] spi: cadence-quadspi: enable PHY for direct reads
    [v10,12/19] spi: cadence-quadspi: enable PHY for indirect writes
    [v10,13/19] spi: cadence-quadspi: reprogram CS timing on every chip-select switch
    [v10,14/19] spi: cadence-quadspi: reprogram PHY DLL on runtime resume
    [v10,15/19] mtd: spinand: extract variant ranking logic into spinand_op_find_best_variant()
    [v10,16/19] mtd: spinand: negotiate optimal controller operating point before dirmap creation
    [v10,17/19] mtd: spi-nor: extract read op template construction into helper
    [v10,18/19] mtd: spi-nor: run controller optimization before dirmap creation
    [v10,19/19] mtd: spi-nor: reset max_read_op frequency for security register reads

Latest series: [v2] spi: intel: only check locked opmenu for SW sequencer operations (2026-11-08T20:37:28)
  Superseding: [v1] spi: intel: only check locked opmenu for SW sequencer operations (2026-11-01T20:03:13):
    spi: intel: only check locked opmenu for SW sequencer operations

Latest series: [v2] spi: use dmaengine_desc_set_callback() (2026-11-04T15:22:45)
  Superseding: [v1] spi: use dmaengine_desc_set_callback() (2026-11-02T17:39:58):
    [1/1] spi: use dmaengine_desc_set_callback()

Checked 212 series in 6.68 seconds.
This project currently has 16997 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

