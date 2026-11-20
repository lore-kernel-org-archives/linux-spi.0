Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189806;
	b=JIbef9/0lc1hBGxwypjfYOk4kRGG4L3qdvc51qC/6tV3nUQVIgHXiSGYSTf1hS6InbP6
	 NhQnG+/QerH9s3fnkoC4CtQJo3Zdrr4hFhuGM4w3Cc17a/6xdVrDbOuj4odIJy0LDt5mi
	 7iGSLvUOnvMg21uBX+gIUawbOkYsKe3gxrNkFVyFIZE8nvsp6C4mdoPEcQCZO5/5WaT2t
	 /vcmdCZvNcak8R1LrTAHPTj05EQyhjGhQ10HHlLrlHGCxr+Lr/FpXKyyrKOwKrFyR5laK
	 q9EdgjQTeVi47glseYxhr2NsNxWW1A9eWd/GDJVlOIjaKBPfzOMa1FhvSret2LfWgGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=tG1wUF2wKqeHFZbHEgCOitzk2QWxov8zQUD8SYGoCqc=;
	b=zHF0ObBPjx5aNzFpbH/dJ1IhhhxyeKkpU5g5QmCUROxR6r0d/LfzEjJDgFPuVOzrzHrW
	 CZIURm+GMZrYJw+N8DUYE/q9IFTSoZF69milhzO4qyHTTw0G/EIPcrjsGzUXAtIOswKzw
	 dkjCu2PXoDJ0Z4HbizG5OmbRZljcLZjJesHFzXvxCihkqKU/kGNw9Oz36dTwz1c5jYpGw
	 p2Dy1cZ1lS6Qdp00e5tjg9Ra5hWn+rSYGFUgGrFHHcCszZB5QWkt8K1Pr5Hpya4IJFQQz
	 YxuF+T71beeuZKcP0ZI5eGOGTK0MisQZdXG+dSeC25VTjEaQKnOF3yVObxu4S8kz/Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WN7BV+LS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C8760A260D
	for <linux-spi@vger.kernel.org>; Fri, 20 Nov 2026 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WN7BV+LS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09D61F000D8;
	Fri, 20 Nov 2026 15:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795189805;
	bh=tG1wUF2wKqeHFZbHEgCOitzk2QWxov8zQUD8SYGoCqc=;
	h=Subject:From:Date:To;
	b=WN7BV+LSyKYD26EvTDLaBKPxbWpxAisflfVnevRdHzHZMVWI5Fd8n+VJ/MJFltfkl
	 VjiOORs1q2xYaCGSiB9zMolad7PyxB0CuGgaEtoGLJM5ZSJmGsrNTFQHnXR95lIHdc
	 yPjM+jpMHS2P4dXc/vAO+aQSn6X6jWWhwU/NY22Y7pUdazmRHrkOA+GRff4y2xjHkc
	 SRQe0mu2ZhYafdBOhOND1bAhHuuxE+aD4VnZaf0T5dFfgLToJje7aY6shOdtAuxrLn
	 +vIS67J0Z4at76+0ydtuLvv9X4ftnARRhE5USkuMPGO3Z0E284q6HqqjcFBrbKtXyA
	 7OmOvhERjcmuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B6C243809A29;
	Fri, 20 Nov 2026 15:50:05 +0000 (UTC)
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
 <179518980438.150772.10593694217442982408.git-patchwork-summary@kernel.org>
Date: Fri, 20 Nov 2026 15:50:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: tools/spi: Return failure from spidev_fdx on I/O errors
  Submitter: Zhu Jun <zhujun2@cmss.chinamobile.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1216952/
  Lore link: https://lore.kernel.org/r/20261120061922.98182-1-zhujun2@cmss.chinamobile.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


