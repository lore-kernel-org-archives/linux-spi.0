Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B426F325738;
	Wed,  4 Feb 2026 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206469; cv=none; b=iEeuVqDB9Cv1Izi2M1LL7F7N7Cm+TqdTg2ADsYlvsS5APD7aUzyWyK0h+dUXYyXDMeLxhlTYXf1qT/mfforjHvP/F61XnaKSJlmzq9SyIcR7Z+8l+2hKpyQkZlIE45YKg/QP3CqM+7yPsHbZQ/5tSe2ZEKXQvNi9b7y9UcxUPus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206469; c=relaxed/simple;
	bh=pFrd/M6Si4XMj9SNVLy6nTDn9r2/yk+RUG1kfMNsMN4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UwMWxloWXr8sCpU/UyvfmYyi3x0HHRlBEp68j3V+h7ylBZXJy/CHfPNqGKCKV33IxlN6pDxPzj7GS9b0vGCn75BlAyG5bY6BDJ8dfAW/n0y0o12NANuzp5oaP3fTq2S4gdDFR1uU089w3PmZlIBIGqzUm0wupPyUSfeWNNrZyDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gp1GwpWD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gp1GwpWD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6676CC4CEF7;
	Wed,  4 Feb 2026 12:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770206469;
	bh=pFrd/M6Si4XMj9SNVLy6nTDn9r2/yk+RUG1kfMNsMN4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gp1GwpWD4YY6CruFRUAnfeE2gfDgcScLUF0+tWJltGw2MrVkoZEaGuFptGf891zNs
	 H7ns6lW2rBLMmsxvKWw4Dcd4DoKkM30Ixk4h919wKaeOrXZCBds3RONNNFyx3ZphyE
	 UzehBk08WsgdtTDrWWaYk3zwc7enlhwMFFSl1I7s3i6qhFmyKEmlBwdT3B6lvE2fLv
	 zOqs+LgUa2jrtFzH6FhCuWuS397vVmJ5AqvYgRet+SCslcmeS1eFAX0XH73GjbH3Jq
	 SzCMlYdxIP+lYf4zkwwxQHkoCkv8IN7LFEiylacDDOngKSSNe3soUEmUHKb4fP71jj
	 BPsqmfSdIdL3Q==
From: Mark Brown <broonie@kernel.org>
To: Michal Simek <michal.simek@amd.com>, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260122-spi-xilinx-v3-1-8cea20e82f0b@nexthop.ai>
References: <20260122-spi-xilinx-v3-1-8cea20e82f0b@nexthop.ai>
Subject: Re: [PATCH v3] spi: xilinx: use device property accessors.
Message-Id: <177020646814.61613.1868990347848506059.b4-ty@kernel.org>
Date: Wed, 04 Feb 2026 12:01:08 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Thu, 22 Jan 2026 09:00:29 +0000, Abdurrahman Hussain wrote:
> Switch to device property accessors.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: xilinx: use device property accessors.
      commit: 4cc4ace709860c37f7f8019e950380a4694eb101

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

