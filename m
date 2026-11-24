Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521485;
	b=YinOcMHloM+IVkH8KPDpJU9I5B+TRqb9hfXbaEotWYRF+G4DR3lUM1ZyGriGtisLcB2g
	 pLZ2cUo9njmixwgkjUYZ14uxaOQ9H9duIeHy/wxbzn2p4yMpkGUmc6VBNLOahq1XL5/f2
	 Cyo7qu//VazKGJOfOEZLOVnP0SGaLpTWvvRFYti8XHhhJwzHGZir58G0bbmemieduo1wB
	 7XppByOVg1KqLPboZXVH7HV18Y/eylXD9R5QW/9gysqNc0sG3U/gL2m5qICXNNjzQz6tQ
	 RxI7/esalkhXYTkDIkzPhh/RcKa3uNgRTn4D/unQDv2CV6l5NqjtxNhymuhkE97GdiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521485;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=DF7sP+tAZjvTgLiD1GkuE/17wPQzBc+OhRdiDaJdPBY=;
	b=pegGCQ6mFfbuOevrLVIlvL/oPW1skqzIuwR+plx70EdC+8HfhdxOG5ahY/srirqmIZj/
	 J9Zt8Vdh5DKCxdFNXTiW+TU/8qgzD527R65wIlMPvBmv5SjKC6LMrsdn7PP3QbX8RLqNG
	 po08xJenVSUfSivNsu6YohW0Sccz+DI5WzwrkSiXcGZS9Pxjj0Iwbpj650kq708HoM6xV
	 PG/d52iiimJuMQKpiHBoNZTIrazVmLddJRfzozMQL+kqygauyq25KDwtyBtyypXp+cDQu
	 UqHSajiWePn1lTBfGn0rSF5E3oonQSgO6KmvBWZLhYisfaBXHuv61l8TAVg3/XTiF+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kyur5lLC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD770606A31E
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 11:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kyur5lLC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538CB1F000C6;
	Tue, 24 Nov 2026 11:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795521485;
	bh=DF7sP+tAZjvTgLiD1GkuE/17wPQzBc+OhRdiDaJdPBY=;
	h=Subject:From:Date:To;
	b=kyur5lLCbH2QQw7sCYRB3BFtMRPBcKk4Gt7LX9dFcC9wTFVfI5Um2ezaB5+ZewD0O
	 e6lYsFp9IRPOIj+/sl6MS+Pu9B+5zGw4kMrLsb+lZjKyESTFSZtMFA1R3Evo0HDxQc
	 vZ6Pczxg/57pazGl3K44Vh6hk58KvRXEm7V4hzsUrXzrhfnA++9VnwrQmc4wKtq3Ff
	 GB2CY/jd9q9wHQBL2NGm+f8vuj2EeMxWvlRaqQFIV+Z2XGplvc085saS7MJsU57IU1
	 gKemlSvLiSGiCvIZGL8b4WE2bwdGAnRhlit56jZJ/OWvlPKgv5UModncWK5FXYD6np
	 IBFwXJuEgbI4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3C9933931072;
	Tue, 24 Nov 2026 11:58:05 +0000 (UTC)
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
 <179552148379.3477101.9408834905624610654.git-patchwork-housekeeping@kernel.org>
Date: Tue, 24 Nov 2026 11:58:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v7] dmaengine: Support bus widths of 32 bytes and above (2026-11-24T11:19:41)
  Superseding: [v6] dmaengine: Support bus widths of 32 bytes and above (2026-10-14T14:19:11):
    [v6,1/9] dmaengine: Support bus widths of 32 bytes and above
    [v6,2/9] dmaengine: dma-axi-dmac: Use bus width capability helpers
    [v6,3/9] dmaengine: dw-axi-dmac: Use bus width capability helpers
    [v6,4/9] dmaengine: qcom: gpi: Use bus width capability helpers
    [v6,5/9] dmaengine: stm32-dma3: Use bus width capability helpers
    [v6,6/9] iio: buffer-dmaengine: Use dma_slave_caps bus width accessors
    [v6,7/9] ALSA: pcm_dmaengine: Use dma_slave_caps bus width helpers
    [v6,8/9] spi: dw: Use dma_slave_caps bus width helpers
    [v6,9/9] dmaengine: Drop legacy bus width fields from dma_slave_caps

Checked 231 series in 3.37 seconds.
This project currently has 17162 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

