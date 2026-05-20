Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120B73469F6
	for <linux-spi@vger.kernel.org>; Wed, 20 May 2026 19:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307059; cv=none; b=BzJ+XQ1trJrIg8MGLLnZ32vQy102YImJSga09yQNZIeo5AcRtW7nXB+glkwWz2OLp1AkXLeqmps4Gzt2YVzXQF9RyKSjLyuh7zVbna5+B1q0QLIDcvLxWTi93WKKEbQV+6D8+842BHOMjMefjjIaag8l33X4BVKJvEr0Ix/qPFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307059; c=relaxed/simple;
	bh=Ogb805pMckRQ56PMKLMLPstZkwVBJMUfCLZ2BPI78uw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=iwB3BttX8FURb244PRYsGHUM/nqouFfPfGnAmye/PtTvzvi4bU6peGCRlEZ2vIR2KFoAs8oB6U7XrNAYk1EdKhbm5MCPluxb8hFzK2g87Pbmt+cCjnlwWKPK/96Y+aB4lVC4O+g6u+iiwJTAj+SF8VKAUDReLYp9BYKukZUUARs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ndw4wrvH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ndw4wrvH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6B91F00893;
	Wed, 20 May 2026 19:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779307057;
	bh=o8eto4l8tgFfmMKW0l1N3CfBO382T4hKuzNflMJnq4c=;
	h=Subject:From:Date:To;
	b=Ndw4wrvHLFPF4CcLmUbfhN2muo/aT3LqIgcx272/Qr3CxuPMJ5lvaaep0pqu/WuHq
	 Qnhv78cxC5xC0/rBejCSbyK4KjffUtmAKsSFdwYWJ3+/BquF+4r685HFY1s9Oa/ly8
	 7100iAK8Q7tHOFJSPlw9gCccbaxGo6JaK3yT6g4XUlzUVjdVwq+InFvRpUQR+SRPFi
	 7iOxSlIqumva4xwQJbeFg58jQUo9x2ieWF+GILO8phn+tnkHkA6SaTkgIWuiL5pajE
	 xEBXGUNQ1biSrSnBil1a4vmHscRQTmDXFS0ShchfYJJGf/kM/PZBCl/qUJ19rpphGA
	 D05nEVXPWZM5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5690C3930BAF;
	Wed, 20 May 2026 19:57:49 +0000 (UTC)
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
 <177930706805.3735561.18344686572348809765.git-patchwork-housekeeping@kernel.org>
Date: Wed, 20 May 2026 19:57:48 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: tegra210-quad: Improve interrupt handling for loaded systems (2026-05-20T19:24:04)
  Superseding: [v2] spi: tegra210-quad: Improve interrupt handling for loaded systems (2026-05-19T15:51:06):
    [v2,1/3] spi: tegra210-quad: Convert to hard IRQ with high-priority workqueue
    [v2,2/3] spi: tegra210-quad: Cache TRANS_STATUS in ISR for timeout handler
    [v2,3/3] spi: tegra210-quad: Process small PIO transfers in hard IRQ context


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

