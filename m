Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4143D3329
	for <linux-spi@vger.kernel.org>; Wed, 16 Sep 2026 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581546; cv=none; b=SzdWVsRagvdrHu4/Y+kdUUuHlhsvKw4RWuqqGwXpPJjhQTpeFiLlIYMESVRhy+7on2zJSQ73g6AtzIY8yTwqZUSvmTG5AX17joFsZD1kedj7nJ9wFqnG9UO2d8AJ6C9N6S8M13wmc1JiXc2qyspct1gCcYixqSYsYodQG5prLWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581546; c=relaxed/simple;
	bh=eZFFcQU9N0Q6sl6qwUMT0ukyC+0O0IT0XernLSUQP4Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=VroS4wSrUWrUN7pNRhUANpIXeoj0IWkNiPyKDKAjc7t1dq8CsmyR9NeodVPwr1Kw67lEh3gD0IHzQ6E+R12L6DFXrhsLuT2csicYz0xCeJUAzwQMddgWaZP5Gmm0c26767IsrsGOfxkd+bavfqusrrLHOP7oHV0pBWwq7P64/7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/fDFJLW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/fDFJLW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141BC1F000FF;
	Wed, 16 Sep 2026 17:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789581528;
	bh=gdDE3OrswaYJrIi+P15T4eSykGmQRX9X0wJjXZGzE1E=;
	h=Subject:From:Date:To;
	b=k/fDFJLWM1DGkxZysiJaRin2Zx2LOwb3DnAmz33ffQU3o4a8mOJESNLJq3YMibDjq
	 KP5yKFjsGFKySdOk2zzQPEtnsr5I4ANapMWOgAw/4+oFEnKnhX+JyJcaWpMZatxuoL
	 NYS8DlABxEfQ8uguAPPONXYt3HuE6ALIuI8DOvNPAxafJRhVKRhoFxm+uPtK1fpwDU
	 1Q3eNmS3lPAzS1IR7L4MhTg2b8w2K7S8R+LQox96gMyT4RSgSx8o4waYXb4XRoLl52
	 8WMFwUW1yc963byY9mdsz2gaec0DBaR19gYfpuMLmFwd0SiYB3ygEEDh/QqafNaeJl
	 iFwluLkwsg9GQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5910239E8A4F;
	Wed, 16 Sep 2026 17:57:43 +0000 (UTC)
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
 <178958146198.2775890.17967418341691483560.git-patchwork-housekeeping@kernel.org>
Date: Wed, 16 Sep 2026 17:57:41 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spidev_test: new features (2026-09-16T17:41:19)
  Superseding: [v1] spi: spidev_test: new features (2026-09-14T14:50:42):
    [1/7] spi: spidev_test: include tools/include
    [2/7] spi: spidev_test: add compare mode
    [3/7] spi: spidev_test: allow disabling rx or tx buffers
    [4/7] spi: spidev_test: don't send 0x0 or 0xff
    [5/7] spi: spidev_test: send predictable data
    [6/7] spi: spidev_test: add option to split message into multiple transfers
    [7/7] spi: spidev_test: print TX on error

Checked 158 series in 3.16 seconds.
This project currently has 16493 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

