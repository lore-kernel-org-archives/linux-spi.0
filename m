Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798705;
	b=5WAaNNNI3zAxNY9VL7NzSB9JP2574g9tey2nwktkH7Ym2dqsqveF/DrlcgpAlyA4Wm2Q
	 jOKojptF7cFbaPVARNJnKTRpvB2aFPxNL0d/JeC0h8RjLjuFqnonm5T7mEIFeogVHqWlY
	 DrvForhv0UdtpXTEXMIpFUkT8R8gh/UP/X0XAls8sdpxGWso4ASuHKvCImGigdCIMtotS
	 D57ocrCNZCGJUEwr7WTiCC8HG5AI1PjJYy/SbG65oX/STtBNaWth0Amx/imGS+JgImWK6
	 XoS4s1leAS8y7ot1GE6pXy3GJdUfX3IdLZW55/PwPo7fJyS5gxP39yZ/VDlkYLdcWqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798705;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=54OopTS5SAjb03Vnj6sGN5VIvIkD4MtcCl9KigD/dFs=;
	b=cy3OAu0sBKBtfij7G/2eou85VZNUadgSO8f1t2+GZJO4uZgjPq/sYRKt3//yiQm//FSh
	 i5KrD1cOg6aX38kDAcbDVe8NoN0u6KMKbN5oSOocWTILwYqVjaUS4LYt6vZ8Gu1pZEiWE
	 A1wdw//g6d7lQkfFpRflF6N59YD2HYoKRVeNbXeu3no6i8NC96mu/8jDOHzHBnsVmcLYU
	 5nhBDWyuJsxZoL4vun3Z4h4q0pcq3WIbeu1Kg9UgpTSLiOpiFVyHRwIjRHiO0ovFf3kS+
	 WyYqmcNIDtYUOk6X3HQKZnqjXQHoHXn9byvNw3uZULi7TT6UrxoDZv8LIA7ntTGPXgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fEb/AMFq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885E3606A31C
	for <linux-spi@vger.kernel.org>; Fri, 27 Nov 2026 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fEb/AMFq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A4B1F00897;
	Fri, 27 Nov 2026 16:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798704;
	bh=54OopTS5SAjb03Vnj6sGN5VIvIkD4MtcCl9KigD/dFs=;
	h=Subject:From:Date:To;
	b=fEb/AMFqBBZNGUJy1K0G9kbTpNXMtsK61lBwNV4/XhGvmc6fG3ZvjfTv0mP/yEqYu
	 atgJy+bKeByKdjiRUgchUZUF6bePmgnZ6eB/ouNfV0gZI5HRKKlX9fzMwIbjH7tmCY
	 oxCEiSPNq/I2a8Dp7Wh/JOZp/kJ9lfgnFKqejGXIgUowgIYSjn8VKoqtQKbk2BV3fS
	 4DujHeMkSt/yMf0pJZByMjl48svGBdQN9seEAZta9JSbsVLWUmyJYtruVGHxqGSc0g
	 xRNXL/MrVEoCoUMdGoo+4yD8nLnBQc58Yn4Ee5nTBcbmfAuhdcDBhP9wFtt5slriWl
	 Zasolp+UEHaKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEA34392704B;
	Fri, 27 Nov 2026 16:58:24 +0000 (UTC)
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
 <179579870334.1588391.16596108031338379789.git-patchwork-housekeeping@kernel.org>
Date: Fri, 27 Nov 2026 16:58:23 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] spi: cadence-xspi: Fixes and ACPI changes (2026-11-27T16:07:58)
  Superseding: [v5] spi: cadence-xspi: Fixes and ACPI changes (2026-11-20T11:59:18):
    [v5,1/7] spi: cadence-xspi: Properly handle errors in .transfer_one_message
    [v5,2/7] spi: cadence-xspi: Reconfigure to STIG mode before SPI message
    [v5,3/7] spi: cadence-xspi: Inform SPI core about size transferred
    [v5,4/7] spi: cadence-xspi: Clear "SDMA ready" IRQ flag after polling
    [v5,5/7] spi: cadence-xspi: Drop useless cdns_xspi->cur_cs
    [v5,6/7] spi: cadence-xspi: Rework resource discovery
    [v5,7/7] spi: cadence-xspi: Add workaround for old Marvell firmwares

Checked 246 series in 3.27 seconds.
This project currently has 17277 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

