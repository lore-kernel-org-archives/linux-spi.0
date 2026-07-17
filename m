Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A54390992
	for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 18:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314724; cv=none; b=GjNvl6nI2SE371xCZ9+wesuXrxfyhzGkwZrutTplLPhw4HPf2wb4FKm8nbMDqMRZ9xeg5avgU7WjcteWzxrEB+eVcL7xIggAGlLpxDMz8rEKZ/6BjTgtSPg38d7bwmUgm3vbN7HFfW1UUdyCkkQypUDaULqE/nlXHSn9k3majj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314724; c=relaxed/simple;
	bh=B4JTQz8Gfa6dsKFARUG7LyStr4c8lDaoWA4IrzIPxZY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=VjPjR1ay82hDttE1Ha9GDfKRv4dt/aErgWkflUljl3O7LcbJRBmnWPykjDb/x7lG8iPCdEYANSDsLUgllljXKI0yvD9uV5i0z+PaAqRiSH70CsQudth1xgSvsOHXUOIsBgi3EW1zyMCgRf6bdAb11e2TmdaHzQHzmhehzCU86dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAeagTYC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAeagTYC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D611F000E9;
	Fri, 17 Jul 2026 18:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784314723;
	bh=rOLD4uy+2pElD5HBejH/YY+Tq61ISwIeZXj/usLctFk=;
	h=Subject:From:Date:To;
	b=mAeagTYCaUypIIg6j6SzkdEZbZSeNprgD7M+8sr8rYNjmpJWkaz6jXNqIC175T1St
	 fMMbmjpnJImW1dsKtnpjNSeZxO4xY8rpn3Af7NP3OV15yzquPba5V4/PBX+05CojvR
	 BHH9WFrSTRenQfEbt3CwnlWsYAFujvWcjiaZBZg9Wrd5R5pPqYwIDkkkjXQLuke+mD
	 1f52OVMmmdmnipug8T3YKG5B8Phmec7Vs1yYyGaeO4Fkkb7GBKMM9MmgiFrzUT5HNs
	 Mdcy8tpC8/cJPcN8toho25zKPoxh05iV+A5drKYlZHqWbviQMpFbb1KsX5Eo+OO2o7
	 hpJSOh3ALOVBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D30A8380CFE0;
	Fri, 17 Jul 2026 18:58:16 +0000 (UTC)
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
 <178431469526.1834672.1911710487038586514.git-patchwork-housekeeping@kernel.org>
Date: Fri, 17 Jul 2026 18:58:15 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: cadence-quadspi: add PHY tuning support (2026-07-17T18:50:59)
  Superseding: [v4] spi: cadence-quadspi: add PHY tuning support (2026-06-18T07:37:09):
    [v4,01/16] spi: dt-bindings: add spi-max-post-config-frequency property
    [v4,02/16] spi: dt-bindings: add spi-phy-pattern-partition property
    [v4,03/16] spi: parse spi-max-post-config-frequency into post_config_max_speed_hz
    [v4,04/16] spi: spi-mem: teach spi_mem_adjust_op_freq() about post-config ops
    [v4,05/16] spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
    [v4,06/16] spi: cadence-quadspi: move cqspi_readdata_capture earlier
    [v4,07/16] spi: cadence-quadspi: add DQS support to read data capture
    [v4,08/16] spi: cadence-quadspi: add PHY tuning support
    [v4,09/16] spi: cadence-quadspi: skip DDR PHY tuning for 2-byte-address ops (i2383)
    [v4,10/16] spi: cadence-quadspi: refactor direct read path for PHY support
    [v4,11/16] spi: cadence-quadspi: enable PHY for direct reads
    [v4,12/16] spi: cadence-quadspi: enable PHY for indirect writes
    [v4,13/16] mtd: spinand: extract variant ranking logic into spinand_op_find_best()
    [v4,14/16] mtd: spinand: negotiate optimal PHY operating point before dirmap creation
    [v4,15/16] mtd: spi-nor: extract read op template construction into helper
    [v4,16/16] mtd: spi-nor: run PHY tuning after init and update dirmap frequency


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

