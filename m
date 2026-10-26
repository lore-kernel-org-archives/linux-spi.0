Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016046;
	b=mlW6aZUG6EXY2ag8VVHj984saAC7UfW3zwkInnRElVKVFZxn3dJ5zVSNuCwlbRMqgVOz
	 gipxZyrp+6vHM2fyTmHuF7DP96dMRZib5XdNbIggoPvmFgU4s8p7GPdZn102wglAZvBPC
	 eF5f7gVD0jeh4wwAidiVBgVlOZLb3GIVKEq1CsUcXub+TL9CqhiL4CoiDaCYRNXJmP5fB
	 R7KgISNl3zZKiOnQyiQW0D4xF5USEzAnZNZqvOPH4ZOPsbuiplV/A6bRnavzJt7RtEr3V
	 BtZrB3wquUtWxRK1YURIbm5R4zNltlvex/eBwEuNyWZ8WHLJknKD3L2ixrmWrWyJ/sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016046;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=8SnXv0dp1Z3xNYSOFmb1/ySVNOu4onZXlEaQqZsu5aM=;
	b=KLjopDwDAPwjVhsy/i5Ga5Sw8w4Uccy6BgQ1j4T5vu2ZOLsc94Gt93tOaiGRJQx+OfZi
	 J2Mc6874XqxZARy2pBQ8OZ4iWnhpcRp/+sJaBBqc5OGWH7LuJPqBv/zX02KT7CGLfj8gp
	 vr31ao74jtt5crZk03BRdqmJJNSG7SkD8Mz+4fHhTVKrRciTpy8huHvAao4jZOO/ZjR3q
	 ibu/X/AvPhpCAo7gzmw8fiEgLgZg+Iw5HMr6NxgSo8QY5cql7iWh7IzN/hk7Iku4Jjw8h
	 62wnj/VH/lfxc0zyneIur5MlNXJMOFPdK9C8uklnfZKdOv44+tIT9Tpqip7W67SoBkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l49rbiQc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E623606A31A
	for <linux-spi@vger.kernel.org>; Mon, 26 Oct 2026 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l49rbiQc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953C81F01825;
	Mon, 26 Oct 2026 12:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793016045;
	bh=8SnXv0dp1Z3xNYSOFmb1/ySVNOu4onZXlEaQqZsu5aM=;
	h=Subject:From:Date:To;
	b=l49rbiQca4KM6w065kzJJCjBhJlJYT9j0OIFWYE9ZfzNZ2kqcX4q3arqc138OC1h9
	 SiGgvOdXwlmr9rkdke9qeKz92XQX0P5471GGHcOJjuGNnlx3aTVtWx+GxCShuIoxo5
	 AGrkAvBh5daASDghy6IzNp0hy6fN8tIUfh0kBA3WFGxakin5cxmiI+E/KK3a4qcvCv
	 YB1ren+yAEWsGv0MPuYyHsekRinlm9DX/uu7wrYFsARqDnZl7YoL5Z3hcKLV9rTNjn
	 3+B0z8f2+QJAnW6wk+YeFzir1CKJJ/yiC5CU1PImS4vj+3eXtkAt6vkJyEkGRd9Jtt
	 nD/a9xNubYtWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 83DFA3AA58A5;
	Mon, 26 Oct 2026 12:00:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179301604409.2668412.9671082608886928530.git-patchwork-housekeeping@kernel.org>
Date: Mon, 26 Oct 2026 12:00:44 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: tegra210-quad: Fix timeout path status handling and DMA leak (2026-10-26T11:14:10)
  Superseding: [v1] spi: tegra210-quad: Fix timeout path status handling and DMA leak (2026-10-16T13:25:19):
    [1/2] spi: tegra210-quad: don't overwrite refreshed status with lost-IRQ snapshot
    [2/2] spi: tegra210-quad: Unmap DMA buffers on transfer timeout

Latest series: [v2] spi: mtk-snfi: use min() in mtk_snand_read_page_cache() (2026-10-26T11:20:33)
  Superseding: [v1] spi: mtk-snfi: use min() in mtk_snand_read_page_cache() (2026-10-22T10:20:20):
    spi: mtk-snfi: use min() in mtk_snand_read_page_cache()

Checked 198 series in 8.37 seconds.
This project currently has 16826 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

