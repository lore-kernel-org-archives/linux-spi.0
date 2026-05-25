Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DCD3A784A
	for <linux-spi@vger.kernel.org>; Mon, 25 May 2026 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779692279; cv=none; b=sYjShv36PSbfBXLOgi7oRghbcEipRB1QQ57p1bR7P0lNo2uGo7i0GyMlqPN1WjIL2BetbgW2t7wvZQ0mphcAsYdLgS/8crFli0nuRvMjvxiUWCjnKWylGA1YlIxSP7MFhRRJp2DVxO/g69YZvKigZ3XdSlgrGL7OCR5irjqLUDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779692279; c=relaxed/simple;
	bh=geztMqZOCyGiY6jZgLlQ8OiXoepRM7rKuOOONppmF5g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=PCOCyiYO1/xnn6FkBh3Cit5NP4GxRP3DkQC+lQgY9E1Ea79jWilYidVdPjxcvpY+i2Ryw6UdiuEb9zVQFjorFMRwpuKC7+Q2Sx6NQWTR+Fd+bu1UC/9wDp+0VD08y21XsCV+cI+jwXKt2KHnGaDPzPxFdJ6f7t4COcI2PM1Rffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOXjK42E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOXjK42E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E741F00A3A;
	Mon, 25 May 2026 06:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779692275;
	bh=jkO5gjxx0Xdz5bqIwHfhpSvJKTVnSI8CJUyOALsadw8=;
	h=Subject:From:Date:To;
	b=iOXjK42EULQ8OkyXG+8i+FmbROpL1KciRkws9u9+fl5C61/Z9nDLivbmhF71gXW5k
	 SCzn2Z6BREaGG3BXRD732uNYTKXc2H9ouadzlR5htTQPSYZDyLZ0lSiJAuwIRqjI2A
	 8OjPuCbmZhxhN4KpUTK3U8oP2bSesls9NUZ5hFHEJry+A1RV/y5/yn/3+uGfQWABSo
	 9d+L14i8tHuywN59gEAY+7UZ8K40b+xGwYquWp9BsIdpX/gDVEviZWeZR6CZN4g1J8
	 23UHZYsVPT9UnDQPxbTw0zVo6XdGj/l23gOxgS5llUBvQc74Cbbz3H8arBJ7CpnLdh
	 R5xTBqnkkOw5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C9A380A94F;
	Mon, 25 May 2026 06:58:03 +0000 (UTC)
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
 <177969228239.2444448.13780866716900664360.git-patchwork-housekeeping@kernel.org>
Date: Mon, 25 May 2026 06:58:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: fsl-lpspi: fix DMA termination issues (2026-05-25T06:23:55)
  Superseding: [v2] spi: fsl-lpspi: fix DMA termination issues (2026-05-20T09:43:06):
    [v2,1/2] spi: fsl-lpspi: replace dmaengine_terminate_all with dmaengine_terminate_sync
    [v2,2/2] spi: fsl-lpspi: fix missing RX DMA termination on TX prepare failure


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

