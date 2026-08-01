Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BEB19DF62
	for <linux-spi@vger.kernel.org>; Sat,  1 Aug 2026 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785607128; cv=none; b=RX8OZ+eulC0X5/A8vGcUBfPU4yUGPN2aIWa3qtWmoHrGcysbir2hL9kZ2rMoHjkw8fTjLZ800S4kcs2kq4BjSseUHcQhN5xW+iMrimN90DowjS1ilG5PtlFGZ8KNrO04URSwRGV+nF+VXkHV9M3vdexjHRn/HKkBICZb1TiI/Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785607128; c=relaxed/simple;
	bh=ig4nCkl814Y191aU7EHmgZjuEUcSxJawk1jCPe1FT5s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=oeHmRg2TqADvmI+wgjayMi3L5YLb8V2HYowbbvHju3PHYRLIX6ETYM1GXt7NAElNGHvdxoUYVQIAqNxyxFrXv3LA4gpyLM2x4mJxEuooeuFIrc0HhUuXzU/8DB6Pqm2wMoDpNd6bF/SU+/Z3nWRhATbPrSLU5th+hjVK70pz4OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akRCJsMp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akRCJsMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DD21F00AC4;
	Sat,  1 Aug 2026 17:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785607127;
	bh=neXFIkM1/wai7c6kvcBNuw0mU+mM9s0UXXrdFQeAZfY=;
	h=Subject:From:Date:To;
	b=akRCJsMpUW+yHdydjRm2xU/bA7woWv8eIFqhAgF1mHZkZJlugLoRy21LiBDU+79AH
	 wF3epYOUMvZUbUxO3CfVl/8PTwMlZw5hBI51oGT4ODREDKfA/UfRMLOl25gA2IYtv/
	 45Q+sIgxzz03M+4zgDUgEmuNlvlqVxCQ1j4B5TRFnUA/pzMTXHubRRIgRpnvm4bq7J
	 ElSCV2O1jsIG8xhmUcJWF8V94wQGmyX+bRmEUjceRORjosp4PDAevvKuCLzcM6/Tm0
	 XDQKAx9HBSWMDmGGUR6YfDbV2VcZ4Ay+l77u8s0Z+A0xTIx8yggqG6b5UXvqA9Ahbh
	 MEdqdKjGE6ijw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C181380820D;
	Sat,  1 Aug 2026 17:58:11 +0000 (UTC)
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
 <178560708962.1177699.15459601910360497364.git-patchwork-housekeeping@kernel.org>
Date: Sat, 01 Aug 2026 17:58:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: meson-spifc: use devm_pm_runtime_set_active_enabled (2026-08-01T17:51:24)
  Superseding: [v1] spi: meson-spifc: use devm_pm_runtime_set_active_enabled (2026-07-22T12:09:17):
    spi: meson-spifc: use devm_pm_runtime_set_active_enabled


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

