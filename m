Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EC538D6A2
	for <linux-spi@vger.kernel.org>; Mon, 31 Aug 2026 23:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788220762; cv=none; b=qR0cfUyAVFS1sO3eHEKQY22k6Jvqgaq7GRZmAsx8BIyHzZx/hVbHjH3KG9F0rmeQ/PDqsdO1xTYwI/urxCXufgAyHFIDw1Pxh5kTcWd94VFErtgRNXlXFhx5CVu0u0eoZicxsxsLBrsMiP5DYYdzmBOuoSCaL5TtK59+FvC9ly0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788220762; c=relaxed/simple;
	bh=W9YEWmzpalswqKpdFmMYczPsRjCzIFM7IsQ+aJEdXhI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=svk1UW5DO85wG3uNfBAR2c/3jGEjLg9tQwa0jAA4h1rJCDbSzWC4U0T645k7bZj1zdKC7C/PzlOq+LIOS6ZI0Ir/xwpsyws8VvGIbuX7mO69FT8U8HwjlJEyYMX4CauYGBDkbsx9UrLwcTBVnsFyFqivtV3IfVwNBdd/uch9QJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8dRTlff; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8dRTlff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DA91F000E9;
	Mon, 31 Aug 2026 23:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788220760;
	bh=SnuRlt2YaIUhTXxleIM9HtGfFGujMJDVV6tDelIXqyk=;
	h=Subject:From:Date:To;
	b=K8dRTlff7+uWL0kj1Kc50N7pzo5VPTx4Oo53n03McUGu7WwOcQDChzENp+nUzAUzH
	 JXXUBj3r0yueVPOD+mK3+saGiNshK8Ya+EHfz930+dDayz0xDTB78Il8nr1y806v8m
	 RJ68ymJa5YaaH3d9YqExcdlEk8XGBCpyWNJZ0znF4NXyMs/mVjE6Udj8rULzlMkETc
	 As/medoLfxY55rD7XPbu8MhV6B1eKmsS7MBgnnaDAfh5KfuOMsd7+HFw3mIQNNA7Gv
	 ymBwGWL6i5Yd+l2gSDpW4cX3N+mkZFR4kXDL0IvohqD4RT1Igmlg/WOvSXOk3+uRct
	 OcJae7s/gGLOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198F6392447D;
	Mon, 31 Aug 2026 23:58:25 +0000 (UTC)
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
 <178822070374.841093.12210911776121306834.git-patchwork-housekeeping@kernel.org>
Date: Mon, 31 Aug 2026 23:58:23 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: davinci: Convert bindings to DT schema and clean up DTS (2026-08-31T23:32:09)
  Superseding: [v3] spi: davinci: Convert bindings to DT schema and clean up DTS (2026-08-16T21:55:24):
    [v3,1/2] ARM: dts: ti: keystone-k2l: Rename ti,davinci-spi-num-cs to num-cs
    [v3,2/2] dt-bindings: spi: ti,davinci-spi: convert to DT schema

Checked 167 series in 3.78 seconds.
This project currently has 16428 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

