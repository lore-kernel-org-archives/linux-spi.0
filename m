Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794264271;
	b=x/jXpUKCf0C+sGBcWfro43JNX6CSGEPVQyGCSHUZf722PKj5EBycNGH9tDQuq8fL3Gy5
	 88wq2LdP7MLqzRzv07Qvc8uecVQk/WZP113K0cxn4Tj92qy8oCBomCJt9ERvUpl9x4ruq
	 IPmaqr/TgFruZlTMYNDcIG5xPCEi/VzobqNsqhbrgWOs0hP49GbaVl09SaTSc4WPzb083
	 tX0YJH4tuYYmCkuJS3+zus+AwxHGcWfwvAmdkUkvk6+/LWfR/1BS5BSP3+q8O9vZEal8L
	 adu7NmuviGXd4zYjoi7zVbyFeQ6lDsEnKr6Ialrw4YMVzqMTQE4znpKSaQjDmAg/Brw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264271;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=lbmh/0Z0zwTEAIGZ8vw8plOMg7G98sTILva2sucTUcE=;
	b=sI2ncTyFm1E9C1/Ww6yoUyeXD7Pk6YfyHLU56qbG8CVd4UH3gic42SSFX8ybxhDTX/tm
	 oc533KzUqE/4pHEOvnfDkcuXAMOqmqTPb/tTfS7oOPvVj3VA/lWvlUKPH38CDABjl8QpV
	 N9cNMCLBeVvwEK5vNFETkI96VhsXI9/qPj6/xbe3wtBNPUWXPsJ4SB53W4/Htjs73R8lZ
	 Hn82VdWkuhdp7vn2yJN6iWXjSf8ToNux5pmKiehNtg6uTKTOo2VVEgW23XT457zgSq1Sn
	 W9vmAPWVxyArNpq/8mO+n973lvwubt9ABiJ+oGcDWPJ91dLegjdUdxvm5qswuDVHSzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YS340XH9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386AC606A326;
	Mon,  9 Nov 2026 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YS340XH9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61871F0089F;
	Mon,  9 Nov 2026 22:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794264271;
	bh=lbmh/0Z0zwTEAIGZ8vw8plOMg7G98sTILva2sucTUcE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YS340XH9AgYiYC0jmay2BOZ8psYLNTS9Zrj+ai1c0l0V3ody+zwIbLGKaNGAGBa4J
	 d9aPJgiLauxuP8BmJQSc4iHfqQSdIMPFvqoZdhvllfDpSeXc3vutC6h9i9MK/xnRN9
	 dIRg1N6rLkEd2ZBuRQl19ce7kHwCYP6jorqrFPJxo1LriWVol/DWOFmnbLH1HMilCc
	 7Uj68OXXpLHznUZRlz7kcg6kTHT3s1XEMPq+7NHYItafxe7T66Oh3nx8NXaqJT/l7T
	 dBvKnsrMMJzH/z0kiG9OTMLFTueglK0GqfYsdJKUEz8yrPmdhSIpTDARYW5sQLa6NL
	 pdO/hDQ3kA+2g==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 351CF303EFF9;
	Mon, 09 Nov 2026 22:44:27 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Vladimir Moravcevic <vmoravcevic@axiado.com>, 
 Tzu-Hao Wei <twei@axiado.com>, Swark Yang <syang@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 Karthikeyan Mitran <kmitran@axiado.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, Jyan Chou <jyanchou@realtek.com>, 
 Yu-Chun Lin <eleanor.lin@realtek.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Joshua Crofts <crofts@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-tegra@vger.kernel.org
In-Reply-To: <20261108-spi-dont-use-autosuspend-v1-0-3587b0183cbe@kernel.org>
References: <20261108-spi-dont-use-autosuspend-v1-0-3587b0183cbe@kernel.org>
Subject: Re: [PATCH 00/11] spi: remove redundant
 pm_runtime_dont_use_autosuspend() calls
Message-Id: <179425512291.3711751.11313466595449863242.b4-ty@b4>
Date: Mon, 09 Nov 2026 20:12:02 +0000
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2825; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fGK1+6kBLTgLKjWD8aKdb74u71yNwRTJZfTglc1HBn0=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI++ZwODWpPPLn8k2Swd6BwZ+i06Lcex+7e3ZW06bQrL
 8vrE7O/dpSyMIhxMciKKbLEZXG/rC95vYbv4MI2mDmsTCBDGLg4BWAiHC2MDGc67Hb+5puz5IRx
 GdsjBpnZF97yZonUlPO0X+D66L1UIZKR4au03ISGG6cDm2792q+lcTQvZNuXKQqR0/3a7jyzWrv
 Sjx8A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 08 Nov 2026 13:16:47 +0100, Joshua Crofts wrote:
> spi: remove redundant pm_runtime_dont_use_autosuspend() calls
> 
> Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
> driver core is now responsible for undoing any
> pm_runtime_use_autosuspend() calls on driver exit.
> 
> Remove the redundant function calls.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[01/11] spi: axiado: remove redundant pm_runtime_dont_use_autosuspend() calls
        https://git.kernel.org/broonie/spi/c/9c5ba93a5a13
[02/11] spi: cadence-quadspi: remove redundant pm_runtime_dont_use_autosuspend() calls
        https://git.kernel.org/broonie/spi/c/4a1cab30f7e0
[03/11] spi: cadence: remove redundant pm_runtime_dont_use_autosuspend() calls
        https://git.kernel.org/broonie/spi/c/e5187e13ce1f
[04/11] spi: stm32: remove redundant pm_runtime_dont_use_autosuspend() calls
        https://git.kernel.org/broonie/spi/c/6d2a6ec8942d
[05/11] spi: stm32-qspi: remove redundant pm_runtime_dont_use_autosuspend() calls
        https://git.kernel.org/broonie/spi/c/73f3bb4134f4
[06/11] spi: zynqmp-gqspi: remove redundant pm_runtime_dont_use_autosuspend() calls
        https://git.kernel.org/broonie/spi/c/affeee16b705
[07/11] spi: mtk-nor: remove redundant pm_runtime_dont_use_autosuspend() calls
        https://git.kernel.org/broonie/spi/c/634d73e929cb
[08/11] spi: orion: remove redundant pm_runtime_dont_use_autosuspend() calls
        https://git.kernel.org/broonie/spi/c/ca8b81eca7f1
[09/11] spi: rockchip-sfc: remove redundant pm_runtime_dont_use_autosuspend() calls
        https://git.kernel.org/broonie/spi/c/b90c9acd16cb
[10/11] spi: rtk-nor: remove redundant pm_runtime_dont_use_autosuspend() calls
        https://git.kernel.org/broonie/spi/c/1fcfd0275515
[11/11] spi: tegra210-quad: remove redundant pm_runtime_dont_use_autosuspend() calls
        https://git.kernel.org/broonie/spi/c/ff3bd58298fc

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

