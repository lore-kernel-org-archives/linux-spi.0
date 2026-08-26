Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EFF3FFD
	for <linux-spi@vger.kernel.org>; Wed, 26 Aug 2026 00:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787705925; cv=none; b=ccMWdaNZe7lk/A6pVG71STo+lpY1GdWJkpWz56CTkxgoM+cjiUBBU9yrih/AFLovbshsNWn/3PlngA66mykWferjniiqGSRz3V9xtGxQyj1uuztn+FLc6rmmRQ1tNhpUxMl1TEfgwtTiZ26iLrFxtEbJB39YjAiSbnDNyPAJCn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787705925; c=relaxed/simple;
	bh=wHdp22itoxknp3pwH3UM4Uz2NrBfr9v8mp6/50g/+SM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=OqutDlCDhjRAAapopoopCAiXSlw7A9GsaLnMBUeygOyzI/vlOEewfIzJgbZg5whHyHntSkCygnmi3l6HiqgoTymW03hmpu7d2fAdSzI+ojKacCEvCs1XaZTO0OR5hFZHH3dS6+MiBMlBtBC8sJah7GudvtdsYAQ1u2QJi0XJom4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtqzxQuM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtqzxQuM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C801F000E9;
	Wed, 26 Aug 2026 00:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787705924;
	bh=0HFAkh9RK7jkFTt9E2hx3b4LWN9d+qLq4RZD1PDquho=;
	h=Subject:From:Date:To;
	b=EtqzxQuMQeBIe41VHEJmPIrpOFd75ac+1NK6wZLgJqRwf5zSJDyM7jqMzBHFUQudT
	 ug4lbAqwa5xkIsd2PTAZFnRvAcqW/nj8orDIsNEoSRsyhRA2/wBwrij2ALfYubkMFb
	 AigayXdgn4icLQthwOuKUsGzRM4+EOwXl99MtE9E+1bG73k/D8D8MkpEvhzgMlUZc+
	 3Wv6sL9B/pbflR9AXe7NkD8erjk476z7PLdWlApSaxUK1r0dFFfNjaifyEV6o8M/jk
	 AeRk3K0P7skqkp8p99ubqhufT3uy4VnH5hKRKxqmeA4EIiZPzC5X0L5DOWcbGmwQpi
	 e/ySRhVkTsQIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D324339253F4;
	Wed, 26 Aug 2026 00:57:51 +0000 (UTC)
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
 <178770587050.4189382.8569943359497061371.git-patchwork-housekeeping@kernel.org>
Date: Wed, 26 Aug 2026 00:57:50 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: tegra114: initialize native chip selects inactive (2026-08-26T00:05:17)
  Superseding: [v2] spi: tegra114: initialize native chip selects inactive (2026-07-31T03:01:28):
    [v2] spi: tegra114: initialize native chip selects inactive

Checked 161 series in 3.97 seconds.
This project currently has 16394 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

