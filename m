Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F5D15F40B
	for <linux-spi@vger.kernel.org>; Fri,  1 Nov 2024 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467229; cv=none; b=aaL0AxcHEV75VtpkYwnHcA7SVbak4lmx20+P2Faw0XcGko7T7XjOXADeMuJ8Sgx1Y0AO7kcwzZO6bk6dlMOfuyb6nLncoJnQSEE/45i1t0fgJedrTehqSZegc4PcG8HQf5y4Voqt1DaIZV1Mf8SN6O0/Nqpa7Qm1Tt0dxOMBNRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467229; c=relaxed/simple;
	bh=YfwR4KzCA2brWFcK4ODdbOvkJKzKrG3rMYzc/+K3TEs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=jqj1BPJCtm2txcy55xiX8fEIvy5Uc6AVyMJ3AlFrNo2awY1s5N1wamPPFBESTy4x/ALEoMkne9wMUrk6kWhlljDdVgB3T3dkEfJojCy5qcNb/3MSpR8bVMbHhsYNWxTDJOoyZk7SNF/b4cSwMicdKDxMjFiu/ciEdC+iSEjLnbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEpMNjAF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEpMNjAF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67315C4CECD;
	Fri,  1 Nov 2024 13:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730467227;
	bh=YfwR4KzCA2brWFcK4ODdbOvkJKzKrG3rMYzc/+K3TEs=;
	h=Subject:From:Date:To:From;
	b=hEpMNjAF0qZ+UFsjxFjx1vkGTBD8Eb5RXtDXKKPJddbIJ31/fP7OkY/+GQWFlz46K
	 TdUh1jY5pBsc6HKTqCzaFiSXluokHSdcnIx7dZYsFl97m/n2cgInHXp+ciaQTaglOs
	 0kTyRsn1uQ4RgzNHSdkigstCh3gNGpaDl9O1M+c7XjlQxtYfPJjkwTOjga5GZK9pxJ
	 LQJs4Yk5lDRHENq/M9nc4ciVXC/E9CrlZAM2C3URKLDsXCRJbyQhD49E4WGPJSB9Y+
	 Xi+mjt2Dff593w3m7zS4KTbgRcfZsIaFnA9MvTWgidH+h7uhGTkCVRcdP9To9gY6Ln
	 WW9e/h2cgwfog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7B2F5380AC02;
	Fri,  1 Nov 2024 13:20:36 +0000 (UTC)
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
 <173046723500.2588482.11601733050967719426.git-patchwork-summary@kernel.org>
Date: Fri, 01 Nov 2024 13:20:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: axi-spi-engine: Emit trace events for spi transfers
  Submitter: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=904997
  Lore link: https://lore.kernel.org/r/20241031111646.747692-2-u.kleine-koenig@baylibre.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


