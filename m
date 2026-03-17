Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0C33AF664;
	Tue, 17 Mar 2026 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748230; cv=none; b=ZA3CZw4vDJj+Wcg1d/CxjJv9bdSdUW0ZVV+6+5CfZ5L6NHMiVYhJFZlRgHV/3E7WDl+i3VY/aI+8gq6sDyxIkLpolkxqg79MFXyRw5RNaPW3u5aRI3+E6yE6je6tf4fTRzKOrdhyjbLuv54LlZ7EKT9vXCFvLb4ryQ8pD45INNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748230; c=relaxed/simple;
	bh=7d8dEuQP3aoq39I0BJE4GSmkONtpDjYrXvu/mExnb5A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bzBDVyP8yFySiJmLtbM3Q/hmN+dXnSC89n5wmiMVTXFrZVgMSH8bDj1ji0gTZEpSBNQs4e+vTAo7MB0j5o7clNVIBsLWsnkPQFL+fnBdS7atJUkB8vvrCbUENfPdYl0pthLwqBffWJaYF1+6GybAFFTKF1IHiMP4ENBuja40iDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Okx4fEoI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Okx4fEoI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14053C19425;
	Tue, 17 Mar 2026 11:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773748230;
	bh=7d8dEuQP3aoq39I0BJE4GSmkONtpDjYrXvu/mExnb5A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Okx4fEoITyPSsSKeZPDSrAyzELVKP2I/tfib8HT+pfH5YrE/Dmqd+Gbb3zfeay2gq
	 /WBsNW5uO4IuPsJf3y6kOL86Ln3cDKcUpSrDgoTckunDzPv+TqDKkf0+/nLU7UH3LA
	 fksWZJYNkC4QHXpTD4ePPy1/O18MFt8eERTlzo0VPImht1x2VTdORGAfsusaE/wf4p
	 JAEfysx752UW39vavqbhcD2rsy3qIJAcPHk/vihgAunSlKPlXy1fhxsuAB9cFE779f
	 LjFJ3xdm7owuqfpwK4fiTNyOib70X8aQA2M7WknNkbuqMPNx0baw9aY6Wczg0KDuHW
	 GBgXrqyXMOwVw==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260312151817.32100-1-johan@kernel.org>
References: <20260312151817.32100-1-johan@kernel.org>
Subject: Re: [PATCH 0/5] spi: controller registration fixes
Message-Id: <177374822981.26349.10728287149984568690.b4-ty@kernel.org>
Date: Tue, 17 Mar 2026 11:50:29 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-f420f

On Thu, 12 Mar 2026 16:18:12 +0100, Johan Hovold wrote:
> This series fixes a few issues related to controller registration found
> through inspection.
> 
> Johan
> 
> 
> Johan Hovold (5):
>   spi: fix use-after-free on controller registration failure
>   spi: fix statistics allocation
>   spi: drop unused devres statistics allocation
>   spi: fix misleading controller registration kernel-doc
>   spi: fix misleading controller deregistration kernel-doc
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: fix use-after-free on controller registration failure
      https://git.kernel.org/broonie/misc/c/8634e05b08ea
[2/5] spi: fix statistics allocation
      https://git.kernel.org/broonie/misc/c/dee0774bbb2a
[3/5] spi: drop unused devres statistics allocation
      https://git.kernel.org/broonie/misc/c/d5b4cb41b9a2
[4/5] spi: fix misleading controller registration kernel-doc
      https://git.kernel.org/broonie/misc/c/edc463d72d69
[5/5] spi: fix misleading controller deregistration kernel-doc
      https://git.kernel.org/broonie/misc/c/3f174274d224

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

