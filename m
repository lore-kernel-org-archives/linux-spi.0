Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794877229;
	b=gPP9rpInEp2Uq3NUPSaxPhxKpj3yrFPlOoQ17ytLeNM8auLZWC1cFpfYg36WGJRvtz1D
	 X8N2tg3vauMbSdPhKWj8tEiEHrbYGS35M2VW1u6xYHXmZDXZl7rrScxqJ3gFALyBTKmat
	 fR9wyWK65ayQneNKxRVXQ6WldaKwn1SeWQcwUBEw6L7oI/ioeUWDLr0FVBK81PakA+z2f
	 2+Z8c4Jk0EA28QWCmIDR84Oy9amc2S3nhv4m/KCp3bsoMNLQuluv0v0ihMqGm+uYA77Ci
	 IJByoDMq25b49p9vrBYnIbRCM4xAHowl1ALutsMBxquP5VDoFlysdmznpGpIlvIFJmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794877229;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=1HjsXGD+/jNNjOWvFBb4g2K6fISAdH1Vg5t1O4G65xY=;
	b=pmlKDo8vDdC9ESnQ7SbkiWKa7UqEk6mnxkWG/PEBtGMoPnXkbX0Mo+YzXov+k0DYRa46
	 O9DI6+c3rhgftqkNOPjm6epSfSjrpzLsDUacJAhwtG+ImLJ3kHrCljrxcHzMUNVnoTB9k
	 KRA4ho/gBL6EgfNuH9emXeyP3CqlmBE7g5i3l95dj4bQO2No57HFZmYClOeSJUseKZkqU
	 bvPCR8SI4B3C2AVai6Sxzhd4cGV/uvlhu8CakEmnjOf3bA1lSIvxCrbn3a0M0HOuNI6Le
	 LEi09Vi77GGxK8buG8PwzE8tNlW8IcbLCjphBhJIMiYM56im/iHbD1LdlZvOFbJo8FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kUH6lvsi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBB4606A31C;
	Tue, 17 Nov 2026 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kUH6lvsi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528861F000C5;
	Tue, 17 Nov 2026 01:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794877228;
	bh=1HjsXGD+/jNNjOWvFBb4g2K6fISAdH1Vg5t1O4G65xY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kUH6lvsi7YuOshE0tCl9iUEYMFLU2Mj7DRCSaNGXXKuCkW6KEBfasseB/XXMjIwIK
	 DBenGHCxynpTqHXEY+PeIha3qUoQM6l1EaMX1T4XRCtNquTxuBk4y1qG7NLDXUka5U
	 +HLpGSs2BO/w+irevEmywiV7OMeVJnE9R8eNjl+Gi9QRTzDFwVn3yGJ7FBVcI2G1WG
	 tAYFUBIVMq4eYEvEAfpuz6cJDvsuxkqFlqUcERgDR4aZcjkShrGrWwytuQqa0kZZbA
	 FUhAi/DWclNpe5VEQyWy4o2D8VX395hJ5tmRLSZJvDCIckHE+uoPaeO4PzFnfJzLTc
	 6ovoeH1t47m/w==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Fei Xie <fei.xie@horizon.auto>
In-Reply-To: <20261107072044.17574-1-jszhang@kernel.org>
References: <20261107072044.17574-1-jszhang@kernel.org>
Subject: Re: [PATCH 0/3] spi: cadence-xspi: add DMA support
Message-Id: <179486302401.2504946.17728543055996478690.b4-ty@b4>
Date: Mon, 16 Nov 2026 21:03:44 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1578; i=broonie@kernel.org;
 h=from:subject:message-id; bh=xfmqZOpGVf84MdC9KDWv8lo4k6ghdFfVUj7ZUO/CNjY=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJ+L9dMfvTr16u+qE0T1jLHLfnzyflxkook47bE2R95y
 j5d3/Rke0cpC4MYF4OsmCJLXBb3y/qS12v4Di5sg5nDygQyhIGLUwAmEnOLkeHxIl3ZgyuePjDh
 TDdxOGHqcmaTTM3dawffucil7trdtUqMkWH7NZP5rGmblp+6PfN9YfMdebknB5idZu+Xn7lV2mz
 OCXUGAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 07 Nov 2026 15:20:41 +0800, Jisheng Zhang wrote:
> spi: cadence-xspi: add DMA support
> 
> This series tries to improve the cadence-xspi cpu usage and potential
> performance if the allocated dmaengine is powerful.
> 
> But no matter the dmaengine performance is powerful or not, the cpu
> usage is reduced a lot.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/3] spi: dt-bindings: cdns,xspi: Add DMA properties
      https://git.kernel.org/broonie/spi/c/f3d871df3184
[2/3] spi: cadence-xspi: Support dmaengine for sdma io copy
      https://git.kernel.org/broonie/spi/c/b7d724ff0f4a
[3/3] spi: cadence-xspi: Use writel_relaxed() for cmd regs
      https://git.kernel.org/broonie/spi/c/f73ef73be217

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

