Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE8B3D7D6D
	for <linux-spi@vger.kernel.org>; Tue, 20 Jan 2026 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768911005; cv=none; b=X/kGxmVRKQ9idsnhFjFJI9mKS/TiQAtMF+o8YIxEkDw2gXCNVo1AxupT/lyhTqPqm/aGz+cNLJeNIMDdu40Kc8Rvr5fUwv8HlpYmnAEufsCrGuKQTOV8V25MevrAIqC5YUPAs5z4SDVRLzi0xUGyAOQl+Z1kP5NXjJh0kMCcWt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768911005; c=relaxed/simple;
	bh=b1f9+nw290n3yDVjVrbwuQpkNA3wIyCjteRZ1SRMzKI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=E1bI/uYbLWgKlhOTizerAuZTAqK5T9DGbasA0iHz0lNfl4nNmmoFgaUdHD72d+LtPUJ9F9TOcc1SvFG73WhDnnQZu1xnure+soEdU1fgTdvlB8oDof0DWL7t/tS5eGhKyekiG545T5JsobMJSX/0MpsyPo7vWOTKUV6ZxhVV+BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhFSz7Ez; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhFSz7Ez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93E1C16AAE;
	Tue, 20 Jan 2026 12:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768911005;
	bh=b1f9+nw290n3yDVjVrbwuQpkNA3wIyCjteRZ1SRMzKI=;
	h=Subject:From:Date:To:From;
	b=PhFSz7Ezny7cAB18nrpR1j3X9N5gKrBn7vMjbTISo1YFGPDNtnw/5yuKvQ8RIgY04
	 QAQNR63lRhPFtO8xcrFLmt8FqqpCkcEnMpmxjpoa/lMmFEttFvwsDAY2St4J8C6e6I
	 IU5TfbegFKqs6ZeSs4c0qA0Np7JAjgBf1p9nK8U5fjJz4obKUI4o6c3cCJ40fVm8p/
	 2A2guhZwhUjIvMqGT7AayQm3xuxDErupgVr1DCgVIVpTllhgwgCGQ5eKXVBUre+1hP
	 aaC5Gu4fcLQvUgjAsnbA7i5nPPqSdsjKyoWcgEO6kLegubDDVutlosO5XECe5dxIdg
	 RiUnqz6q85j2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4145A38068DF;
	Tue, 20 Jan 2026 12:10:04 +0000 (UTC)
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
 <176891100268.764478.10081805561546537093.git-patchwork-summary@kernel.org>
Date: Tue, 20 Jan 2026 12:10:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: rockchip: Use plain request_irq()
  Submitter: Mark Brown <broonie@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1043349
  Lore link: https://lore.kernel.org/r/20260116-spi-rockchip-threaded-irq-v1-1-c45c3a5a38b1@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


