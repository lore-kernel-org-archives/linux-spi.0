Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649523ED13F
	for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295639; cv=none; b=JODCWvp6j2aqMdSqpvXhsVYVkhrMJO78kox0OTydZFiosbs0MVYl99KWK4PiA6QsiLuS1DoS2juIJynBG9kPAQHK5dG0uE+EsAWG3C8y6BIUQfkO6lwqi4iszehA6xB+0kwtCU4QD9knEK1xhiKu8/VqVPzdWlmejMjqeZV1g3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295639; c=relaxed/simple;
	bh=thWGrdb2fcSCV4Sq08exHOMIVFkzeIfGlVKEO2f9GZM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=nS6qY5ZtU7KtV6pbDH8Q7+XRXU6SOJtukwG/5kAq2jF6PL7z3QTsoIw9rMvX5T2/7b6nxVreLzfSTKHpkrpEneR14gZETMd96efdU4XmVBchfr0EJIs+dY9DFV1fO3m8Ax5FZBMLm+lNHcspFHqcHadNayvA8H1tD1RfIIsspbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixWBFZkv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixWBFZkv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063891F00A3D;
	Fri, 17 Jul 2026 13:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784295638;
	bh=2vNfO1htdtFFKYYz7YJI9i1rfHgy+SnjHGZtav9ZB+c=;
	h=Subject:From:Date:To;
	b=ixWBFZkv+qO0EuXNJolzd2JHIz36J1N3PdN0lMLCXoNUuYvBMY4Y0LV4ttTY9q3Mi
	 qOt4/929eHDTadDTTuWP+cy8daVvO3D6XfdXeYTSro81Bi5zEFUuVQ4bixwKaWXs6a
	 07PV56+yNTEnH9a/INCitc7jqPGQ8IuuxJap+bgfB9tCOMz6dWfmc4zFUjUvprloir
	 jSernK632FteDkyiMSyCU1H13BOXM/nHu96WH3eIXHJkvJuVdBHxd2F7GnU13NPn4T
	 t6uGq7bEvINbcMTMYigwL0FV2TWHYSDXbL8p+bZtT11AqkIPhUeurGi+CmVQhw8IS6
	 aVY4MgxVWvV5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 96A0F380CEE7;
	Fri, 17 Jul 2026 13:40:11 +0000 (UTC)
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
 <178429561012.1724817.352190480038262170.git-patchwork-summary@kernel.org>
Date: Fri, 17 Jul 2026 13:40:10 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: realtek-rtl: change to __raw reads and writes
  Submitter: Rustam Adilov <adilov@disroot.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1125768
  Lore link: https://lore.kernel.org/r/20260711083411.45836-1-adilov@disroot.org

Patch: spi: geni-qcom: Fix sticky ret causing wrong return value on invalid proto
  Submitter: Praveen Talari <praveen.talari@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1128638
  Lore link: https://lore.kernel.org/r/20260716-fix_return_error_code-v1-1-3295003aacd5@oss.qualcomm.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


