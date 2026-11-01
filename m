Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571412;
	b=wR7eoXvyvxCaL9OW9kB7G1q3W9rl6Rfnm+1knrrvhpiouRIr/qUzlM0P0u+G5QNCj9L3
	 pecIkjy3mWTcXOuQsUx3yKYGpK0iphELos0wqEU1ifwaXPUqP9ZZ/F3nIXID/joJxF4d0
	 bLj6fNgcmP22c2453o6zi1MGHm72J0qc6iY27E0Ps1MeoQY4+kr2vfL0VsxCs+SEhJkMO
	 IEpOGlzS5aUnOaUfdJggRR4FlJcynvCG1O+VSXs3tzZf731bj3t43zd+rgLmVncGMCpbc
	 KxvZr7zaBn+5UOLfZexK5KuFDgf2+zC8XnXPFUb1+CtxMSK9c8CySzGcKpigrv3QXUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571412;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=1M18UEoj2fkXVA3N5MwFODgLvNc8kgHEtwNhvCdbEts=;
	b=0JfBMMg6S6ShaxwX8G+W1hWmkQUzEGejqJx5tHKZmrCk9Zw9s6/7lqhMCixtz3sFCeQ7
	 OalrBa48/AbYweicuTlrYP1fSkZbv/5k+T3BzWXzdjRskM8R+SeJEYGJnIApIe0cLGoaj
	 QLIcZiSgEhfIJ5/M5GNxYrppWYQ6uinYgpLPArzqMeTV0zeHSAvEoifRprhEmrWMcLzir
	 sladll9yEVUU3k7obWdVo7aD7FOy3itlzifNdJPht6pZ47T/RVqNhxNlmltupftYDzvZ/
	 /tobGmAMOQf9QDkoxHRJrAP8915RkJzY0bcu19W8UDp3X0ey1ZV8Iwyl/6PrDjGBo+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4ZsiFDt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C5A607214C;
	Sun,  1 Nov 2026 22:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4ZsiFDt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59771F00919;
	Sun,  1 Nov 2026 22:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571411;
	bh=1M18UEoj2fkXVA3N5MwFODgLvNc8kgHEtwNhvCdbEts=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=G4ZsiFDtZ62yw/+PrdD8L5Da6gB7BqqsvG701dZBR1txA7fSnfvZerKJe/hPf9qvZ
	 4dhfa7sn+SvyWYLr7JPbMzZROg2ndHcu7yFY9M8ejckEQk4zQGTsveX3hMKIkIAR/h
	 PEOoFYc5ThbkMFFjiIdoT8PETipkrDFzVTx+1f+O/+qNRcnzOuAxDSUC01qJCR5DHV
	 IwXAm8U8f+iDeO4dcnr2aFpB55Po8yP/uLgPpGwbX+WgwBeS9CZ3V717KQuYvMjhJQ
	 epfyR6Fge8m1DNcfsWd/uIU03aC59pi4rQI3NJu/wm3NOxeMOZXb84fp+XODxAaIA3
	 sDGSj81m6UQ2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA28A38003B8;
	Sun,  1 Nov 2026 22:16:51 +0000 (UTC)
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
Subject: Re: [PATCH v2 0/4] spi: sophgo: Fix SPI NOR errors and clock limits
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179357141023.2624073.834055517039065391.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:16:50 +0000
References: <20261001-fix-sg204xspi-v2-0-014dbaf22b5e@iscas.ac.cn>
In-Reply-To: <20261001-fix-sg204xspi-v2-0-014dbaf22b5e@iscas.ac.cn>
To: Han Gao <gaohan@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, broonie@kernel.org, looong.bin@gmail.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 chen.wang@linux.dev, inochiama@gmail.com, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, rabenda.cn@gmail.com,
 lihangfan@iscas.ac.cn, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev

Hello:

This series was applied to riscv/linux.git (fixes)
by Inochi Amaoto <inochiama@gmail.com>:

On Thu, 01 Oct 2026 02:22:49 +0800 you wrote:
> The SG204x SPI NOR driver ignores transfer errors and clock limits.
> Fix both, enable SPI NOR on SRD3-10, and use 12.5 MHz on SRD3-10 and
> SG2042 to match EDK2 and the vendor kernel, respectively.
> 
> Tested on SRD3-12 at 12.5 MHz: both flashes identify correctly, SFDP
> reads succeed, and two full 64 MiB reads per flash match.
> 
> [...]

Here is the summary with links:
  - [v2,1/4] spi: sg2044-nor: Return transfer errors
    (no matching commit)
  - [v2,2/4] spi: sg2044-nor: Honor SPI clock limits
    (no matching commit)
  - [v2,3/4] riscv: dts: sophgo: Enable SPI NOR on SRD3-10
    https://git.kernel.org/riscv/c/0fe449e8ff7b
  - [v2,4/4] riscv: dts: sophgo: Limit SG2042 SPI NOR to 12.5 MHz
    https://git.kernel.org/riscv/c/a3a8c25c59f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


