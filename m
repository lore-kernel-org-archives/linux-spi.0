Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0962535028D
	for <linux-spi@vger.kernel.org>; Fri, 22 May 2026 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472202; cv=none; b=rp5aLHN7B0PkEqZX6oDPIMx001ai00bxgDgooSh/oq4ycXimwL6g1Jc8LcKedzka84vKY2CnXy8o6My77dbZGkUQQnQafRSz7ox4gDdy4CjO6pwnaK1OC00/oAxSfHy7vhj7MH435J84E/mvM//zn2JBNGBlKxneavfs3jJSTJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472202; c=relaxed/simple;
	bh=fAadQpNaGWWKeC91VgY/8ze+5Kn1mphtvV1QNXYPSbs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Vj4xjytV3wtL9cPVprqyScu/B7Z8TnjKj+/f+cZgAi+kesiyqeXMwjs5Gh9W+0U8zVpRcfSeqGxdWGp0oTtAiY9pTuv0p7BUakft+0y+Wiu3Cz14jgdUctFLFBv9gtU6B/K1DZqPXUkgA+mQuu2yjWgbrkso0QDud4p1AIehyU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3rFQ3uP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3rFQ3uP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25A11F000E9;
	Fri, 22 May 2026 17:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779472200;
	bh=baO2GmwwyCQVQxV8eOIz5NvCa3UjEQVlSn5lbXfCyvA=;
	h=Subject:From:Date:To;
	b=M3rFQ3uP+87i2SJGqE+3rj8GfZVOyJNe1y+2QN0o35xbMeIrtweSNRb+8uZ1asPcJ
	 /zOZWUEk4jsqATnYRxaDLjr36Dqr1Ff5he7XT4HqX7TXCnYZW/eKsSh4QzHYSoqt1+
	 qgdnDmpLiCmrdd+cU14bx3ZPKDt0aUV/ukSAxmwly/0wnzLu3Jbh37c8WKUSI3EumY
	 XV6/zCLCDd2NMP7mxlTGjZBuBX/QLH52sl8cmqLl8on0shcE6cvuZe6b2z4k6NhLC4
	 I80gDnkjIUdrAs9G5uo59tp/iSO7JwOJ7AGqNWl/WrUILZN1Qgk9ay0v7I6Ee9wuEx
	 JjuU6HOKvEu3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C3043930FB1;
	Fri, 22 May 2026 17:50:11 +0000 (UTC)
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
 <177947220969.1310362.4573917224474397554.git-patchwork-summary@kernel.org>
Date: Fri, 22 May 2026 17:50:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: aspeed: Fix __iomem annotation and VLA parameter
  Submitter: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1099183
  Lore link: https://lore.kernel.org/r/20260522071621.102507-1-chin-ting_kuo@aspeedtech.com
    Patches: [v2,1/2] spi: aspeed: Fix missing __iomem annotation in output transfer path
             [v2,2/2] spi: aspeed: Replace VLA parameter with flat pointer in calibration helper

Patch: [v1] spi: Use named initializers for arrays of i2c_device_data
  Submitter: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1096760
  Lore link: https://lore.kernel.org/r/20260518170542.807843-2-u.kleine-koenig@baylibre.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


