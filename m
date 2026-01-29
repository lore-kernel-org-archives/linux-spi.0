Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1151621CC62
	for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769685617; cv=none; b=Hz/RvMZoV1CQxrv6/ErTXvlLyjV2Z5V3HcfFHdJDjaVMa0XGUHc1skcXKfyYLYusjhuE6wrmYoTN/xmxTts5E6ukpxUklOygKkgNgZ+oEbirjcwcXYf9QusqEijGPshU81AVyq+74YNEgmNk1claHhFPVjw1R4c2Aybj/0X1GFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769685617; c=relaxed/simple;
	bh=9U+ru9HwNJqYWcINoCJctERIm8sxpaid7wmJbEfaun4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Mnmc9BjuCRiniBkgOi3+KcKKIbrw8SVk8B7VYpqIjTr0DyCr4DnxMcyzGZxbl9WQE0YPeFzAcQlgIsd32/VaDS4rgkS/uUL22zopkZBNI2+2wlFzCGuKIY0e+D0/e6GcLgAmqGZTpeRMoKxoh82D5bDQfSAaTwg7Q9s5ClmLplE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V96SaJLx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V96SaJLx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE75C116D0;
	Thu, 29 Jan 2026 11:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769685616;
	bh=9U+ru9HwNJqYWcINoCJctERIm8sxpaid7wmJbEfaun4=;
	h=Subject:From:Date:To:From;
	b=V96SaJLxC6eELe5Bo3CjfxZcb1EJStMfHlV9XNKDwMf4cZLGmIUBt33nkqQUanGAI
	 pdk0DilJaeIjfZAkNuhVkSCpGmRPVO2xC3uyl7NX/1spxhwLEVVgtIPqJHW2K9mwS2
	 Tsa1jKJAH8HFOUlvW9/R4PDADJCNZIGdP7dkpFiHe1ARJOT+GfaOkabxp+lw2otI3b
	 DvoDwLApKidd+nO2jw3iO/AyRs4ZksV4L3WHFIY0Xf4ZFNxMd1muQJ5yfyOSeLoyz7
	 FE6JHeIvbDQHipmjC608rj0j0I48HC89qoznQAbKB4AT2jcBEuQGrTbiY9/EHSH1N4
	 OL9Tr6aQOG6HA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CBB1A380AAF2;
	Thu, 29 Jan 2026 11:20:10 +0000 (UTC)
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
 <176968560933.2467428.17474354478968795657.git-patchwork-summary@kernel.org>
Date: Thu, 29 Jan 2026 11:20:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: cadence-qspi: Add Renesas RZ/N1 support
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1045722
  Lore link: https://lore.kernel.org/r/20260122-schneider-6-19-rc1-qspi-v4-0-f9c21419a3e6@bootlin.com
    Patches: [v4,01/15] spi: dt-bindings: cdns,qspi-nor: Drop label in example
             [v4,03/15] spi: cadence-qspi: Align definitions
             [v4,04/15] spi: cadence-qspi: Fix style and improve readability
             [v4,05/15] spi: cadence-qspi: Fix ORing style and alignments
             [v4,06/15] spi: cadence-qspi: Remove an useless operation
             [v4,07/15] spi: cadence-qspi: Make sure we filter out unsupported ops
             [v4,08/15] spi: cadence-qspi: Fix probe error path and remove
             [v4,09/15] spi: cadence-qspi: Try hard to disable the clocks
             [v4,11/15] spi: cadence-qspi: Add a flag for controllers without indirect access support
             [v4,12/15] spi: cadence-qspi: Make sure write protection is disabled
             [v4,13/15] spi: cadence-qspi: Use a default value for cdns,fifo-width


Total patches: 11

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


