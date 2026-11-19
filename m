Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795129248;
	b=Lva+yCVDU5kLYkLHIcBxu2zQ3MJ7SGnYxZnzz5YtgwPicNweJczlSRwcZlaAYu+xSbzO
	 t8AhhtHr/DyJKmMdhBzLnSLTU8PHTb/WCQNXldxkznHogn7q6uDcwCzXyr7ygP45I4zVi
	 bamj2264x60tFzpiUrJ5mFxf9rGrrPZKETZvPvXzpBoXQ5TltqrctJCvPGMv08U1k8E4h
	 NY5iDh7q7uYOkAdNLEBmwjlBoq17T3npqoQUhK4JJvE3bmY18RV09icSnLaPWQvLspwm+
	 VNKBg5Y2+MYicEkqJjkqxAJAW4MMzfmCiSaS6qpKKvWt5epkp2H3P/AIVd4QvAwHDlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795129248;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=QvNjxNSGJW86t12B1vBF2kfzVwruLnbkO6fgYNIDWjE=;
	b=0h7n6Qc7vDca5nMkYvDgmNymLBTpa3KoKOL3X3gHaAPJ8rDnLuGlgkO9dUMDk4jAtP4E
	 SdPCvr2RHfOrXR8rWfbQQxbPx2ZWcMJ6P6IWXemp+LGs9eWlADcTKU/7RJAknX8RKryph
	 Zemx/FWCWgyVCROBVkSDeSwoLliSHw1uXZJu2y2uYchhEKLHFXR1N54cO19vxrrTWooek
	 NAax8wawew17XR/PnF6bD8Qh7xXOQSsAPYmxAVDZqnVri9bJ2nmwmKDBb4jSS2idLz6Tr
	 hYC5CbIlMOwYxOvDtp+IUN/sLMd0Sa9rNDrcu+BsNhG7VeA14wLz9sm7zbYOupmcF3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UxivtHH0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EA9606A326;
	Thu, 19 Nov 2026 23:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UxivtHH0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D442E1F000C4;
	Thu, 19 Nov 2026 23:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795129247;
	bh=QvNjxNSGJW86t12B1vBF2kfzVwruLnbkO6fgYNIDWjE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=UxivtHH0WjofZkSUSreMwE4f5maal1V+4gc6s/bf4vWylJlAFeALb1mDf1LVdqYz6
	 5biiQIfnJiOVQyTVbnoHCap17kqdtlU5Jm/QRssHvknzCV/fMMXGXl7qZgCUivTVsG
	 +K9FgQCtdMwiRXqmjIQqutH7ZI9h+e7Qg5OaHAsP2xKFsR7bh2wLhfr6lMKiZRkkYN
	 hnN3EI21KRG41VcRScSyHgKn9PdTEinudfCfmTjzjrIqvRnWjTVRgrhpwg4P1ipjBU
	 odSG2+LKfjlKjCC8cB85893M3FCA8Qwit3hdrvfUUM0iWpoY5qsiu5wpS9LsNMvJm/
	 qjuyav+lbl8ww==
From: Mark Brown <broonie@kernel.org>
To: Li-hao Kuo <lhjeff911@gmail.com>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261115-sunplus-sp7021-v1-1-43d06657fc90@gmail.com>
References: <20261115-sunplus-sp7021-v1-1-43d06657fc90@gmail.com>
Subject: Re: [PATCH] spi: sunplus-sp7021: Fix target transfer completion
Message-Id: <179512788753.116416.11586537660527993590.b4-ty@b4>
Date: Thu, 19 Nov 2026 22:38:07 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=broonie@kernel.org;
 h=from:subject:message-id; bh=o8Q5Yrjf7Yrygj0AFAn/fTHkbE0StqONipoD969oEcU=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLL+18/9FJjbuFzn1q+W7l26drYpO29M3/hL4puW3sIW2
 /R8vyDjjlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAEwkvYPhf1DLTFNe1lldVcK6
 bk2LFqo8XbSl+Mp3g8bNXt5W7PN+T2P4p7UtJmrSvCXm3/MvXXsbfnFt0KOeF9YVV8qC5jE6Njg
 kcgIA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 15 Nov 2026 01:11:19 +0800, Felix Gu wrote:
> spi: sunplus-sp7021: Fix target transfer completion

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: sunplus-sp7021: Fix target transfer completion
      https://git.kernel.org/broonie/spi/c/650fa66466aa

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

