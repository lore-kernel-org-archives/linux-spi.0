Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EE940963F
	for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208196; cv=none; b=cMBd5J/hFQ3r1xFrVehB1I4kyYf1YibNqUBgvwk7/pWWLEnlQ50YrykeIXtkS4NcsG/0NCDKZex1sWEfPLhOTcQdDbFqF0V1L1Ln105UNZe5acSjSKDgGfwhB2SJBqNTy9wKLghIR+astitzVdDnGSFOpE7KSUoXBJbpV4Aus+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208196; c=relaxed/simple;
	bh=FxpklD04qw10k6hlWFNj2nmhgS7O410uQb0fqxmd7rQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=FS5NFN8ofqVxhRPkjYhrFD+F7g8M0lhvxIZFc1E1R+h4aqsIVXoyVVx38jBBQadDrfEwJd41Uj3akaYWie7wNyzh7uw4Z1UJqkWzAuCon9ylpcO2m0BojXjGxd3ds1vQ8/Pyd31yeiGQHFUybGQkojrH/ylJb008yOR9uXN6x0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwTQzFxq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwTQzFxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0EAC2BCB3;
	Tue, 19 May 2026 16:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779208196;
	bh=FxpklD04qw10k6hlWFNj2nmhgS7O410uQb0fqxmd7rQ=;
	h=Subject:From:Date:To:From;
	b=LwTQzFxqueCl8LPe7zq4m5OUrM9VVA7PO5fUOyM6r3PkyNGv7d49K11Sl7iXcwRCU
	 l8y9huBH4qT2pUNKXjP5JRqIbNSz0DSn/EHtKm4zA5Z2D6ZukP/KDJR+qu8x6nsSfr
	 9iXIf+MY33oXYBmGklUG0U/lkkkPV3cy/U8gyYoGqewTI8WrXBFJneVOSLRc/+Nu0d
	 5mcZF2oE/Rt2bsS3wnLAILKBBnp0nMTJsa6++a6/vHpbOH3fAdcrMpnaW3qCaSpTst
	 jKTBhVJI939/jFxvW7F7wCczZWkNqI6ndYvEdqvtvKFAfbn4DPhOKNA/RYQJoPY4pb
	 Ih8rGu9vddgbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 963083930E32;
	Tue, 19 May 2026 16:30:08 +0000 (UTC)
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
 <177920820721.2797154.4400593013130603196.git-patchwork-summary@kernel.org>
Date: Tue, 19 May 2026 16:30:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add trace events for Qualcomm GENI SPI drivers
  Submitter: Praveen Talari <praveen.talari@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1096756
  Lore link: https://lore.kernel.org/r/20260518-add-tracepoints-for-qcom-geni-spi-v3-0-7928f6810a79@oss.qualcomm.com
    Patches: [v3,1/2] spi: qcom-geni: trace: Add trace events for Qualcomm GENI SPI
             [v3,2/2] spi: qcom-geni: Add trace events for Qualcomm GENI SPI driver


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


