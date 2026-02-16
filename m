Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC2117AE11;
	Mon, 16 Feb 2026 18:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771265307; cv=none; b=fVS7/kCSqErVAzRNZJ2p/g6+DpzyAh964LnFzgLCtw/wKuWixEs07CGIAXwvlFpmavWIOH7gK96CcfFSpB53w8FoIXa2X6I7w2z2HTyqvRgz+pmMJOaD6LuEajH8VtI8NUubTFB6nn9xDrw493LZzCEs8ERMFK9RHfXdFCKvkSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771265307; c=relaxed/simple;
	bh=17Ji2Yw1wMoI3NDkXjlPEvp0s8IDgFaWCzLP9yCO1ng=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GWJdiTgaeHXK7mZnQ3XTlRjl+VkAcAx2oxPbIwyMljIqt3gSrI+MmwZQmtscRoESOkwibyvC9Fnu1iBEXMlyZtu2sArWEUx8ANT8loG2GnKdtmEOI04uG15e0FlBOn499ij5VTfM1mDKYnM9uPjSuQpaDdd2azr9ju9/j84ybH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFbOkB0L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFbOkB0L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE01C116C6;
	Mon, 16 Feb 2026 18:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771265306;
	bh=17Ji2Yw1wMoI3NDkXjlPEvp0s8IDgFaWCzLP9yCO1ng=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eFbOkB0L6OZw9TLZ3+s6A/lvKgzU/M3tD36XjfJ3M+KNSdruoI70ahEtj1jKeSwn5
	 twePNArkbroa5dvrQ+LGKC9088414SOBfMXpAUqJowMtIoEUcOI0iiVVsANqciUR9m
	 2bYahXvS+Vk8irHhh+T9kNU3ekuBCbeHcfxM7nQokRMW202S1eC6ssX4NTUwAWT/+U
	 AYxqp4VTxQZYo9ftCmNliUGfYTbtBfnzRoO82Ii0fC2IZ/AqWApOtJkdzV4x0q+m0J
	 nBn0Zj1rjyMbr59cy7zmnlvHsFOwKf4ut00DnbeeeIZFEj0/6nZiAAhP8zd3wukJnY
	 8o3ckzsTVMcuw==
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Felix Gu <ustc.gu@gmail.com>
Cc: openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260212-wpcm-v1-1-5b7c4f526aac@gmail.com>
References: <20260212-wpcm-v1-1-5b7c4f526aac@gmail.com>
Subject: Re: [PATCH] spi: wpcm-fiu: Fix potential NULL pointer dereference
 in wpcm_fiu_probe()
Message-Id: <177126530558.153476.16439337159534333967.b4-ty@kernel.org>
Date: Mon, 16 Feb 2026 18:08:25 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Thu, 12 Feb 2026 20:41:40 +0800, Felix Gu wrote:
> platform_get_resource_byname() can return NULL, which would cause a crash
> when passed the pointer to resource_size().
> 
> Move the fiu->memory_size assignment after the error check for
> devm_ioremap_resource() to prevent the potential NULL pointer dereference.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: wpcm-fiu: Fix potential NULL pointer dereference in wpcm_fiu_probe()
      commit: 888a0a802c467bbe34a42167bdf9d7331333440a

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

