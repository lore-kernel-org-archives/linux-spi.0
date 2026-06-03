Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064CE25B0BF
	for <linux-spi@vger.kernel.org>; Wed,  3 Jun 2026 00:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448269; cv=none; b=BeiIa/JlmE7XtvhHV6QkdbyAagS0qZgFgNpqqLu3faI7+Swt3grUA9GIJlxiN2PLQFKcEutZv/L4cVsDP0/y2eKD3YDDe2CJK1YXdO+UvZwuzOqu5NTDEjqVh0UT9Xe/H9qgfj+U9P6HWC38BpKPqTPL+bsPRdyC+D9f63J5nLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448269; c=relaxed/simple;
	bh=JkxJUVSI7w2uIpvU3X/lExoJh1pFtsSudW4FkX2U6cA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=VUsym6KVPw/zsbXJaSU0xJS5cJki6QSw8BGOTvpOiLeKTZBmMf/2HHhfehsAsqe7sXkdDMD9MiVEQzkgjuL4dwX8QNwIKPCXHsnlKSMXVCOqTCs2gr0pRMndc6vVF0bknHWAUFUqBrf31jSf3ihmExngv+qanwybL7O9F7tBvXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdBEok9Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdBEok9Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A601F00893;
	Wed,  3 Jun 2026 00:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780448268;
	bh=/UviEkzRBVlKWtdqnc+xpydk7Aic0f9JuI16/7/XHos=;
	h=Subject:From:Date:To;
	b=cdBEok9QbZ+ufhVuNMZMLdEOvcCZbDgz2D3Vy2UfoKJpjX+1lPE4RDipbePJAzGa3
	 BkJVjpuekj+/6Bk5Sh5O7mstsXWfJI/VibIvK/krlckRtROXBfoovrK6GziX+X/CkS
	 BF7zU5t9rkyEAlGLKZOOZqUutA/AIGG0aulVMcgbamiloS5ZuulaFhNBjcR1wTGbVX
	 aqM1861Inr9IPB0FKEyKSFBFoK4S/FDkdyM0IOpO5fYAQ+GD4WwJYFcCj6p4KzvbZ+
	 YuRb6OC+criquct7INhJaEzUORapEYbVv8PQhVcRK1pHMIaG4HhshioGyEDb4VhHpk
	 ZKzf1zag+okIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 95FE1393003A;
	Wed,  3 Jun 2026 00:57:51 +0000 (UTC)
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
 <178044827011.1151508.17323575374289269093.git-patchwork-housekeeping@kernel.org>
Date: Wed, 03 Jun 2026 00:57:50 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: cadence-xspi: Support 32bit and 64bit slave dma interface (2026-06-02T23:58:25)
  Superseding: [v2] spi: cadence-xspi: Support 32bit and 64bit slave dma interface (2026-05-30T12:37:15):
    [v2] spi: cadence-xspi: Support 32bit and 64bit slave dma interface


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

