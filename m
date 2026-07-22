Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0D8470E9C
	for <linux-spi@vger.kernel.org>; Wed, 22 Jul 2026 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784761128; cv=none; b=ELdc2f2/2c2olCYsDsGbh7q9Og9fZpaUYNQt487xDhhX0fFP9xLGOMNHWD0HkESOCV9jOLF8ntvqh3vmYNWaiPhxrdo5GHqruW2jzU1wKm7p6SGnoE/5MionHmgWJZkWEa7NGNf3W/mNgYrzJcbJ/iTzf7YrtxpQJzRS+iels8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784761128; c=relaxed/simple;
	bh=9RSn4NkggcGrvOP4g9rBCqhFxN7XX4eQHd1AX50+Jqs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Lfw07bGBbhDJfJ+W+09fzANAM0/5GzrOe6TiGmNxxQaCpVnZkmvcki1k0WJp03zqyVZxJStOa4MohMeFC5E9VLmSuLRMA5jB0uFEF05Z2qZgOd+GaeK5TvsX+w2m2x3PPxXOBYOABI1SFGU59a6SgzZ5/dx2d62yj/hZHX4WTxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ok+l8taK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ok+l8taK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1168C1F000E9;
	Wed, 22 Jul 2026 22:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784761127;
	bh=3bdg6ZVu2WMQ66DYcySAGaPrtJcU8Dnx1F8h/wQfHLQ=;
	h=Subject:From:Date:To;
	b=ok+l8taKnRe1HEvU+GD5zhvlpU7pUtTdJMLZOP7poFABzHY4uqJd/PIFdYzYlm0RQ
	 dFHdotLl9oVbMcTqw6q1XQ4oQGrjtvLO+4tfTscDjxZExYrrvjtg/2Q6Gjo2bsUapE
	 oaxgKXnV3yXNhatowALlsjJKq5z2ks4Br/Ulf8VlrpA66ijSQGk2JHq1PaXGbNUkfT
	 rc7AEdNOCwMkBqh45zbIirIyyq/MEI0HN7ODICdHDpLNJhLG0g1OCcI3zJnLR8Ki/f
	 XcVwVp3pASAkPUqIE9av93WG50KFgkjruvxF7biMsQc7FhnZvsnAMSmmpuCwoKuIyn
	 1mdlbr1cBRq/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D3BFE380CED9;
	Wed, 22 Jul 2026 22:58:16 +0000 (UTC)
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
 <178476109545.2052620.11231611005842608592.git-patchwork-housekeeping@kernel.org>
Date: Wed, 22 Jul 2026 22:58:15 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Add DMA support for i.MX94 and improve AHB read performance (2026-07-22T22:00:41)
  Superseding: [v2] Add DMA support for i.MX94 and improve AHB read performance (2026-07-21T21:01:41):
    [v2,1/3] spi: dt-bindings: nxp,imx94-xspi: add DMA properties
    [v2,2/3] spi: nxp-xspi: Improve AHB read performance with DMA
    [v2,3/3] arm64: dts: imx94-xspi: add the DMA channels


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

