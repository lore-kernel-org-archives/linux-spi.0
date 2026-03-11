Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3093B3880
	for <linux-spi@vger.kernel.org>; Wed, 11 Mar 2026 10:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226210; cv=none; b=lyVUMeDLBcbTqRB3W8BC3aRtJvJmqDk+uJUgCrlf2tpm8A8pgiV6Q9cKnN4LHY/e8LNbLTOavLX8VLv0JRUm7Yn4yKj9Q9dzCGqaszSvPDOkj6USQcRA+dJsn8muIjC9o5Wt+tz9asQ8AxtkQmazwMmfomaYe702pVuY0VPsVqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226210; c=relaxed/simple;
	bh=vSJmMzk4BgR27tOcmNnonH/ok/L40P4sfIzgUkigcr0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=akZ/oDjzZaU3OMao9+6tyGdGTecOIOAG4zyGKfkoWhJ/n6VOJNRFF/ECAaFljxrUJ6GmMH8IWfReGqo87JMD3WNAPgYL5Eve3qU9A5L3XHOmQIU8anwr225rP+y1FwSm5STT3IQKR9NVXdu6HS3X9++HsMd2y7dTLNeLkuGTmMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anmenrZS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anmenrZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD83C4CEF7;
	Wed, 11 Mar 2026 10:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773226210;
	bh=vSJmMzk4BgR27tOcmNnonH/ok/L40P4sfIzgUkigcr0=;
	h=Subject:From:Date:To:From;
	b=anmenrZSiCMNHfOZsjGB8cFnxCV+/N0U+U5o18ClOHhczhr+ApTi+y+nMvhpK53cG
	 OVfa2pwrCb6iisyPceEHvx5fBYQs6m8xGprBmiYPspt8WDZ1dKEfAsydvqXqMfJ7wA
	 kpSE7PI5hsePJ5tP0orCUdzGaUK8+77PHKgzJZwk/FaP8POT+Jo8kfSYBHcbjQa4zY
	 ZYY36JUoRCADuCQm3VC/Nn3sFxZuZ2oFiUsbbwLg8fRAftgy/uoYTBjwrA4kDOcdhg
	 UVvG9cwyb9TlvVf+Tt4ZIYZ7jL/nrO3bPIp7RwVSmYfOPpkSEsu1wmv2jWIMpNWrvH
	 sTu6LW9XdgJJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BCAC53808200;
	Wed, 11 Mar 2026 10:50:07 +0000 (UTC)
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
 <177322620630.3195438.18254569396716978914.git-patchwork-summary@kernel.org>
Date: Wed, 11 Mar 2026 10:50:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: axiado: Remove redundant pm_runtime_mark_last_busy() call
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1062966
  Lore link: https://lore.kernel.org/r/20260307-axiado-1-v1-1-e90aa1b6dd9b@gmail.com

Patch: spi: tegra210-quad: Remove redundant pm_runtime_mark_last_busy() calls
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1062961
  Lore link: https://lore.kernel.org/r/20260307-quad-v1-1-f103515db501@gmail.com

Patch: spi: intel-pci: Add support for Nova Lake mobile SPI flash
  Submitter: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1063758
  Lore link: https://lore.kernel.org/r/20260309153703.74282-1-alan.borzeszkowski@linux.intel.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


