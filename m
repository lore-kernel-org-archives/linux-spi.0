Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14951DDC28
	for <linux-spi@vger.kernel.org>; Fri, 30 Jan 2026 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793013; cv=none; b=JaSyycxAC50m+kYSOnh+b0DCyC+zhC9M6iYj17dfsXS+MJYr2k+WCmvgj2PnPmIouXPjczAEjgeWflQ0a1MXlwSAxyPJMjzW10IfU8wBDbcxb5m7aYk604Lgc29wCEbLZ579KQem+AzJj9yrSPsCFHVQvvMaQYmkdCxRKAufo3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793013; c=relaxed/simple;
	bh=o7ia+y2ZtRzUK22iVfl81lT7blKYArvsnUCBref7CF4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Ph5BY2GlsHlmk4+u2L6yGcLrS+QTEEjDdXKV3ywop0WkXAPN0heXothNwvLJ/5Aig81ui100gYZNyZavUeSLnOTbavswt4mUH0wYvLYPjnrEIg/nifLd1k6jp4aR7PCjEjpP1mJJnTH0EPJeaJ7z8aOv20roZwOOSBI6HHaeL0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQ1xSHfL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQ1xSHfL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3DEC4CEF7;
	Fri, 30 Jan 2026 17:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769793012;
	bh=o7ia+y2ZtRzUK22iVfl81lT7blKYArvsnUCBref7CF4=;
	h=Subject:From:Date:To:From;
	b=PQ1xSHfL2NYPvVJcISul2ANJEYrNEE9y4B0JujaXcvVj+bpwnW6y4XE0gxD+BTFCG
	 v+IUMWIKVzPM5inYAKlL9Rpdm3J+B1559B0UVb/UlPOoZepi03JUkLeRq7GS9NkOi4
	 XoHBBFbaH3oHCSXB2lzO5zvExWbdcYbsszWQ4zReksO2AMxXR3lPjhbotYZxYDF4e8
	 3GOmrH7eZFO4z/CIpkNe4+fhFvDfvQKzI6Ly0WL3XpBJGKkRMN2UctTUsLk/JBTPke
	 ma9agmk2tA62y0ZQ7g1WCEH3KGSTHom1rJqfW5hYLQjzsD9nG1q3Hf/RSECSPG+7aA
	 QpygQerWvaCPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 143EB380CFD5;
	Fri, 30 Jan 2026 17:10:06 +0000 (UTC)
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
 <176979300475.3449000.7430651081836041833.git-patchwork-summary@kernel.org>
Date: Fri, 30 Jan 2026 17:10:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: tegra-qspi: Fix race condition causing NULL pointer dereference and spurious IRQ
  Submitter: Breno Leitao <leitao@debian.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1047243
  Lore link: https://lore.kernel.org/r/20260126-tegra_xfer-v2-0-6d2115e4f387@debian.org
    Patches: [v2,1/6] spi: tegra210-quad: Return IRQ_HANDLED when timeout already processed transfer
             [v2,2/6] spi: tegra210-quad: Move curr_xfer read inside spinlock
             [v2,3/6] spi: tegra210-quad: Protect curr_xfer assignment in tegra_qspi_setup_transfer_one
             [v2,4/6] spi: tegra210-quad: Protect curr_xfer in tegra_qspi_combined_seq_xfer
             [v2,5/6] spi: tegra210-quad: Protect curr_xfer clearing in tegra_qspi_non_combined_seq_xfer
             [v2,6/6] spi: tegra210-quad: Protect curr_xfer check in IRQ handler


Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


