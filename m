Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63B451C041
	for <linux-spi@vger.kernel.org>; Wed, 30 Sep 2026 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793047; cv=none; b=c2CanSiZiMaMeI4E6pX06+Wyitv5RjulNuL4XsRl/YUvtM5WlcTDyQAVmiwUDnmseAeFMh3QvmFnV3BagpdN4mgSWuu+NmMv75po/5sMEzJ0zVBYshAJb/b8kYmfZIhDmMSOYt4SXuQLvfZukKvsk6d9K1hBMw7I0QO2bf0o+uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793047; c=relaxed/simple;
	bh=o5pKwS03WlK5v17APDxO+Z3W9UDc7wbIzVGdKIlHSiI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Xcx/Rm+sz+4K9joZdxGIUbwxTeqXNFW3FlToV/hI5d9G1qbmIKKZp8vMno4VN9881MxZkzMle1Ddew/s6OmGWqno2cCKcQclpU/o1NLraSyprVzy4xNAUqp73l+3AD6D0gcP8aU0akO6d/GxsmPz8ltFFIa/FwerlS1iqIXokQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW1Jxpal; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW1Jxpal"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD671F0089A;
	Wed, 30 Sep 2026 18:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790793045;
	bh=VRP8lVqfrPyPoOj/i99pSBstq1Vr/ES4NHDbjYlLcZE=;
	h=Subject:From:Date:To;
	b=VW1Jxpal2DT6fKgpnHKTAdXElofpfn9JFP5+uC7iNQLV95jBLwFmf8BiQW470PILU
	 KGOd5jXCxY5nbNZ9pdaCwCfBHZTT4ofHoYAjZJQbYLOsUqoYHAS8aywEzTYZgz1h+g
	 qdkKly6+ZAogrvFeZgpK/9wOWuasetbesel69bBHB7og1L6ybiXPokMeTTIUwFBFjw
	 QRJ/P5JAuleM2/wVy6XyAmbY7SBHAt+qMQt1o85IaDmWrQww+HTNUgmF0KRl0s5Ydv
	 wOWWRmbX4ZWkTV4NfVGCouWtccLKWMEnDmrwk8HrQ1qToYdXIGvAs/S2UEsDokzmEp
	 NE7LZihLzwPrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F41C43A56765;
	Wed, 30 Sep 2026 18:30:44 +0000 (UTC)
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
 <179079304361.2074608.17054545828850061880.git-patchwork-summary@kernel.org>
Date: Wed, 30 Sep 2026 18:30:43 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: realtek: Add support for RTD1625 SPI NOR Flash Controller
  Submitter: Yu-Chun Lin <eleanor.lin@realtek.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1176598/
  Lore link: https://lore.kernel.org/r/20260930065945.88008-1-eleanor.lin@realtek.com
    Patches: [v5,1/2] dt-bindings: spi: Add Realtek RTD1625 SPI NOR support
             [v5,2/2] spi: spi-mem: Add Realtek SPI NOR flash controller driver

Series: Add enhance SPI DMA support for JHB100 SFC
  Submitter: Changhuang Liang <changhuang.liang@starfivetech.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1176618/
  Lore link: https://lore.kernel.org/r/20260930071535.7947-1-changhuang.liang@starfivetech.com
    Patches: [v2,1/3] spi: dw: Convert the Tx done delay from SCK cycles to time
             [v2,2/3] spi: dw: Support DMA with a single channel
             [v2,3/3] spi: dw: Add DMA support for enhanced memory operations

Patch: spi: spi-qpic-snand: set 'qpic_version2' flag
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1173304/
  Lore link: https://lore.kernel.org/r/20260924-qpic-snand-set-qpic_version2-v1-1-a0a9a3e0d06a@gmail.com


Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


