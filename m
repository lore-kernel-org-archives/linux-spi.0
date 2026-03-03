Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764C3428834
	for <linux-spi@vger.kernel.org>; Tue,  3 Mar 2026 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548215; cv=none; b=Dp6gdXT+5jf1Dk3FS/82IgLS9mMMoC4waDhhwmboOyAbojUUTPCDH3/6iFvP5rAZtu7fGsOHFHFf6k2UfjHGjPtrq+sYkT2BDaab27fXTmbrUpaYGngH8KznynuyeWEXRMbsrz8KjQk5M9AFrxaiFflmqhnopn6wetYOTXfS7gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548215; c=relaxed/simple;
	bh=Xv+7YB+YllIJDK0xqvb52E+sUpBnE0+ND6wL1AsQmbE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=b/llaAk6jU8y57vdC3I2UhKcI1HSkVoaDw316Qvlvptjsot4tX0AzhiuJ6mE0BEqKWI4iI0A/RqyPaK3YNQGjx5l0pIzJnqTD1ZW44Oib7xs0CU6YlfjRp0OvJHzkyqJuaUhGCh3mE45jXeYcitDgtjJ7xXgRFXh+VVos+J3q8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKvelPdv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKvelPdv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DC9C116C6;
	Tue,  3 Mar 2026 14:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772548215;
	bh=Xv+7YB+YllIJDK0xqvb52E+sUpBnE0+ND6wL1AsQmbE=;
	h=Subject:From:Date:To:From;
	b=BKvelPdv38hoiahFbknhzPfLxjwBKYBk0IqO2oXUogB4W1sTSzdboAslYkWITS08o
	 B9e5aIZR/3k9zqN78G/fCDBF7+Zf7e1SH3S2c7mYUpYYLw5RJUxWFVtkLm81YH84pp
	 vn9TDBx+8L+/9iV2iPXpk/bdNZOKKRsjxu9IrtGrkUJbOegRgHjVeoI0Uc3cAGWY96
	 tcZxRDEDq0AbiU9qJuQ7XqQWin0JeynOtKZEiN21YODkqja+LXrMccETy+hvVEnPnu
	 nmnDtPX75WLpkW8F/2JowgPsI3qMzqTXPjTsKrI32uegM8USqEOS3rcuizv+HkyyHE
	 WtUspJA2KUw8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7FDFF380AA4B;
	Tue,  3 Mar 2026 14:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <177254821606.901668.3017044513745242941.git-patchwork-summary@kernel.org>
Date: Tue, 03 Mar 2026 14:30:16 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-dw-dma: fix print error log when wait finish transaction
  Submitter: Vladimir Yakovlev <vovchkir@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1060298
  Lore link: https://lore.kernel.org/r/20260302222017.992228-1-vovchkir@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


