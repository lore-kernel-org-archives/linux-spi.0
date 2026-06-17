Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C806335DA6A
	for <linux-spi@vger.kernel.org>; Wed, 17 Jun 2026 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703011; cv=none; b=RfJ0UKSqW4xtbqIBHeriPl9BQ/virSPmuGxrg3I/RzwlC5rF0N8+7Jncb5C7EdxQt6VPkGilYkL6F+N4+gbwk3o5Rs37TfqPdKSAeaN+xwdupxbDyEKAaawOzEmvkANSWwgBFqFVAKbGrcbpaKa5N+cVzbftWq48SsLHscHAE6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703011; c=relaxed/simple;
	bh=LX8x+m+Xm9I9JVJFDgmnvPSjRdMeUTBbWoXPcVD+jGM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=dPKEuaJzUPZ7eBiJ6uF1X1U1rBGBvLPZkU1oe0STd6aHEbTbVEAGW389pn+LqmBX0sr1QcKJZNx5QiH8JtrHZEzskwrhaYxp2JISXfpUnNsfA76OUNR1DRKsSUeUA/WcUWlaQS82azOYtd2ZuKQaWEK+RdpI7aej/Qx2r1Pa9rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqOnztfy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqOnztfy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A311F000E9;
	Wed, 17 Jun 2026 13:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781703010;
	bh=F37OvisxlnjK3jCGDWVaiitFsxZ/Q3m1n3M+E+bujp0=;
	h=Subject:From:Date:To;
	b=oqOnztfy+ltGWAsZoxqiCko1XdrD/PnGfuct9AdCzNw7ZEj5qUSibdP12S8sZzWwQ
	 M/Eu/8bxPkxFlbnTHfHKLNfeV/iUheWAPUU2bLt7YzZ+RUQpVWF+bFGGmtR4Gr9upf
	 fotoQjkuPdk3jtD/6L/fewSmd4vd+izLkce7hAt6wFBQlFsqw64dZuhm1NHtO8+zti
	 uy5eN7e8yhIzHp/g/lXAOJ8EtVfWPSSCbzbUd0N9NOFtb/KzjUgjkDiqfjufLpCAsR
	 /l3DiMUgqAXP1SZl3T4U6ZtHfrJvwurD1HLWnRnlDJuuDoUYy1grF0EWADX/+Oqigo
	 14f6TUxLgzY9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44553930E21;
	Wed, 17 Jun 2026 13:30:05 +0000 (UTC)
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
 <178170300446.1621267.4050087278935878294.git-patchwork-summary@kernel.org>
Date: Wed, 17 Jun 2026 13:30:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: dw: fix wrong BAUDR setting after resume
  Submitter: Jisheng Zhang <jszhang@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1110363
  Lore link: https://lore.kernel.org/r/20260612002835.5240-1-jszhang@kernel.org

Patch: [v2] spi: uniphier: Fix completion initialization order before devm_request_irq()
  Submitter: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1112008
  Lore link: https://lore.kernel.org/r/20260616011223.201357-1-hayashi.kunihiko@socionext.com

Series: [v4,1/2] can: mcp251xfd: mcp251xfd: Cache and validate match data pointer in probe
  Submitter: guoqi0226 <guoqi0226@163.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1112210
  Lore link: https://lore.kernel.org/r/20260616103018.105612-2-guoqi0226@163.com
    Patches: [v4,1/2] can: mcp251xfd: mcp251xfd: Cache and validate match data pointer in probe
             [v4,2/2] spi: Add NULL check for spi_get_device_id() in spi_get_device_match_data()

Patch: [1/1] spi: Add NULL check for spi_get_device_id() in spi_get_device_match_data()
  Submitter: guoqi0226 <guoqi0226@163.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1112244
  Lore link: https://lore.kernel.org/r/20260616110221.110781-1-guoqi0226@163.com


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


