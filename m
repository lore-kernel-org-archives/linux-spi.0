Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232E133CEA5;
	Mon, 16 Mar 2026 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683575; cv=none; b=rB9PNTQqbYoEkPRe7k1nkbTA/JGrPTeDJLaEaxirUewoxByREohN/qPTxIZpDq2TA9XXfBnmPYvvi6Suaj9piQu6p2ab7dQf87w2+olYIWhPljJF90TymqjTaufffKRS/oS5LacElsAl4OfNltUe7nGLEIWoY5psJ/yOm9z6Wqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683575; c=relaxed/simple;
	bh=RMMdwUBKrsM2fcZYyAiOm2zP3QvMKJ2MU0w5P34paeM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uTaVqWt8sR+cvz7osF8Xq66S7dMddcts2opNT00vtb7Js4wab1FXSkapid7h30TFHiLnU8RV//Kk5HMfLOdJv3v/JdzLDdhbtWh85TjGGpkV0DJWTQ9IQf03JACYdwOFUJcFUnj/bAJPtU7EIIizBocjyM1hLZcdSQKcWiukKoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGE836MA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGE836MA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCE4C19421;
	Mon, 16 Mar 2026 17:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773683574;
	bh=RMMdwUBKrsM2fcZYyAiOm2zP3QvMKJ2MU0w5P34paeM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MGE836MAujJMtajPP1K5ZufO3peej0xs9cP9x4ui+8IU7IiI7nVnVcw8gAKS0w/IU
	 XlSXngYbVwvCGq9Wrs37k7x96nheMn1D/+jdYx60BRrb46QT7aRUVQa8GeuPCHz5l5
	 He/t6t2hDnoNWEoNjGDaSzBt9T1cdTVwQLcJ8eL95d2YUBYfwFO7ST+L44NofucdY1
	 gei1KIRbs5ls9WnQk5rAKZ85tBuF/4oF6LApFNemKanQnDszs8ENz57/5A04Lo+GZc
	 g6WHBLcHjjfefk5U1IDJqzhTUGcdBMpbJqFlSBmsPZeABLEjeWNxtE5BTgiuzAlhFd
	 DeSMdLS0Vleog==
From: Mark Brown <broonie@kernel.org>
To: Sunny Luo <sunny.luo@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260308-spisg-1-v1-1-4e209faf228d@gmail.com>
References: <20260308-spisg-1-v1-1-4e209faf228d@gmail.com>
Subject: Re: [PATCH] spi: amlogic-spisg: Use IS_ERR() instead of
 IS_ERR_OR_NULL()
Message-Id: <177368357343.147197.2388005468869139656.b4-ty@kernel.org>
Date: Mon, 16 Mar 2026 17:52:53 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c239c

On Sun, 08 Mar 2026 14:59:50 +0800, Felix Gu wrote:
> devm_clk_get_enabled() and devm_clk_hw_get_clk() return error pointers
> on failure and never return NULL. So IS_ERR_OR_NULL() is unnecessary,
> replace them with IS_ERR().

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: amlogic-spisg: Use IS_ERR() instead of IS_ERR_OR_NULL()
      https://git.kernel.org/broonie/misc/c/8abf84f76a54

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

