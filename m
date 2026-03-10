Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791F9355F44
	for <linux-spi@vger.kernel.org>; Tue, 10 Mar 2026 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158409; cv=none; b=ZMAR14ML5UfRDizfjuZNgFaLCLr4HvsWu9pj9uoHoGXQvS4eWvmxsNGhvSR51kGOJ3rzv/oFKTuU2rbF5X1oXlmuCV6fBSrtBuc7A6ErqpsMw7hYbLxzzwQEY0HAJzX+Aql5iM/JjoDEOyibVMTVRKqcv0dAxm8oSs57kx63AEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158409; c=relaxed/simple;
	bh=CTnKUmaVgPiXrBjqseTyErc1afZryNP9XccglGQnK4E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=RcqsRRYNyp0ogAwa3W1ebRx6jGMsR6l8FsqYX3S85n4ZMtnh24nOOBAVJtuT+/j0MmYG3CffQMLYbxON71+YOCtE9OE+ZGgHeEluV/JSdyfugga2PJINksL4E3KphDZo5eesD6Rc0BwzdkYSy180ktnPYOZTA4P87sTHwxWfCHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwHwtqE0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwHwtqE0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52092C19423;
	Tue, 10 Mar 2026 16:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773158409;
	bh=CTnKUmaVgPiXrBjqseTyErc1afZryNP9XccglGQnK4E=;
	h=Subject:From:Date:To:From;
	b=KwHwtqE0Fs3S1qYgyjQ/9eKogXXKoZY9zG9k8AAYKPfUm4DXxMrvdH0WrMKULZNp+
	 aBd7i+Gbkf4GzaFiUB9zbr/RGFFf8Ptbicut0I5aLBQe9lKKiqrTwZB5sXAH08e5Wo
	 B1j8/ed3iYQ+vF8jXY2npxhftDh79b3nLgjOtKfyTZBI+BY0eCbivDMGNZ9beDc/kz
	 SfC43qlUP/pg8qzqmXYRgFYDxBRxBWU8sMeeOzHgO73bfXKySDhXbqjtZxuHQGg8X6
	 wOfA8f4048a5QWquFmXYo2XPX9sVrt9yL2MAHjWpd5bMUs5RlB8qXuZbPB0OJo4r7e
	 dkLrpcA39JO8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4017E3808200;
	Tue, 10 Mar 2026 16:00:07 +0000 (UTC)
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
 <177315840589.2398788.15732100894993727048.git-patchwork-summary@kernel.org>
Date: Tue, 10 Mar 2026 16:00:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: cadence-qspi: Fix requesting of APB and AHB clocks on JH7110
  Submitter: Mark Brown <broonie@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1063053
  Lore link: https://lore.kernel.org/r/20260307-spi-cadence-qspi-fix-jh7110-v1-1-c9f37b8c58b1@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


