Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6754E358373;
	Thu, 30 Jul 2026 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785426636; cv=none; b=odkPYrUUhWpANcdzaRNODCR9WGYB5dV35BnvoVTak7LBe002ZThF56sSXDHW4rLHwHmU621MLzhJucMEJnKPMdnNgKTH06Ar1qwj0dsJyLBLeqZByQvO/oZSyoO6q21HjSQtTyz9+4IwU2gO/m51JrEspmf6otkh9WKtuipApEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785426636; c=relaxed/simple;
	bh=eEagDVNa74snUjVb+2QD9R1XSCdWxJ9S9H2GGmns5MQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rLShF1ufJrJV9MZ8IWBjl22G6c4Uxhn/MJRl6UFObHETVTjQhE5G4PMkYIpn6PYcymtP8X9/SOcHWW3758rHW9LZII9pM6KljFd/qHQ6MZ0kKDLwUne60NRefMWLGBb2fl1M+JdqFAFJL/nocnwjLHfB0X0o8Vz9E6qGZz3d3Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9bBYW55; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9bBYW55"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66B11F00A3D;
	Thu, 30 Jul 2026 15:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785426635;
	bh=DFBbCu7MXNkrRdNdjcdS2i6Yb/YnpCSeqktE6bleyZU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=D9bBYW55Y1ChDJxkbaPBL8RyIyhV5I4WqDfHpePtZ5dM0kSxaexkhB+seG8NKC5br
	 v+j771bvyHaKRGYj4DZjOtacrVqbDBCKUUcDJBdg04EmCbhZk3KusQ3KCEmn2Jx0pp
	 iu00HxB9xxbQxXqbXj02KZHoap9J/N1CeTIr8KAtjFaDYBtlVvOPcYTTCi5ruyG3Ix
	 lObOgSViSuKaTr3MJcSv5UduijtkF92fUvr5mKPEZwxWnhJARk2YcwKaR3J9PtR/uF
	 Rmqt7wY1BPbcmB0tIRHqM9wLc6eRV89pHFHCCC9oItAMcDrS89Q+RIvK15HEiPH6Gj
	 KxYJVNhFlkslw==
From: Mark Brown <broonie@kernel.org>
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 haibo.chen@oss.nxp.com
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
In-Reply-To: <20260728-fspi-clock-v2-0-dbe786a4a6eb@nxp.com>
References: <20260728-fspi-clock-v2-0-dbe786a4a6eb@nxp.com>
Subject: Re: [PATCH v2 0/3] Few fix/improvement for spi-nxp-fspi
Message-Id: <178541365553.81171.1972476944935498438.b4-ty@b4>
Date: Thu, 30 Jul 2026 13:14:15 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev

On Tue, 28 Jul 2026 18:18:07 +0800, haibo.chen@oss.nxp.com wrote:
> Few fix/improvement for spi-nxp-fspi
> 
> Patch 1 introduce per-SoC clock rate limits for both SDR and DTR modes
>         by adding max_sdr_rate and max_dtr_rate to nxp_fspi_devtype_data.
> Patch 2 enter stop mode before reconfiguring MCR0 and DLL to follow
> 	FlexSPI reference manual initialization sequence
> Patch 3 propagate clock reconfig failures in nxp_fspi_select_mem()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/3] spi: spi-nxp-fspi: add per-SoC SDR/DTR clock rate limits for all supported SoCs
      https://git.kernel.org/broonie/spi/c/9c19d60fea9f
[2/3] spi: spi-nxp-fspi: enter stop mode before reconfiguring MCR0 and DLL
      https://git.kernel.org/broonie/spi/c/b4bde5cfff8e
[3/3] spi: spi-nxp-fspi: propagate clock reconfig failures in nxp_fspi_select_mem()
      https://git.kernel.org/broonie/spi/c/b5902b977979

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

