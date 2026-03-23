Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F2124468C;
	Tue, 24 Mar 2026 00:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311143; cv=none; b=fm+6en1gHmF6wNPpNVh6tUy7+yI4UtB5GakMldqTNFsu4ueUAC0zJOMhmWJuqF54d85lY+lzek2QYrFZZ3qkUUjcCqaULAiwvkOWuyPipLxFOn5RRR+enRttfRbVR1u61Ig48K7F4URVcxj/B34tq4yJYphdCl1Q8e0F87rmfcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311143; c=relaxed/simple;
	bh=iUC1F/QWIQoH81SLgzIValo+5s42zljAjLlp1ygjj8A=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H4gLg/juSMbdJAuD8JjlZBvVFdH0GmzbbwoLowU9aBuMXTCK7aQbecoGP1TwAMtJYEMOtxQJ9OOA7PkxKPNVdZm6zX7bwUgg5IBiOFa3VeHSpRg23hvNEOnhNW8zUg9lShpv/IR7s2lunOJaO4tMcWVjmXeFaPDXADaQyot8OJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTJQKE16; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTJQKE16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F69C4CEF7;
	Tue, 24 Mar 2026 00:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774311143;
	bh=iUC1F/QWIQoH81SLgzIValo+5s42zljAjLlp1ygjj8A=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=qTJQKE163VywPPUAscu1OHU8ATV/aVPhMgOV3a2r61RYi0tkEYp6/cvP+wGHWXJGl
	 Ot4fmKYkJFRUKV8GVgI80R68zojbEJUUdzv/7lX7ZZFQNfSyOHcyg4G5mq+YwyhIO0
	 ZhJiMg+msu8xPys7U8PaZaeL87aBPcFGgMAYcyTwrfoshSHpcilStIqMxro/SkUhTp
	 bbW9pNH8AASNUGcLK+cB00UhaeeRK+x4EIi2pX1oT7dWmzNYf4Ce5reh35++54zE3Q
	 HAFHirlCfB7HCbeRpq1//W+wdQFLYfd/66eEtig85619yTktYb4InZaW6yJOJxfMZR
	 9AakIjBK3s+Pg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260323140445.3496736-1-andriy.shevchenko@linux.intel.com>
References: <20260323140445.3496736-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: Replace open coded variant of
 spi_bpw_to_bytes()
Message-Id: <177428077551.99914.2674079117686691917.b4-ty@b4>
Date: Mon, 23 Mar 2026 15:46:15 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=broonie@kernel.org;
 h=from:subject:message-id; bh=iUC1F/QWIQoH81SLgzIValo+5s42zljAjLlp1ygjj8A=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpwdblBY2oGvOGjd5Vzqp8abx7tT/jGlOyVaAdj
 zFyicFKXSWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCacHW5QAKCRAk1otyXVSH
 0JMIB/9xISaV0lJSS338/NSdveuNg/wX8GMjGnBErCJsooz2VX+yWFwh5Z02oAGk0vav25XVmBJ
 2KnJgS9i0hpVZCv42TfHjvHeLDB5/sDSBm4/bbDuG/+bbs2RyaPxtgg5lA765JzXUYpMWIs1rAf
 Az5iTfpcUrvV6LlhxrOPlNFuf7F2spli4k8SxJvIvgkhR+PA0Id2UQH9KPB5mVkr98ur/11iZ37
 +P0bTrF4KoVOdPoVlQL2hbkXaGmkGJu29k9eG5c0vQASV1i7OOPK1x/oN2vhmzJLMnuxntLLwQe
 C4wmX4bS+342Yc8viVhzn8AEFS5YpLQIyjHYlV+K33Zgcc4t
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 23 Mar 2026 15:04:45 +0100, Andy Shevchenko wrote:
> spi: Replace open coded variant of spi_bpw_to_bytes()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: Replace open coded variant of spi_bpw_to_bytes()
      https://git.kernel.org/broonie/spi/c/9861e15f6347

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

