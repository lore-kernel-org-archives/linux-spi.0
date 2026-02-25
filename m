Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64222D481F
	for <linux-spi@vger.kernel.org>; Wed, 25 Feb 2026 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772046615; cv=none; b=deddOeuddqlqQ6CwGuGbsrKQIrs5VBDVwWedRhH+hpmUDP88nYkHbYZNrF3nduk3IADyQgFxkFBJX95SWfz6AEsXoXamjK1udQuKM0yPQSpVGE3iHmB1Xa4nqS+ckIAgM+KqWTLP2ptp+cBCIQgOY72a9epyeKYvYSptRQ/xvtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772046615; c=relaxed/simple;
	bh=r8PjZgsILplbNFI9Dk16zZAmoSOipmJ3Luwlb0O7SVQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=GTVC3pBY6k3QcnhJdVhUKDokwmbZ/kCMHQWZ9lfT5QDtEciv8aY94PJBm1khjta79loYhq8mwfoMV8oX6AdI0Xgqt0lFSkNeF+jYV8mXCpv3tnNzmu1y5tTQgRTZ5qoT7vMSJ1Uqc2ZtU7G1g8dr0j3tpZ/TLHM7j+ozS2nxzKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Au/j+CuR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Au/j+CuR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37585C116D0;
	Wed, 25 Feb 2026 19:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772046615;
	bh=r8PjZgsILplbNFI9Dk16zZAmoSOipmJ3Luwlb0O7SVQ=;
	h=Subject:From:Date:To:From;
	b=Au/j+CuRuR4Bk4it9bCMkH4sTGdqsDY3kXQWbes32+w4s3Y1oxeORw5Yjwd4vMbUe
	 Q0PTFsfsNHODljtzN7fbHjrvFDSFDNVZdX4vLmzUtjAAt6ivnBackYCtv54iOvwUZD
	 4wlrA+sejAXX2dp1HTwWd20pV521ijHnh4IAspjnNKoMDBDi8ZaYAdlIpNo0UsJ6B9
	 5RbuwA7K8J3ggqlUEvzEmYFi/ubi2HQ7ApHPTzUdLxuYEbGJU6ygwhfIOwHUNmiyDF
	 M31BGovWTOJp+t9Y8kDfbcfF3b4kRoh9gPAoaQsaY+H40T4gOWmzGKZnXv+gBaVTm4
	 qXQjPvndAHFrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 428E63809A90;
	Wed, 25 Feb 2026 19:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <177204661982.875724.10346781126684114168.git-patchwork-summary@kernel.org>
Date: Wed, 25 Feb 2026 19:10:19 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: stm32: Use NULL instead of 0 for pointer
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1054443
  Lore link: https://lore.kernel.org/r/20260216085816.69888-2-krzysztof.kozlowski@oss.qualcomm.com

Series: iio: adc: ad4080: add support for AD4880 dual-channel ADC
  Submitter: Antoniu Miclaus <antoniu.miclaus@analog.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1056650
  Lore link: https://lore.kernel.org/r/20260223162110.156746-1-antoniu.miclaus@analog.com
    Patches: [v4,1/5] spi: allow ancillary devices to share parent's chip selects
             [v4,2/5] spi: add devm_spi_new_ancillary_device()

Patch: spi: atcspi200: Remove redundant assignment to .owner
  Submitter: None <xiaopeitux@foxmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1055751
  Lore link: https://lore.kernel.org/r/tencent_65C9C09CBD2B68C400F7145521A4B217E606@qq.com

Patch: spi: stm32: fix rx DMA request error handling
  Submitter: Alain Volmat <alain.volmat@foss.st.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1053525
  Lore link: https://lore.kernel.org/r/20260212-spi-stm32-fix-dma-rx-release-v1-1-53a37c31626b@foss.st.com

Patch: spi: omap2-mcspi: add support for 3-wire transfers
  Submitter: Antoni Pokusinski <apokusinski01@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1054218
  Lore link: https://lore.kernel.org/r/20260214212800.262461-1-apokusinski01@gmail.com

Patch: [RESEND] spi: cs42l43: Don't support sidecar properties on device tree systems
  Submitter: Charles Keepax <ckeepax@opensource.cirrus.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1056416
  Lore link: https://lore.kernel.org/r/20260223100717.4011114-1-ckeepax@opensource.cirrus.com

Patch: [v2,1/1] spi: pxa2xx: use min() instead of min_t()
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1056597
  Lore link: https://lore.kernel.org/r/20260223153117.2838840-1-andriy.shevchenko@linux.intel.com

Series: Add DMA support for RZ/T2H RSPI
  Submitter: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1048273
  Lore link: https://lore.kernel.org/r/20260128215132.1353381-1-cosmin-gabriel.tanislav.xa@renesas.com
    Patches: [v3,1/3] dt-bindings: spi: renesas,rzv2h-rspi: allow multiple DMAs

Patch: spi: tegra210-quad: Add runtime autosuspend support
  Submitter: Vishwaroop A <va@nvidia.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1057108
  Lore link: https://lore.kernel.org/r/20260224092452.1482800-1-va@nvidia.com

Patch: spi: stm32-ospi: Remove exec_op() callback debug log
  Submitter: Patrice Chotard <patrice.chotard@foss.st.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1053835
  Lore link: https://lore.kernel.org/r/20260213-upstream_ospi_remove_exec_op_debug_log-v1-1-164f17515fd0@foss.st.com


Total patches: 11

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


