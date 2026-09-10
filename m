Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B839E47127D
	for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2026 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038070; cv=none; b=akPpMhgdhqtH4VeCeb+SvNSEzmSIBicYnsj6Luhop7pjkDZs391ZFZkONfGZ2n6/0SLqpB8srrukcvJ0MaK9uoTgpH+aQZHYDZeiLKIBN3OzFkCXdB6rQ5LWjulXnOGOHJBUA2zJ7JbgawT+VddIKpT8+9OQLotwHc9rLDuk8Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038070; c=relaxed/simple;
	bh=+Bp7waD25JBrUVws8CVhO8RMshC4Avl1Z3TbE+rXhhg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=daCJVCmHjO4rOa+LGXQKbMkEGLqvcjG7c7IKkxBZmXQMiFG+flvHtS4vKYBjMPuTCVuenoFs3pIyWNvLqIe9Imtfs0Y7jSW/I/J+2RGFI6Q21289wwE6WkvurHTcIzvoy91D+LXhMNPWu4N4XwNkV6Tb0pTqk5T0oQsVwfLVd+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dF94f6rV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dF94f6rV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5CB1F000FF;
	Thu, 10 Sep 2026 11:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038069;
	bh=CxfzuhlwefPUeSOzejw+j/QV+GY1z7DSfbQiiu/KoAQ=;
	h=Subject:From:Date:To;
	b=dF94f6rVBxP57rtYz6XfJlgSFa6ZdAQpAJOSUIg6x3SyiL43FFsuvhK6cEyE/PKmX
	 teXwAMrCXJmPIJFIvAKz0+BkWGtwJD3JhCMOj129ieJrP4k6wX7Q6s6XJkw2ftcRwB
	 84aWuRuVGEJJhuIScCCztC+6B/V7bBOqdg0p8+oY9UsrU5qZqS6X5Z2/K1sAdr9HI2
	 ydEPyPx3H4FREPcq2SCMz+RSHgriMmiBqjQLoGMEsM/kBrm5blP/6Vn86dCjKLIP2B
	 G2lmBzuttcarif6ItRWU9F9Exo87ktc+PZR/uxdSpanD42qYFKQdrTJA+zUap3qv+u
	 DuGd6iFxc7kag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B48380CFEC;
	Thu, 10 Sep 2026 11:00:08 +0000 (UTC)
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
 <178903800704.1358329.16019816663141277783.git-patchwork-summary@kernel.org>
Date: Thu, 10 Sep 2026 11:00:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: tegra210-quad: Improve interrupt handling for loaded systems
  Submitter: Vishwaroop A <va@nvidia.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1145701/
  Lore link: https://lore.kernel.org/r/20260813200027.2711863-1-va@nvidia.com
    Patches: [v6,1/3] spi: tegra210-quad: Convert to hard IRQ with high-priority workqueue
             [v6,2/3] spi: tegra210-quad: Cache TRANS_STATUS in ISR for timeout handler
             [v6,3/3] spi: tegra210-quad: Process small PIO transfers in hard IRQ context

Patch: spi: amlogic-spisg: check clk_prepare_enable() return value
  Submitter: 李佑鸿 <dayou5941@163.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1154371/
  Lore link: https://lore.kernel.org/r/20260831094553.2247003-1-dayou5941@163.com

Patch: spi: rockchip-sfc: disable runtime PM in remove
  Submitter: Jiawen Liu <1298662399@qq.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1147833/
  Lore link: https://lore.kernel.org/r/tencent_DD16C0EEDFEF4ACAFAB5A23EC8235D462707@qq.com

Patch: spi: spi-qpic-snand: remove interim 'dev_data' variable from qcom_spi_probe()
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1160826/
  Lore link: https://lore.kernel.org/r/20260908-qpic-snand-drop-dev_data-var-v1-1-147d3fab6c48@gmail.com


Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


