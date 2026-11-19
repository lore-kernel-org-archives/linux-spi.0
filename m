Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096809;
	b=emoUcPkUdolgqA8oIojBYON/vwexwDWKhCHgj1I1qBAHy8zIrxy/6F6awNlRAPjiwMmo
	 r99SFVC3kbguUcIeo5KzDP6WajEsJ+Uc5qHxkCffNW/zP80hGGc8HCK36v6Ai/IcFPPNw
	 yqE98PyGmVPzRgkJHbVNaETkEYJXqaQQ9br/L5mxWG4xhH0FQnhOKL+j9Wc5eQeAjysUd
	 PSB+sU3b4D7JAu3dqXasqLj9dhmePkiF72zdEyzvwIh2hTUVL34J/9QUgQFoPXLwUjVRB
	 sojMcxi0DJzr4+q/ZTcH5H4dNlEkhJd6AaqXJbebsg8lnzzq/akh08587z2Kv55aGgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=1dunnBEJHo7IyD+yti6dpnPalVdIxMbbQ4FZsTGuTbk=;
	b=fVbovjhUHIJweF2/zbfBjuss2H+dDeCrJxBSoGkkL5lvL+kvKT79TYfB+wIx1VJ4BcPp
	 kkKiFk5o3WndUaoAAZFLP09/iSrbvxKPr6/1RJyjui+dB5E2f7y69QnGnLDW4k/q257e5
	 aWRajE4uvgVBUSZUsrCXFDEH1rSVWeTYxXD89mFjS0LV5L1jQTxyIJ9OKAJyRhItz/Xvg
	 y0Eqmc2qBaBFl76s2HBOx2qH5NIK/30ryubzGndEsfDmCOQqhT9pcrAoJUfLTPs0beedZ
	 RpsAxTCZIG/8ROsurmP/uUyZOtYOvp3Og5yTHuXqfOARIkiqOlQZzqOZrLAq5MSabxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+SAnosq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F9C606A320
	for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2026 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+SAnosq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DEB1F000C4;
	Thu, 19 Nov 2026 14:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795096809;
	bh=1dunnBEJHo7IyD+yti6dpnPalVdIxMbbQ4FZsTGuTbk=;
	h=Subject:From:Date:To;
	b=g+SAnosqwd38VzRV1HgYvlaDszfJpO9OXZwaO8uSOSw5zSmcCTg/WRu4KoDgMVNx6
	 HGCliMZdl0IJHZRD7RwsVLqgAbnn1sBpxSq4ghH0LUhH9Fovog+7IIfVXoQkc/o9JM
	 KwvgTy1BcSVYkjx8+0QGoGkEhrDZXhHzBFk0jo5ubZ0K1GreqO9Bty/lMuakAbMKvY
	 WBJ52eml8TQe+k5zgHMBCSeJl6arT/mugp5kFSWr83QBqO4gf94gZDO35yCu6eOjfJ
	 7pnjR09WCNi416wGVy53P5XTT3/K4SBxdEUO2Y1ybpRQP70gPzaa8uoYBwUpXQpgK2
	 sNnq2mO96M5yQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3CA623808210;
	Thu, 19 Nov 2026 14:00:09 +0000 (UTC)
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
 <179509680790.3111853.1025062486067005153.git-patchwork-summary@kernel.org>
Date: Thu, 19 Nov 2026 14:00:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: PM: runtime: Convert pm_runtime_put_autosuspend() and friends to a void function
  Submitter: Brian Norris <briannorris@chromium.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1180567/
  Lore link: https://lore.kernel.org/r/20261006231900.3230373-1-briannorris@chromium.org

Patch: [RESEND] spi: ti-qspi: Discard pm_runtime_put_autosuspend() return value
  Submitter: Brian Norris <briannorris@chromium.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1209917/
  Lore link: https://lore.kernel.org/r/20261112112334.RESEND.1.Ia678a25bddd5942c7f3e11ff0eb807754d7e2aa2@changeid


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


