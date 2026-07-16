Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C90043F093
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 23:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784246323; cv=none; b=AtWcnCdXwakoW8Sv2XzG7LgkQagUOJ5uwBQvMFx/N6WtP7n0+N0ll1K8SSJo40EuysW3gRYvRQmu7OoSAUrxjtdZnu6MX4AZegTDj9pxERpRhZRMn+dZ+K8S5hOVb8Cv+slOT4Zi9fb1WX94Hp4/SXXi4SPKk+FZcB5Lge9lFkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784246323; c=relaxed/simple;
	bh=ED6moH1iKUXJYu2HuFvUZUWEmZZ2ut2/YkBcL1sdt5U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=si1ctE8YbB/H/rPOSvzzLfjmzr4ePm+xUhqi9iGQ14cLSNrKW6bP97kz2hCxVaMtYFqcXX20QLmoDUa5L5n2CpmTcSQ0BAuOm7BInJJYIA8xqjpWHwcvLTMrcDk7w/jRkDxZ6tTLRmeLWxOTcRWhmmjH4pqwB32GQ4gbn0tJY6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W65lI5Bv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W65lI5Bv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A8D1F000E9;
	Thu, 16 Jul 2026 23:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784246321;
	bh=hE4NcojXzglEqS+11HqPFsLjI0KrpzBJ+8gqeNvJps4=;
	h=Subject:From:Date:To;
	b=W65lI5BvGGt9AmeUk1+nxH0QdMmF1OfNED3Nq7tCG1xjrTLQikLBTqQNFm4XxpAh0
	 uW/oaXWRCidcR/jTfWODALY8513c+tsXoXyVdzu75PNVcuNfq001+Mfs/M/woT/BAX
	 Oa5cIHi8Qr0ZTWDOFP6jej37CImn581q6+j9shQAioaT7QA/yL6Hqym1EtZ4fcYxO2
	 WIP27Q7xj5ydzUoH4Z8vD6c2d24CbmzuPkxfsuQT8ePIm2xg5/QtRGEI7PVV6McIKh
	 +8Sj2Zs4ltkws03Eafo4MvjnbFhMYPyjgwHBRQkvya55OgR/2uM1B9gWbb3zf/JkDx
	 CRUJKyxfCk3SA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AD9380A970;
	Thu, 16 Jul 2026 23:58:15 +0000 (UTC)
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
 <178424629438.1461542.13159177964029047635.git-patchwork-housekeeping@kernel.org>
Date: Thu, 16 Jul 2026 23:58:14 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: orion: use devm_clk_get_optional_enabled for axi clock (2026-07-16T23:14:11)
  Superseding: [v1] spi: orion: use devm_clk_get_optional_enabled for axi clock (2026-07-15T22:13:43):
    spi: orion: use devm_clk_get_optional_enabled for axi clock


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

