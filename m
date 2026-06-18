Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF23D6CDE
	for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769467; cv=none; b=Hlt2KeBSuRX+oVcbl4euVRy8z+HPfc8bek7yCXUqRS/WXsB0/1/Iry/3p3yLbeeZtjr25N0srn880Xnlp8VbTSQN9mbPsXQifqnyKOniutTc6Y6tK1ly9eEdUpmLz0caP3aKKc/EFyY6pYliP2NnSrGsNKLbcGg/L8FMKjKtVnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769467; c=relaxed/simple;
	bh=yCfqfOQseDV1Q5TB4bj6zVUCUIfgJi0p6u9uqXwKAVI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=n7g29kymfJHZpD/VIzfyC5NMf/IXwHGGwUvAExJ/tsLCL/6ZtDj8sKMuslGpFcLX9GECow6sBR3myKeiapiThr3BoOjql01x8ZqkqTMaaVcx2fVSsitK1HF8iVfIakLKrSsqwX06YbnNO0eQRzIxYTOle0fWpu0z3vpZ+zmT8nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRqVDi+3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRqVDi+3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA251F000E9;
	Thu, 18 Jun 2026 07:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781769466;
	bh=TQ8G9rER/ZLoygWNb2r9NkX+3MOhwiSE6GItZbZyRmU=;
	h=Subject:From:Date:To;
	b=TRqVDi+3L+R1F2QfRZPLx+6AqmMCbaPZH0UyET2K7/+9e7ogH7aiXFL+D/q3tTea/
	 xaX4muruxmfAJ0AQnd01X6Pl84j0acXVch5rIZU61MO+Ibw2LJLsb0t/RjZhFQlQsa
	 I7V5Z/y8Kd8KeChQbUc3Be/fvLCqXUbTwOg/2T/uHChRAHB6ZA8SGpiTqBRkH3gvdm
	 jA87SlJZB1TI5GqyWzIedhq8sZesNlJcOPTuUGdX5RcgfbEub8hOzGD/2sCSxMc+C9
	 CCQJNdwjxVw4Kka25FqPeWgi3i8Wx1M3CEvQnf2eScUdX9zcEO4bJ1eCLMDwvIW7Jz
	 cuY1DfwlJFUUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569BE39D267E;
	Thu, 18 Jun 2026 07:57:41 +0000 (UTC)
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
 <178176945978.1954745.17797804167975184147.git-patchwork-housekeeping@kernel.org>
Date: Thu, 18 Jun 2026 07:57:39 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: cadence-quadspi: add PHY tuning support (2026-06-18T07:37:09)
  Superseding: [v3] spi: cadence-quadspi: add PHY tuning support (2026-05-27T17:55:14):
    [v3,01/13] spi: dt-bindings: allow spi-max-frequency to specify a frequency pair
    [v3,02/13] spi: dt-bindings: cdns,qspi-nor: add PHY tuning pattern partition property
    [v3,03/13] spi: parse two-element spi-max-frequency property
    [v3,04/13] spi: spi-mem: add spi_mem_apply_base_freq_cap()
    [v3,05/13] spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
    [v3,06/13] spi: cadence-quadspi: move cqspi_readdata_capture earlier
    [v3,07/13] spi: cadence-quadspi: add DQS support to read data capture
    [v3,08/13] spi: cadence-quadspi: add PHY tuning support
    [v3,09/13] spi: cadence-quadspi: reject 2-byte-address DDR ops on PHY-tunable hardware
    [v3,10/13] spi: cadence-quadspi: enable PHY for direct reads and indirect writes
    [v3,11/13] mtd: spinand: run PHY tuning after init and update dirmap frequencies
    [v3,12/13] mtd: spi-nor: extract read op template construction into helper
    [v3,13/13] mtd: spi-nor: run PHY tuning after init and update dirmap frequency


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

