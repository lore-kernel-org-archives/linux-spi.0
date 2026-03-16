Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766251C862D
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 02:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773626601; cv=none; b=VraOQ1KNEk8BSwGcuUCUeSobfxisBxj5bT7a1CVMO9vc3sownvcrnb6oaPzB8429DpXOUgNZGoAUFiIinIRUevygI78jhQAOw7aXB8/r821jd5WnfOLrqwUwuQeJZeKBffsNxKmlV23wUkLUU2znIhiuFRfoRh0Xfi3ucGPPnv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773626601; c=relaxed/simple;
	bh=15jSuk/oVaROaSjffuIi3IM4HN88wfUO7l2Qi3dmopI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=oEQ8696hrjvvtEIU0v0rvqJZ9Otb7vDUVfFvhY4pbNqixEQQFoJZ4r6qkUzhdAm28X6F6WHT4DCZuO4DDqFGEHMTg3vs6736eV+zD4jOxqrfMgUx0U+V6h25aG3jf1GYDbtjCgrIvF3vAoQRUQu8SvTy3S/ffmHpGGyR7EZwHSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOboWtjg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOboWtjg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1021CC4CEF7;
	Mon, 16 Mar 2026 02:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773626601;
	bh=15jSuk/oVaROaSjffuIi3IM4HN88wfUO7l2Qi3dmopI=;
	h=Subject:From:Date:To:From;
	b=DOboWtjgrIcXNGCo0Lco7ONvBNQ/EY1d/+7cnvW02/szQUWKuoNEn9QqE1JWNYTsK
	 3UmVRts0V9P2vf50u4Pe3zOka9O2ce7QdjjydZagcpHosh3XlRvhq/YSwC08ZJpBBX
	 mTpjEEowW15CTbujDXtT3CJaj7WQxRW3EMCxftII7ewUs+lMGoZxyOQ3oZnhc4wtwf
	 h+mqOnda1lKZvXdsWZpFsqlqUXr4yFgGWyykOdQx5ZuA1QobhTRQHeCTcnefkdy+19
	 8ZcH1kQnwp81tcMeLOJlSrsDSfiRG1G+wiQK2tvbTnuXkLQu2156aRK5hDloXS5hqV
	 yk7PAMAdeCySw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7FD423808200;
	Mon, 16 Mar 2026 02:03:15 +0000 (UTC)
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
 <177362659393.2457382.8121764160361276275.git-patchwork-summary@kernel.org>
Date: Mon, 16 Mar 2026 02:03:13 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [GIT,PULL] SPI fixes for v7.0-rc3
  Submitter: Mark Brown <broonie@kernel.org>
  Committer: Linus Torvalds <torvalds@linux-foundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1066495
  Lore link: https://lore.kernel.org/r/6c3c2037d9b46f47a5e3416071f0ffea@kernel.org

Patch: spi: axiado: Fix double-free in ax_spi_probe()
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1059670
  Lore link: https://lore.kernel.org/r/20260302-axiado-v1-1-1132819f1cb7@gmail.com

Patch: spi: amlogic: spifc-a4: Remove redundant clock cleanup
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1063229
  Lore link: https://lore.kernel.org/r/20260308-spifc-a4-1-v1-1-77e286c26832@gmail.com

Patch: spi: amlogic-spisg: Fix memory leak in aml_spisg_probe()
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1063176
  Lore link: https://lore.kernel.org/r/20260308-spisg-v1-1-2cace5cafc24@gmail.com


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


