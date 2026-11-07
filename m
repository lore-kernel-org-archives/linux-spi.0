Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062409;
	b=bx6M6qUBNlOnCPUaVoGHbrAJPyECjSsIa3+GIuRJ5xSZSPTLTAfU3SlDvBYJQdyr2gJI
	 53zjTkNt+VV+X+vPYBOrb2+dFVoFf+djxLZvRUK/tW8S+Ys2xXDFJRmAfdQizPyOPHi/F
	 Ka0rkE6nyqNLGHoMdBzHvALJT4m1m9xLWgUtNTfiHLghfiLEcDbV+wSwGte/6GL57d5Is
	 zbhJQrRVQIavTuORCpyZRuAf7Ca3YU5CS8S+G9GCgYYxytfqIPjQkRPH0utWMHZwRZuqL
	 bN9OlUzhrw4TRIZ+iLfB4ziyNABeYhF8t5/dAfGAMkYiRWr34c5FewwVv72u8RgPHYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062409;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=u8rarf8t3eUzmhOcq5q3dMjzeYju+Xd6LywiI+qeGtI=;
	b=3p7kwC72hmasDM6OB4qOQ8ASynfFk6yjXyCuHRFDq3uhl5rJuWVrX9mse1F+mjxQAtrx
	 9AjzXEpuZet4Y5JEb21rTFkJqBrHisW3wXiafHbZVW36kZaOj2oYq4Jnz3idt318v8EtV
	 uS5U+r1s8fFpN0D+VD32EUJahbObzXEflDXtr7Zn0QpwNzwnTJGV2HLB20FJPRt8iDFTW
	 nhDsUDdn86ctfL2apevpqxabyb7wcvwqvyWjlU7GuEOsrZgV6gLteT9wqu4ip5Vgfr6ZY
	 zsI/Svf4pRBO+ZXFlIve4MBQPkcsCo+HE8KsSg/5/eDV60yrVoTA0JO6/6LXIlrPbWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MQhx6Yf0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D17F606D82A
	for <linux-spi@vger.kernel.org>; Sat,  7 Nov 2026 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MQhx6Yf0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EE01F0089F;
	Sat,  7 Nov 2026 14:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794062408;
	bh=u8rarf8t3eUzmhOcq5q3dMjzeYju+Xd6LywiI+qeGtI=;
	h=Subject:From:Date:To;
	b=MQhx6Yf0dHBx7KtdD68XJFEt0uLtN0bwhncuJ8b+9BXNl4/57aiOhSK+Os98v/CG6
	 CTPe0nkvhmj/XyRJQLtOBo2t48gp3Z5vMGE0qxBfDCBhVv/YnIO2CZj51j3bWaXxA/
	 biQ2uLz2RkknvR01Recd/pATH/MP+uZPyfGHClI06XopdqbFuJ7kzqlPTXp6nXcl9o
	 jTc2FpRQ9fhe/5jZWJvauDttZFrA6buTqHHt4wSj0MzGxhQOpACd0rId7h4A5y5z99
	 P5ejYyVYzjPx6mJx8qMsRTtE+HYxnVifKCNddakejICMobEUHJ/lWvBNN37OR5hcxe
	 fGwz40NRIXEeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9D9C9380821F;
	Sat,  7 Nov 2026 14:40:08 +0000 (UTC)
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
 <179406240718.1202517.8062458441676875187.git-patchwork-summary@kernel.org>
Date: Sat, 07 Nov 2026 14:40:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: tegra20-slink: size words with spi_bpw_to_bytes()
  Submitter: Weibin Liu <liuwb@xiaopeng.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1193775/
  Lore link: https://lore.kernel.org/r/20261026132146.3806906-1-liuwb@xiaopeng.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


