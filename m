Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FAB61FFE
	for <linux-spi@vger.kernel.org>; Mon, 11 May 2026 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510461; cv=none; b=NQiuzK8GYHhEZRuSjtf+qRDIDe6/qGMnU6k2ukdGXlA0UpzmFot+fBjQDF/js0nZokfIsYjE6H4/GyOhMarv1inbfX4YF6GGLcBCdTf9oF3gLeYlE3O3TV6bQUdFw77IjKCw710zje0AUfSMCsrkLF2yTaC5HIZSHJ5yCPDXEM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510461; c=relaxed/simple;
	bh=OuC7g0xPiieOTv3E+KHV+g4l3qQ6gw7dZqDNOUNj7EQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=qWCLJPMWalGbm5sZRh69d05qTMhsqFbXFHGJ6OqqnjxFUoc9uGH+MR0dFrPMS6N7yLYs/2EVSGv34QJzPAVD2GKpDbPaPBgJ1UNG3Z0mwP7ZkzhlM/unUvi+Xd1Xl/1/rgtdFcqdyK601KReJdXO2KatbFT/gGWYWZ4OIrtT2Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ad4MzVbt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ad4MzVbt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B68C2BCB0;
	Mon, 11 May 2026 14:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778510460;
	bh=OuC7g0xPiieOTv3E+KHV+g4l3qQ6gw7dZqDNOUNj7EQ=;
	h=Subject:From:Date:To:From;
	b=Ad4MzVbtRDa+mhm5W+sS1XWpRhtku8jU2weaUnk8PTXxKO+sKk9V6U2GEk5u+J4ln
	 ZsMayk60vWePJWqwlBTkaqnS//8bO4Hv0DG6IGV+SkJpu7qAtWJ7ey02Iy4Zzhgtdh
	 Pw2SKFZNxdOqJgVk6C3R/27hDEbcwpRDhWEzCfuwCEF9hBRyrJtzlmYpH8E+ezR+e7
	 9i0MRsq9cu9b3ypnYIddlitTtcS5TBPxRagYumhGiFaO4PE16htnOZUfisC5Y1cDSt
	 7LNdKvQz7p1Jj8q38PlX8bU7Zh7h93xIPpboV5Pn9o5h7v3L6UjTLVTXjEH9YuTsHv
	 HNuRf6lUR9GBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8179639302E0;
	Mon, 11 May 2026 14:40:08 +0000 (UTC)
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
 <177851040726.2271173.11187968876503575471.git-patchwork-summary@kernel.org>
Date: Mon, 11 May 2026 14:40:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: Use FIELD_MODIFY() for bitfield operations
  Submitter: Hans Zhang <18255117159@163.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1088228
  Lore link: https://lore.kernel.org/r/20260430155456.36998-1-18255117159@163.com
    Patches: [01/10] spi: amlogic-spifc-a1: Use FIELD_MODIFY()
             [02/10] spi: amlogic-spisg: Use FIELD_MODIFY()
             [03/10] spi: cadence-xspi: Use FIELD_MODIFY()
             [04/10] spi: meson-spicc: Use FIELD_MODIFY()
             [05/10] spi: nxp-xspi: Use FIELD_MODIFY()
             [06/10] spi: sn-f-ospi: Use FIELD_MODIFY()
             [07/10] spi: stm32-ospi: Use FIELD_MODIFY()
             [08/10] spi: stm32-qspi: Use FIELD_MODIFY()
             [09/10] spi: sunplus-sp7021: Use FIELD_MODIFY()
             [10/10] spi: uniphier: Use FIELD_MODIFY()


Total patches: 10

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


