Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61246349AEA
	for <linux-spi@vger.kernel.org>; Thu, 19 Mar 2026 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943005; cv=none; b=XY/T70PJfniuY2MlhWuU5oyuYU4hfq9ua2FntrRYa5fsqyp8MxemcLKfdGAPXlV2GtHOUpNBZ+XXlc0eNgAfcOv4w8tRvn1dEtk8PjiTSNKhrsnm4bVp+XvB13CZqCXuWmYZXET1jYttibudt/qCeVLTa0isANGsztnk+bNjuks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943005; c=relaxed/simple;
	bh=2jsb5J51RLiiUcGKNirKiJZA37vs8miY+AmGWo2oyFE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Dv9RF21a4tMrvZjD0uLONnUXV5CtkckL0idoEc05CRwBoK3Z91TYLEE02ON6W8fPJjN7pQbOMF1RXX8KoMgojOtg1fqLHk4DCjj0WibAq16Z9l5BP232IyDikmImcbJqASpeDxpxcG4+YfipsWOF29GE5TLO1wBIGLTGnsyfgR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRyA1fx1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRyA1fx1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BFAC19424;
	Thu, 19 Mar 2026 17:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773943005;
	bh=2jsb5J51RLiiUcGKNirKiJZA37vs8miY+AmGWo2oyFE=;
	h=Subject:From:Date:To:From;
	b=TRyA1fx11Z9s00QjvN+wRcfJ0DjdnDM4X06Eltf9DsPWmPF6iKTLrUCT0FTHQR6NZ
	 FavuDhSjcuBHWxDF03fy90au3VjCaHD3vxqD6i10SSs9ERKLsV4BlYHrC6CMS2rh2a
	 TR00rDEUad8rD+vkE6vlRS+ytWxcLV/jEXzh6hBUNkHj/j+QCwck1Rqq8VNnlvNUF3
	 sinCm3Xd3327WKbF3MOXsRNhpBA13xyyryS3yr1yqckjg6DodkcpYR43UYRnamSxW+
	 Rh0S5Ey9mYm4xYG1ztsGjnoBMrhZFAzAQR0lFUUODoX6HA57/eLm/3msAUVLUyW7SD
	 hEthKjqsBrTnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 05C5F39302E2;
	Thu, 19 Mar 2026 17:56:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <177394299558.1737578.7448805535897396275.git-patchwork-housekeeping@kernel.org>
Date: Thu, 19 Mar 2026 17:56:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-fsl-lpspi: various cleanup and enhancement patches (2026-03-19T16:55:40)
  Superseding: [v1] spi: spi-fsl-lpspi: various cleanup and enhancement patches (2026-03-16T08:39:06):
    [spi-next,01/11] spi: spi-fsl-lpspi: adapt to kernel coding style
    [spi-next,02/11] spi: spi-fsl-lpspi: fsl_lpspi_probe(): use FIELD_GET to decode Parameter register
    [spi-next,03/11] spi: spi-fsl-lpspi: fsl_lpspi_set_cmd(): use FIELD_PREP to encode Transmit Command register
    [spi-next,04/11] spi: spi-fsl-lpspi: fsl_lpspi_set_watermark(): use FIELD_PREP() to encode FIFO Status register
    [spi-next,05/11] spi: spi-fsl-lpspi: fsl_lpspi_setup_transfer(): remove useless spi_transfer NULL pointer check
    [spi-next,06/11] spi: spi-fsl-lpspi: fsl_lpspi_can_dma(): directly assign return value to fsl_lpspi->usedma
    [spi-next,07/11] spi: spi-fsl-lpspi: fsl_lpspi_reset(): convert to void
    [spi-next,08/11] spi: spi-fsl-lpspi: fsl_lpspi_write_tx_fifo(): simplify while() loop check
    [spi-next,09/11] spi: spi-fsl-lpspi: make struct lpspi_config::mode u32
    [spi-next,10/11] spi: spi-fsl-lpspi: fsl_lpspi_set_cmd(): use mode from (struct fsl_lpspi_data::config::mode
    [spi-next,11/11] spi: spi-fsl-lpspi: fsl_lpspi_set_bitrate(): don't treat devtype_data->prescale_max == 0 as a special case


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

