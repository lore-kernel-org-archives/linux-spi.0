Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3220537CD31
	for <linux-spi@vger.kernel.org>; Fri, 12 Jun 2026 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781265477; cv=none; b=QWkQyZinAHigVXxqqMzUy/7pklwSNgr1hJYhHhvjJYcAV6f7gLFSVFFGbTwhbNtZqc/oQtxzgguv2lTEFaljgfZQ16fZjy9cAYlzdBPbzdt35qOtYsoU+g4zb3EZLQ7bkGUstKWHjxw4dI/eG7LFv5vieL342TQCgCGJbvc+XGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781265477; c=relaxed/simple;
	bh=sTl6GDOTIXowKbo5rAyGCIgDs8CbQU2qsRpnUgRN5zs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=tNXy/C89DkSI7EZBASLn/5hSEDiTueGo1Gf356YSb1s09GKbeUuxGChkpFPA5KyKEbihs1JW6v8K10tWabUo9qIOYflL9M09A3d1wektMud9uBuwm3paNkGfAGqSuchge/71m9i50oS6EF28OZyqwGY/O9WqkrxPjNpBZQ2HgnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Efp43K3K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Efp43K3K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D6A1F000E9;
	Fri, 12 Jun 2026 11:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781265475;
	bh=euB8sOCup9wtEairjQ/Hi81ekkDBacSnmLGtuduoGyg=;
	h=Subject:From:Date:To;
	b=Efp43K3KHRvG+nLwDAYj1Argb7d/R0KXC/aVLufIE00ReqJHY3hH5Gns+7tRXlspn
	 ncxa1Z6IfraIfGm3tgG8anFyVVqZNsJAHwO+TaWJqtEm+5jjwdK8o7jYd74l2/aOx8
	 BRqKtOaqUIURnCEXveCyPwg9T1fEvweQBjzfFM/hAmPXSbu0SjVAX9rhq5SYY0uP+S
	 7hcMKDtSw2Fb5cDuVquWgYh2PfvQTt42XpFoIKWdx/USWBojyQ2hJ3q1Rye7piR7Cy
	 +HQakid3kFalDCbdvSHdhmGWzGjZapxNQEslUuLRcPvK7ZrrN+/X24p9r3/pkznnXA
	 3TYDjCEGWHRaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B9C3931022;
	Fri, 12 Jun 2026 11:57:53 +0000 (UTC)
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
 <178126547253.630581.4014976188490433555.git-patchwork-housekeeping@kernel.org>
Date: Fri, 12 Jun 2026 11:57:52 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: xilinx: use FIFO occupancy register to determine buffer size (2026-06-12T10:52:44)
  Superseding: [v1] spi: xilinx: use FIFO occupancy register to determine buffer size (2026-06-11T07:10:33):
    spi: xilinx: use FIFO occupancy register to determine buffer size


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

