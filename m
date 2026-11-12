Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484812;
	b=loIKDTfiDaax+86oIaV0XorkaDQUrxCeZfyziXxRSxlqLc2k+p/Rs5J0sTzWXNShYB5m
	 WT9Sa3r7/5FZxillSOxTaTyjv7CXsyJlqkeM0PM/EdKkWb6VsJL73NxoylH0QbQ00HHM+
	 pUSj6c/oLay0JW9+gejrlw0/d5YzqU07AClhcPBcEo6xlYFq2gixgiPAgUn7cWP9Iih4t
	 4Xcu4UGotwbMD39jPutLTnfeXGaa7BpFL54Fe6Kgs8nGVzauEhlYafPYovmjuNJXYyL0w
	 uRsEXdcL+C+w3GR9ssftVubve+Lf10NW7bgnkLuYDD2DbcfDRntG/fcmWiXqgDtCxZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484812;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=PDOyVwOMM4YTvHVGKlNvMfwzA5zlTqarcfdXn3Jm9zc=;
	b=g2C50bnN+MHXgPezCVAEYaWwRMYjfDhTWX920bc/wgiQZZ+rB4DXGJD7PvQdO9HnnoX3
	 obHzeSNidmqNPiPfQQ8TiKJ+tmEtw12T29gOmnT4P6oGUonAYtDcgkcQxYTSFyQGlapm6
	 BG2t3kYC2wh6YTZp6+J4vfpmQvW0f+VC/OwTyhX4mFZT1LSITb9lR7LdR17FQ2piZneJ3
	 IZYYQtoTDQo46Mt96pS5MU0GFZlWXMUhxziUEoRFqUGe0roypQ/VFcKv8bY8RWge9KGOk
	 payOoafUDTFaM5SgsuGkkHoamC/xDS0dT1n8rvOHBat5ilMe3B8y3zXiHfAyt1PTP/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fzpRSIeA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3509606A323
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fzpRSIeA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6341F00A06;
	Thu, 12 Nov 2026 12:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794484812;
	bh=PDOyVwOMM4YTvHVGKlNvMfwzA5zlTqarcfdXn3Jm9zc=;
	h=Subject:From:Date:To;
	b=fzpRSIeAF9HX95Z1/Ud+Vgekj+T63AvLOnW8UA5jjwvrMtu/veFbSwpOQWTwzXjbH
	 Tf/vQDYIOcoN03YAwCuf27HnrLYiLyjt65c17Oc2ElrAVeI9VuWb47BBHSzfUV/VPj
	 0er7RGdXBmSesPR+31+nLuMZg+1lwb8Q6v1nXeC9KYNNEgiNZKt/0QrIFXleYZ0pAn
	 4VAIvpgv4IUtOVwqwtrBs43LmiHVbZQo4/rt3fW3i8tfM54/AdLyVbGDO9ss5Vgkrh
	 ArQFD/vQzBgU8tmaPTRCE2QVDAjdqQYLQXxOSUsdGxXWbysyN0p8s6MVSi86Lqd9LE
	 9Yf9u0C9PnGlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 214FD3AA9F74;
	Thu, 12 Nov 2026 12:00:12 +0000 (UTC)
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
 <179448481077.2051018.5972779323329433414.git-patchwork-summary@kernel.org>
Date: Thu, 12 Nov 2026 12:00:10 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: dt-bindings: spi: pl022: Allow a power domain
  Submitter: Linus Walleij <linusw@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1205033/
  Lore link: https://lore.kernel.org/r/20261107-ux500-pl022-power-domain-v1-1-d51913109afa@kernel.org

Series: spi: tegra210-quad: Fix timeout path status handling and DMA leak
  Submitter: Vishwaroop A <va@nvidia.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1193638/
  Lore link: https://lore.kernel.org/r/20261026111412.3843954-1-va@nvidia.com
    Patches: [v2,1/3] spi: tegra210-quad: don't overwrite refreshed status with lost-IRQ snapshot
             [v2,2/3] spi: tegra210-quad: Track DMA mapping state
             [v2,3/3] spi: tegra210-quad: Unmap DMA buffers on transfer timeout

Patch: spi: virtio: move teardown to .remove()
  Submitter: Francesco Valla <francesco@valla.it>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1205417/
  Lore link: https://lore.kernel.org/r/20261108-spi_virtio_remove-v1-1-fda5f0996290@valla.it


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


