Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451A71A23A6
	for <linux-spi@vger.kernel.org>; Fri, 22 May 2026 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779454683; cv=none; b=oBG7Mm43Jpo9E5EALCW9Rz6ae/8iAoK/iR6kU67d0vLhbgH590g4RrGZVpnh36WddWRNFXr0r7fpIoLOOfog2t0ypJhdKKdI76wrTrSm7OQeUXu46jlRPKVTmfnNTLYDAVMUeCZTBhaNLE9G9RUvX8BJFejxL0UvsTQULS8Vc3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779454683; c=relaxed/simple;
	bh=rJVT+3MpMjkis49IskSmG8Ih5hOLKQbpmNAJ6NqOvI8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=WQ49NPqGrmaidD+myULLF10aMhhRlMMHhRSqQuIXLytskq3oJKmDToMCrd9Hnald4/bHutI0par50uGn/nY0R2DfRm90MuN6Cs5c/YegWmQhQN9RYgd7U3uAx8fGxxo6iuTzDl8Hhzo/w193si0YpSdzlvwP3oBlNAyMLH3Q5mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcLOh+fc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcLOh+fc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4901F00ADF;
	Fri, 22 May 2026 12:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779454681;
	bh=gkSQfJKD+DDhx5HwBchLh1Q4JMAMiu76902els5Q550=;
	h=Subject:From:Date:To;
	b=kcLOh+fcy8/SoWznAYablfe8db2ZBqIt57oZ9Uq9/6G9fS/EjVfP3yn1FkJSXOa8z
	 yRZmLmu9BrSYEuSPjNSZnKmhUWGAT9R3ZTT4PkTR17zhYV53MnXE+akxBmVZLYu7BL
	 GugWDvDnZ/J/NcIvKHQdzKCMTLMhC3WWztI+FpCiu/ae/LFfS56UVJsGVUDef84YQu
	 6JWcd8P493DmhfAVV0TNWo2hsynUdA5xQ8pPw4CGp+EKAY5QwTO4YrOZqdF3P6hk2+
	 C7Cac7tb+5k68R+k2iQP0WKmbRRgJ/8zpy+fu0CSgMBZOemRsD6KG1EOP0mfOeENiJ
	 jdpF+qVe8kTGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AA93930F8E;
	Fri, 22 May 2026 12:58:12 +0000 (UTC)
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
 <177945469105.790469.14934415590592228944.git-patchwork-housekeeping@kernel.org>
Date: Fri, 22 May 2026 12:58:11 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: atmel: fix DMA channel and bounce buffer leaks (2026-05-22T12:40:48)
  Superseding: [v2] spi: atmel: fix DMA channel and bounce buffer leaks (2026-05-17T10:39:54):
    [v2] spi: atmel: fix DMA channel and bounce buffer leaks


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

