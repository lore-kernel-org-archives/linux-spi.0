Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525E93C0600
	for <linux-spi@vger.kernel.org>; Tue,  7 Apr 2026 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577489; cv=none; b=feZ1abVicpEGOxPU7A6V+SB5TIweIZTwTlhqUvKSS6ddNtTRpEYQgA1J5JzafGxjUsMlJLvWoUpWt3HfI2jtCnRnD5INq4XpT0oNz9JnPutgucX109f7zQtYGWVHFlblg1ekZCcGcoybFqifsTkU7ujJfPr58oBHibm8qZyU5GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577489; c=relaxed/simple;
	bh=w1aJnfg1OUlRVc0aBm+TaBHD5UV5UnXSqVuhZ4ANSvo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=BMaUZKQ2yr6fDw5ji12eEoCxIyGOTGDEvcRvLDvCyk2GOS7/UO1QxFhHyjzbjQlhofkUnjzsCK9VDThASO1JfaeSLBGFfb5+HpI+yZs+BdVRfojS/CpGdMSwnad4ZVNK3iRwyvo6ZYueYimmNIE3kKLW5KnhdrmdJRZRn+seE+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ed1TMwVZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ed1TMwVZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC84DC116C6;
	Tue,  7 Apr 2026 15:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775577487;
	bh=w1aJnfg1OUlRVc0aBm+TaBHD5UV5UnXSqVuhZ4ANSvo=;
	h=Subject:From:Date:To:From;
	b=Ed1TMwVZ8E2ahv/PrNBKrvOBzwdsB5++ViOP4pVZh/sx9DCzf4TXH3rWF277G6EDQ
	 OfobDuNJUtUY8ksnexqlMIpVkoJxa/yJdGIyc9g8ZJtLWajQClkC9GKb0ZymgrwqB9
	 EuUyp5WjUl1D6eo1MI0BhQBKoOH0+tYnlwsIOQY39H5SmERQPsKCBnn1PZyt5OkQOT
	 zvgTHjSDbCclPBYA/1okeAGE1RcJ1dMK/4/pvwh36hOOvs2NE/6yYU3PpS9K03dkG+
	 7KEC7Fy1MwnYfE/ZgJ/7PM1/aUiePMwknNAdDmHYhAqdp7QeyL3P1TM//xuC+lRTeR
	 X2cryQ13YoBlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F373809A31;
	Tue,  7 Apr 2026 15:57:46 +0000 (UTC)
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
 <177557746537.4050657.17814711736479580770.git-patchwork-housekeeping@kernel.org>
Date: Tue, 07 Apr 2026 15:57:45 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Add Renesas RZ/G3L RSPI support (2026-04-07T14:57:49)
  Superseding: [v2] Add Renesas RZ/G3L RSPI support (2026-04-02T13:10:15):
    [v2,1/2] dt-bindings: spi: renesas,rzv2h-rspi: Document RZ/G3L SoC
    [v2,2/2] spi: rzv2h-rspi: Add support for RZ/G3L (R9A08G046)


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

