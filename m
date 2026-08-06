Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9003448BB7
	for <linux-spi@vger.kernel.org>; Thu,  6 Aug 2026 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026048; cv=none; b=fGmfbI4P1vRIjiSjHIhZnG/4OQSDcWtGeuHXom6dhdCOlcBZKm1ME5BE3WvzOh5Jx6zEiR5+wdaNXKd8DwaR2NeyAEZol5NxMbA+q5E6CwC07hjZrjCzRCiFc8iUe3BbAIZ0Uo+IEgiTJxUoCbC+Sgds+dTqycZO/QEYiEshhck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026048; c=relaxed/simple;
	bh=FOMcQqvgNRyMyZtuu66CLQAlf3J2CpThe1I+sSkcv4Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=HndgHtJErccmpd5+RWeLEemW/66NvMMLFheLZCTT5zVNuCuz0H5Tl7kgSsJPIlEu1JAjFdlyv6UvFlxOI3gqgTnQMIA0Y7DNWECyCjx5y2X5nRerm9v9PJFmLTbDUtSK1Ht/c4LyOaY2swfG/eGb3ubKVOiPOAdUe+XGjoQ+owY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRLktjD1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRLktjD1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915071F000E9;
	Thu,  6 Aug 2026 14:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786026047;
	bh=Klp7w2XB4JA2pKBuWik3biMUsWS3Gk6GpVBKpM/9M+g=;
	h=Subject:From:Date:To;
	b=dRLktjD1CZfSCr/OdEnu5jFObfyEZZbxrMcG7So7jaI51SE94ugHqk8AqhflVzJgo
	 Qv708bLjkZO1/KHjKdB+U9FSOB241/ub7b0pGZ0shQBCvJ8RmRNaqW7UyaQ53qIBih
	 6+SFvdE3VojM6jCRs4IdW2T3k9acVEp/ZbHI+vW+k2YJVuWMsN+M6bx9o/X6RvWivF
	 7N2uZEOIVylhXuG1ao1AvG3wUBF22mflTqb9jptyHr4l89fqtR72IAUjt8trXHeP+b
	 ZalRHDqPFSYM5dEgIJGOLBoeCc8uhSYUA355w/MEGybxaCwNtRgaJexZRvqz/NVGow
	 0qWD6vYz2ck/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C0AD380820D;
	Thu,  6 Aug 2026 14:20:08 +0000 (UTC)
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
 <178602600665.867505.3513828005115953094.git-patchwork-summary@kernel.org>
Date: Thu, 06 Aug 2026 14:20:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v4] spi: dt-bindings: snps,dw-apb-ssi: Document Axiado AX3005
  Submitter: Swark Yang <syang@axiado.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1141146
  Lore link: https://lore.kernel.org/r/20260805-upstrea-ax3005-spi-v4-v4-1-5b8bc11cb841@axiado.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


