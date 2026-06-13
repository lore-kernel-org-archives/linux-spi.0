Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C0635DA64
	for <linux-spi@vger.kernel.org>; Sat, 13 Jun 2026 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781380671; cv=none; b=KZByzsOu71JkB3anQI8n2LOrGGv8LoBgNLhfomWr5X8N2io+vLOCqRz/VxNXuMrUT+flbWC+e+r1PlQ96gV8kxvQGHUdy9zmsKivLiDO4+iebkvntuRWm9hT/HXszk5yGhv7zk6nGI7xt4IoN2eY2oBmEYoECYe48Zeu412hW2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781380671; c=relaxed/simple;
	bh=yUK82KLe9fEgSmKijErsqF9pRskRyzk3c8fLBWX5PxA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=W/GMq9iXmjNpSTRfZBFaS8U/pe4ZlcaEJaZRP8kGJzqvCHYU5vHC/Lmf54eloHvFuYUxPQY9FWy3dlW9qXDFvPBxi0IQwzFAHIqGMlUoM835oV7IrIBF6olHdQimcOgCAydV0bm58+d5v1qFlSCRk6fKMlkBqHtTUwEmVyVi1L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJEVxMru; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJEVxMru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7271F000E9;
	Sat, 13 Jun 2026 19:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781380669;
	bh=QIzgx2fMG1M3SN6t3koKFNIx1tYFgtjb1q5nw1f+Dio=;
	h=Subject:From:Date:To;
	b=KJEVxMru26AptLkepNzSZVsmfeQrYOXO0bRxCWYBDCDtuBAmz3ZoXk2nM/WoV+2Zo
	 7bj9geFo3MRxAJMKb1WvaPhEJDapNxZHwsH3cM55+3+rm2Rd/3Rh87eaSe+WTNz+1n
	 5eiGg3dZGdm9LuKydvCvDmrty9ArP4ti32ZehJyzFlOSEOdx/W//lJAgUHtEZO2PA6
	 IHtEaOpnqMz4ICwiVwKP06YJbypOKiRgzO6TbYbFeMA8IYamSRUwaSsYdMgggls//d
	 oDtXHWqE78pRnO0BEpi//zH5V3RWpNhNEwxOgb48/vjTPfSzKBUQ+rRCri5JgfegZA
	 J5ls3DA210WLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D34E63A54A32;
	Sat, 13 Jun 2026 19:57:46 +0000 (UTC)
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
 <178138066541.1577028.8829706337739741881.git-patchwork-housekeeping@kernel.org>
Date: Sat, 13 Jun 2026 19:57:45 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: dt-bindings: octeon: Convert to DT schema (2026-06-13T19:22:33)
  Superseding: [v1] spi: dt-bindings: octeon: Convert to DT schema (2026-06-07T14:23:56):
    spi: dt-bindings: octeon: Convert to DT schema


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

