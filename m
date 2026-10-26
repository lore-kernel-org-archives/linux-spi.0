Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793050806;
	b=BWJJZZD5lv64RVVM6Ns0/dEy3fNXY09QwQzAvn4fNwpY+ZOXxCjOGJWhVuZOGRXCKxSn
	 mu3qH1Li092NgVEz+U455Da0558+icFsEFtkhz45sVAUl0O62I8+7kJCIx150Zp8ZtI46
	 oX21mEcwZS84BGyydqp16tw59TlFde6GNqXBvVJ9fBDyGClDBDYsi2MfWJao9bpy4uVDD
	 QmfJOgfvQIw2b5Kde40wyG/MVwD+G4KSuvb8Mcj2bh4RDyaHMLJAQW95iJeAGivwXxQXf
	 Ukc2Kk1XjYHPDkLiS8jYk/NGlZdHIB/QlYWUH6IHrPJL7rKmQxNsjPBvDT6Q1iyMSqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793050806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=2vb2LnLYlwZ4Z0hDh4eDboHtO1E4PoHNwEvmeLZf91U=;
	b=T9YNS0m/M33SaLhEInxrPfchVrdKMDtSPVh5Z77hfaWk55fZfn8HFmhMZa3dfNduELDT
	 JAN68+0p42mBPlNxRucLLKgenpJtEZ4mZkJDVth/WaFDOpLPzw9PrXwJZ+IdFuRawKXAx
	 7fctoLR9gNYDDIL0us+MiCWozvdt1gHCLkqkRQ3W/plmqlKeEvcqFYQW5L/f68fPpQDay
	 w/X2xAPKRZoKOdVv4vNPg4kPc8bLipvS68+IRWMj5fF11TRczBn3vNpVxFbkg9GTOA75y
	 YnLby0EsvYhXVdOrRExcnVz3PvL6F5mlYtrue8kQwDtloqhInHN9SOYuvpYRhYcag/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BTu1qmAr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF88606A31A
	for <linux-spi@vger.kernel.org>; Mon, 26 Oct 2026 21:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BTu1qmAr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF3D1F01825;
	Mon, 26 Oct 2026 21:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793050805;
	bh=2vb2LnLYlwZ4Z0hDh4eDboHtO1E4PoHNwEvmeLZf91U=;
	h=Subject:From:Date:To;
	b=BTu1qmArniFKBSRuuBo/vNRCGXsdnXLD223A6P4idWAd2LByb4jo546jhvDNRHcns
	 53ldcK5rG5iXOLL1GVkeOd4W8Lj1YOSU3Y+clmVT9ryb+Om3ckkh4wtj38zlD+H6RQ
	 BrKhry43eMCPGyivcViLki+wBXi22dByPrXpkGZLnkAmSAdJvaGFxNlEh770Y0lgAa
	 fcrCr09xwKK3w0a2ZAsaXwTH1M6SCt9u89aWARMY/pwm3GXw2EpcK8tl6N+69A/Avy
	 K8cK9fj29QcpLpDc1CNxxyKSlGTZ44PAi4A5djoRQsztjBgliuN4pDP1dYzj2r4byX
	 NgD92zwnnUu9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 46E5B3AA80E9;
	Mon, 26 Oct 2026 21:40:05 +0000 (UTC)
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
 <179305080381.3403508.17659368002372273596.git-patchwork-summary@kernel.org>
Date: Mon, 26 Oct 2026 21:40:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: cs42l43: Add speaker ID quirk for Dell XPS 13 DX13260 SKU 0E54
  Submitter: Jérémie Rodon <jeremie.rodon@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1192969/
  Lore link: https://lore.kernel.org/r/20261025095037.18891-1-jeremie.rodon@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


