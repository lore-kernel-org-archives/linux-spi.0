Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A551E98EA
	for <linux-spi@vger.kernel.org>; Tue, 11 Mar 2025 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713602; cv=none; b=WEMaqdegqaqGdWtXvGEG4fb2TPzSXQUdE29GuZ5bpvHoN1J7RZ0HbEoWHpOSHyz6rJq2kDCFVurPOLqFYFPOJVTWI/UTWoI60rgX2XL3LVOwWjY5J55Adk+6Uk+Y6UdhLCZDQVjENBN4XlxKS/6kYIVmu3nU9NunlpGT0l2lCR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713602; c=relaxed/simple;
	bh=j1PnE4tZAaw4n1jxekhU0yGNT/sd+/50/Qlxw/P9XWs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=X3KSLG6Wn0O6NBFE7ksoxKGNRoqUlbNQsR21fEnvpPrb8cdz8nbGGuvdCo31pHMdyuEurpi5akwGIFsulXNvzlx2WZodJ9JK4jX1B4AygbgEDYMSgty1tI+wgHGgHbBSKYjuQPd6FRWk7lvQLyPYbQulu35Jqs4goy3hplRPgh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ax159eXS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax159eXS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6E9C4CEE9;
	Tue, 11 Mar 2025 17:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741713602;
	bh=j1PnE4tZAaw4n1jxekhU0yGNT/sd+/50/Qlxw/P9XWs=;
	h=Subject:From:Date:To:From;
	b=Ax159eXSCYZvTq/IAbMa9cKCHu1PajG4VRWOGZoT5SehfkL4HXDfEdPlwR/Ldu/fB
	 Jr35icbQFV/jLDcqLgFd94mxX3JE6O8uIx0/SPl4jd+BOSfWMHwEoqsYasww7FNoFo
	 y/jh7OKG0vy1KrOEgQz03XzwLnLJc8irFZj6Yk6+CBxBVLIJTpjt0fKNroi9gk5KKJ
	 YG/SIoIWSHJIkOazRZMtqk5cbM57dOFnUMyysyMV+VXESFiZ3+eGIY4Cv3Fsu7TGi+
	 5voDXIlKg4QoiIaZTQDAzwjVZ+T8enDC8OMpF74GaJq86t00IAUrKKEhj8k0eJHDVe
	 2BN4C7HelZqgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7AC3B380AC1C;
	Tue, 11 Mar 2025 17:20:37 +0000 (UTC)
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
 <174171363583.164155.9751003667574393459.git-patchwork-summary@kernel.org>
Date: Tue, 11 Mar 2025 17:20:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [next] spi: spi-qpic-snand: Fix ECC_CFG_ECC_DISABLE shift in qcom_spi_read_last_cw()
  Submitter: Dan Carpenter <dan.carpenter@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=940930
  Lore link: https://lore.kernel.org/r/2f4b0a0b-2c03-41c0-8a4a-3d789a83832d@stanley.mountain

Patch: [v2] spi: mt65xx: add PM QoS support
  Submitter: Leilk Liu <leilk.liu@mediatek.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=939856
  Lore link: https://lore.kernel.org/r/20250304024045.7788-1-leilk.liu@mediatek.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


