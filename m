Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE9A486BAB
	for <linux-spi@vger.kernel.org>; Mon, 21 Sep 2026 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988446; cv=none; b=QcN0cS6UirerCsR/UAKOtlEL12xrRik4lM+79WxwuscMzivL4CJ26Cr+BBRd3oKJ+Y+woW6zQiOTQT8ZZX+5LuAgARkxl+Mh08FF4VFDXbmSmBO0M7d+xpAfMgN0D29PDn7N413UHDWY9+v0hWiSVst1C3+Wb0otfK3T0o0UCaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988446; c=relaxed/simple;
	bh=wbYFlv+vwlTOYrm2+LNlpMuITtPfO/rQgtKqAENwQDo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=vGaq3YiBoxXekCTqiUX53LAdFBtD0Mqf4l/zoc8ymCKiyO3yIY1Nvn+1R7ZjUZQ3ek/yqi+sKb6oaIS5CMHrMXM7rPAvK3TQKc5s7z89695Qehy+9aGFcdZDPH8K2qRWgLzdX1QbS/xJP26D3j38rnYwURGc9my/vTFuj55q4M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8lIWd/x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8lIWd/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBC21F000FF;
	Mon, 21 Sep 2026 11:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789988444;
	bh=XdKJHXbG0ZXX6O0yjB8MWYu1t5alk5NQxCYRPJ45MFE=;
	h=Subject:From:Date:To;
	b=j8lIWd/xlXwdtgXiugoiqdtgZVJuCz8hvYE8SGt1QKnbFkmwcs2X82pILvDrP3pkN
	 hV5S4pXd6EgOXiSoePPK1l14Q3faDNzMWpZcQ6wUQGdhDzJzbkIRlvO6FC5e/YEwym
	 S8VgdYbBWQauaNrJhKK8gzDLQv2ZrH7iyKmSttvYJP3zqEixeD7d3nUzk1Itw0vxPd
	 Zh1QohKO+dpBMNut80XUucQay0C1+Ylh3ZSmTvbprJjVyx+s/3Fls7LrOGpeZlH9bX
	 cU+ia21YdGEOZRlPnuBD4doycvBZzYxz3Zphm9Va8cGpggEF8KbQeQ73xZ9Duz5q2G
	 T1hkUBEQ9zNUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D34723926398;
	Mon, 21 Sep 2026 10:59:36 +0000 (UTC)
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
 <178998837530.2503903.12994915535594983053.git-patchwork-housekeeping@kernel.org>
Date: Mon, 21 Sep 2026 10:59:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: Better specification for rx-sample-delay-ns and core parsing (2026-09-21T10:16:44)
  Superseding: [v1] spi: Better specification for rx-sample-delay-ns and core parsing (2026-09-17T15:37:35):
    [1/3] dt-bindings: spi: Clarify what rx-sample-delay-ns describes
    [2/3] spi: Parse the rx-sample-delay-ns peripheral property in the core
    [3/3] spi: dw: Use the rx-sample-delay-ns value parsed by the core

Checked 167 series in 4.20 seconds.
This project currently has 16535 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

