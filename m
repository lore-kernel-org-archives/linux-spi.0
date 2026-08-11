Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA57B3655CE
	for <linux-spi@vger.kernel.org>; Tue, 11 Aug 2026 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474767; cv=none; b=hcL2nWN892p39ymx1nWn9Cf7gVJ0fjO6goe2jcLkot9GTRVMF/sYTWknCuRNGq5zgrQv4WdkPQgMLsJ/IJPRORzinR7w7iIMn92B9SmgboHkc+Ya3RNh+8fwI+mUglFeY1SjzVdSjPq7jegiG1rRNh1ZN3+ieYG6Kf07ErlKGj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474767; c=relaxed/simple;
	bh=6/prz4N11q5FG8ClVE2Kp1cMcv2Amfl/Vo1qiibWFJ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=PciBcB8U7NAASrIFycgvQrRlDF0bZZTUbTY/O9tn9yes/DQxcYw3SFVqK+ZY7aiOgXedYpSGVlxWc0SWc6uWhETLzjsv2unIDEfxy7tTByQgoIffQ3aZkWoqlrHjbrROdMUhgj+dL7Qf/POJVAvWc4NXSOp2SgXAsgijTFPjTIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVhSXd4w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVhSXd4w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630461F000E9;
	Tue, 11 Aug 2026 18:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786474766;
	bh=HQyXQTQXaJCgEg+DSi9sh/5e8pA1DitPdXvO3jy9evE=;
	h=Subject:From:Date:To;
	b=LVhSXd4w18ZgNbwxfgf/B9QxLwa7iRP7fjGOC0hJDNNi8DyGOBJYwEod6xXef4e4l
	 RV1ghSfPDk2VZCqmRp9kJzY5Kj8Mha+BwbHKUUB8YK28wPF6b/P33ByNm7X085IUYS
	 BzHhFTyZUqC4SHwb/2J0Q9F49SoVKpSEzPcMAgX16fFCeQqzKRHFmvro8w9Z15iLo8
	 aQDb0GhK/PvJtmsmSI+uVFpDhvpi5OMpa5JdtltZqa5nTDcVfzwq1tlk8CDMsWLnHn
	 JC8Z8wBWowMLX42pN8VBP/nDV0/0y/dG+PgUdGqiYyzzd/hSRTrVecT9U+MeHk3j7K
	 7WhWfWyrt4g3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 96438380820D;
	Tue, 11 Aug 2026 18:58:43 +0000 (UTC)
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
 <178647472209.1108737.5990792172467686927.git-patchwork-housekeeping@kernel.org>
Date: Tue, 11 Aug 2026 18:58:42 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v7] spi: cadence-quadspi: add PHY tuning support (2026-08-11T18:32:55)
  Superseding: [v6] spi: cadence-quadspi: add PHY tuning support (2026-07-23T11:02:02):
    [v6,01/17] spi: dt-bindings: add spi-max-post-config-frequency-hz property
    [v6,02/17] spi: dt-bindings: add spi-phy-pattern-partition property
    [v6,03/17] spi: parse spi-max-post-config-frequency-hz into post_config_max_speed_hz
    [v6,04/17] spi: spi-mem: teach spi_mem_adjust_op_freq() about post-config ops
    [v6,05/17] spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
    [v6,06/17] spi: cadence-quadspi: move cqspi_readdata_capture earlier
    [v6,07/17] spi: cadence-quadspi: add DQS support to read data capture
    [v6,08/17] spi: cadence-quadspi: add PHY tuning support
    [v6,09/17] spi: cadence-quadspi: skip DDR PHY tuning for 2-byte-address ops (i2383)
    [v6,10/17] spi: cadence-quadspi: refactor direct read path for PHY support
    [v6,11/17] spi: cadence-quadspi: enable PHY for direct reads
    [v6,12/17] spi: cadence-quadspi: enable PHY for indirect writes
    [v6,13/17] spi: cadence-quadspi: reprogram CS timing on every chip-select switch
    [v6,14/17] mtd: spinand: extract variant ranking logic into spinand_op_find_best_variant()
    [v6,15/17] mtd: spinand: negotiate optimal controller operating point before dirmap creation
    [v6,16/17] mtd: spi-nor: extract read op template construction into helper
    [v6,17/17] mtd: spi-nor: run controller optimization before dirmap creation


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

