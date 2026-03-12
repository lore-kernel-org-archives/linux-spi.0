Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C423F6603;
	Thu, 12 Mar 2026 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773336904; cv=none; b=SvECvrMGmZa8nJ2ByPpln6ZR3cHmsrIXbiBSzIKWluFxPGjwbFATMUHxf+E04y3Cj63GQOmjazv3oLYrS8y6kMYmjjzp9EIi6cARlPMvuHETO8/HVJOjRoRPbROL424fRzBW+b9OvnpV5Fx8VnsqvKDANeUYztIFw4Y/74UQevY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773336904; c=relaxed/simple;
	bh=kCHiISmQWFilybWLONApoZTCpR+YQ2+nXHqj1KnkMEA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N2RtJKdxajr7tPBv5iw9+Uf06WwUXDCaBNPWo8MbSCu5dMd7Y+kk5c6l7voFhhcgRVHDdAQAUJEfiYsW849UhkBTo4QE8qaNtD92nlpY3sEaROMkICUIdNmmg0rWZNMfJXz28U2StXofhuLP4m++f0m4gjEMREyRzyF4kIaI4RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAT+igBw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAT+igBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C91C116C6;
	Thu, 12 Mar 2026 17:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773336903;
	bh=kCHiISmQWFilybWLONApoZTCpR+YQ2+nXHqj1KnkMEA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=lAT+igBwnftTq+bh5xCgjiHats3nkdOF7k7b+fDtbYk4zxnxvT/IIZhQ8IqaY+Pba
	 9T8ND6jzF6eRbXOqCJhbv6tncqu1kwTogQ/XVUOVSDMw83AqpUURTxntkSn0hajMOK
	 jmoBB3spu37ZMxEuJduiGKW1WqiwZNQ9n+rpWDcVNcvsyqcV8jRADazRDEIcq4LeGf
	 A8CcYGhhOkeX5qakNp6nfrQQyGPmIzZiPXkrWxcHN+C9medw4uenSmnn5W+nn0atBG
	 IeFunRkKjkbmRWJUWULkQef6B3EIF3Sj7VIED1Pny0E20Oof+f9Y24VtvfB8Oxyj+E
	 YDo6ogNvvw7Vg==
From: Mark Brown <broonie@kernel.org>
To: cl634@andestech.com, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <15a71241affc25108a97d40d9d3dd1bc3d2d69ed.1773282905.git.xiaopei01@kylinos.cn>
References: <15a71241affc25108a97d40d9d3dd1bc3d2d69ed.1773282905.git.xiaopei01@kylinos.cn>
Subject: Re: [PATCH v3] spi: atcspi200: fix mutex initialization order
Message-Id: <177333690259.303272.14160069588733416887.b4-ty@kernel.org>
Date: Thu, 12 Mar 2026 17:35:02 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-68380

On Thu, 12 Mar 2026 10:47:55 +0800, Pei Xiao wrote:
> The atcspi_exec_mem_op() function may call mutex_lock() on the
> driver's mutex before it is properly initialized if a SPI memory
> operation is initiated immediately after devm_spi_register_controller()
> is called. The mutex initialization currently occurs after the
> controller registration, which leaves a window where the mutex could
> be used uninitialized.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atcspi200: fix mutex initialization order
      commit: 869d5b4b2a8012f6ef6058a1055cac6922c2cb55

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

