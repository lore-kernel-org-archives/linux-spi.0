Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA6F346AC6
	for <linux-spi@vger.kernel.org>; Tue, 17 Mar 2026 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766616; cv=none; b=f6H9Z0mqxXD6L6Ees+drn+od5/+kYrQDb2R0u0jDfnlY/7+CSmiEyCxsLvkK03OjHMve1M6RVEkfQLRnvnC/slq1a11Qh8VPgnXrxE/YtsIpcPHz+VO+DZr8IsM1XAWtuargLS8kP7ztmYGdWRv8XB6HM7CJ71Tj7SMMBnlzI8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766616; c=relaxed/simple;
	bh=WsUJ2lHL2eVsLOUjl8Y4YGu0dVLZN/VCjtSUbNQVFVM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=twvJSNV1GUVM/gfNNU2xHVG1Q9bCISXJmCLBL++ecVyGUYdcS4VZlFF/XIJPRXDDImWo8/xr1UeWNBhYfGuGh8d/Acg1OWvUZAfVCifj00C9zPYGYjree5R6O3kSbpZ3N183a5GVaanQE/b4DYBKh3t9BOR56qERE/zW/0kcmQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnemBYIB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnemBYIB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB917C19424;
	Tue, 17 Mar 2026 16:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773766615;
	bh=WsUJ2lHL2eVsLOUjl8Y4YGu0dVLZN/VCjtSUbNQVFVM=;
	h=Subject:From:Date:To:From;
	b=SnemBYIBnWe1TtuZ4AIHBlmNomgedSCAydsMbc4DhNDT6S3nrVLoQS+38mfHmE5er
	 yx+Le579YpubtrlgiyLmLoQWJEHVLU5hCiS/9qCLPgOwanFnooH/jCoa6IUjPngU6P
	 MU6tkBY79GGMtpkPfeIE1dksUbxqdj1/kkc25lXgsDG45uqrgFEG2hPZ6P635gDoKo
	 1/dJD4dH7hFGh58LR4RxKgIruw/Khz3rMLhWESsZBy3LRcUmBmHXVxkDdwhGetm4AV
	 K184h7HeFour1ZG1b1LQGH3lLTG6gVGS5tWnrUdx0zgT57xhN1PSIawsIN0D5VIc6A
	 f8hWXCK0bvPyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 25A4E3808200;
	Tue, 17 Mar 2026 16:56:49 +0000 (UTC)
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
 <177376660797.3704984.11820778847919524095.git-patchwork-housekeeping@kernel.org>
Date: Tue, 17 Mar 2026 16:56:47 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] device property: Make modifications of fwnode "flags" thread safe (2026-03-17T16:01:20)
  Superseding: [v1] device property: Make modifications of fwnode "flags" thread safe (2026-03-16T22:42:06):
    device property: Make modifications of fwnode "flags" thread safe


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

