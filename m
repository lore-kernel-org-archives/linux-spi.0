Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795126805;
	b=om03VdZxnaCz513cDx3v8QrS2ualuGltMtlPynH0f5ovYBg9ErICqZrBEN0TC4TyEa97
	 6uhKwUu0zMAnHyY+nOj8R1sKRxhK0zIHGrAgBwuqkeqXDA82Xtx7E1rL0kkAG42gZBcBR
	 n4AFjen3fJtmHS0MzDYJWwgiXHx6YLhTAYZ0fFIqVtLTkSCSOW0AlVdA53O2cJekUimw8
	 XUfa7ThAdXk6l8UwRkU2Q/CuhIK7kmaliThytVYbaopPusWcsRSIkiEDDpngV/lNA+39o
	 qLj/lWFVJgmO8iDf8L8tzScxrIg2doNmO6aHfhb9V8z4R/Isa8k3a0m4xBWgF5kaWGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126805;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=eEVz5MlMdLOgn4QUU5cninN7GEKUa8ao4d3C9SLleZs=;
	b=JWsxsDJfpUZorkqT3kMCQp30NhiQy4gIuE3HqtAyvLPir1WSgF2HIcL92qKln+iJZclN
	 sxnTGF1UAx25QkyS9wv3tn1kVqF/DQuFW2JaQV6YSYGR65TuJPKU3cwsMDWZx/GkSci98
	 5EyCuZ8VfsyELaCsJLpHpW1aRj9f7IaOpOpGFXhYPSs2ewgtroOgUzanybM4fPa6IOtPj
	 Qg+srme7P8KwxXfnz0NGffAueMIzKefaIiPTBbSB72ASIgWO8KqhrBOLYNX581d+s5/+g
	 CiuRQQTrHUFR3wMjjdj+N54OWnbuZ+vZOpLuWOGRu3fEZkJZHsIEqLPYSv442eDBWUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVfdXZwr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6788606A320
	for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2026 22:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVfdXZwr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BA91F000C0;
	Thu, 19 Nov 2026 22:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795126805;
	bh=eEVz5MlMdLOgn4QUU5cninN7GEKUa8ao4d3C9SLleZs=;
	h=Subject:From:Date:To;
	b=AVfdXZwrWcYRlmQx23bSlyaf8itdLPBIZuZ3bqADN6WAIfq1uivivLXMmitFiU+lE
	 clNb//OmluIiPeOQFNsBwxC5UiIkWQ1CIHlXL+28RSMDXe5/0RZ0UWHQxwIKxEo2//
	 eO1rLrt9ptG8IbaHUCpqkVaycul/jHA0tdrlVCR4t5WEo0Q7hyl02EpMCmKjSg2lV2
	 FB9nsq9zTMCZt0TE6XLI8WomkzM4Zvsy1gApGkPj0ei6lEbEJmWxjFgMay4zeT/Bhq
	 ppxHQZV5KlGFITJ3dpgrzSF1ljku5aDjfLbQL4qP9ncxi+jxIS4G4jku+L1ELjMgLA
	 R5o8Q37tVMILg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 79CCD3808209;
	Thu, 19 Nov 2026 22:20:05 +0000 (UTC)
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
 <179512680412.3894933.16834927435195573468.git-patchwork-summary@kernel.org>
Date: Thu, 19 Nov 2026 22:20:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: sunplus-sp7021: use devm_reset_control_get_exclusive_deasserted()
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1210778/
  Lore link: https://lore.kernel.org/r/20261114-sunplus-reset-cleanup-v1-1-115e32fe8c1a@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


