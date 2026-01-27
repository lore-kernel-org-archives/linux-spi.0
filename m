Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897382DAFA5;
	Tue, 27 Jan 2026 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769553372; cv=none; b=X155W31iPePoI/EHDM15q4++q2UQVrf4Ttu640kiym0/hORLiHwW2sUJ1VyMi+1BYkD8P6Tt0Izfi+3lmlM2abYd8oQNReKaXQOmZMvDVshh+4aNpa1+9Gw5hMYdRxMmMWl5CVo3WlUOcmlqLvyLYOIsCncHBUJsD0HGR5GagHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769553372; c=relaxed/simple;
	bh=2KBe9pma1g2Ig5/aLHfRnizMwYuFE5P2DXg5FD1wUeo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F4YyMXt58yJDxAFCMLy//ByYKYVKVUT3MQCVevBTvktL3q69kVG3+uCwFTWTAZci9JzLbZ90Jedq21sdsLl/VmszrbJUimDB90MBkhtlEKBKfMkfM2q5CvpfN8VLxnBsVulx+dpaKvf31aVhEY5KhOC3rAo4EII3d+Ikpdc7jgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liKBshzd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liKBshzd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90603C2BC86;
	Tue, 27 Jan 2026 22:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769553372;
	bh=2KBe9pma1g2Ig5/aLHfRnizMwYuFE5P2DXg5FD1wUeo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=liKBshzdMvTjtV9kHlH+APXsadQ0w2m2PxdFc1r5nIdfc38+2Y4ufcVTsYD027UIY
	 UJ9po6wSoDVGaa//rNFwPCAeBjaalFYehn/NIKOLdzh6ORfDc8TmenaghgjPbnlfcJ
	 /5kFfsSrnWMbVUhAPtb4HqvZ7uWx+1Sq5vJQnDBJ6j2AjzEt0Cfy5G8RmRPgApcNz2
	 zspoVwoXWxfUkmYLtTStRYN33LciziHaL6jAXO6/yhJiCGWlUx0wG6rmVBl+dEin6G
	 KBUKVvU9fY0S0mgXM20eEl6lIeVWnIz2sXqQCqg6gf1nzeizfKnWh7OqHKh/KwtSkH
	 hokdg/6Y2tsYA==
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260122155119.12865-1-jszhang@kernel.org>
References: <20260122155119.12865-1-jszhang@kernel.org>
Subject: Re: [PATCH] spi: cadence-xspi: support suspend/resume
Message-Id: <176955337134.1431389.11342628727911801081.b4-ty@kernel.org>
Date: Tue, 27 Jan 2026 22:36:11 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Thu, 22 Jan 2026 23:51:19 +0800, Jisheng Zhang wrote:
> Add system wide suspend and resume support, the suspend hook
> implementation is straightforward, just call spi_controller_suspend()
> While the resume hook implementation is a bit complex, we need to redo
> something which is done during probe, such as enable the interrupts,
> setup clk and config the phy for mrvl hw overlay.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-xspi: support suspend/resume
      commit: db6a59cfcc9364dec501993690a320d916ae3904

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

