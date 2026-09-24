Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472093911B5
	for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2026 06:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229635; cv=none; b=ZxWMbl0c0RWwWiBTm9GhiFtW2786q4wIgHOjNunOnVH01691HjqV5t79nmGvP9DovGToMdmUQNurbNsTy2zXwhzcUxThX4Jojp7bzc9DWHkWo1FgHDFFigfF8p4vExx2PiGeh73OSeSPilkhIvrUij4TvJ+jqU8TW1UZXeK6l3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229635; c=relaxed/simple;
	bh=JKASUpbfKC6+d0W8lONOIp9Y9cDdxvBKZSCPBzsEU2Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=OExdTu4+IqkiCDh1mUcu3c488v3lKV58PgTpvbTGuGRs4Mdicc4lwHa3vVu5P2BycYK8kTYwNKEpVNPF9dS9wMzc6qBXmr9+ffQNWQqjLMWlP94TV66ZPVARERJsA6mvlBJ354gPhLkiw+ngxMQqSjwoMIdfFdsTxo+D/dRO/1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9/p+3ds; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9/p+3ds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056C61F000FF;
	Thu, 24 Sep 2026 06:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790229634;
	bh=R69B8G3wlbuR0qIBBa+6Wb93/DyKbfcriwfTbExqRKo=;
	h=Subject:From:Date:To;
	b=i9/p+3ds3Ztmq1a/ooedjJumO/VegGCgufePC708rjal5flbX8lRpIh8tYP/XirZi
	 n6A4P1IU+OiTBe3wkC8kGLokRqnw1zxRovFtO6MVFvz/O7TWFRnWkJT/bPKVnQQd1f
	 glw2tyOzXbdxBbVMC5zQc+8j6edH2rrfPh3yd83CJZgMZ3xttMsAzz2SSELyfgFBdy
	 OIueDwvnKKT7zp2Zxef4V7At+scXhbU6opWmteeQCr48DGKYaY0rvbY4IZ8NGevcK9
	 WlyqOKVkdPMPm4ZVWWSkaQZ7rp4SeWAZz//Mw0V34IIgdCYD2S46v7UdNrhzyDGXf2
	 E746gw+hbouQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9626339EAF44;
	Thu, 24 Sep 2026 05:59:24 +0000 (UTC)
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
 <179022956315.1340058.10608775092029970893.git-patchwork-housekeeping@kernel.org>
Date: Thu, 24 Sep 2026 05:59:23 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] t7: add some nodes for Amlogc t7. (2026-09-24T05:51:08)
  Superseding: [v1] t7: add some nodes for Amlogc t7. (2026-09-20T08:13:29):
    [1/3] spi: dt-bindings: amlogic,meson-gx-spicc: add T7 compatible
    [2/3] dt-bindings: net: meson-dwmac: add T7 support
    [3/3] arm64: dts: amlogic: add T7 peripheral nodes

Checked 174 series in 4.03 seconds.
This project currently has 16566 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

