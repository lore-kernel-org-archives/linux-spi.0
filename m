Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A92E1CEAA3
	for <linux-spi@vger.kernel.org>; Mon, 23 Feb 2026 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771865807; cv=none; b=qayk/uUFDjAR5SmvZf46mwoQuNcXgn3clSOUqCdaJM26MfLJHTBneX0G5iyU4yb4CkJyWO++Wkq6yYTqKqsMT7t3uUeIcZIgQS4Z3N4ibzlkG93v2KX49zphxXVmcBQzfrDhdd7fhdP4fKv5FNPIg0sTGsr/NT7mqtKcoBHSARM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771865807; c=relaxed/simple;
	bh=JTv7JXgc533PdduxHkglzYROlOkZlNadmoLAYT+aOe0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=QAJmV3r/Ty8/ySxjofOz7bSh0ZX1Y3FiLnTSS6emoYvQVSGo+MivodJP5PqKjSQCuhAn19IOnGeGeeqx2PT7IeLifUaG8Ax4GKv9oWrTudSkeTbyHLgbtNTbADVeyfhZ87xVM+ef/H76WNyOoFEf+Rs8hLpaUfhtjRZMRGIibCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rr3dxV30; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rr3dxV30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440E2C116C6;
	Mon, 23 Feb 2026 16:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771865807;
	bh=JTv7JXgc533PdduxHkglzYROlOkZlNadmoLAYT+aOe0=;
	h=Subject:From:Date:To:From;
	b=rr3dxV30oMPXnn8tWxsh4kEeCPLemu1Q2oSI5Hm/4CG2+cPju+3FSP5Cy//mmfnZR
	 fxP/QdIP4WHyOpEBTU7BjL+sXRA8nD0Ga1GwhTVOTcv/SAtbLp5SORZWVtLin9eYwX
	 IaC0d5Y8dHsanbLwYaW1uLjVBIlsudHOF5NSU8qeDDB4nbMDjHN8cTGZ3TZq4vnioq
	 2LjxFwFYMps6kiP+U2sx1Ai//6oVy7JYEDNMaUr07AQrS2jlGhSS7VHTVvYouAbCzQ
	 zrJQTPvciiHAmc5Vmq4jWuesfLxyVKW+JMK2b9ky9ZW+3X2xSMryvBxzN0341jZ6Kd
	 PrOrpHPsM08Ow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0703808200;
	Mon, 23 Feb 2026 16:56:54 +0000 (UTC)
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
 <177186581320.2514607.4989343584019329655.git-patchwork-housekeeping@kernel.org>
Date: Mon, 23 Feb 2026 16:56:53 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] iio: adc: ad4080: add support for AD4880 dual-channel ADC (2026-02-23T16:20:59)
  Superseding: [v3] iio: adc: ad4080: add support for AD4880 dual-channel ADC (2026-02-13T14:47:32):
    [v3,1/5] spi: allow ancillary devices to share parent's chip selects
    [v3,2/5] spi: add devm_spi_new_ancillary_device()
    [v3,3/5] iio: backend: add devm_iio_backend_get_by_index()
    [v3,4/5] dt-bindings: iio: adc: ad4080: add AD4880 support
    [v3,5/5] iio: adc: ad4080: add support for AD4880 dual-channel ADC


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

