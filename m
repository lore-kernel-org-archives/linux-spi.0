Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963B22C11D6
	for <linux-spi@vger.kernel.org>; Sun, 12 Apr 2026 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776013078; cv=none; b=d7VssvG+9pB3goRdYwZyKxo6ig9Jzyq/hbhSb9uYVyOG3rASXyAAyNbk8khdoiNleoZDuogPM7MLXLCXON5HRKOMptM+SChP9EyUl8fV1aABFKapXr7EiMZwCLovBFOpPUzbRnoZ21B7ozwZ5EDAknlDOJHNNWDDencszD4MRQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776013078; c=relaxed/simple;
	bh=4VMEge75RvD3+rgxHRqnymTDFgULdI5P2IDngowQul4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=iCQhZYr62ZaVbAnzO8VZwI2Ti9FS7uhb5kcKRmiKvCmL/c304qnJB9K6BFLtAG+o1W5J+QFpvpOVZkQvVo2I5glZe0v9mCkanoQMK4rs5k6mD9kf5JUOIoo9hocS8+KjHZo0XdKmX5xkZ0olX2xS5Ww5RDt4YaN0gxOW1yuCfCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRjXrOlV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRjXrOlV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DEAC19424;
	Sun, 12 Apr 2026 16:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776013078;
	bh=4VMEge75RvD3+rgxHRqnymTDFgULdI5P2IDngowQul4=;
	h=Subject:From:Date:To:From;
	b=ZRjXrOlV3O2J7/MjViAemojGtlXztNAHH1CV/uqXVcfhSndnW7x0fk4YX5HsB9t6L
	 0qk2T184ZZdJ/ZjlcNIv4P9QoLuxXUudb5xRAZau5RHQ7YGbiERWbtTjVSKCmD4xHz
	 e16YGGmJu6r8qlTjHjrISt/92C5w/nuKDDJu0IRx0Xnr9Tpjhxxw/Covkii4DlOYdj
	 c5c56d+Ft7qv+Oc7o8sFMYC3Wo3aP7xtrLksIWnWaCXMf+3vCF+Y/ZukDIetyWHwxV
	 WKa0HaNFdn7ooAdiCSePQ7Sk08vtpFd+otJJefWmP0zLwgtiEwtyU9AtMqiTR1AgEz
	 A1wbibaei0Zpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D633809A8C;
	Sun, 12 Apr 2026 16:57:32 +0000 (UTC)
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
 <177601305049.3341893.9830784584439053362.git-patchwork-housekeeping@kernel.org>
Date: Sun, 12 Apr 2026 16:57:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: Preserve preset cs_gpiod in __spi_add_device() (2026-04-12T16:31:49)
  Superseding: [v1] spi: Preserve preset cs_gpiod in __spi_add_device() (2026-04-11T18:04:12):
    [1/3] spi: Preserve preset cs_gpiod in __spi_add_device()
    [2/3] platform/x86: serial-multi-instantiate: Fix SPI chip select on platforms with incomplete ACPI cs-gpios
    [3/3] spi: pxa2xx: Handle clock gating for GPIO chip select devices


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

