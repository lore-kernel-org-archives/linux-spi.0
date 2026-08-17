Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D9C21CC5C
	for <linux-spi@vger.kernel.org>; Mon, 17 Aug 2026 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982595; cv=none; b=S94FH9z8Jf2Y8fuhfNhTL7EHvh7/+3Sry3xX4jTVPmBUmzQH2T5ZrAsoy16E7wUL+tpxaPZL0Dv0VTZ/Rpj0uL1xbcl8HRtNVUzQCOVJt3pUuLa4b5XBlGpSWQNQWqqHsd1dMrd4049x61UOJITzbCmPfmfqHCMfaaiIvOtGnkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982595; c=relaxed/simple;
	bh=VMVe8lnPGvqXq8RFM2ntr0UBfSyzwGI7f3aBm55T+JE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=NxGst3GecuTK2AlNTwfKgFVi1PWtBBvHkL77DzSJmEpze/VblfJR9FSXAzFhl63UgSt2THhNp5GTyECCfj3QtBXEwMwSxcOiGIO5yAXA7iVPrF9KGf9n08xn/NMNs5tgpYk6hfmV0uXsU/tcNvIk/qMB0QGSVwmrMSdFJQphF5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BF7uKVBY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BF7uKVBY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3011F000E9;
	Mon, 17 Aug 2026 16:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786982591;
	bh=rRvicgjmsYHi3Bt2UiWQWPNp0NCdGTpCc2RQq7AtDD4=;
	h=Subject:From:Date:To;
	b=BF7uKVBYTOlgW51xH9FO3MWrskkApDbXes5szdXeq+h9+9mluW9SZn41kogxgNi4u
	 qhA0UIOoVzCoKtHx4GGMXue4cDfrNGvfqgxhwUYgR3bztCLsLlXFqkm7tGHwMc+Zvq
	 jZ7yeUhqEZz3vcFLn0ecd9bxK3/CudmWM9c9yKZKj20PEg/F63T8TEbsnYVjbQbuAr
	 1BQE97bo86umL7r4rxUVHWZ4Dx5s/97mu52rqoLPwlVMqWp+x5/lLaBRRH4wuKPjdY
	 Ua06L3a/DFglakmVYRMsWh7bJOfWBHY2/2xbqCzQ6Y45eDN1F4i+Zc5sNan6nnrtQJ
	 0DKJQry/wrkIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 962603806925;
	Mon, 17 Aug 2026 16:02:24 +0000 (UTC)
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
 <178698254305.1200590.12012131164855801306.git-patchwork-housekeeping@kernel.org>
Date: Mon, 17 Aug 2026 16:02:23 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-qpic-snand: reject when no enough OOB space (2026-08-17T15:15:02)
  Superseding: [v1] spi: spi-qpic-snand: reject when no enough OOB space (2026-08-16T13:44:40):
    spi: spi-qpic-snand: reject when no enough OOB space


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

