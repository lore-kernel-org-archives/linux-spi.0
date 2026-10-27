Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793062817;
	b=XUcUcuN7E8FEHMWApIyYPaKfZ+xd2VoqnG1OE+jGDdh4pNfmWqopjATUmNjF4zeXHo9+
	 X89+3p/CsDWF5s469GolwLi70WS0Pt1ZQ9rzgcnZqIylMXYbIidYlLCBCEGCBYbizEGdU
	 VkBdBv61w2dW/ZueU0MV0UP6dpOTPgfYHuuwP9tPO1xCDU1Ouy0cPhRVM9CyM2WZb9Nk0
	 0rY/xZoHAUF7dK8iMV2awHqDuOgbOOs+5iAhpO1yKTHwq+oZhztcYxK1TgHjfi2kECcz9
	 LRoaiEII2ZUpXWOnl1Gr2i+hMshjnpK2kF8qrIfT0CCMJsr4qyU17/mnq0+DRDVYYFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793062817;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=Mgtz7+lg/wX+nLFQyvC8tCZFsu0Yeb0r5EucTlbL3Ak=;
	b=jDa3KWB2gPgHGW2K/J4J+spNj7wxAVnXbVFVuEKXX44Mie0a4v8neJGTYg0aXmr9wrlf
	 ofpstlIHPu1/LCFThwFhrFSrmB7r+i2xZ4LeLEB6a5cPkT1yyjU19TIojzC5MGn+BXP/c
	 2m+32dB097OFADJGtuMhlmXjiodmjszZ+CdsVXZIPyeTh9xam6h5wq/mh3fMZemJO1e8U
	 +nNrigOiLk0cumw4OHXRPGYGAHOMBoMInrgiI6b33C18LUdj83pmXnbGAjQOvrr9goxLI
	 S1KdU51TfaJSJhUNVux65yjimfyf+Y4gRvbv8Ursjk5b2C3uzB3fLcuN4sj4X/SV4ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmKpBhSL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60865606A31D
	for <linux-spi@vger.kernel.org>; Tue, 27 Oct 2026 01:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmKpBhSL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99681F01825;
	Tue, 27 Oct 2026 01:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793062816;
	bh=Mgtz7+lg/wX+nLFQyvC8tCZFsu0Yeb0r5EucTlbL3Ak=;
	h=Subject:From:Date:To;
	b=JmKpBhSLHN2vTDatUTrZkNhDTBmX77hB89VsLw1bQLkyaU3jK0uWAVQa3mZyX831K
	 OgUQRIy25Sfmrt2jt5Shiej+Gkl3KUMsNepmMaBCjYyWZcwZfmT6jSVVSXLfHyzrdU
	 +Gq+FidB9EP05wk1vx7jiqmKAfGpdQKIEdvzn5QRQrfr0Du6zy8ODkF7e8EKURgqnL
	 S24G5RCtuXtGAAQLd8z2Cauiu9NJjxuhiiLwRo4sYseM/P7HBpNa3k+jBvfVZKxdHg
	 RiSxnukADNaZfqVdqoB7DlhIgPB0bs6aK+q9+lye7Up7hzBaeoDur7r2Qf1efNHxii
	 y9N2w8vc0AWBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C0FD13AA80F1;
	Tue, 27 Oct 2026 01:00:16 +0000 (UTC)
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
 <179306281536.3490591.17661887510888756000.git-patchwork-housekeeping@kernel.org>
Date: Tue, 27 Oct 2026 01:00:15 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] rust: helpers: add SPI helpers (2026-10-27T00:20:06)
  Superseding: [v2] rust: helpers: add SPI helpers (2026-10-26T10:17:46):
    [v2,1/3] rust: helpers: add SPI helpers
    [v2,2/3] rust: spi: add SPI driver abstractions
    [v2,3/3] samples: rust: add SPI driver sample

Checked 198 series in 4.54 seconds.
This project currently has 16832 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

