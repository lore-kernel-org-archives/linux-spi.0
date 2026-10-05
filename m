Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4208480DEB
	for <linux-spi@vger.kernel.org>; Mon,  5 Oct 2026 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206423; cv=none; b=CxL94xCdbR7wycgQzq64aMO/zA6GUKdSn428xTi1B0NC2iptJaGuIrGDL0HwGphu2VNMJ6hRXsPk0ZC9vtE4TmVvUP+XusV4ZmrBvPt3MZj1Lhet6664k5UEPtPu4UrFbZ5aHk4/ZEXvR48WprqC0QlagQei1LwlRdim9VYU0o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206423; c=relaxed/simple;
	bh=GY+07Pu+oB7gJ0fA6if2urfNLl0Ebfijq4m5Ija65bI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=qU3xt+gdOY5pWcIMzgp8mVpdIKy23l9R/LEJgIYpdHj02ecAXfT6vVUv+StRYEHWXKaJTqGTdTr9zDrBjEUVb2BT5Uj7oqQkCoqEw6LDQUoYRQ47t5O7+9ORljvmwVXYUXIESm9hehi4WUGVLuEI70NNytMnYf46eiEVFx1n0EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCDCLo7w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCDCLo7w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04AD1F00898;
	Mon,  5 Oct 2026 13:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791206406;
	bh=QzXuTdskCiU29Z1uCxsluI4mNRNo2ZIAmOgcUdAtGz0=;
	h=Subject:From:Date:To;
	b=JCDCLo7w9IKc726Q6f3v0iYgj9SIcynUQgYfBIewAajd911A21/sW0+SBTIcpLqYh
	 J9oh0MK0Y/OeF9xZTMT47ZAh4OdFuVh74rnLe5lZPg1nDpk2bpNjwIOLentHfkJwCy
	 /n0EtpKuOM5kR+AFQvhkMvPaY3r2Z39tY8mzmOaK99+6ZATlxItkcFk2CR5XazvxzC
	 CnP7TlsKdbjvM+yaMR+OMQTC+w73sLOL9r8C4mMSAekXxhuH3l6jJstCncgvbd0Q38
	 +oCy7q/ZpUTdAt/3xtjfyuODLuC2hrcf3MJw7l8eRVERVbbR5y+a7B4jCMjrk1j3He
	 g4yKMgSRFgdVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 79E0E392627A;
	Mon,  5 Oct 2026 13:20:06 +0000 (UTC)
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
 <179120640503.1721199.18083774917661938716.git-patchwork-summary@kernel.org>
Date: Mon, 05 Oct 2026 13:20:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: balance remove-path teardown in three drivers
  Submitter: Guangshuo Li <lgs201920130244@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1173054/
  Lore link: https://lore.kernel.org/r/20260924112329.1566051-1-lgs201920130244@gmail.com
    Patches: [1/3] spi: fsl: unmap immr_spi_cs on remove
             [3/3] spi: bcm63xx-hsspi: Disable runtime PM on remove

Series: spi: Add Nuvoton MA35D1 SPI controller support
  Submitter: Chi-Wen Weng <cwweng.linux@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1177684/
  Lore link: https://lore.kernel.org/r/20261001131818.110028-1-cwweng.linux@gmail.com
    Patches: [v2,1/3] spi: dt-bindings: nuvoton,ma35d1-qspi: Add MA35D1 SPI controller
             [v2,2/3] spi: ma35d1: Add Nuvoton MA35D1 SPI controller support
             [v2,3/3] spi: ma35d1-qspi: Add GPIO chip select support

Patch: [v5] spi: dt-bindings: ti,davinci-spi: Convert to DT schema
  Submitter: Bhargav Joshi <j.bhargav.u@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1172620/
  Lore link: https://lore.kernel.org/r/20260924-ti-davinci-spi-v5-1-ed811dc6cd89@gmail.com


Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


