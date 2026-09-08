Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E2935C180
	for <linux-spi@vger.kernel.org>; Tue,  8 Sep 2026 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892276; cv=none; b=SiWNIkYRlC5TQIRr2oYqJsHsBE5T/diLQGAB7aptKTUaGH5toCflBq8JbSWK/XgZrS+1++drE5Ff+39teA/V9R75jD9FQ65LN2CTeQhK99uORPQtsO70Q8HQ1/SEjHNX7r2GgA1oWZACIT34rfk2DvzX4ajKc3H30LLKdy/MZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892276; c=relaxed/simple;
	bh=qLzYKR4aoYOUr42E22TcdvQaa3PTFr7C2Kl77OXvZyU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=YX/PiBPYQHPgR42pi/Z4wyP8aWtbxKI4cE1faDTm4OMp+7u8p6ROWyPi/1EOorIaef4TxuDejPPUNNBpAkAjBD4ACVbMzswKVA8+qcqP1vdy0KKLlHpiYIigJKihc3mykQTMcOPy+MRLTDRqdMzgSl/cwXJz2kIKsY3ppRantTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjUK0AIV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjUK0AIV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED631F00A3A;
	Tue,  8 Sep 2026 18:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788892274;
	bh=bTxZdoZdCr9BQ8tzF9IZ+znPk/OXpB0ZXydtGWy9Q9k=;
	h=Subject:From:Date:To;
	b=KjUK0AIVPdzqpTsJS76okPEjt2FiGcl/JiggmuFKc/1qCSlGh00b2wPwFqFYxCeYL
	 V86y1HyUE4a4viBAFfAurLaWSaKAOYFC+y6KPji99uyMorFFbvZJQ75BiTl2W/PXyS
	 J9JNFbj7N3u9w+xmEPjiWcRLYsf1PzTnnisawrerRnYLl8amG3UmFMg8qk4toUOKq0
	 mvGrAniBIxBaep7aA48zHgR1iF0OnPb2Fm6T4zu9Z3OeS8vSEg/eQdWHssDlBbET6+
	 8355vrfCRF2hxq/+4rpftoVw7WGVnANhRMLwcRo2APOmC7M9h7SWfQxcLNEXpkc4Qv
	 Jos/dyo3tl3iQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 592B439EB05E;
	Tue,  8 Sep 2026 18:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <178889221293.3688134.9981769984847333699.git-patchwork-summary@kernel.org>
Date: Tue, 08 Sep 2026 18:30:12 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: orion: yield to scheduler in transfer wait loop
  Submitter: Rosen Penev <rosenp@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1159244/
  Lore link: https://lore.kernel.org/r/20260907005750.230103-1-rosenp@gmail.com

Series: riscv: Add device tree support for UltraRISC DP1000
  Submitter: Jia Wang <wangjia@ultrarisc.com>
  Patchwork: https://patchwork.kernel.org/series/1159608/
  Lore link: https://lore.kernel.org/r/20260907-ultrarisc-dts-v2-0-5eb4c97477c5@ultrarisc.com
    Patches: [v2,01/10] dt-bindings: vendor-prefixes: Add shenrongda
             [v2,05/10] spi: dt-bindings: snps,dw-apb-ssi: Add compatible for UltraRISC DP1000 SoC

Patch: spi: ar934x: Convert to devm_spi_register_controller()
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1159760/
  Lore link: https://lore.kernel.org/r/20260907-ar934x-v1-1-71327eb482bc@gmail.com


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


