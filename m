Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989112;
	b=kb0gZdMM68kqSI1Q/Ymj+6/zDdhQvZ70qbxegTC3XDhdVfwEZFZOZKw9nV/MNDoZmOQJ
	 b+JFOZmsG3p7AMmCCK/gM9LjaIHU8X56ACjAcxKTzmXptMhNdJt9gFQI1SY5uSlxVLfvG
	 mMSXmd6NxD9onV4Tc0Er3GkMHO9UFPCu9NZsHUbnzBq2LzMRQSlvZWSR03+98+EbgDyvL
	 8nj+ADzYfGJXWGFwcbbM0o6kC/HiSxqGkMvpbWnCnDnej6CnGlKZK0SCnTeqC5csAbMVj
	 nCE7nPLSp8d4mzLcOV8Ke1rRXgtwMsonTCZDCe7FLd14YGMqc9VC3+J5TZKPD62O36g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989112;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=UQa4GKXrA9X+wr7u/zsOdyF9bjrxFeMq7idC2deAia8=;
	b=bE96qfWn5vUg8jwu2SlpqJnR8kOkKRX2CzSipE33L8HL1qkhA1HpiOWn/Kb7QVl4u4C+
	 hCNBDe2G2VULc74NM0GUzVZxU/xhSzBmIbdhuGFNv0PpYAZG4wLBSEWU1TCLlzMt2dHpW
	 xudWBXWy+TZZ/Lm9KuneFbRNeSKcBAZDdm8ZavS0sSOg35ob4Nfnm3tfX1/n8gQepc986
	 gSYJbWX2oCEyTL+ioQktJXlnSLCyHyKNPBvG6iV9MUEsFqbCS5RWkF11p30Vk6x1smL5K
	 XH5kQCjbi5YDmU5q6aGkiyJ50kL8aoJQUxxyIR40z1QBtPq/l1ppHEphc9FQAQSzL/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=jRTSBGkB;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2FE606A32C
	for <linux-spi@vger.kernel.org>; Fri,  6 Nov 2026 18:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E2FE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=jRTSBGkB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=UQa4GKXrA9X+wr7u/zsOdyF9bjrxFeMq7idC2deAia8=; b=jRTSBGkBNHrkqdFy+yA8aopz4F
	e1Rnt9GPp24aSyLnAYmdzF56oK0syYCaEO5zC9Tp0E8iAaAKgO2rurmQzx+ffo8CsFetrNhNNZB2b
	/D4zRarhpxgjcQf0TidPSrN0Wjsbim7c14wwvqCzNX8ZQqQy3uj6OG4+Xs9yobGjLvHX6OzB7xus0
	3aa/eAWlJr2cU85x+di3oNWrmAOsf2I61I+nVs5j4GZ/CeFg/ugmxUffg8/UR54gA0h96bTMVKFS2
	oYfir7sEh40zfJyLEL67FtuOILzkVYiOVTmV13nbHr4XUkwwwdUcwL5gyvGVbtt3J6i9XccbDuYkj
	pImTOMSg==;
From: Heiko Stuebner <heiko@sntech.de>
To: broonie@kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	quentin.schulz@cherry.de,
	Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 0/2] spi: Implement a atomic transfer as a last resort
Date: Fri,  6 Nov 2026 19:18:21 +0100
Message-ID: <20261106181824.1361235-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.3
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

SPI devices at times are used as PMICs including a power-controller
functionality that should turn off a system.

This happens in an atomic context very late during the shutdown, where
no interrupts are available anymore and conflicts with the asynchronous
nature of the SPI subsystem.


====== History ======
For the RK806 spi-connected PMIC this has already caused interesting
artifacts.

A first change, tried to "fix" the issue by using the
SYS_OFF_MODE_POWER_OFF_PREPARE step of poweroff. While this hides the
issue, on some devices this now turns the pmic off too early before
other important steps are done.

To mitigate that issue for "some" devices, a change [0] tried to use
different poweroff phases for i2c and spi devices, where Lee rightfully
said, that with this no proper solution would be done - and Lee was right,
as that issue now is open since 2024.

The newest change is a simple revert back the old way [1] because of
those issues caused on other devices, but that now breaks the SPI side
again and also did not take into account that long history.


====== Now =======
The I2C framework has an atomic transfer callback for exactly this late
stage transfers since
commit 63b96983a5dd ("i2c: core: introduce callbacks for atomic transfers")
and during the discussion it was suggested implementing something like
this for SPI too.


As this did not seem to have happened yet, I thought I'd try my luck.

Similar to I2C this is meant only for that latest stage so I stole the
gating from there too.

I assume I did not take some SPI specifics into account, but I guess
having some code to discuss is a starting point at least :-)



[0] https://lore.kernel.org/lkml/20240730180903.81688-1-sebastian.reichel@collabora.com/
[1] https://lore.kernel.org/all/20260908-veyron-shutdown-v1-1-066ecb80f5f2@gmail.com/


Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-spi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: quentin.schulz@cherry.de
Cc: Lee Jones <lee@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>


Heiko Stuebner (2):
  spi: Add infrastructure for atomic sync transfers
  spi: rockchip: add an atomic transfer function

 drivers/spi/spi-rockchip.c | 88 ++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi.c          | 66 ++++++++++++++++++++++++++--
 include/linux/spi/spi.h    | 11 +++++
 3 files changed, 161 insertions(+), 4 deletions(-)

-- 
2.47.3

