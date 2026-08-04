Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545BD3F0773
	for <linux-spi@vger.kernel.org>; Tue,  4 Aug 2026 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878450; cv=none; b=G5bXSY0o0lbA6aktXyCvlJC7Ri7Txpn8d/wdstGIFmZQGctX2L45FSb4BLFVEI49SyLffdFCeYLn/D2HpJlNovZRda2LG8IummSCewnxlmB8uIzseJjl3kyy5scS5V2nRs9VDUpJ9dgprmJt7i4HXJ8ggtIFsJKB/4SjSOvADr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878450; c=relaxed/simple;
	bh=ZwVzisCGNOywfPv1KHrGsXSqsFvgwg0CBqNXme5JjbU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Ok7N/hH2QGSp1MlLiHVFc10cE96cXXLWlMJ5KSfgagDKH8mfbuuVcLC6eXVeUBddHN5kPZCo5UDFLWFOOgK0Kw4JEjdpADRFQxunskuerz19H4Ej14+PuasS05ar8HGE7ZLXJx/AcSJEBNuMhZBnOQKH/6kD4nU2Re22aog860M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2BdxDJt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2BdxDJt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9861F000E9;
	Tue,  4 Aug 2026 21:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785878446;
	bh=5stxuZyaoruSiRRxkyKXmT4n4x+kjI3k5fXSTr26uTU=;
	h=Subject:From:Date:To;
	b=W2BdxDJtToEGmhPEB7tyVHo8cNEIw+Vh/MPSwrQp3Hz4ZWCTN0cot6C8TDJ57TJ+1
	 vXqLQeG8MrxBfLz9qwxOvmv0erSfY4yjRH9AxnFyytbv/wLkU8mlhiNlb7oQKKJrSw
	 5CR0mfXTCjL2ZvRDJS95zkE+H/mkBQS/WQJALbYKCw/S7Iugpv1FzW21kOxB+St9qO
	 my+VEh8UY8rFSrpB6GdWw8jdvavb1yTjvjpnoidNI8jNGtiH8JKqVvRZ4v62Bb3JFZ
	 pSiBBSNKZglFGopSQ6Z4aXMuLA2tdzrN2TDiwZfNCXqY/vrbUdb3EMm3i8XXNMCiX5
	 3d/nBi6xCcfnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C6873926648;
	Tue,  4 Aug 2026 21:20:08 +0000 (UTC)
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
 <178587840667.3790760.1438316879742340914.git-patchwork-summary@kernel.org>
Date: Tue, 04 Aug 2026 21:20:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: bcmbca-hsspi: disable clocks on resume failure
  Submitter: Can Peng <pengcan@kylinos.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1139893
  Lore link: https://lore.kernel.org/r/20260804071904.860842-1-pengcan@kylinos.cn

Series: spi: Few cleanups while looking at num-cs
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1139891
  Lore link: https://lore.kernel.org/r/20260804-spi-num-cs-v1-0-4ccb13dcc7b0@oss.qualcomm.com
    Patches: [1/5] spi: dt-bindings: andestech,ae350-spi: Drop redundant num-cs
             [2/5] spi: dt-bindings: marvell,armada-3700-spi: Drop redundant num-cs
             [3/5] spi: dt-bindings: axiado,ax3000-spi: Drop duplicated type/ref
             [4/5] spi: dt-bindings: spi-cadence: Drop duplicated type/ref
             [5/5] spi: atcspi200: Drop redundant andestech,qilai-spi compatible

Patch: spi: bcm63xx: disable clock on resume failure
  Submitter: Can Peng <pengcan@kylinos.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1139892
  Lore link: https://lore.kernel.org/r/20260804071831.860784-1-pengcan@kylinos.cn

Patch: spi: bcm63xx-hsspi: disable clocks on resume failure
  Submitter: Can Peng <pengcan@kylinos.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1139894
  Lore link: https://lore.kernel.org/r/20260804072017.860974-1-pengcan@kylinos.cn


Total patches: 8

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


