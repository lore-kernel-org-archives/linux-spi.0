Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79CA3D0C09
	for <linux-spi@vger.kernel.org>; Wed, 22 Jul 2026 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710747; cv=none; b=QNqkRuujBOlztxNJGiDDp0iGXo9FxSZZ2I2eQb/ruLcat/nXexC1QtYfpJdCa3e8wTQsLtDefEaV+jsxTQa9NnZ67SOr9ZP7Wu+bMsr63Vpfkb44GzZ1nFiREDxj0o9Mc39blwb22xB72zC6cu7QLrS+or30pMRNL4GYJ1HVXLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710747; c=relaxed/simple;
	bh=wtEI2uvTpA3uE500+M2MKgwXlWExpSiXdFLYp7rYNQo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=GxyrSLzUyzzDd3heW4/rs47EXRj3cY7qbgiZwEurY8Q4nsU6YtnPhITHxpt4dmYNE1UCE5T/AOQZahpjPaoEqxd+io20hAGxq2w09CoQ13EJQJ2UC3vAL7de/tD+A7fOlJoenBFRdLwxNDYmKIQa9njTDpm3FwE13Rff4gBQWDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=am2pqbOc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="am2pqbOc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED341F000E9;
	Wed, 22 Jul 2026 08:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784710746;
	bh=+Si9/SvNwgHhmlceFSsd9Xq4wTjP1T6SQhS40YDtAEU=;
	h=Subject:From:Date:To;
	b=am2pqbOcxrbvnp0Us59jH/kxFbCo6pYi5LizoJowjL3Evzu+mNsy2+Vc9UPe1Xp4N
	 L2sUqyw2Qh8l5QfFibSSwpkWHQbiKtj8vcfJI9nYxCMvvq4+DuAmRAnowR4C6QtI7O
	 rX4n67IgoA/cpujAKSwCywWu5G9swKJ+fjnkprbfgXzOOwcQJIS8CzqPDzT0Dv8CfK
	 k3f347dmzTYztn4Dr2AygfsR6g9NR9tQDGLqLvJGBKZtFyaSjb3nMWmkWaCRbU/4Gc
	 WcTTBHNnrmUJSp9pYQAQOMhoGwiH5dK1Buu72onQ6I7Beo+NTKlM0l+8OPKfrZgUIg
	 X2PsQB0pNDYlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AC53809A90;
	Wed, 22 Jul 2026 08:58:36 +0000 (UTC)
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
 <178471071553.1303486.8232131477119052262.git-patchwork-housekeeping@kernel.org>
Date: Wed, 22 Jul 2026 08:58:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v7] iio: dac: Add support for AD5529R DAC (2026-07-22T07:54:13)
  Superseding: [v6] iio: dac: Add support for AD5529R DAC (2026-07-15T11:41:04):
    [v6,1/5] spi: dt-bindings: Add spi-device-addr peripheral property
    [v6,2/5] dt-bindings: iio: adc: microchip,mcp3564: Add spi-device-addr
    [v6,3/5] dt-bindings: iio: adc: microchip,mcp3911: Add spi-device-addr
    [v6,4/5] dt-bindings: iio: dac: Add AD5529R
    [v6,5/5] iio: dac: Add AD5529R DAC driver support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

