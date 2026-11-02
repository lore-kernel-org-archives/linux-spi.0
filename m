Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623812;
	b=Bz4sLUf4tw8ZgUGJBKUHOcY2Sd9UfPFnYiSt8ZRXx3vKiwu/qwhSLUL/LTqP3rZSI37p
	 JVeI0BxqY22VdGV7fALk23okyxjlwUayi4FvnZ9U/b11t98f1zzzDi3uHqPoLvpzGFoO0
	 prfP5w9Nfo04bga1d6/jCf6PH9uQm0YIELBgewx58dXtDbGUqgWJqfbkyZeZjg/p+a85Q
	 XHKEtccZdF/KaYeTW8kj2PXq/FiGNpXydSHBRazykxgmLIL1NSL8zsUc7bU8bu3NOGpRv
	 CKGX6NankBzy1gqcOq9KEOb1NOWOaQFnuZtVvfFSAW5n6qFrVLuwluQKVqW+6yWSb4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623812;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=4eQgb73Q3+NDXYB13GelTPBtYDDAYl5kHgbpf+sUJJ4=;
	b=bXj3MvkVR9gAxb8j8sEuy+tHgIZ4ZschGbxu+bdv0NFPHWjdP7Dha+iORUpeWXmv7Oha
	 Lu3EZcGiyM5IUkN9HLPE6IYqOgl2uCa8iyWsE/Ws9X4/8J1Dzu2eIgSBgMfobMmzCzUtZ
	 RKOwx3uQuxWlGcRWJnhFGrZYD2LKnhPgcf73U9G7SedwfO5ndHGShIDchYFxOqC9KnEla
	 VzhRQDpYpMICNtXovhLQQlw3uS3mXGn51qZ8ljGrHLX5iuh/HSfwQqb56Us6loGkckUBL
	 PXYV/4noCogQ4dvg6B3pHKiQl5sTn0W/VWmLhKjXjJk/IPWAKN4Je+pYsJ+Zv+fbslw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K86MCPXu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C906760A2605
	for <linux-spi@vger.kernel.org>; Mon,  2 Nov 2026 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K86MCPXu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7C31F00A1E;
	Mon,  2 Nov 2026 12:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793623811;
	bh=4eQgb73Q3+NDXYB13GelTPBtYDDAYl5kHgbpf+sUJJ4=;
	h=Subject:From:Date:To;
	b=K86MCPXurZEBayVIr7JNmE8PTJnZRhjCBEFQD9+4y0Y6GLtOkLN2HLe+jfYtyn9wT
	 JSeDicLTQR9Tk9JnZAGWM3CuiEBSE7mIPWRbcRVLMJN5GcNbZi3KebpsGWFSeqxzIR
	 4WM8OgmQdjB6EddT9FJzB9YrnyaUNYDQCvqkXoDzRwYFlLJ/LjaT3mMWcmbfyEOCDA
	 7G0tht2FOLhBXmyROGyzwJkVuktiG/8k/Ie97n+5vb6/WqXynhKoZ6WI3p6L26+Gax
	 SoKNPNMT2lFXjRz/Ui9MZD/xhLgXt4phrvlxJ5s0+0tfaR8+3zgeXTdDIGw/BdSZrA
	 PXSzCLvQ6O9VQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 42CBC380821F;
	Mon,  2 Nov 2026 12:50:11 +0000 (UTC)
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
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179362380985.4011165.8155326725781390403.git-patchwork-summary@kernel.org>
Date: Mon, 02 Nov 2026 12:50:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: topcliff-pch: clamp DMA bpw_len by bytes not words
  Submitter: Weibin Liu <liuwb@xiaopeng.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1185647/
  Lore link: https://lore.kernel.org/r/20261014-spi-pch-bpw-clamp-v1-1-3e04b3ac5106@xiaopeng.com

Patch: [v2] spi: mtk-snfi: use min() in mtk_snand_read_page_cache()
  Submitter: Ninad Naik <ninadnaik07@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1193650/
  Lore link: https://lore.kernel.org/r/20261026112033.36310-1-ninadnaik07@gmail.com

Patch: spi: core: do not WARN on OOM spi_controller_id_alloc
  Submitter: Gowtham S Bhushan <gowtham398gs@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1197584/
  Lore link: https://lore.kernel.org/r/20261031023942.591298-1-gowtham398gs@gmail.com

Patch: [v2] spi: fix zero-length scatterlist entries for vmalloc buffers
  Submitter: Chunfa Zhang <zcf1810@163.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1196919/
  Lore link: https://lore.kernel.org/r/179334613930.227576.16591083055909656623@163.com

Patch: spi: rtk-nor: Limit exec_op writes to one byte per operation
  Submitter: David Carlier <devnexen@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1197237/
  Lore link: https://lore.kernel.org/r/20261030145909.285144-1-devnexen@gmail.com

Patch: spi: amd: validate FIFO usage before executing message
  Submitter: Weibin Liu <liuwb@xiaopeng.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1194191/
  Lore link: https://lore.kernel.org/r/20261027021340.914399-1-liuwb@xiaopeng.com

Patch: spi: pic32-sqi: fail transfer when the BD ring is exhausted
  Submitter: Hongjian Dai <daihongjian@kylinsec.com.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1187860/
  Lore link: https://lore.kernel.org/r/F5276982A630220B+20261017075545.95854-1-daihongjian@kylinsec.com.cn

Patch: spi: acpi: only look up the IRQ of confirmed SPI devices
  Submitter: Rosen Penev <rosenp@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1198264/
  Lore link: https://lore.kernel.org/r/20261101200155.15740-1-rosenp@gmail.com


Total patches: 8

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


