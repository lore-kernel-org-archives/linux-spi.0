Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACEB30F81A
	for <linux-spi@vger.kernel.org>; Mon,  7 Sep 2026 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778768; cv=none; b=Zgvr5aKAKEDxXMSazC3JYkHeu3fFur+7itTIVuYKPLT0MGI0U0zrChgTkKmyu9P+RmtRGQDep615GfZdNJGw03Yn8iFLx4JKX4fNpg/w0DZvG2U8ac3LTT9IJoQ5F22aVIn36BEnXoXBl3C/HTYXlKBgZG5jyELl0LX7sLDfyQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778768; c=relaxed/simple;
	bh=HajASYo+mkHa8x6mnzOcoTjNluBK1SGPLOitD1mVvkQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=E7S7Ht/DY4lh+pzDPw6IM5WfBXLFT4rYLMLKmi8/qVlV8rQx78U/cTiVbm0UVbEz10NlfufELNDhZxDarBjO0AbOc7uRHCeuxIVQQ3aWXmYprdJN84Xpc77wZNyjRRTfiL0IBBRel/Q0H2bRv8Bl/xtGXGKe+lYT4HstLp00rQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6i4s9/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6i4s9/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3D71F00A3D;
	Mon,  7 Sep 2026 10:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788778767;
	bh=zhUcXjaq06KybjCw/f9QuRygUSfSSvbbwKum2f2U7Q4=;
	h=Subject:From:Date:To;
	b=X6i4s9/bx5/xfTQhadBsca/mqEi/3HfYNmpuLsL4evjiG4cpShvxvPnB+iGw0XCA7
	 WeAIITqfdz05YtPSJ0Z34d1VJM0YkVvreQHhmlVM9bgbbx3RJQ77+59ZTzE53KSqaR
	 Li3VrHwaGcchOQOaZhs/ml0wDgNlETGtKMKJYoLUxNOpQNiaXRk5vASfi1H5SMzSf0
	 KFDKZTa22pOPSc923Ync4Z2CiylVx9+5MbUzEG3BXZs5b8af9/m4RIBiR+jg9lpNud
	 52ts7EGupWpWW6dmwHpdBMCtAz4msY4KpIPpy2DwUiPDL+f61phuonhP+AGaY/337e
	 hDkEvUiSmFDQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BC839D5FDF;
	Mon,  7 Sep 2026 10:58:27 +0000 (UTC)
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
 <178877870655.2455108.10531301496140595953.git-patchwork-housekeeping@kernel.org>
Date: Mon, 07 Sep 2026 10:58:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] riscv: Add device tree support for UltraRISC DP1000 (2026-09-07T09:54:40)
  Superseding: [v1] riscv: Add device tree support for UltraRISC DP1000 (2026-08-24T05:54:13):
    [01/12] dt-bindings: riscv: cpus: Fix yamllint style issues
    [02/12] dt-bindings: vendor-prefixes: Add shenrongda
    [03/12] dt-bindings: riscv: cpus: Add UltraRISC CP100 compatible
    [04/12] dt-bindings: riscv: Add UltraRISC DP1000 board compatibles
    [05/12] dt-bindings: timer: Add UltraRISC DP1000 CLINT
    [06/12] spi: dt-bindings: snps,dw-apb-ssi: Add compatible for UltraRISC DP1000 SoC
    [07/12] dt-bindings: i2c: dw: Add compatible for UltraRISC DP1000 SoC
    [08/12] dt-bindings: net: snps,dwmac: Add compatible for UltraRISC DP1000 SoC
    [09/12] dt-bindings: dma: snps,dw-axi-dmac: Add UltraRISC DP1000 compatible
    [10/12] riscv: dts: ultrarisc: Add initial device tree for UltraRISC DP1000
    [11/12] riscv: dts: ultrarisc: Add Shenzhen Rongda M0 board device tree
    [12/12] riscv: dts: ultrarisc: Add Milk-V Titan board device tree

Checked 165 series in 4.58 seconds.
This project currently has 16439 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

