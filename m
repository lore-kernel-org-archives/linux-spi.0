Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36165453495;
	Tue,  3 Mar 2026 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547616; cv=none; b=aUEfqSi2E1+yxGmIMgPgWQWl8LJW3Lz5Re5mYoN/Miux0Z7Nvjv433oiaQ7oL/MI+LwwtjvbUb7gtqekgmY9ikXWn1AIBSqVIBmtKbjISqZlzHjldpf/ZAPmYTq03EO5+wmCtV72Bes9NhaBgIap1FxnOIpcjZhiQOinCMShfgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547616; c=relaxed/simple;
	bh=Qwyg11nXDcWPVvDs575iNLabUBAYCNleEwxbnicdSN4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NJoJVQYZZzlhLCgKa6H80AiLCBRYF4/nHiHP6EMvnY+Mla+4K2QLCxj7NrDICX4p0gfEUfQYFAtMcCsY9mIpTOQUWnIH0GPOr2T24TdKseTxiNLE4zljTrupc5geLr0FQYc+TYjxb4PbGNz0uxRFBMBqoZLJyOcY+tMidDvLMiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF7efodN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF7efodN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBE5C2BCB0;
	Tue,  3 Mar 2026 14:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772547615;
	bh=Qwyg11nXDcWPVvDs575iNLabUBAYCNleEwxbnicdSN4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MF7efodNqc1RDRa7lRsrUWiTljeCzYagyCjMhMRintxIjiNuHlxvdHgllrPIfkEwU
	 jB4cSu+Bfr3KY+4Dor34cd39x+fBfz86bhXwOz7Zmen7AVj8/+YapR6B6yS5WG/I6/
	 wurGHXMZbufeQQmldLutog0eWmQZt9VBtfR3gqakAMsKzjc1/HuloSrA4F1wz7QBrE
	 XysdmvVPsGxLEy4/C6VKZUn9Da/bLLweLx/wHZJrepCQb3gQa/2uvaN5R0kbEkRH0J
	 PIymaFRBKgFX5dOQuoo2JomSiJWPo3G98iNPqFUEcs6n5CYFhQp8zmneku7sWpU4Cm
	 JbxP0/yDJSH9A==
From: Mark Brown <broonie@kernel.org>
To: Vladimir Yakovlev <vovchkir@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260302222017.992228-1-vovchkir@gmail.com>
References: <20260302222017.992228-1-vovchkir@gmail.com>
Subject: Re: [PATCH v2 0/1] spi: spi-dw-dma: fix print error log when wait
 finish transaction
Message-Id: <177254761497.95700.4347311545062036624.b4-ty@kernel.org>
Date: Tue, 03 Mar 2026 14:20:14 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-6ac23

On Tue, 03 Mar 2026 01:20:16 +0300, Vladimir Yakovlev wrote:
> This patch fixes a system crash if there is no current message
> for a transaction.
> 
> Changes in v2:
> - Sorry for the inattention. The variable in the dw_spi structure,
> - which has the struct spi_controller type, was renamed from host to ctlr
> - starting with version 6.19.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-dw-dma: fix print error log when wait finish transaction
      commit: 3b46d61890632c8f8b117147b6923bff4b42ccb7

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

