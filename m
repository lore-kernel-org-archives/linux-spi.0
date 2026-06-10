Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6B1175A68
	for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096271; cv=none; b=cY1y2c8KFK1jk6wl0Fma54x9fIYC1d2bFcklxkgrMNkRDrLGXI2toHUmnal2R6LqHvJJ+Q9QoMzo25la+ByKO1hHFq+GAd0hYvSC4vMqGXsSG77ihhda83lqd/lbVCcZVi/kmXzu9hMhkmGp/sgFijQ+soD+6msZGyAHwBO+1g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096271; c=relaxed/simple;
	bh=uUB17OxyNWc5DOzUJU110rWSvJnbHZtP425YxdWV/mg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=d2uBzvPegaOSC9NLxKGb9g4/JQqTXnXzmRsqWxdxs1hy/b45y2Whq7QdR0zQMGErp2lBxEA5LOjgJazSROV6faONfFKm6bowil17CkYDs+Q8Q8LvJxcS4u19Y8MH/L/BJEPwfAocraPHEt1sr7LEVvKlHXQOybY9V5MUzA5tEUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2scKneq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2scKneq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367361F00893;
	Wed, 10 Jun 2026 12:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781096270;
	bh=b+9f27GlTRtR3veZXpeaTX9/Vb0/qIpfftWj4I6dZxw=;
	h=Subject:From:Date:To;
	b=o2scKneqkxLogKKkCj2JScuBHj0POes4ogjj34kmFcI9qmhM3InB0yaySa9co/gOK
	 QZpsbEDL/Qkci4InDlZGqhDBXuFfDD6DAViDBXNi2Ohr+aacTiOZ/pUx4YXW3sKct8
	 Gikkc+BwDfkhJ4MsT3wdqh2T74Ez+lIQC6l/woOZbR8hGIKdFjUIRNA1WqhuFuM2S1
	 aEWP5tXl4IvOlStwwpnJmb/Z2GLvBGEy4vr46qZBYJ6BUGqg+L458r12Zkfotwzsve
	 DP1yPJ3pt2QZd4q0wnOuYRLgD2/8B+R332KE8Rt7+nnBIq2ujrZnIE19kMUvEdzgXo
	 fi2nsiGpvl6Vg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B033930CA4;
	Wed, 10 Jun 2026 12:57:49 +0000 (UTC)
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
 <178109626791.3024685.15724689217670633708.git-patchwork-housekeeping@kernel.org>
Date: Wed, 10 Jun 2026 12:57:47 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] Nuvoton NPCM FIU DTS fixes and binding conversion (2026-06-10T12:18:19)
  Superseding: [v4] Nuvoton NPCM FIU DTS fixes and binding conversion (2026-06-09T16:39:16):
    [v4,1/3] arm: dts: nuvoton: npcm7xx: Drop bogus FIU memory reg-names
    [v4,2/3] arm: dts: nuvoton: npcm7xx: Drop redundant FIU clock-names
    [v4,3/3] spi: dt-bindings: nuvoton,npcm750-fiu: Convert to DT schema


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

