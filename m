Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795749606;
	b=thnBqXtGctNTxEHY57ip5bLCVl6aBTy2QOneZ/UxrasCuxTyJ/95sVKHoFLej92gNqgW
	 P4HkWac6ikNON46r2wgG7NHGNySM09v4pEfE0dnxIoh+p88P6/N+ajgx+Vt4OdfQpmkCW
	 RMmHEnJqJR2ZyVbqdcMaZWAOs2uIEzY/AqNkjL+HBePctZJGRmydV4pJQBfrOHmInLA4+
	 Q8UUWD+w0/Syh1yRvAimkXGnCEGE48/s80+1LLw6bvDPOXA2J8/n5lMC5x3jWQ5Wg3vQ0
	 w2NydE4iYdPz36T3Jcl/LT4SgovrhJuI3cBsiwK1M12ppWmQhBAvA2QYG6eDAKlsNWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=EoqfWBWJiZgQBeYKcgK24puyUcIoei1tWKvxOWyBfM4=;
	b=c5Y3VnnWL4ZX7wJGQMmkpb42P5jy2jKvF4Fi5RuJsOTzPQLtgUvIqDa4gCdOl/L2OAdA
	 BTFMMcMVtTTw270pCHtLIDLMADTxX46fo72zqUqHCIQEXHlMRpiUd10kCZbn6ley1xnx+
	 uI8VlckKNDfcOqn3KkxLOkq+riAUJlRfjdorgVcNCC8oMhgUbaI76HMCn1n4K9t2h4CRc
	 pENYdIWwKEG/A4F4X5A9uZ3Pkz6AMud9ipkTqVrSJouYUMNBMsXRFvuw9c1/wPg1Jj6wg
	 sI0X4PkFGw316ggCF/zWmTA0GyqpaTTX29v441oS7CRI7NfiHbPHlEWYnDmoG0UGbnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6l6bEdf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D8A606A31E
	for <linux-spi@vger.kernel.org>; Fri, 27 Nov 2026 03:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6l6bEdf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590AE1F00893;
	Fri, 27 Nov 2026 03:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795749606;
	bh=EoqfWBWJiZgQBeYKcgK24puyUcIoei1tWKvxOWyBfM4=;
	h=Subject:From:Date:To;
	b=W6l6bEdf2pgbCDtjE9NK68pmMVxt6Bq0TPcx5i0ZGHq1GyJTo5YQ3yaZpnT0hNwq8
	 kWxYZtjgzY29DA0EfT0+q///8f2IQY9nU2m5195eilwPtDjJs2r7K5GcH7IorjNYCn
	 f3MtPii/30jH7CE2j1+iW3Ud6qO59Ck1ILLSZoLSjNhiLAu3XfgwtAB6elbNS+lUxZ
	 IpL1Jz0ZsQE5wYUD+NVsmTcCbRTz/Aekvl9Hwr1yN7iMzLGK1Zu9rilGLZuef8+AT+
	 pAc9AmLF0g7C6ujts2VJhQ4rE5Tvos181ABDiW3pA8sIOPXm/Q/PoHs3Zc3cc/uuUZ
	 k4UzoDiSVeBKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 36DE93803223;
	Fri, 27 Nov 2026 03:20:06 +0000 (UTC)
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
 <179574960478.725149.10061020814357924059.git-patchwork-summary@kernel.org>
Date: Fri, 27 Nov 2026 03:20:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: Add support for panic mem writes
  Submitter: Paul Cercueil <paul.cercueil@bootlin.com>
  Patchwork: https://patchwork.kernel.org/series/1187224/
  Lore link: https://lore.kernel.org/r/20261016102917.171095-1-paul.cercueil@bootlin.com
    Patches: [v4,1/7] spi: spi-mem: Add support for panic mem writes
             [v4,4/7] spi: cadence-xspi: Clear "SDMA ready" IRQ flag after polling

Series: spi: cadence-xspi: Fixes and ACPI changes
  Submitter: Paul Cercueil <paul.cercueil@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1217298/
  Lore link: https://lore.kernel.org/r/20261120115925.173568-1-paul.cercueil@bootlin.com
    Patches: [v5,1/7] spi: cadence-xspi: Properly handle errors in .transfer_one_message
             [v5,2/7] spi: cadence-xspi: Reconfigure to STIG mode before SPI message
             [v5,3/7] spi: cadence-xspi: Inform SPI core about size transferred
             [v5,4/7] spi: cadence-xspi: Clear "SDMA ready" IRQ flag after polling
             [v5,5/7] spi: cadence-xspi: Drop useless cdns_xspi->cur_cs
             [v5,7/7] spi: cadence-xspi: Add workaround for old Marvell firmwares

Series: spi: cadence-xspi: Fixes and misc. changes
  Submitter: Paul Cercueil <paul.cercueil@bootlin.com>
  Patchwork: https://patchwork.kernel.org/series/1201595/
  Lore link: https://lore.kernel.org/r/20261104100643.162694-1-paul.cercueil@bootlin.com
    Patches: [1/5] spi: cadence-xspi: Reconfigure to STIG mode before SPI message
             [2/5] spi: cadence-xspi: Inform SPI core about size transferred


Total patches: 10

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


