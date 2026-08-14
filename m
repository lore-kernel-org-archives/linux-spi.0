Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B867143E07D
	for <linux-spi@vger.kernel.org>; Fri, 14 Aug 2026 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786705158; cv=none; b=UvJILvw+ltEIoUi2asFjk4qthMbCmtQNOXhSiDFTNUEeYmcdX6cgFRGKuxfRNMRuoegy5bUTCJNxvd/T2aY6LZWv3DVXSzrCtu367bcMv7CgAwSqvwvslZKyXGPxRMwUdRMhwtQIS611xYuqwO8phtH7qU0WbNVOckTa7+3KllY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786705158; c=relaxed/simple;
	bh=iLOAXXqIe8tUlZb2sqHCeNp2BICDXG/CKM/yjkrCHkc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=hD7ZynsSnhN3hJzh4l+dtLs3hbI3Vt8uM14wAiwHkQsqsrz+RmfZV8lAf+5AIJGbIMtPqN5Ih3L5erRII98T0wrN4z8Ug75DVlm55ENBRtRXsPjGMkYJg0lj02oRiReDZVi9LrmSsv8cAI9gVV/yf5cEe41K9peCBZiyRl1gMvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEaD2E6z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEaD2E6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610411F000E9;
	Fri, 14 Aug 2026 10:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786705150;
	bh=ogf1E6x8rglQuSDJX8yjGsbBDcLkLt/VPV0HSHYVMyA=;
	h=Subject:From:Date:To;
	b=aEaD2E6zaNVFKd5raxDxy21sDO9GLSNaPTiyrbMmsGpFMLzggPJ4krfBpIoOLTUiX
	 HohdQfnQot+lmUzeJTTS74V5eqU/aBqk9NhtWInwtcQE1v2J/sMl3uFWkIm7bRB0U/
	 UA/3LCGbHITtYWHEBGSqAoX31944WEP3Z1MK231rA6hiK8ikSSJCcQq4lXXBsUeaQP
	 39Y6AIScznwmKeV4RMcOBiRWwXNWLJRbHicV0olYeOckGvmOxrRCwAtckuHC0Yx6Mv
	 3a6Uk8tLmSRBm2tQEtperA8/Wn+jcMf3szozQxdyF4eZm38+bWt5UvpGJX4/TriYPs
	 CleC8F/fcl+cQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D3252380CFE1;
	Fri, 14 Aug 2026 10:58:25 +0000 (UTC)
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
 <178670510435.3302804.13487593825989602859.git-patchwork-housekeeping@kernel.org>
Date: Fri, 14 Aug 2026 10:58:24 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: dt-bindings: microchip,pic32mzda-sqi: Convert to DT schema (2026-08-14T10:17:33)
  Superseding: [v2] spi: dt-bindings: microchip,pic32mzda-sqi: Convert to DT schema (2026-06-25T06:09:03):
    [v2] spi: dt-bindings: microchip,pic32mzda-sqi: Convert to DT schema


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

