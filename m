Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A626D379991
	for <linux-spi@vger.kernel.org>; Mon, 27 Jul 2026 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146321; cv=none; b=kQoRwN5OkW6AjptfRiXACdlBYVfWXKgqbUfeYSMreqhrnJ5HA/84aQNwi6tZSpCfAdg5XEtk0rnsxgqgAR5T8JbMLejuJBY9tCPRUCwryyn3uq9+Upixv1K1cWw2bLfJWr1hrDz+WQP20sYPmvXHDzQsg+JfF2lWjKdPhe4fmkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146321; c=relaxed/simple;
	bh=u3abamYN+Qw+Xim2pb+LKj0DzUBjS1afy7Bo/3jQ+jg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=qD2QKYqzyyr+cM32sFJjqucS8LI25OBud0sy9OBVmD+FRiv4pso/PYfqwlHjR/SYkCJWDV82Em9u7NBdiq8FhPPSbsB1+08a/Nxf0/IGWPWuMIZ/AiK3JtCo62c5dCBE1LzEIuced4wBTEchSC0Cwp9pObIFFisKgwFLp4yVDSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8L8GoAE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8L8GoAE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAE01F000E9;
	Mon, 27 Jul 2026 09:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785146320;
	bh=KEAUQrT+mT7TDFhB+dktOEVvl3qnnJsFXrAiqXu5SBo=;
	h=Subject:From:Date:To;
	b=g8L8GoAEtlMBffwMXLQaUXS5SMC1fsxI4BS/NNyV+7yurrMDqPQ5QrgQ7wpKA9+GO
	 JXNl+hwYLPQ2slXI/GmFf+fDt5sNHDMyUV1cHA0sKN6Y6CQ+dtlH/BkgkRb67K/gh5
	 Gu3j5mJlLThBdgVSMreWEavG8LIME/Bs+QwScF7q6QZrAW17MuBm96Ix51YbgA5Kwt
	 IHlo1zFCnPHeKFGCegRhwzw6cM0dS13DIe/lu1Ubk4fkCIvNqJaP3LRPzERjQlqQYp
	 ddLBxt9p8itvQuSn0i9EmT+OM3FXQybjc4XhwSYiIxHb+eYtAPEN3HGWND48CE0Ue2
	 C0A7R6uo9Y+5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198BE3809A36;
	Mon, 27 Jul 2026 09:58:07 +0000 (UTC)
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
 <178514628569.717496.4652361750307942909.git-patchwork-housekeeping@kernel.org>
Date: Mon, 27 Jul 2026 09:58:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI controller (2026-07-27T09:18:31)
  Superseding: [v3] spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI controller (2026-06-11T09:12:44):
    [v3,1/2] dt-bindings: spi: nuvoton,ma35d1-qspi: Add Nuvoton MA35D1 QSPI
    [v3,2/2] spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI controller support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

