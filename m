Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793841839;
	b=JeO1s/3LAZdJyGpnMyjG8nnlHxqLU9Z9mq9oxumNhU3mQ7uZ938a0HsYKMJ2+/QO2cbW
	 I8ZT1vIe8NYqfpXjzNsY04MQe5ca1LC8GIyONY8OAYs7b4nwSGl1I9P6gk2e1QD77AsrE
	 f1EM5XeJFCroW60J74G3WdbwKXVYegIa5uoyarEwlMvYtkNV+hcukCSKiWgd5xX9YRCib
	 +kadMD36rCLlXB2p2p78jBioUN6ixmHIs6gi2wPiq60IaWf2j0vAMRbJICeruZouOcO8K
	 iairkz6dgwgTFa11NdUSWW4QU+eUxiUKjv3TE1aCtpmdeGt3GzGmkZXhZtS19gmCRzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793841839;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=J+EILcfuyY9VpXVTMC1QD+wI52UfxjOGU5dlQuGRwTo=;
	b=xR+m/DEgUD9vQm2ezKbE0UAngAzj8eUEtFKqhHD7+1bK0lEJt5pn7Dfp9wfyXjtmkaOa
	 /Yo/WJogHdmsx0yJg23vBhzMfFErhPzVDZJXcF5WBfHtvzCcrDbXGuZMsu/T78sxDGOJ3
	 AZ2o+pZ7fCT7KxLsRxppr83wUnyOpNSAezUpOIz1RiKjL33cm4S/6gH2pBbvxVQY4r0bD
	 0iX8mhPgv1iunHKo62Mp/nMXRLFRdhDDGof2HMlCnpnGd1ivwuuQodiPcjhNFHVwutMmz
	 PNiRrL//4uIN6tZOnYJO5Z4K6gcRkn/pJdHEV+taniAOB2VuBN95/CuqDoKGWlxbueQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qfon3zD9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48163606A328;
	Thu,  5 Nov 2026 01:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qfon3zD9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD041F00919;
	Thu,  5 Nov 2026 01:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793841838;
	bh=J+EILcfuyY9VpXVTMC1QD+wI52UfxjOGU5dlQuGRwTo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Qfon3zD9MjLP/+lKYHwqpO0SpBulnmv5KNINHyD/jxL3nhQAFuWM9XHKo+VsRyrlk
	 3HDe7QZeORM+m8cBpy1g/gYPJXgYG7g05vlsfJkvHIiHg25BypoqJFg3BVAdAPV2Vt
	 MPiC6zNt5wjDHlw5D6G3YjebZxoQR99m/HlObkA0DQzFr53k5vq4bmbXi/Li0lsY1L
	 vzrJW6WQu/CgD5uLsGMPvUnGcBLudc+gtGS23IGAJ0zmUM1ZRO2bW3x2pYGESh2Xs2
	 7IhCmxdTSptBvxPT7Plenm3JulIeIIvSN5Nbck913l+c5TnGVnQZgMAyHQY+KxMOaj
	 9htBAs5fBhiWA==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 116B4272CB3D;
	Thu, 05 Nov 2026 01:23:57 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: lakshmi.sai.krishna.potthuri@xilinx.com, 
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, git@amd.com, 
 Frederic Konrad <fkonrad@amd.com>, 
 Srikanth Boyapally <srikanth.boyapally@amd.com>
In-Reply-To: <20261104071958.2405117-1-radhey.shyam.pandey@amd.com>
References: <20261104071958.2405117-1-radhey.shyam.pandey@amd.com>
Subject: Re: [PATCH] spi: cadence-quadspi: Fix race between DMA completion
 and transfer start
Message-Id: <179383426941.2456854.16360344545455068523.b4-ty@b4>
Date: Wed, 04 Nov 2026 23:17:49 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LTEV6J+SkxyVQy8yvPv6Qkb7f5PMqghcKG+zN7k8jnY=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJe31qjs+Bh5AapLrVH7ppiOutFWUv+1f70E1Of1afwq
 iFWsCCyo5SFQYyLQVZMkSUui/tlfcnrNXwHF7bBzGFlAhnCwMUpABN5rc/I8HVW3seZwQIuPo3m
 kvcjdvxXqnzKsDbRSPDJvVlfNvUV72ZkOPfj/sljypMuHePgj1024fHlVjlHJdfDR+afuaS37Kb
 IOm4A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 04 Nov 2026 12:49:58 +0530, Radhey Shyam Pandey wrote:
> spi: cadence-quadspi: Fix race between DMA completion and transfer start

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: cadence-quadspi: Fix race between DMA completion and transfer start
      https://git.kernel.org/broonie/spi/c/059518f775ba

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

