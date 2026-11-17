Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932406;
	b=c+dLAOSfhmF+lx8/K6/UU+uitQMQuzJIDlNHEoh1yKMOO24tOBubEDU1aGeVPyvfDDwO
	 6JYK8g00Rp3F7PacrD8ZmAJaIGEj4/vAz5K6t5eLw7fUz69Fhrhd2MnvTsQpYOWBfO9it
	 qSV1rR1LvZ9sK+Dk4l6LoOIlMwr3rM1KrZzJz8C/KTsZVPruKHJkuR9xsBOgQ21+RAzU6
	 EQ9YWyCgltKMgmgtzpZ0tZvOR4POJ3r33NVfi+4e9+Ot0ar5sSqHLOdnc4dX8/JagwfjY
	 r7PWqxErXAycTuvVxMAOLRsC8B7JNlDA1+sCE4YRXbw+d56WWa13eM2UH/J9bN6D0Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932406;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=5qjtaO6hUXSNWyDjWdlqyVX4ZnoeYpH8mMg//dZkMOA=;
	b=17uiCVUCWWC1TK4wrO6y4/MbsjIDGz5hKhmCzBkYEEBBtEmZSut8ptJDaN24NHEyvXX8
	 gYrW2t7Kw/AbRQFuDTFlu9lbAFMpvqVb0FjK5sr2hYlgqBzuACW5YzEmHplLL1ozMagol
	 Y7aB7JJX3sjfyQ+fTuRwsXSQRN+A1189VRxP0xbcTPnpsr6KoJV1mCrz0n2Ml+rssThO4
	 lm/geL9cjE6cfvUDzg5VuGUG2993bVX90Bju6E46cvLhxPgPJITzcEu/7reOWHhod4mju
	 CNoHSTDivSHaMUj2xlfquCVvrWnL0+TX1wuCf6DSIgyHkSbd+qlfgVHjnJJc4tKpiiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8ARpqEm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4772F606A32A
	for <linux-spi@vger.kernel.org>; Tue, 17 Nov 2026 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8ARpqEm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F641F000C4;
	Tue, 17 Nov 2026 16:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794932406;
	bh=5qjtaO6hUXSNWyDjWdlqyVX4ZnoeYpH8mMg//dZkMOA=;
	h=Subject:From:Date:To;
	b=k8ARpqEm/N0u72CUPdRWw+cZLt1c6TaGxEEjhhfvQmK//h9DwIpVWvA1hQYXUr5Wv
	 o+OB66qJsXkJeRnJ9O0CDpBW4mL+fhnGlmINuKij7YJJEQ60O79WYvdajsOIXtq1Zz
	 Egr9IgE+zduvs18zsHSlkpKQgZfDyhEwYH+14mcMbW7gCLUiaQsb1KTm+4V28/DUJi
	 oiu+WZC1KnGmFFqUN3oORKSi2ebLfowXlXlTQ3jJleStQHFcvF6+KSKpSaApgYjrZW
	 Gzu09eCFmz5DOM8RRTB5EmwDyhuIJopk5otE+PSjFr6KWlkpm1yTUHYtRTz/qyZJ1k
	 uMfbmoOoFaN4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F3A0F3927066;
	Tue, 17 Nov 2026 16:20:05 +0000 (UTC)
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
 <179493240459.682076.4946912422420572015.git-patchwork-summary@kernel.org>
Date: Tue, 17 Nov 2026 16:20:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: Fix runtime PM imbalance on pump transfer message error
  Submitter: Sebastian Reichel <sebastian.reichel@collabora.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1206554/
  Lore link: https://lore.kernel.org/r/20261110-spi-runtime-pm-fix-v1-1-8601ebb2f6a8@collabora.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


