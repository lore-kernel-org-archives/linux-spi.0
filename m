Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598363;
	b=IElz0YGQ9ir2yWtMRtGy24iSeiFhQGok1h/9e20TEBezDbgyS2JZRjmnnh0sPB+dbxvR
	 SFjezPRKUG8vcE1KlPwFxoSwQ6dERj1H5DKLOEViN6Hj1lDmSBbXZ6gIvuCyKTvMevI8F
	 3cWykBd9O8GfLrwue/hpk1sSI40E1n6Y+KC9TM19e2LIISEzlWsZy2P3Tb9Z3o6MS3FOo
	 L0t0pJjs6H7eCiPUPp+ifiQm5oI67AAyAePY9x0Xe1ykN6y2dTUUQR7a20izA0UMB6UfR
	 PzlYsqqNlIpJpvd5v2wv4h3S5yJ0SqjlyQRMgl2FpMqPcoDa14c+nKYknhCMRrbnJag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598363;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=FAOrpGqZ+3N5X/sw0HW+stWSQzEnjEb59HAeKHdKsMY=;
	b=4KTtOug14JgdqDgqw73A3KFmcDq+BWMc8SChBfznJ2jb3e+VZIsqU/Zomx5/4w6dXq88
	 0CsNSNoj2KIQlvg06G4zzksxSYlMSArvPrlxtL20MBrGoLovDLz8v+Z1deKbbsn+hnaLD
	 pXX9DPQLrPUcWG0i3krYV4mByuuX5tn0h1AMuB+PqWGFe0dTwiDADGdZ8WFVKm81ZRbop
	 0KzxFGx8bFJfTxbGkXP1//6mBLohVSEUidFFuV2ETJLgzpHh4WfHNfgMVkDzjbPuB/Lu2
	 1cjA0nsLN/JJUog8HHIvlBGhoRxqFOMzL4Y1VCXvwdEf5aHQXfJ8GOnU7SyokfB8K8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aeKpqFZ4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FCF606A327
	for <linux-spi@vger.kernel.org>; Wed, 21 Oct 2026 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aeKpqFZ4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD6B1F000C2;
	Wed, 21 Oct 2026 15:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792598362;
	bh=FAOrpGqZ+3N5X/sw0HW+stWSQzEnjEb59HAeKHdKsMY=;
	h=Subject:From:Date:To;
	b=aeKpqFZ4qDRsGxO/bqryKqDcmm/dAh/Yluu84/NrKujzAqEqUW9wFXMR1IaXesWQU
	 FNiprskDowEcal6KOTaaOFMEnf5a8/eX/bnh6bctfQMxkxXztE/e5Kdy1/CPsRGrNK
	 z5UNBVOQ83CnPbhJd82/mHTW6Nadn9IzNmoBaqO5RuIs4u1IW4E4FkzI8mk0G8a7qv
	 03+3wSP+omBftimnxkN0tmOTUztYrxxeS2D/Qn9Aarb6CLT3g04SkPL/t6rcx2F0cD
	 BHnZNbA7VGVZRHDmW1gNusbt9TjCDA/Z/oyK1uff5AqpNjxIomoM73E3udSCHIs91/
	 e04hXwZ4B+YGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B6D833809A8D;
	Wed, 21 Oct 2026 15:59:22 +0000 (UTC)
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
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179259836144.1157042.6329875941921559113.git-patchwork-housekeeping@kernel.org>
Date: Wed, 21 Oct 2026 15:59:21 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: fix zero-length scatterlist entries for vmalloc buffers (2026-10-21T15:01:45)
  Superseding: [v1] spi: fix zero-length scatterlist entries for vmalloc buffers (2026-10-21T14:57:34):
    spi: fix zero-length scatterlist entries for vmalloc buffers

Checked 201 series in 4.40 seconds.
This project currently has 16804 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

