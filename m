Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748606;
	b=2QIJz+DZ/M+Xy90F3QnHGEGbq3urZMD+bFvGwPITIXss32Tw0zUnIOuk/JFi3dQuBrGM
	 LOWTnI/fczZaN/WZP5wWOLBVVMLlMF9pbe2aKGxLaknrHDLflWN/LyzFMSOuaN3iAQcYu
	 Q0lRL5JTtSN00A9yOZjrfV2dJAmpY1+GaiZb1zLA6IkaWn/2+2VsPjzYTPN4dR2zGGX9m
	 iHyB3P+EUqrSrwgfvq5zE8MycRTS+8PzVmvuU5HJLeODz9/GSjmuos5PTZgi4960467mj
	 z14jCXK0B01o/dGcT/uwvk48/o77rXaiVTeDOkcz3/UQmBsk5bCHTWlcTRt/ijbXytw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=s+3GRRuolL4XNARwUHAwvCKJtUzeO3r5RWt7Py/kyCo=;
	b=OjUvnzBTdE+f4cXo3Si7LKo9eNVsA006rOooAMpZuPdO3xJTCtsV2fy78U1FTeY5cL+Y
	 F5UwT2ZT6cIALW/DNj8GEbdsV/0keREvk6AwthlF5uqEPkWNTPZayLOKm+ekWAMA87/Ok
	 5IcVDt1H+qEs79EU7G5bfnSfLDDAHAweKvE5HsdoB48JN/xOdUkTaqUnnbpmUGrQBqjt+
	 1hZozoLBPZTgiSOk6/SCmZcO/t18sXHuguJ2PGOpbAHBIQCam7cKsvkhCfFcv/UizITE0
	 9bEoHAKzA47Ls+LY4qRRAt9EqmYqvXUPCA1jAHeFWxJKixx/ve3XSDc4B+nY1+oaWlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWqbCTbR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32329606A324
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWqbCTbR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9C51F000C1;
	Tue,  3 Nov 2026 23:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793748605;
	bh=s+3GRRuolL4XNARwUHAwvCKJtUzeO3r5RWt7Py/kyCo=;
	h=Subject:From:Date:To;
	b=OWqbCTbRjiQW2Pt3avDs8y5+ZlXaRAXzq1vGkZxzp/Wtn+fNyh3Vtx73vuKssLdG+
	 D46L9endVY0zv2y2iTdG2Qxi9vpWoAWqCMe3cddLG+6HEyjTGs9ONkHyF3ulNswCZ9
	 u4eoesHUev3vqRf9FfLkvViT/6wixM4QY8v3ooIdZs5VH64/5h37F7OzXt9oBFe9a5
	 Eb0Rt9KWr9rdoldjj29bS9wfFjvWhrt91k7xsVpmj5CWiQv/Exbt20d/Y/IXAejDaj
	 nb0iM18y0U4BOmSjKIL8iRGVer7mrZnC3ebnY9h+gxAgw3c1EHkSXgGune78FfgKeR
	 BxIZifJLV5G/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7FC6A3800477;
	Tue,  3 Nov 2026 23:30:05 +0000 (UTC)
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
 <179374860395.1946211.4741938434063260617.git-patchwork-summary@kernel.org>
Date: Tue, 03 Nov 2026 23:30:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: xlp: reinitialize completion before each transfer block
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1200302/
  Lore link: https://lore.kernel.org/r/20261103-xlp-v1-1-696d0a50b84e@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


