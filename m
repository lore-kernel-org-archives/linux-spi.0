Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3276544E044
	for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121849; cv=none; b=eDoCJpSqQNZnu4mbNWh6aaD57V0qRBmdZFUjr71ne/gZovJBVmy6DoW+A97gKt8z4/uKlDqs/8/5vrIgDNUcEqbMZkgSTqhy42CK2yrj1a6Y5W9h5dl8v2p1dPyGPsfltB86uIVRaXWJGRx5HepdlJo5fOZmaUS6iISlumpGahs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121849; c=relaxed/simple;
	bh=nOuofC/YwpUgSXH/HXx1+MFsplQxpYiG1bHVXn3r4NY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=YwBbJQgaXAO54BnwNRwIJXXXn2Gg4iJo98C696gKopj58lor12PTRYJg7uV1kZMoZFJMT5UU82phxonxJNi6hqjlxh42U6s61vlxIsLUZzghhUqJjnyTfD5pNaJtq8lcc9Q2Op+LZO/I2xxvh/YMvq50Mz0rxONB/7R0vG2cYfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ouq/0Tfi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ouq/0Tfi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5106C2BCB7;
	Mon, 18 May 2026 16:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779121848;
	bh=nOuofC/YwpUgSXH/HXx1+MFsplQxpYiG1bHVXn3r4NY=;
	h=Subject:From:Date:To:From;
	b=Ouq/0TfiIuX1yifDbawmDNX+cIinzBEIt1YWWHrZPlheQZGILyo/d2phs5Dm+bxbs
	 7m8evhZOviVha4VgwSrPA6Iy4RpBiSgi6zXiIcOoqbLnKQ1d2dJQ7WPnu9rAegigm/
	 DIx6Q7exP6skLRIXSll9L6RDgxzkLNohSo9OxeXctFDosfQAkaRXM8RqYDWGO1A3NX
	 W11Rj7wxr4cMSq8/dn/lJvctR1BUpAO7ASr0TzsXzDYbeHieiPqXDQRu8mjq56GOA3
	 w2Jrh+IdoHb8NLDMAczHRsHEIewSV13G/Jm/M0B50yicioxc2lsvk7Q3Fk5fRjhk8R
	 v8IXxLDAFX6Og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9650F3930C93;
	Mon, 18 May 2026 16:31:01 +0000 (UTC)
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
 <177912186021.1470407.13891938262509954338.git-patchwork-summary@kernel.org>
Date: Mon, 18 May 2026 16:31:00 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: switch to managed controller allocation (part 3/3)
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1092889
  Lore link: https://lore.kernel.org/r/20260511150408.796155-1-johan@kernel.org
    Patches: [01/12] spi: altera-platform: switch to managed controller allocation
             [02/12] spi: armada-3700: switch to managed controller allocation
             [03/12] spi: clps711x: switch to managed controller allocation
             [04/12] spi: falcon: switch to managed controller allocation
             [05/12] spi: fsi: switch to managed controller allocation
             [06/12] spi: hisi-sfc-v3xx: switch to managed controller allocation
             [07/12] spi: jcore: switch to managed controller allocation
             [08/12] spi: lp8841-rtc: switch to managed controller allocation
             [09/12] spi: lp8841-rtc: drop unused ifdef
             [10/12] spi: meson-spifc: switch to managed controller allocation
             [11/12] spi: mux: switch to managed controller allocation
             [12/12] spi: xlp: switch to managed controller allocation


Total patches: 12

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


