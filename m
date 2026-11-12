Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511804;
	b=LEOcWgNYk+uEz/O88kauhYnSWhB1FqbgzEftbO5nxemqtCY/sjf3EULkKwINmriy58Yr
	 Mrua/vr/P/Q3xoWtaTF1qpvhgAVJNxrGNJtLWHPbKhd/LRwbu/pGOmaZ2NeTZT6rW92DE
	 wKF6iYEshdbMYPfmt35gDD97SGOFU2TVkWnreKQFaLFP4II9Q93NYVl6csuaIJyb1greP
	 FSDjjYlcZMS2JF2EVzahZJ1YYbKjk2WG4SuCXGW8CzuOxNruTmx1lp3Bf+ty8T2CuMgsq
	 vm/b/6lRosUVW8pTu4mfl+e4cT2XjW5k0PHUOPP6EwBC/K6/m8kqJ87PTyO3EhGrqPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511804;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=//eTBsWqfWNkl1bREFM53BmMlq38CWVymr70pZjHbAM=;
	b=RXTDxxBywCXjIt5gXgSqBdWhbzsURjF4cKhmlm/r+tlLydGU/tdccrUq4BaxKsK3O5XQ
	 p3spi4R3s0nnoANm3gWPR79Hc7dgQ4A/CcmrrTycaNcJoJer0NVf2nNdiA67Ek85EvsMm
	 9oo6aEEzTptudbQ+GJ4BhzyTR61c67H+i28XRFIZDyxuN6vV3Cx8RGCTVHVocEbFGJS8G
	 mOuIrvzIvD84PGeajpufl3OdThg8nuv+Li2Z+GH7HWkS8VrqCh/nw56W8068cq5gvpKia
	 B3Mc0RSxUK5t+k/3Puz/w5Tzud9LRzaxaA0oH/L/f6es4RdZIXZJiJb44Gi+ECwLsYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tqve0kr+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7B8606A321;
	Thu, 12 Nov 2026 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tqve0kr+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A4D1F000C5;
	Thu, 12 Nov 2026 19:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794511803;
	bh=//eTBsWqfWNkl1bREFM53BmMlq38CWVymr70pZjHbAM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Tqve0kr+Z3Ylzu9IgzKF7p0UWNUPkCyiD4F02dJaCfxa+K57HfI/qdt7iYRqGiosQ
	 dNERW4jD2qz6W+FnA6C3NFXhNuYP5Wc9uTaTeCNc04szlUwS4n8hyIZr4x/FHtblko
	 gAEbs3Sp9ver5q6LXuc1YCUM5U34gK5YtEh6lbjAumeMZTosBj6m8KBjMjj+UkmHXp
	 5/NolueFfTu37ruRVbkD30JQDXdWbVSy9ZXurn1ZOJajqDyD4jBrzHy2K6IGIculWz
	 9niEez2yNBwk+xdo/vc4xyBSkza/2en2du5dc7oW+SDA0dpkANo4ZzFRkf9M7k+Inj
	 +9Lq2UoAzr0vg==
From: Mark Brown <broonie@kernel.org>
To: Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20261111202741.3866239-1-Frank.Li@oss.nxp.com>
References: <20261111202741.3866239-1-Frank.Li@oss.nxp.com>
Subject: Re: [PATCH 1/1] spi: nxp-xspi: use dmaengine_get_copy_align() API
Message-Id: <179450592111.339049.13884238628105644116.b4-ty@b4>
Date: Thu, 12 Nov 2026 17:52:01 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FH5kTmZfwj/aq4Ezd+f97Rjvto9LE3d0JY4k3/OC/W4=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLK+Ce+Y7PP3Z4a7+rqGvd9y9HfxSnGIdtfeenbz10Q+9
 RsLNtlYdpSyMIhxMciKKbLEZXG/rC95vYbv4MI2mDmsTCBDGLg4BWAid0IZGc4sferjaPvVM9eh
 +WjltueP34h2XPHVkdbMjd8Zkr7iehojw8pStbuey41U/1pdSvebPs/5BVM/K/eto7cC3bzs30q
 s5AAA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 11 Nov 2026 15:27:40 -0500, Frank.Li@oss.nxp.com wrote:
> spi: nxp-xspi: use dmaengine_get_copy_align() API

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: nxp-xspi: use dmaengine_get_copy_align() API
      https://git.kernel.org/broonie/spi/c/172b8b7eff22

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

