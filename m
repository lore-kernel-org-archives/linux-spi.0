Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886AD45FFA0
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787050748; cv=none; b=H0sALXVxV7PO5A8gNktwSJA02gmmvLm6kycczRHoxDhmqOE6UovLhCybYeYpQj8cV0sWcfzyTcC6LAe/zK9Yr67J3tfVIuFRgePYZesCxrOEEsGz+Ip/tq9zgtWrxKs34HYr3yIyEea0YmoAyK81lC6MgAshveW0gxL1Wko2Eh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787050748; c=relaxed/simple;
	bh=VZJveDS2uPpC4HID6lCY+j41hqWYvZh80V6myBDfucE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=cE81RlJQ8XmE65XMhbWd997/gKcQm+OgjQwUsI8/qFHUe6ZASORLDIV/rm8RlqFms1C3Cr0BUvONx5Pc+LEJKafFXlPWj32QZoDV6CClUfcmE2tSyIH9CB6tFbrPzH80BG2c9BxYIfp1t8hbkr2nkYnbrMVabbsT+Oj9twTLBWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6gDB01J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6gDB01J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA4D1F000E9;
	Tue, 18 Aug 2026 10:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787050747;
	bh=I9M4GOtC11sMYmn64EOzHPnzeAq4VswK2GxHf198woU=;
	h=Subject:From:Date:To;
	b=B6gDB01JMevGb1+OF4uYhf5hn66ntaJ07Swwr3iEqEdA8QMmicx8zXGt+Wf29mz8a
	 brfURNgGJjIFbNoEMJ8bxQpE0FgKrsIeW9A+dWd0x1dJclUWVBuVt1UOUj9mQXaVv8
	 /HUQL6wPYDSKDBvhnysvoxX4GzdJJZHJENuk+6enyTYLyoq+Fua4aINFrls1ybYG5i
	 V/SdPvvIs/7tOuJDozRsiPDXHHwrIuuI5TfynI3EYytqpquMr7+fQ7owtFoDyGXeoN
	 I6KFEZFrXdLvZYTGAohWLCM/00qsevoukybp2S9rGtapDN2lZFMsZ/1Qn8Mw8RrK/F
	 U6P4E0f5L+f9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 240A33926657;
	Tue, 18 Aug 2026 10:58:20 +0000 (UTC)
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
 <178705069902.2022795.10830366890663197986.git-patchwork-housekeeping@kernel.org>
Date: Tue, 18 Aug 2026 10:58:19 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: qcom-geni: Add shutdown and panic notifier support (2026-08-18T10:45:53)
  Superseding: [v1] spi: qcom-geni: Add shutdown and panic notifier support (2026-08-05T10:42:08):
    [1/2] spi: qcom-geni: Add shutdown callback to quiesce hardware on reboot
    [2/2] spi: qcom-geni: Add panic notifier to suspend controller during panic


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

