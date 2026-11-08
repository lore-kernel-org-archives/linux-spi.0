Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794133806;
	b=k5LNQ5GvUJ9z1hksB0Ja2OQCdKeZQPrOIqzHSS+N4vyNAW2GSS6Dfsxrr/mTgFQIIUB9
	 N44su+J/h0oNEs6c9RTOWsRk6685vg0VhbvuaDfeYJhuqGpTOx9E16uSYQOOqpAFym0tF
	 tBmaJWdGlkrvKEJdPepWbbGPHo3TV9rxhOKZLnWQnfC4J4xvBy4ZkrjMT9N/4zu4SMYLp
	 ybg95Dzq25ZJQ0Utf/pHDaDp51XxwtAC/Un9sl4Ie5Kn/dx01/4FyR5pBo/MUmTCB4OD5
	 +/JWfluxqlf1pW/nbkU7F+Cb+QhJxAknLkq9HiwY9gvcfxxfOyGiZ52uCfu2exWlXeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794133806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=30hJxUqqQC4yzneMyzNZctxP7lWtn5aOEoSbe9/cr9E=;
	b=fl45Ou4i8QONaDat1oV2MMzWSLOrkmYZmZpKtR3BJepil31Yf8sokSzdDHGoOcArCsNV
	 GMu/aORpxlTkm/CO3JfaZiYuXnn+7lUDVjZhGPx3HBFQc7BdvjJWLDJcHsqjzOHDGs8mN
	 ElxAyY18BV1Lvs3sA0jlZobhazen2w5NV3gZmFyPl+w0xkMv9UylBVweScWYrqgOD7L9D
	 EL6vadsxcLjEPUO+XzQiCl4g8wsaKQy+C2XM6dwGk1tqSgJO9pR27vT02M4fXyCHnyFU8
	 uBQcd0DnvvqHIk6yFnFmLAuhqyAj1vVWfRLb1rHz1VD7EfsDJqFRIpvLXS+zzepW2nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WkSu8Vlq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25730606A31C
	for <linux-spi@vger.kernel.org>; Sun,  8 Nov 2026 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WkSu8Vlq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BBB1F0089F;
	Sun,  8 Nov 2026 10:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794133805;
	bh=30hJxUqqQC4yzneMyzNZctxP7lWtn5aOEoSbe9/cr9E=;
	h=Subject:From:Date:To;
	b=WkSu8Vlqs9xNTZRn3ZRQZWbmzPSLvT5nbD0sPZA7IZ8LJXtBQgHP732E7g0bnp2+1
	 sqD2Co+9ZaaluBe+dLCZsSypg/JaYtmgumPK5DeYTyyrHTLGkqkuQxGN3VCk+xhxBY
	 IMgNAJA+vmqnDuCevdx9Gh+haNiYuZL3fyKH/d8z+nc1kENWUI1YnOLVCGpTszyHNA
	 Z9jhJNsO9ttUeGLcHV3DZ4dT1pjvVUR5TqM0eDqemE1mpvg8sskrhZWAG0vPDBJnjT
	 d43+3EIk81b1DhwjkdQqB+YW1zBdHByAe12GlqGDKHxBxJwhYrsBA/LJG5hZTpJEgu
	 QWBYxgIUeo2Fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 60B8D380821F;
	Sun,  8 Nov 2026 10:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179413380409.1533413.14012158725675766530.git-patchwork-summary@kernel.org>
Date: Sun, 08 Nov 2026 10:30:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add DDR (Dual Data-Rate) support for DW SPI controller
  Submitter: Changhuang Liang <changhuang.liang@starfivetech.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1195406/
  Lore link: https://lore.kernel.org/r/20261028121100.79667-1-changhuang.liang@starfivetech.com
    Patches: [v2,1/5] spi: dw: Detect DDR support in enhanced SPI mode
             [v2,2/5] spi: dw: Add DDR (Dual Data-Rate) support for enhanced SPI mode

Patch: [v2,1/1] spi: use dmaengine_desc_set_callback()
  Submitter: Frank Li <Frank.Li@oss.nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1201958/
  Lore link: https://lore.kernel.org/r/20261104152253.3279052-1-Frank.Li@oss.nxp.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


