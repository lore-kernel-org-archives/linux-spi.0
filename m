Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793070032;
	b=K8CcWjEsBQayQ2cniLxTfz0VERHvVl4vQXXHkYjZ3/wpdWo0LXaRey47kxbLQ4IyvIbs
	 kYiG6rWclMo9l3xKQecjsMeE2qnZcbfn4AkXza4Kcn2GOyT17d9zm5zdqyeb/6Xh6DL5L
	 /iLUMXZygn+haVxSYiT+W6A+XdBpF2qPGvqD+7Yn2/ATeGGttM0fVDEnTODDN3ZazAjdX
	 z+bsO26UlPgW42b0p3B5nhsmgRQILuneX2bY92c2+PY+UsvszlVQcrk8bhyS+Eso/3Mbo
	 kWHzyAPP93DloTNgMWSyisvLFJX0TDrNw3elNFP23fuLX8bhH74yrllFrm6Jcu7ELYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793070032;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=IEDxmNlVQL9k7b27ovei/n168L5CRUJBcAliyjmI5hI=;
	b=PaKVs2L0qW05jVyZbtlK4lSK/U6zf8dF1V/IyHrkBsUibkc+vw/qVr89Uh4OSspFoRxI
	 qDaOW7n0x/MJJk4p2PmTPQBSDu2Wp+3q5bkKiDeMSHuo7SaiH1xi532dk7Y0ck/QbsMRd
	 iRMUxh/C+NJ5dx51nejaLgBUOGNoDa4kGJ3o+i2pgqia7UHXQHtReyroXWhMfDf+Xv5bz
	 6QUSgzT/DJdc6ek/nspr3ZuTfESmoO6olWlLYY8UyEbi5ao7WS++Pn1kxxQFrLEEvHT2d
	 m6uhcqJkFp7t4DORhxlVo47bMKbtwHAe3sHRXOK9NpsEIHkYpqgEoVTCKmon5GWI+ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WfNlhNcG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F29A606A31A
	for <linux-spi@vger.kernel.org>; Tue, 27 Oct 2026 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WfNlhNcG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1156E1F01825;
	Tue, 27 Oct 2026 03:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793070032;
	bh=IEDxmNlVQL9k7b27ovei/n168L5CRUJBcAliyjmI5hI=;
	h=Subject:From:Date:To;
	b=WfNlhNcGEUcdhPvU4sgLMHWGjxMg2Ed3Pje76ElVWUxQuYNjESGMWSftSKKPu/fDN
	 0A7UmivRVS0VKmfoUwogfgfXOdqH492r+egjlCna6R2N6BXn4HyCSygGWurErn+mFe
	 1FS7paVJ6uT087PFZ/5Iy5ieJ4Ut9KwVw/fvVeKxArMw1PPvRY7uB++vaCcnO1qbvV
	 VH2Xyk+Pcc2ouWc0/2drJUWgfJLelJ/eeLvFm5PONGz8BfaAwdB4ipuyMpMYZwFuc3
	 IQmjfnfdyx/EjIPXbj8s6mk9yPKfxyefiFdTwX3r2LkvU2yHkAV4Xgcfdwwy1H+jBg
	 /vQIXRusi76bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 076343AA80F1;
	Tue, 27 Oct 2026 03:00:32 +0000 (UTC)
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
 <179307003067.3531867.10837427317241635064.git-patchwork-housekeeping@kernel.org>
Date: Tue, 27 Oct 2026 03:00:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] rust: helpers: add SPI helpers (2026-10-27T02:13:30)
  Superseding: [v3] rust: helpers: add SPI helpers (2026-10-27T00:20:06):
    [v3,1/3] rust: helpers: add SPI helpers
    [v3,2/3] rust: spi: add SPI driver abstractions
    [v3,3/3] samples: rust: add SPI driver sample

Checked 199 series in 4.81 seconds.
This project currently has 16836 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

