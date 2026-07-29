Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4893793D2
	for <linux-spi@vger.kernel.org>; Wed, 29 Jul 2026 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330649; cv=none; b=fENn8GJz9nl9+ZAbZbxVVPSyDalCSEX1ibnHH5NNvgzK3Dd+y9mA2SDN/6UC0uwTbO67X2y1FZ9gme2/iS6ufWfoOE/2Fzl9CdHmfSV0kTeyF1SgTLmyytrQwnQr/Alf8tzp1XItxhGTM7Zo8Ztnf0yHKogy6NVmA0m/MwQi29Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330649; c=relaxed/simple;
	bh=jT12NVjn6AnHn6v50Tfc3tNX7tnKAi8+M3pG8mnrzf4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=pIBlhg7hP0CwijadX2OsqbcLkv+Zv6etzPASKac2ItDC5kQdlwyjqJ/ej+JnVyhmh9YjwXrprlMcUXfsx7MWT+x5B6Jb0mtFjoF/lKNxf62BWA6Oqu/O5TWGWtQ5JRPMUnO5ALpCr8f1/XNd20OlwwprA9fJTkC3nLaEL4ViDss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGZOpscI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGZOpscI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AC81F000E9;
	Wed, 29 Jul 2026 13:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785330648;
	bh=bOsILpQYlHcve4422fw8BldxnjicT6mDtGqsUUBMCXg=;
	h=Subject:From:Date:To;
	b=JGZOpscIRCrAWHwRK0IQEFLedG80IbLmolheAuRgmwyOvTBDNrM3moFdRF7rKtRXv
	 SHuW2Clp072pkIAGZiCjRMJqfTqK0DVN5hLFKzFLs9yiA1inQcuNjTmZWSBWUbPPzO
	 YZUhUrnyqyoYAL5s7AspPMuDTvr1jerr6MG3R8YBQFAXfrm+AInd2nBPXQyvZ5+IhT
	 Iodd3Ws3YIwM9DlXGKuWfaPsY2njmqhvfiiiHTGO3HbtiSQAlptvc+pjKvKnuH614Y
	 7IClYjZYh3BdlgTmbtgyrs2NKxq50RtsWZ830Hp1M6pfIR1tiLluQvvOw7zdP6W8bg
	 QcrKNDH2v9htg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9650E39253C5;
	Wed, 29 Jul 2026 13:10:13 +0000 (UTC)
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
 <178533061215.2638258.8981416222544182747.git-patchwork-summary@kernel.org>
Date: Wed, 29 Jul 2026 13:10:12 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-qpic-snand: write the feature value before executing SET_FEATURE
  Submitter: Stanislaw Pal <kuncy7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1135286
  Lore link: https://lore.kernel.org/r/20260727163216.109938-1-kuncy7@gmail.com

Series: fix and cleanup in spi-spacemit-k1
  Submitter: Pei Xiao <xiaopei01@kylinos.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1130559
  Lore link: https://lore.kernel.org/r/cover.1784527556.git.xiaopei01@kylinos.cn
    Patches: [1/2] spi: spacemit: fix dangling TX DMA descriptor on RX prep failure
             [2/2] spi: spacemit: drop redundant dev_err_probe() around irq helpers


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


