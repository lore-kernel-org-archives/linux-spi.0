Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1880322D4D3
	for <linux-spi@vger.kernel.org>; Mon, 16 Feb 2026 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771265412; cv=none; b=WqF0n4b8wehR25xgeTO4cQ8706VJWMIUKPTNpTXOUbu/lXZ4Ou3YhVABkO+gc0tbYLSQrtmM9E2BwGH7EqnfNzkpvZHs3p6GtHBDt/8rhUlf6OpSmm5IS/7sJZsqKbyDNQ8UumctXTMxpa3F5sK5Bt04YKfQQ+6zh5RpxqwGhRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771265412; c=relaxed/simple;
	bh=oX18fqC2M96JMoqKGc4ia8wSabGNi0fs6eZnO6O9KpA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Wd6sAZ7D2VuVkiSBHp7JuZIf3tE453ewTnfCTeg9pz5CJ1C5gkSznkD8sfu5BVfsZlDDQvIFwMxYP7c/O+QimmNlcLKXwwKoemawtR+65fmNx5K0J3MqdyWItXLBLLIrzyQ5vpXYNLsqlHAtMLnMOS1ACsInmqee2hjJdGOTu1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5NyndOK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5NyndOK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9208AC116C6;
	Mon, 16 Feb 2026 18:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771265411;
	bh=oX18fqC2M96JMoqKGc4ia8wSabGNi0fs6eZnO6O9KpA=;
	h=Subject:From:Date:To:From;
	b=n5NyndOKXZLHfaILgGfjYs8p4QFFAa41/S8Au2SnYn8nlrd95lM2B+R2eqKkCA/9D
	 ibNzC2Hysj6zloy/kZyY+m8FGjd5PHc5mhp1A43QC+A/eo4DoyrhcrMrLR8tVPAJiX
	 kIJcbjkIniLKBbap1kAryAvkV3WU+sO10ILAYD9DycrFb1PHU8DFBx/5ObmMhbkvz+
	 7NGIFnFrR7biGGyfRdEBxzY/AupG9ch94Vn2sLs+EcAy8A5yWK7yFP1uY2qXRwHaKj
	 hKx3izaRKa8sGExZO6k+dPbLfaG578SrfOXx7uyzRF8nY3nQvnao2eEvkxWp4/UCSj
	 MUETm6GQJaCZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0D83B39308C1;
	Mon, 16 Feb 2026 18:10:05 +0000 (UTC)
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
 <177126540365.3953586.1431749869081664890.git-patchwork-summary@kernel.org>
Date: Mon, 16 Feb 2026 18:10:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: wpcm-fiu: Fix potential NULL pointer dereference in wpcm_fiu_probe()
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1053537
  Lore link: https://lore.kernel.org/r/20260212-wpcm-v1-1-5b7c4f526aac@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


