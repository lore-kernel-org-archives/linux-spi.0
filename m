Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F49F395D94;
	Wed, 25 Feb 2026 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772046577; cv=none; b=IjomNztEApoU868beomL0JOLlatpPLrbEj0VI+NTzeYVUXg08g2EMlC9g3Db8MRxKVviDWVUf8XbuW+R+zu3Frpgy1N4XeI+61iszFV8BaR8r4lZ8o4e48GfuHHmt2Hp0dpfhvAFdeFA+IVTKmpL6L0xXGjIU8TExSQXVu7fFR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772046577; c=relaxed/simple;
	bh=NHXi0aPwydks9wI7yyK8wdUwdwQtNCgsChXpCmhFh8w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VyST2kjbOaOQvbbxZajaJaql0B9T1Xuu1OzkoMHhD9qJRk9rDcQ9t3qxVVI116Fro+d1+b+hzK8//44I8uVknBNl8g9pgkf+wcogrdyntCX5yZQaoAmOBzh3cjkjVD+VKnk6NW0oFZipyv1mPovBQ5wvgq16P9kAB1afFCJ3tl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJwtVN84; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJwtVN84"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1793C116D0;
	Wed, 25 Feb 2026 19:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772046577;
	bh=NHXi0aPwydks9wI7yyK8wdUwdwQtNCgsChXpCmhFh8w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CJwtVN84d4IYe5nACYoJZWk/khrRz6Eeo40GRn0+lG5k0zhEBvpngd6T9UFKcS3Ki
	 6fPmabUOKh/mZvjAN9rkLQisa8iYpiRA+n8jEPCpIsqhn8jZoXZ5A+cOdiNMFCMXHo
	 mg6xcFiCjjTo6XymrEwY7VJ7TVfkMpP3CC7gSLAvYyoN7pT2G/YZLQzzYW2thnm7ZG
	 fQ615ii2k+7iTCTmNgyWuyqbhdD7UOa84GMHNg6ITL+DY0c80Dmj5cOTW1oYlKm8g2
	 a2J+ZMd0f00WLCitvVGild9m5ksAtru+WS1rdiZYqEUfDW2IdixqZTCWdNHJRVETCu
	 aKH45DNZaKY3g==
From: Mark Brown <broonie@kernel.org>
To: thierry.reding@gmail.com, jonathanh@nvidia.com, skomatineni@nvidia.com, 
 Vishwaroop A <va@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20260224092452.1482800-1-va@nvidia.com>
References: <20260224092452.1482800-1-va@nvidia.com>
Subject: Re: [PATCH] spi: tegra210-quad: Add runtime autosuspend support
Message-Id: <177204657559.171265.13326111103618891655.b4-ty@kernel.org>
Date: Wed, 25 Feb 2026 19:09:35 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-47773

On Tue, 24 Feb 2026 09:24:52 +0000, Vishwaroop A wrote:
> Using Tegra234, it was found that it takes about 10us to disable clocks
> and 20us to enable clocks, adding about 30us overhead per operation.
> For a 4MB firmware update with 16,384 page programs, this results in
> ~491ms total overhead (12% impact).
> 
> With Tegra234, flash operations were observed to occur in bursts with
> 50-200μs gaps between page programs. Testing on Tegra234 with various
> operation patterns shows 500ms delay provides optimal balance, and for
> longer operations (>500ms), the overhead is negligible. Therefore,
> update the driver to use pm-runtime autosuspend with the default timeout
> of 500ms to reduce the clock gating overhead during consecutive QSPI
> transfers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra210-quad: Add runtime autosuspend support
      commit: 7c12f6ead4672cb08b74e6f6115eb04dca8ccfa4

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

