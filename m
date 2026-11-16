Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808707;
	b=hmTiA8UegYTsP4fPwS/Ef57RmXtkUSh3Z0dK2Rh0jfr5Sss5hDc5xvf+TaL4WRys20cE
	 T4dKZzAVWv1TKkzxzqNIOLMv99Ubrq+WCtZROWblrErqDFQaBHinF5o1OUWdxCjhlXiHe
	 tNw+dBwVcxUkSPR/7Aih7cJ4Tlpf0G7wNGwpPAo6850UtP4PRTW7RX+FEmAR/+NIZKTGC
	 HOi4V5X8SkNvR1+9Fzida6xSUQc1LpFbKotPo7UykkixZpvqjxnTEnrlXQGbI2Wh/jpXt
	 PwMfk3HN6AW8s8nvJB1M5S7nHP8DbDqcd/C9BvnatOnR6xy5Ogmm7BGF3RDgfzTMoEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808707;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=oioIVTNnLRRcs9Br01NTwry9u/M5uk9Tn0ItbGcpKFw=;
	b=JtnmMn6kLC8l4rA2mslGxOLO7i3ZVxtQn06kzTpyTJS2AzvMCGkkhs42ucLrHy155zua
	 tXl698kj1rNdpBYF4F3WIyobMRx6goI9Wpfctnm72irSpdPAUaLMAgGYWwwxGsre58esk
	 a9t5g69PDmUVdeCXw7ZTewte8xfitP3WLSVAMXxBQJjcGN2ZZv/1rT6GmDLZBhe+kr4Ar
	 hqTS5xcly+EGfmV9wvAi5RFFBtq9zEeuzVy1PznGGOHsjLMlSuQNOcWybTfMXeToC2xjs
	 yfFLFchuqTw4U4LBaLs8WlS2/KVTBU6vFDCht3E3+X5wYr6zGs8mZ+WwX/I7baGrVWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ln5+p69t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3270606A32F
	for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2026 05:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ln5+p69t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452ED1F000C4;
	Mon, 16 Nov 2026 05:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794808707;
	bh=oioIVTNnLRRcs9Br01NTwry9u/M5uk9Tn0ItbGcpKFw=;
	h=Subject:From:Date:To;
	b=ln5+p69tqUdGQmdbiPD0b74z/uzurCdHb5jIqIJM6p3PdIoOmH7GJw/jnbZ0PoIR9
	 tk4goOvY0CrNjiRTYpE2talDojEnxQ1mgHxf60N6T2T3xeRo6YYm/CB+CiZAd+weLX
	 7MCYeBJHprnVSIyvfPtgKlTgPCL+G4IPHMTW0njGGcS5a6yKUup9Jy0MhRG+7OQdeA
	 Yb97soQtV8QQAwVUveWu5AQwy3T0jodhU9CqUz9XZl9o69v4CO3IJBM3NIpwyEA+rx
	 XlNzMouq2H4NU+J84/nMM1rXnQpm2bDt2RTmA3MwDXDUJffn/O4XXeI1mTPgtVR6Ch
	 vDs0M1XgxJ0dw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3853805CDF;
	Mon, 16 Nov 2026 05:58:27 +0000 (UTC)
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
 <179480870574.3387723.10713412381168798598.git-patchwork-housekeeping@kernel.org>
Date: Mon, 16 Nov 2026 05:58:25 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: sun6i: Add dual read support for the H616 (2026-11-16T05:55:26)
  Superseding: [v1] spi: sun6i: Add dual read support for the H616 (2026-11-10T05:34:25):
    spi: sun6i: Add dual read support for the H616

Checked 220 series in 3.12 seconds.
This project currently has 17072 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

