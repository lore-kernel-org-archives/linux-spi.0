Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A820A353A7C
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583527; cv=none; b=UqASA+ezCTxGH8MSp3I9/zMKavyDVe2PjYFN+gcfcmGodZU8XlZ64pNIm3IIp1V3icdTzZnVGaaV42FbF9VY7cLUWEX52EgQ9IqHey5CXKPTI2pvfl0G9tZSWDcY9HnbfDNN2fvEPpvTQu5ABhwgzq9vn7y0Dedpa2kwmRIBUkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583527; c=relaxed/simple;
	bh=wOZLXLTadWwkSe7cBt3HzeWB/89aYkY2Tl21KjSZduQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=drbS0PWNeQc4pK/jki7KqaWe8uLYhQo43cCC5lr9Qnx6j18g6ZEs3N4H6XMaIE/vfk9xJjFOemyrDN6XpL+R3gRuVkDnM1lv4vIJChfmVPDkj+Dy3NWzv1zdk9/AY3C3NBxmC+nYX9GIJ2aMdtZeQDelGQGeBVjCKE0e2R3iBwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+oMvH5R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+oMvH5R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469CE1F000E9;
	Mon, 24 Aug 2026 14:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787583526;
	bh=BCtN8KtQSvHPXJ1y7iqZQys+Y9cOm+L3rsyGblnTF0Y=;
	h=Subject:From:Date:To;
	b=D+oMvH5ReCKttvtZLQlK3usXdT4rXRUcWqdDDOYcZE8KQ//aPqKcwNj7FuSiUFJlh
	 PnAkxX0FM04DpEQmLgLdW2XIMy2xln02l6y0pepQlcqcuWGK/KGrLkEgFi1CSrKKXL
	 32Z7cJ9YkAOk/Jgv9BPGGfxW05azWY72GZz7TOneRNNZDcd0uogWSuTmm2py8IxCEu
	 1LW+hrhfpNBus1Xhm5VVgwDG9zBmCEadFoy8eVEIF7y0NhDf9Bgj52uAuntLUK3E/v
	 tckJkghU/ZpXH7lpVfOjEjKWUlRlFXQto6B7SYDgoBgliZnpmpxy7gmvAf2c0fjNVO
	 LTya4x0QOZiPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C17A3924451;
	Mon, 24 Aug 2026 14:57:55 +0000 (UTC)
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
 <178758347369.2954884.12311403801845448053.git-patchwork-housekeeping@kernel.org>
Date: Mon, 24 Aug 2026 14:57:53 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: qcom-geni: Use GPIO to notify master of SPI target activity (2026-08-24T14:25:58)
  Superseding: [v3] spi: qcom-geni: Use GPIO to notify master of SPI target activity (2026-08-18T13:38:09):
    [v3,1/2] spi: dt-bindings: Document ready-gpios property
    [v3,2/2] spi: qcom-geni: Use GPIO to notify master of SPI target activity

Checked 160 series in 2.93 seconds.
This project currently has 16371 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

