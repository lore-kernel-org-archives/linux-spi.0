Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A4340DFB1
	for <linux-spi@vger.kernel.org>; Wed, 11 Mar 2026 03:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773201466; cv=none; b=erTVUm4YTRG6lY59zxsGz/XtY+hg1qv1DdAgeoqBBGFBWJwn/C3yyP6VCevAOTzmDW7XqczKWdVJuv6s3jDwUOuX3SodcWDIzNAKSqyHEyrt6WOlolU7bq21xcKPOcvMNYBrrbO5eRzTiFipnRzObBQts7OfWQGtw6kTjLPuBEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773201466; c=relaxed/simple;
	bh=WZIjqPGkT4Si4FVy+fFJvbWhqzs6KCNQnsGI9kOHjMU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KH93Igw5Q9RXSX5g0YdLFOtXCHWkNQAlCHOWUb7nMPxrW23UTeXtnTptEtw+EuwXf5y/Avqgz8iFy7Sfdg6tGKnR+UeCq1COfjAuyuMU4iwucWdRXkt/PXVOJjX7kXAWdS5U+7zAJpC4xRaV1skbICmiYTaac5yH8K2lK96v2bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uL6d1n2k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uL6d1n2k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67856C4CEF7;
	Wed, 11 Mar 2026 03:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773201466;
	bh=WZIjqPGkT4Si4FVy+fFJvbWhqzs6KCNQnsGI9kOHjMU=;
	h=Subject:From:Date:To:From;
	b=uL6d1n2kTNGPydrEdOwbRKV1G3Gs98EYXDuq0YhdmDT8CUup43UqtXaKWUgX8kSSQ
	 rU7iTTUPMsAZ3chqjfYnqfotiTkJoaVvuoKbOehPap4pQqgEZkCCQWvKzTVi6J2UHG
	 eqDzlABl9MUcpGFzhD2S3AGylr/X6Js2vwyY8Ob9BBXkGNRhqsyXgc0j+4Vssxl2fd
	 XeqgjEpFqqrPWgrOMJQ+xzwZPUsyJ/5cbBcYhs3EXOu62zWhHSU1TXM0ckrxpsdQCV
	 LxDIvaCbtpkefA8qpc8/Nq9JqUadzaxR0gMNizSE8h2JVdh3bAZW04aCHdpevYgPBO
	 v5eQffImN6XPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E723808200;
	Wed, 11 Mar 2026 03:57:44 +0000 (UTC)
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
 <177320146265.3036680.3956481745820765170.git-patchwork-housekeeping@kernel.org>
Date: Wed, 11 Mar 2026 03:57:42 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: dt-bindings: mediatek,spi-mtk-nor: Add clock bindings for mt8189 (2026-03-11T03:43:40)
  Superseding: [v1] spi: dt-bindings: mediatek,spi-mtk-nor: Add clock bindings for mt8189 (2026-03-11T01:51:27):
    spi: dt-bindings: mediatek,spi-mtk-nor: Add clock bindings for mt8189


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

