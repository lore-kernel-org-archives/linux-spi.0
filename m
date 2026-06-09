Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8618C3F39E0
	for <linux-spi@vger.kernel.org>; Tue,  9 Jun 2026 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994502; cv=none; b=rMivgJMdVal+5qMCzx6H8wMyzX6qLhy4EhDDIkm0MgvYm8XM65jMsiOM+Jn6CH9+li8c3AF/E5Grgc050m0+RuU8puoPZNhBiiaqEg4fzLg+ZajyM/4wCCrDetEgvBjuBD+LUcOIdIqMPbBQyoTSm8XZN/vWdnE9KCeYb7Oyg90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994502; c=relaxed/simple;
	bh=q72WJudwcJOO1TdKu6KDGnI6ixvnQssHLDuT5yD0eJ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Z0BPOnbQIgjAWpm1Ru56LtlCS4YhJ1kKTC437FgHZXqLN8fPl5v3+XPzPw+u+GNQ6ioNBT/rhjYJnF6P/ss2mZSjRWavgP4zyPTV7BfgpZvOFLDv9Sx5R3a70fzSq3O0nB8XeIlKNcxMFi+MLqr6dyiRxOKgF50KS2cy2VuXmSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qz/RIkJh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qz/RIkJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DCC1F00899;
	Tue,  9 Jun 2026 08:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780994496;
	bh=UFCS6t47D5PfHt/v7sjr9S6UuFuA5ZCcqChtM3VNghs=;
	h=Subject:From:Date:To;
	b=Qz/RIkJh0eutM8/PQ4eGfh8bQLL3Rh3i7Fo9TSTCVTdmFTh+euYmpmC6SeEgIwblw
	 iZM7VpvgB1TtonDUSdzFy1Ohg0WyuBfYnqG3bwgzRk0MOD4C2csifSSNJjWBxPMauW
	 yXgoOA7niUWvsFSKzrYYtZTK+hrWH4klarzCKHhQMKLC3mlwUM6ny11VuDkqWnM3Fy
	 qyABL8mXyG1+hoBpFZzgIWHPaMmkvvs+i/PSO8dSYuKu0Af3jyyupw3/oEkSZC8n9z
	 1gwaU+AK+GdX4/n7uFGIZ+L+ENnyS5WzNdecFGxbc6c4aKPAI0wopbneWKlS8vikHr
	 QLLZE2v7wrOaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5954B39301B9;
	Tue,  9 Jun 2026 08:41:36 +0000 (UTC)
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
 <178099449496.1885909.16275772454904936761.git-patchwork-summary@kernel.org>
Date: Tue, 09 Jun 2026 08:41:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: ep93xx: fix double-free of zeropage on DMA setup failure
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1102995
  Lore link: https://lore.kernel.org/r/20260529-ep93xx-v1-1-9185070ca1fc@gmail.com

Patch: spi: dw-pci: remove redundant pci_free_irq_vectors() calls
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1103071
  Lore link: https://lore.kernel.org/r/20260530-dw-pci-v1-1-5d2cf798b3c3@gmail.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


