Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793347157;
	b=2wBAtyC5O/vO3XY3k/IU6jkt5jIOyULWdA9Qhh1q3rXjmfaN0KaNP6FMxwLrVp5mORMY
	 Q/FRN/ztXv8CCTvUu5MhoAI07RTd1Js9buurKU0iw/zrkEeuuta4arv+K8/PSYjiyHZ6S
	 9txrIuXKVKdgUn9UWzqA+S9HUpaYnCpW86P59Vnz0lh5bM0FZSD/jBuegt+45NAA3iTMw
	 Jj+tTvKbUD9g0SKPfDN4fGe6dFmGvx9Q+Jc62YraSlZbrYqLPV/aypZa8saur+6PQG9EE
	 6h1mWGmORgJADhKV3UJvQzRSfdEo/8fjJcWVdAIP2zrvnODCVQGKCwQPXwgJbm821Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793347157;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=NLJCgEescgZJ4uxyHY/At6f3KXSRIWmUGFz964hq8Ls=;
	b=Qv20talP7hARfAPAbG90So+/yIzCZANGyLxdim7qiarZ7nO6EOVmg80PqiSULMi34HT+
	 y4LJEN841kMrz/TWDcnenhCc23/10tNWW3DWGY+njDeo0oXrLNhtCCb2JrcwXRZsMHxDX
	 jSbqx4Xzoa2pPwlFk9hsX3G6OKQLy1ypBG6wFcxlN1M1JpwF79ZC+qfd4u/Djwy6nCJ2q
	 rY6cPYLlKW4TcppoIUgbiFkLf3EOJJQ0+sEHmFAPnuSFSXUUHnYX0+FpRLeN0ebtiwwrG
	 6Vee6SWJ2VfB+nV/0aMurUgyLHJkztPxEQ+buTxeifp8eI7Fi+Zi1HHMm12nhnS60mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnaUeS+z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DF3606A31A
	for <linux-spi@vger.kernel.org>; Fri, 30 Oct 2026 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnaUeS+z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CF01F000C1;
	Fri, 30 Oct 2026 07:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793347156;
	bh=NLJCgEescgZJ4uxyHY/At6f3KXSRIWmUGFz964hq8Ls=;
	h=Subject:From:Date:To;
	b=fnaUeS+zk8H+FP8zie0D6c6aIoOjNFnQ/0sZy/eiQVxQoAop9tORamuOtwyxtLTbL
	 9Q1I7CXMIWH93+e8kyH5YTotkDd0VZM3ZAaILGIzuZG2IVmCcjtSLyf0LzoSPE1wy4
	 Gratyq0Cr69uzr1Zonm4S64U/tX1qbFeWv0mARbmuzxlzXtCD3MfBwh98RSBiQbONI
	 Y5At+4v1kSd0Vh34u5ITfhGgRLtuoHnCIlfr5F4vQfjKMkqkR4fZRzGzwnLtSk+jFO
	 aWT8ZCekjAsRXmmEZd64DoejIaHhVJRPrU7WUIEgtQ//mFPpvxxOM16lEOJo90WCXE
	 Svh0CkXj0xTmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA2F238007E9;
	Fri, 30 Oct 2026 07:59:16 +0000 (UTC)
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
 <179334715524.913719.14918634795478785458.git-patchwork-housekeeping@kernel.org>
Date: Fri, 30 Oct 2026 07:59:15 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: fix zero-length scatterlist entries for vmalloc buffers (2026-10-30T07:42:19)
  Superseding: [v1] spi: fix zero-length scatterlist entries for vmalloc buffers (2026-10-21T15:01:45):
    spi: fix zero-length scatterlist entries for vmalloc buffers

Checked 195 series in 3.79 seconds.
This project currently has 16853 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

