Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CAE2222B2;
	Mon,  9 Feb 2026 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647504; cv=none; b=MSL75pLmUSeTiuoWky6IZEJa5pUdR3iL9xzvSExmazz50xfjnbiWdfg1NDshhOYfJhKc6QRuvTZJhBbgO7MMAbpKfHeZBmxOxwyPPl2SH+xwttcmqJgpTt589KjsVn8rYNfSFo+IsWlUpduGYZbLYbtwc3HnmVUy+tKl+MlvkFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647504; c=relaxed/simple;
	bh=6HDfdo+vOdo3tUWeu7ARlrw5+jPvCyD9bhcH1iQ3rz0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DO3hF+hOLuSQL4jGdxRZDNFhufgAt4ayNfl0Ttp0shVDOqSJNKGkHphT8Sfd1Sdus4YBvdaUQRJ2/DLHW4r2//EEgTMFdKbvLgbW8yjapaIg9o52Es8Gl4+En5lSoS1OCWUwL3vNdQSJ+VFnPPJ5rXZFAUpL80J0UYwKCNap278=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JI6VZjCd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JI6VZjCd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6321FC116C6;
	Mon,  9 Feb 2026 14:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770647504;
	bh=6HDfdo+vOdo3tUWeu7ARlrw5+jPvCyD9bhcH1iQ3rz0=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=JI6VZjCdlK7PcwrCfjv90OCGmjd+Zy5NEMJl+vkHBn9Q9TP1qgG3XCMosTS8v+mak
	 8MDMnN974OJHiRhoavzQFTl2mRz8ofJiASqo9JE8hBaChf249mNWlpNIShAM9pEZPQ
	 c8DaE0tbM4ULtn3/gVEEJ2L7pkVjGOwMh08yCT5JJbxy/zVnp/YuiRzBPJUlnSqlqh
	 dJL3y3eX4BvcsiWT58YXFGU++mYfROd+q+QQ4sNslnJPCxQ9PUbNJLg/19sdBPMgQB
	 FOcXNq8571q4JF+GPHraYQ6UIuriLMZzwclUVK4aH6P0aEvahT09++qNnRhUNSqMaU
	 v/sJr6y0zZoxw==
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Francesco Lavra <flavra@baylibre.com>
In-Reply-To: <20260209095001.556495-1-flavra@baylibre.com>
References: <20260209095001.556495-1-flavra@baylibre.com>
Subject: Re: [PATCH] spi: tools: Add include folder to .gitignore
Message-Id: <177064749793.791218.15160710873715001964.b4-ty@kernel.org>
Date: Mon, 09 Feb 2026 14:31:37 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Mon, 09 Feb 2026 10:50:01 +0100, Francesco Lavra wrote:
> The Makefile for the SPI tools creates an include/linux/spi folder and some
> symlinks inside it. After running `make -C spi/tools`, this folder shows up
> as untracked in the git status.
> Add the above folder to the .gitignore file.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tools: Add include folder to .gitignore
      commit: 5af56f30c4fcbade4a92f94dadfea517d1db9703

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

