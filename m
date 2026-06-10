Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420782D8795
	for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074672; cv=none; b=rgRKG+mnDror8CcLmNGNSV/7cXxdR54uSZLbmTleaN/tM4aQdAiN0LvEvS0MssOzRSgaq3NOHLv/iGnvbIhbG1lrlYurB9Jo768kaFkoePCaOcllv+J/WRX1PLqQbVP8U4r7nxIx5y/HXoZEowcr08mHmloQbG80++kyMcO+CtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074672; c=relaxed/simple;
	bh=D/tHdm8qXMW1FiOtYtnUPFcvw20f0TAn1bbOW5jOVo4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=bKiMPBsMnwKOsWRu+r2uuIvGRPyed5JSiuuOZBuATzv2O6R4Jozj6usxIy3OQz2Cq9aCqysO7/ooB/caDqb68u02A3/OKtCehW1hW7C1uST3o+8yWFm9a6EoyMsUFBj8IzLdjPad9e6GtXeHTaLCaul6NubS5joBsrSSDCNLMz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McfKc0zC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McfKc0zC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6D91F00893;
	Wed, 10 Jun 2026 06:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781074670;
	bh=jQO1ETPgA/HNMWLtWA/A7vzkcuhcS1H+6rDPDeN8OEY=;
	h=Subject:From:Date:To;
	b=McfKc0zCnxkoltec5nzrJvaOTEBIyu1Vsf2iqSigesiuYpIHsBLzBO6i1K5+sDYAb
	 PvBjGEWmiuWpVWiZkF/1YjvkogqBCSj4bZjIjhnYhFz6ab3DIcwA3owuK08oVoE7fk
	 pE4Rnwdvj/C64+SjJekcrX58OmkwpYro/8W87C7n3P+JHezNF5bCoGCiR5GzSnNl/J
	 d6b0u48HSZ/ZyHNmjhXwSqzySM6UsedJWS8wAexPLDPGvqaBrMr/OMPKS9VsH/AjVp
	 9rwiAzYNtRlQFnRxXBBOhSujav+eW2BUkarg47HX9Npbh2Iqp63I37ojRv1WFZY1QJ
	 4geyIKxWH6rhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198B43930A90;
	Wed, 10 Jun 2026 06:57:50 +0000 (UTC)
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
 <178107466875.2871364.2470628440753426169.git-patchwork-housekeeping@kernel.org>
Date: Wed, 10 Jun 2026 06:57:48 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: tegra210-quad: Improve interrupt handling for loaded systems (2026-06-10T06:24:02)
  Superseding: [v3] spi: tegra210-quad: Improve interrupt handling for loaded systems (2026-05-20T19:24:04):
    [v3,1/3] spi: tegra210-quad: Convert to hard IRQ with high-priority workqueue
    [v3,2/3] spi: tegra210-quad: Cache TRANS_STATUS in ISR for timeout handler
    [v3,3/3] spi: tegra210-quad: Process small PIO transfers in hard IRQ context


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

