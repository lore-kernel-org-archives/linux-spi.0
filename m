Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9718A4A4405
	for <linux-spi@vger.kernel.org>; Wed,  7 Oct 2026 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374367; cv=none; b=QM/ZMi1mFvsB0CgQcbm7HcOXh/LixJhU/p2OFeLxgwbtHcKLJj5AuXdFSBebrIaCQyZGUm0bqVLroCUpQQLPOxhf8IUkJOMgy3KPc0nbQJnf9hAN/PJu0tc+iBTLfYIQ5EOWX3kvvMxEaRCNiF4GKAs8yCy/2ZiBe7n9EJrlH8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374367; c=relaxed/simple;
	bh=KYtekTKz4nYlWahfFcWUQ2yGFD/EXbDD5968mwku/ic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=dePNBKuufysGg2BRsut60uHjGwzkuk0StA5kag4oPZs8IJiG9TUXEyppuspeLBd/n4Qx2gGXaf/5hc2o/Hafzk4aGvS5ICmrK+f3WfzOYBsnAKRL5c3eA9CsvTAbMQkqgeGCSIMZcI9TftH9u9EEPf7MAyAOgDaxnZpOZGenuSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLlIvXGZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLlIvXGZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137F91F0089B;
	Wed,  7 Oct 2026 11:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791374358;
	bh=pk1L8wEbQQGB5RAXCAJsjAw2E2VzqgxHLa0//ztGhGo=;
	h=Subject:From:Date:To;
	b=HLlIvXGZQ3G6+GfBmjxyhwXV0GErjezCj7+tRkN3CVrjubZ2meGFYy03vRmEilw8Y
	 pec7L0DYwiox1t8UygC7M+3mL2cPfqIsGCI18kGSfSllkWskE38RoXBp9XYb7wYwyH
	 5F2CWprvVAxpHguGiwE+Mau1Rmci/PJkypOq6TtUuRJEkIWNg9XS2mbZy1GTSil6tB
	 DKgLT0wotQXz1YgzA3zLpMNwsKm0G5Pz2ZN2cMuRCbveCspSfZRD3URkkAe7ovZhTK
	 2Fzw9cd3dWgQ9Q86bQe4pTsoKKKLENiuyXlQSIbrVOQLlqYz0X0Zs0Lk0pgOFEZ/DK
	 RAn90y2rm0ADA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F3E1D39EAF49;
	Wed,  7 Oct 2026 11:59:17 +0000 (UTC)
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
 <179137435642.3066882.1429804075980190850.git-patchwork-housekeeping@kernel.org>
Date: Wed, 07 Oct 2026 11:59:16 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: axi-spi-engine: fix stale SYNC IRQ pending (2026-10-07T08:52:05)
  Superseding: [v2] spi: axi-spi-engine: fix stale SYNC IRQ pending (2026-09-30T02:17:06):
    [v2,1/2] spi: axi-spi-engine: fix stale SYNC IRQ pending
    [v2,2/2] spi: axi-spi-engine: fix stale SYNC IRQ pending in trigger_enable

Checked 195 series in 4.06 seconds.
This project currently has 16699 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

