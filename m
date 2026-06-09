Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7EF3FD14D
	for <linux-spi@vger.kernel.org>; Tue,  9 Jun 2026 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002693; cv=none; b=tNG4gi99pPSQ8pp6Nm8olpkYh4/14960d79T0luxy79YoIqCA1rIuMvhmeiCHBlLrdvcv/fxHqL0Y8fqCaFU7qQMvRMCuFQY56MfiX/BsqyyRKjFDYkauiMXYGHLXHL07CSNjbZxEdDEhFmJPNgjx9sA93Pm8be9TM6w4hdiXLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002693; c=relaxed/simple;
	bh=5Mi6CJHkMUg+raUDE6kyq+YkQku6mTbhgi7famqLheQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=tL3yBdBHCAL3lfTIG85HAgtdRKjDZAhlwqF5xptDTwyJ1L7shryyLvNAKtQBp5aDvxjvu8jiOutNq/la0KZN7QqmBddIhYIce244rGsg7P58iCYnOX3Q81D/liUkASRK63IniyA90Jn+EOrLIHoqYcPKqmPoctYHnIaOyb8vLA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJHDv8ls; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJHDv8ls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5B01F00893;
	Tue,  9 Jun 2026 10:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781002692;
	bh=mr+174CBVwjmnJvGmmlmcQZaVRmHcwnDbcuDUCffj6Y=;
	h=Subject:From:Date:To;
	b=HJHDv8ls0biZhuUzr3plImoT0ZGuluqPPcClTxIq3UGFGaUlwwa38nSHorzHKCf5e
	 hSPO/MjHqsUmuPRYmA/Eo7NoF1zUI2Pj12jX/Oc4VwRHycVWUJhHsuA8YrS3Y1VIab
	 wV/3mFpy2Maw8KeXIa5kMR/3XPi1gH9JSvn6RBJZmX2a0Qug5zee8UdYhjxqC+YG/D
	 l5XjTogszotXQKi6xCopRUjGMKMIlKYF9UWxJdZ09gaPqoVuo7wY535j/zgshpLTGL
	 p3u8Psvg3Gw3Mo7CDoqGZkDbM3gMFzzI0QF5EzxW17BPpUhdHy+zNYxycqO5Kkki6g
	 Ta+ezaop6njgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09D03930886;
	Tue,  9 Jun 2026 10:58:11 +0000 (UTC)
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
 <178100269060.1955839.13701866558141979743.git-patchwork-housekeeping@kernel.org>
Date: Tue, 09 Jun 2026 10:58:10 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: dw: fix race between transfer IRQ handler and timeout handler (2026-06-09T10:29:55)
  Superseding: [v1] spi: dw: fix race between transfer IRQ handler and timeout handler (2026-05-22T09:57:27):
    spi: dw: fix race between transfer IRQ handler and timeout handler


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

