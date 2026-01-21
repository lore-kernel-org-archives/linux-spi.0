Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2138D3446C4
	for <linux-spi@vger.kernel.org>; Wed, 21 Jan 2026 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769018189; cv=none; b=t2amsRxvsmNjtmFhCsBwVfQanNoxzcuwCuI6V1/ED/G//nETenbqU+fg9uRFTccogTmWHaAGyv4Ti3ITxFIik66yNixsnri4E+71LEGHOWDOnIrNNO0Ni88gU/YgC/UYU2QLkpkripBb8aMsxHnhfxEjTCwsHnX2L+pLDceiIlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769018189; c=relaxed/simple;
	bh=zdSwVYD8hH2PNdMjY+5H1HaBoxENW9d4HedyOi1blfY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=eO78vEWx8RYm/x3Cka4lFYrCU495s4RnLxLknN4MSeWrdSPPnxKCy8f/klodRjow5HuaANTBP2TRwqt+bR9tS5rEaia+yhDju31mPTExKVEdch7s8sPsKY0EXVpaH6DZU4EfN2YbSCLNCInM3witFr6rkLEQyJqU28tM9BKgrqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+vLjEhF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+vLjEhF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FEBC4CEF1;
	Wed, 21 Jan 2026 17:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769018188;
	bh=zdSwVYD8hH2PNdMjY+5H1HaBoxENW9d4HedyOi1blfY=;
	h=Subject:From:Date:To:From;
	b=R+vLjEhFMUKrsO8Tninor/2C43qOuzfXcQOUJq/MvekmUPqSGR4Ceq9UQBIx/DcOb
	 JxdXmm7ZM2rWs4j0AZKzBpx2aHGnXKKP4j/SkfR6d0s74JgN8Zdo/KpkEaEsTqiw8Y
	 BMXDooethOyUpEGYjxEXFHfaPD2Rkpgc8pvHg7fUiGCr2Lj779qT53nQH9xbmrC5rA
	 NoJFDViaT8rnwDEDsWRTDDZSiEi41xzyflPrH6dtndhA3s5dIaDam3KDu7WAMxjawJ
	 qeB1N/xkM82gNLQYhXg5awfrhLa5vECzGSNl4cIAJNIPeJGSWBDg5HI80PYxrm0d/U
	 5K2OY5dCCjKSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CB9743808200;
	Wed, 21 Jan 2026 17:56:26 +0000 (UTC)
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
 <176901818532.1392494.13217158155787642501.git-patchwork-housekeeping@kernel.org>
Date: Wed, 21 Jan 2026 17:56:25 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: cadence-qspi: Add Renesas RZ/N1 support (2026-01-21T17:04:56)
  Superseding: [v2] spi: cadence-qspi: Add Renesas RZ/N1 support (2026-01-15T09:24:51):
    [v2,01/13] spi: dt-bindings: cdns,qspi-nor: Add Renesas RZ/N1D400 to the list
    [v2,02/13] spi: cadence-qspi: Align definitions
    [v2,03/13] spi: cadence-qspi: Fix style and improve readability
    [v2,04/13] spi: cadence-qspi: Fix ORing style and alignments
    [v2,05/13] spi: cadence-qspi: Remove an useless operation
    [v2,06/13] spi: cadence-qspi: Make sure we filter out unsupported ops
    [v2,07/13] spi: cadence-qspi: Fix probe error path and remove
    [v2,08/13] spi: cadence-qspi: Try hard to disable the clocks
    [v2,09/13] spi: cadence-qspi: Kill cqspi_jh7110_clk_init
    [v2,10/13] spi: cadence-qspi: Add a flag for controllers without indirect access support
    [v2,11/13] spi: cadence-qspi: Make sure write protection is disabled
    [v2,12/13] spi: cadence-qspi: Add support for the Renesas RZ/N1 controller
    [v2,13/13] ARM: dts: r9a06g032: Describe the QSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

