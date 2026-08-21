Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939C447A0B0
	for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 11:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787313518; cv=none; b=uUIH33bHQVmvz0rtDhz9L1tUoFu1bXvFkKVMLAJXJTreozw7OhBTTXkF7OzpNywSKEeeIbDTQ/RI2xvTRJQiQJHO5kG1wAvoEbEYW/8JRvhp3o7Y2Wtimk6TJoX+ViwEcDYQz9FpJp1T7FkLnYsjHue3cbsnucOaIo7FWR5Dloo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787313518; c=relaxed/simple;
	bh=gnlGm72B0xlZwg2XwGZ3sDU5/ecYkiUq/iH26jxI8qc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ehikV9zocHNnPbi10PvDdXntym+apKABDfsZMaA3b2jZpZK4VD36xBWTTOnk2BdbZupWNX8n0HNBGMw6EzfIwnAZUeexuAwZdhliXE0eYYFF5NNaDRUBi1p8PRlqBMUEplY2U7gcuuowqI5Dg62P5GKue5ZEoULLgk1ngrdkjis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZC+sRA1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZC+sRA1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDA01F000E9;
	Fri, 21 Aug 2026 11:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787313512;
	bh=Eth0X3bxJMbRQNpFKFNCYN2Iuh5Ls80zMDoMnHNOdr8=;
	h=Subject:From:Date:To;
	b=QZC+sRA1S7InM4TNqEZ4cS2aqcS3bRjlGhqMvXzbugs16vFxDyYPdMCcM4f82sXgr
	 LakZwnEt98SOfAgYVXtODVG5w0XXrWLjfh0kndQaah04X4duyAE5RFbjSSX9tcTpQF
	 8xJW4FtBqPRjgEbhMXz5/ze6aVnvGmUv0+JfiKkV8i5Zuqr14LRco6Z5nvmb5WkmhU
	 wT7Kh2uoDtmGilvceVyewak8dliUM3X1zmB7clD/tmkqQ93feF1Z741i6R5lXpMBvu
	 sVFuwIfDD/QGCzS8Mm+Fg9s1Q+HtXn7BsTbnVJzsV9fZxgugZub6Fmzxahb2O2hoeJ
	 +Q3crfsH315qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A133809A19;
	Fri, 21 Aug 2026 11:57:43 +0000 (UTC)
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
 <178731346212.807739.12960059056421939811.git-patchwork-housekeeping@kernel.org>
Date: Fri, 21 Aug 2026 11:57:42 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v8] spi: cadence-quadspi: add PHY tuning support (2026-08-21T11:48:04)
  Superseding: [v7] spi: cadence-quadspi: add PHY tuning support (2026-08-11T18:32:55):
    [v7,01/18] spi: dt-bindings: add spi-max-post-config-frequency-hz property
    [v7,02/18] spi: dt-bindings: add spi-phy-pattern-partition property
    [v7,03/18] spi: parse spi-max-post-config-frequency-hz into post_config_max_speed_hz
    [v7,04/18] spi: spi-mem: teach spi_mem_adjust_op_freq() about post-config ops
    [v7,05/18] spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
    [v7,06/18] spi: cadence-quadspi: move cqspi_readdata_capture earlier
    [v7,07/18] spi: cadence-quadspi: add DQS support to read data capture
    [v7,08/18] spi: cadence-quadspi: add PHY tuning support
    [v7,09/18] spi: cadence-quadspi: skip DDR PHY tuning for 2-byte-address ops (i2383)
    [v7,10/18] spi: cadence-quadspi: refactor direct read path for PHY support
    [v7,11/18] spi: cadence-quadspi: enable PHY for direct reads
    [v7,12/18] spi: cadence-quadspi: enable PHY for indirect writes
    [v7,13/18] spi: cadence-quadspi: reprogram CS timing on every chip-select switch
    [v7,14/18] spi: cadence-quadspi: reprogram PHY DLL on runtime resume
    [v7,15/18] mtd: spinand: extract variant ranking logic into spinand_op_find_best_variant()
    [v7,16/18] mtd: spinand: negotiate optimal controller operating point before dirmap creation
    [v7,17/18] mtd: spi-nor: extract read op template construction into helper
    [v7,18/18] mtd: spi-nor: run controller optimization before dirmap creation

Checked 162 series in 4.76 seconds.
This project currently has 16358 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

