Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596283F9263
	for <linux-spi@vger.kernel.org>; Fri, 18 Sep 2026 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724474; cv=none; b=IYdkiDctDZPamq/86v76Bw88FtSi12p9qaW+FtbmHx6tcn6iJg5m+AD4qfEqr7cnsOiamtw6wumM3/rx5LHiuD1bf1k/pdCtJWSKGMjP4OBEpQ4ObK0M2G1RfMSQlJD3AZRS9uSeoteb5pPo5MAdXXG7IZPh7U0gBtqR2TOyhr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724474; c=relaxed/simple;
	bh=niJSnSDQikOgHLNrzDFOfAG8mzRpQ66IrJF3PqAmogc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=BzRg4lloPabGwvqPE3br8JyKNmw+ikLWJQ6p9o+c5iKFNuIHd4+F83JZLg2TU9sDPIda03wcjKeVHpodBycltvpCUnH3qnyW71cGD2W/E8RWINxbnkFDxhDBhhonu21tAq4vEe3aY81aYSUXkEW80hEr2strinrRvcIRpzJdxCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOmZTZNp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOmZTZNp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407C21F000FF;
	Fri, 18 Sep 2026 09:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789724473;
	bh=g/MHCsRcy4kkI8K6qzXRVx4OtyWt64mq8qGxQ3Hb5y8=;
	h=Subject:From:Date:To;
	b=OOmZTZNpvnm8xPZU1t+XFKoor9sG7bDMmJtZGc+wI+QfgBfm9reG65JqfdVC5OqYm
	 rMp1UJEfKbtTON1SvFNFqd7l4T40tbaafcbEX39agUoDW3zC/Lib4GxC6COT6rXnaj
	 wdjwxq7FuZ8B8xZdr8Kx4bMWmJ1pbQnQoSOo6MQ16Fd47/zwFDma3b8h+9kVQywWMM
	 KjC3IoWfFuGji1tSk6mXih+FyRV5ZUqjyFm5EDDxaeBXNbNBSTkxU6XynTjrFD6yrd
	 qDzLrzgYlWIdxQfzY4xnI5mMJmufYC3467qNks/66VYyRpxrMnLJBY4QD0Qo/BNiN1
	 ZxV+JL0JghtWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9612D380A94D;
	Fri, 18 Sep 2026 09:40:07 +0000 (UTC)
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
 <178972440618.386031.11834567480603910124.git-patchwork-summary@kernel.org>
Date: Fri, 18 Sep 2026 09:40:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: virtio: fix max frequency setting plus minor cleanup
  Submitter: Francesco Valla <francesco@valla.it>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1165908/
  Lore link: https://lore.kernel.org/r/20260915-virtio-spi-fix2-v1-0-7a474cb1b13b@valla.it
    Patches: [1/2] spi: virtio: fix max frequency setting
             [2/2] spi: virtio: drop unused field from private data

Patch: spi: spi-qpic-snand: publish the ECC context to snandc->qspi
  Submitter: Johan Alvarado <contact@c127.dev>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1151196/
  Lore link: https://lore.kernel.org/r/20260825013848.1056946-1-contact@c127.dev

Series: spi: spi-qpic-snand: fix the stale ECC context pointer
  Submitter: Johan Alvarado <contact@c127.dev>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1163161/
  Lore link: https://lore.kernel.org/r/20260911184416.109790-1-contact@c127.dev
    Patches: [v2,1/2] spi: spi-qpic-snand: publish the ECC context to snandc->qspi
             [v2,2/2] spi: spi-qpic-snand: drop the redundant ECC context handling

Patch: spi: fsl-qspi: Reprogram the clock rate when the operation frequency changes
  Submitter: Frieder Schrempf <frieder@fris.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1167687/
  Lore link: https://lore.kernel.org/r/20260917-fsl-qspi-freq-op-fix-v1-1-5fbe6b02f738@kontron.de


Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


