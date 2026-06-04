Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ABE47ECF3
	for <linux-spi@vger.kernel.org>; Thu,  4 Jun 2026 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579209; cv=none; b=bkuNPXqz6JwlvthTvXfRO79+lmrVz4po2KMOgaHJL5Il2Cp51Cbjxz7jnmlDjLJxLb8V5dmrFB2xKeoHTDZj9gS1CNvIYfygo+G2jrqU5QKZhNGmerocEG7QF+g4kChplLzGkQkQtuYiOCcJSPt2S5YS9ImmA4Qp2L6Z1kO1dKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579209; c=relaxed/simple;
	bh=blqXaUSjyVrsb248QkLyZVqk6Ip7kbBZsL1QPemXVm4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mq0qGtFbmgdlO4BXHkW9nqW4y/LOUp+RFizPK6bZnuLuXOmfeiQcY/qZcfDWM2Ute2XkJATwcbSaSHv/PABAwiMYkD30SXeSWz81glcvEzEPE6NMiz3BZSgqGfqIEezaIR703GRLD6RvmmXuhjmA50g9L9dCc1IJXr3y9irNPh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpZ8jcAY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpZ8jcAY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA811F00893;
	Thu,  4 Jun 2026 13:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780579206;
	bh=DcGkIEjOMdva/pEtsQdNejPJui3tFhtp9Zq6jcl2R9E=;
	h=Subject:From:Date:To;
	b=GpZ8jcAYwh04U5GxQQTKi+6LfXPkB8QZTxNDkbFtecuA0f9FVJxwmXY62JqEh4UNM
	 qJrr1NaEewCLLxf5rpT7jjDFm9+zU+P3IbbJAdP+STOM+AWT5gdvsbBtRuXHPy1cxy
	 YH04g/flzveM3sg3LPAvvNvkRAEiI/hlfpsMeGHbODQuzEBB2u90ks2P2AJ3pnmxdP
	 H58VP2+Ab1T02rPZEJJvn05o4hbsYqd6fOAFdAQ/QTNfqgHa9FNKa85UCY3YwsAtgU
	 I7CUeTBdzGTl/WW12xfIjGNtcF4LdeCV7eiI7qQbXnuj/COva8y5Vvosulnf/oiDLM
	 4y7YvMqchwcsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A842393093E;
	Thu,  4 Jun 2026 13:20:08 +0000 (UTC)
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
 <178057920696.2423423.11261103607078300064.git-patchwork-summary@kernel.org>
Date: Thu, 04 Jun 2026 13:20:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v3] spi: cadence-xspi: Support 32bit and 64bit slave dma interface
  Submitter: Jisheng Zhang <jszhang@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1104921
  Lore link: https://lore.kernel.org/r/20260602235825.28614-1-jszhang@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


