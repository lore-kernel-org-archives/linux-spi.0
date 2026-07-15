Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B65B3B4E9F
	for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 05:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095125; cv=none; b=GL1uuMnQ0i//EseJSD7bDTftDj7h1psc5vnLVWZfU9WjDBgOeG/p80wgejpv5MCTMp5FlJ5of/cU8aKQI6OCgTcz9anEkICG44zYiaMQLCm6zqIDA2Y7a6ZzsWQTSRl+mtQiTynOLjvz/es2ljmomNJnNq/R3Kka+y0TDQ7tCPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095125; c=relaxed/simple;
	bh=/4vsr2WBIYxnMetanAMMEQQ/2lAbX98FyI/rPGhur+o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=cc6UjW7xGqApTlXLj/TzmlQiqBpwm88hBVbL7D/bYuc9ibbgqCdY48Qk1vn+Us4EzkTApg4LU1dDOiQy7CsWCBoI+CZGfrsJUjfcv9ib4Wrwt7OUTvB5u3hkRoHKyBdCX2QaoNULHBNOWsgbho483kv2ZiXQOaNzo8MSO7wSomQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDEhAX/u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDEhAX/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1171F000E9;
	Wed, 15 Jul 2026 05:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784095124;
	bh=AtzCH9YCJ1s/cT30T1f6CZfyYammRcZ7zL9U52b2ac8=;
	h=Subject:From:Date:To;
	b=LDEhAX/uyAk6ObcKXcxQp6du7Yq06Ab7nls2wk+963LLRCT6stn0tosxBCz9f792Q
	 XjrYPktzj4x6CLVEtbzzPwYEJnjBx92MUeZyaobOUJvV84JWxGFXHT2K6UIjzIE8Q5
	 A0vY9KVeHB5Xu8yiRIeAXNt0QhD5fi0WGj06p0JogVcB71gxv6e1vmE8d8zbDU43sH
	 BGQd4rdgu//WS3LEH2zZnt3fI18HMxal3PEUf60Yu0YCcpGkndU9L2Axv3NW5wRODh
	 KhYg37qpe6cy4AX1bw/ViTjjEAhH/PMCDsYHTk4MEu0rLbqy+hzo4lJ/TaCI1nl7h0
	 iKdEvux9Uhqbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A6B39263BB;
	Wed, 15 Jul 2026 05:58:19 +0000 (UTC)
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
 <178409509803.3902365.10228881715336654072.git-patchwork-housekeeping@kernel.org>
Date: Wed, 15 Jul 2026 05:58:18 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Add trace event support for GENI SE registers dump (2026-07-15T05:20:46)
  Superseding: [v2] Add trace event support for GENI SE registers dump (2026-07-10T18:48:40):
    [v2,1/2] soc: qcom: geni-se: trace: Add trace event support for GENI SE registers dump
    [v2,2/2] spi: qcom-geni: add GENI SE registers trace event on error paths


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

