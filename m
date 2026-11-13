Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585511;
	b=kArXmy6sFuR4g57aOaFzcvBzTHpeFkoItRNxfIWo41nGTyMpWw7gEdDFmDpukJ+Hq+an
	 654gYhYxYrg6I5uDC2MkqOwAGWxBwCP4wifoLQ7Jz1LudImWfFKdK0DHvP6ULNiEiQv9J
	 f0t46ZoqK3Af2rcmCBMDwuhrjAYOaNIrSrgFI4bm55xxd1WlfxYOJxB/8rJFE+4KW8N8S
	 R/W61hGLAdAZPhTqYAeQBNRlsuPqIZJ9p7bHy0nN1DKrKh72p6SyCRfVl4zyTxboTAEJb
	 8DMuqb2HI/9dpa4ujSPDVPuGPxdR8JIGC+Qh6RICscwHkcDc9so+kSvqK5u6+WBgyJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585511;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=b4vfClH5tZh4HVMmvm6R5IC+U3//GoW19+sSqSYLbhQ=;
	b=xKdm1UhNKA+YzpI4wXG7gsZMp5dR3wdKBx+GGUqP80F4phywIReg/jc6ZizSlyUQQ/HT
	 PX9cYtK9Jf4U5bXhTg9s1R0hkDVHoBpL9HvWWa52v991YVMvYq6ygJVudiEd+eor36JTq
	 Ih3Wm25X6e0QIEMWY0B8ey5NBmSoruN+XOcj511pHWB6K2XT+T5h5+utbv55AWXTzYd3Y
	 erw7ez+bQQK4mFmv+0zYaI6ku/n9GGHn67vWN2T8cjtppKWgRvu3ICBearmM7lYTsWZRg
	 ojBgABdzA0DDPp7u/UhR0rc0Wnqe1dBAw0rUD156oGMwjj3k/KRF1hZK7cAoTBYK5XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="B/2hZwb6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA31606AE2E
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B/2hZwb6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126181F000C7;
	Fri, 13 Nov 2026 15:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794585511;
	bh=b4vfClH5tZh4HVMmvm6R5IC+U3//GoW19+sSqSYLbhQ=;
	h=Subject:From:Date:To;
	b=B/2hZwb6TzoFR84QbOLecONnPdXJRzFQLiW9T4eBCLsFmlhuASteu13j41/BhVgsD
	 J9I3mqFnr4rJkrCpxL5R/Z8L7MwpNoi3zx6nv9cpmrdAZx4jRvOID6BdDw6OKVyHuO
	 y6F5TdXlz7i9lWEHB6SszwXjaY9TFNpWWuFkdf/5h999kPKE3MNdIQLPdUxA3i8XVf
	 TFenHkRyEkqh1r5ArQihKuqEAOt5+dP1Q0qx9P8dvdmBPhcrcMo3FUrvt7vglmYdHJ
	 PN4rGIzvy5JisCknBbZiBZAQ6mZzQW4fwX4o7Q4PbHG4tK/3PMhNXqGlGAxbG7Bozx
	 jKfsqcH7d2Qdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F3921392B1CC;
	Fri, 13 Nov 2026 15:58:30 +0000 (UTC)
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
 <179458550954.1127404.11792864570018425405.git-patchwork-housekeeping@kernel.org>
Date: Fri, 13 Nov 2026 15:58:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: atmel: poll short PIO transfers (2026-11-13T15:20:32)
  Superseding: [v1] spi: atmel: poll short PIO transfers (2026-11-12T15:43:58):
    spi: atmel: poll short PIO transfers

Checked 218 series in 3.37 seconds.
This project currently has 17060 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

