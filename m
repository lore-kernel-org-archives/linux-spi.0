Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B779A3B2FD4
	for <linux-spi@vger.kernel.org>; Wed,  8 Jul 2026 01:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783475897; cv=none; b=iA94g8rttrANaHCe7d5dndgU34eM6j3tVKDCGl92+LOlb3R2KAA30ltdGp+kz/HB9/TJ43d3tJA40Ky2E4RhZZJNO/xcQqUKW/Z/sFyST3pyFewfOnzujtYqqkR1qFYqxv/CTUl5+v+DV3MjQAWMws8VVWFqGHMVI54hedVIl+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783475897; c=relaxed/simple;
	bh=JKeq9ZPYWXf3Vku8CrfBha6Iq7n9qC/Sz4wVzh1FdA0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Z+1ZTKRCpBwo7QXgYKzUs3yjnyfbheASpaETdUFwGvUpByvaG7cOb86JnHF5kkLiPVL+g4Du2UE8N1lf+SHxXPmR/aGYbpJRHtFz7j6qwWwcHAjJQgwb4LC7miz6AtTngy3U8Y5xjrnxd1v4wmhZubcRda0AJ2f65wGua+O/HnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7X7l/q+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7X7l/q+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6991F000E9;
	Wed,  8 Jul 2026 01:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783475896;
	bh=Ct1uxMEvzBMOoWofD6WHgh1fyNW8kJsEs7JSnM+IYSs=;
	h=Subject:From:Date:To;
	b=I7X7l/q+VGn4KFe7GS97rRaLZPnA6eBFL+eVsmTUTnBkBbqtNo4OphT6R/87d9UeX
	 nOTBg4JRdwSZPumDTqr2vCOehq7RFMQAWOKcW1Ujd/t+kHxX3wjP76knbon9jyMhWE
	 oejFatCmsmj55gMVdlX7qdOB7kxc88sVktYUzLrVoC002L6GyugkuFnlsoFt6HhqXe
	 6auDeMs4XpE8dvqJ8u7OJRFryf21XjQDuovmTM9+8sQFxA9jVh5cmmssfL6WzW31Wr
	 qoRLE20WGKNs+W0rofDutFD2QSPVSfyplpwBUPpRwt10Ma+mTFiZ+lWeHCVaGRCrmZ
	 dwdueULHhQYww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C450392546D;
	Wed,  8 Jul 2026 01:57:57 +0000 (UTC)
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
 <178347587555.2244446.13926197846845082242.git-patchwork-housekeeping@kernel.org>
Date: Wed, 08 Jul 2026 01:57:55 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: tegra210-quad: Improve interrupt handling for loaded systems (2026-07-08T01:12:55)
  Superseding: [v4] spi: tegra210-quad: Improve interrupt handling for loaded systems (2026-06-10T06:24:02):
    [v4,1/3] spi: tegra210-quad: Convert to hard IRQ with high-priority workqueue
    [v4,2/3] spi: tegra210-quad: Cache TRANS_STATUS in ISR for timeout handler
    [v4,3/3] spi: tegra210-quad: Process small PIO transfers in hard IRQ context


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

