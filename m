Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD0B448391
	for <linux-spi@vger.kernel.org>; Mon,  7 Sep 2026 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789585; cv=none; b=N2+AkCeFLHxtdRtxFPGC2Ha/UmYePwczmKeG8ZkmM9p5txfgMUTyZXRlA2e9aCFOCryK+oeX6erABDvqnbyj6ddOjArjidn4O/4cUY9gDrkwjWEq7DjCVTqDoxXiXLq3mvL4X7JERGhHjYtFn1OmuRCD9rCUX144mvFJR3nClGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789585; c=relaxed/simple;
	bh=Rit2Ssow+UXGv2u6YY6dDfI/zIiTny6HNseZpN1Lawc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=n6CDCD2kQUzG3cKv4oFY1sSkOvjjHF+eN1u7P4bT4We9RyDGPo88V1gchMGVa9ZRV7U08FnEk46vPLzqYM+Y4earlTWFOn9bu9BIOVmNJykJuuES3Ul3FLf4rQiefcXfo29XCmpOFuNCb/kVz0l74rlKNE2K0Xyri38hExGsY6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqBEMAwL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqBEMAwL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F9B1F00A3D;
	Mon,  7 Sep 2026 13:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788789583;
	bh=9BiLZdZJMemkqNhodNhztOIT7ouWEI4SODGlbCuTpD0=;
	h=Subject:From:Date:To;
	b=fqBEMAwLtVlxDTIWenkPGrkByJ2dFrXoNMkIJmMucu5sbfe121XAAiURyT3ON1WCL
	 /mAkJTgMtH+WOjDLNGBnTGOcftEf5MS2G2tx8KCRkYPMgEThWS+yymBSM5MDLkUL2C
	 7QyWRgOdMkVWyvOWyCFTz+KZ6hkD9wZuJVlCdth1nPjwZ7paCGxm1NbWkwBOQ4i/Sj
	 0MXsEMbXZfrU1bv8BtHw3tGHQdrmMF7ZliR7FU6MNYjSRCJ5WHX3+RdIxW0ntJhyCI
	 +SsKrTQsSBOY/tE9q5RBmUhe389Mi1x4YlNHgj4g13f7A/ZVo3LXTgHAMIKmA8vNAD
	 CtHOAsnc+IjsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C21939D6574;
	Mon,  7 Sep 2026 13:58:44 +0000 (UTC)
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
 <178878952257.2554381.9788530022188547651.git-patchwork-housekeeping@kernel.org>
Date: Mon, 07 Sep 2026 13:58:42 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] m68k: coldfire: fix non-standard readX()/writeX() functions (2026-09-07T13:37:08)
  Superseding: [v1] m68k: coldfire: fix non-standard readX()/writeX() functions (2026-06-09T14:12:56):
    [PATCHv2,1/4] net: fec: do not use readl()/writel() for ColdFire
    [PATCHv2,2/4] net: smc91x: do not use readw()/writew() on ColdFire platforms
    [PATCHv2,3/4] mmc: sdhci-esdhc-mcf: do not use readl()/writel() on ColdFire
    [PATCHv2,4/4] m68k: coldfire: fix non-standard readX()/writeX() functions

Checked 166 series in 4.22 seconds.
This project currently has 16443 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

