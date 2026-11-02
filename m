Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623387;
	b=3336PGuA6CuSB1JeYMGwgU5ONSGpPxPWw33CuI0TsfzCD9EyZQlsSYToRK9y5L/sDCMK
	 X4TaygZ1/j1ojfxybjnSTr54PvwS1g9GTSI1qr9PTL3ZfexbGwdNko1HD2iPPnDxoh090
	 LZPZeRvKdab1j+U6Z3ByB4PpWFW/TnYAu4Hfc8gLiKMDevbS+iFlJ57mOgr3AQ6CZ2pxZ
	 CBlxog97W7jeNwMHeWKZ63QyP13KVq1Z3jRObY13IVSToYZNMN9oSUCycSwdFphIFT8e0
	 PalVQ9w8lP/x1w/yTJxR7WxMXnmSn9anPJ+LhcyUoGDPNzHznw1xqeDS0T7u3pZ2ifw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623387;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Fvicyg8Fd06ea9xOp3734mK6H6xlGiXlw0uR3rAzBzs=;
	b=m6YNSSbJ1O0nauvK7jWT9+O539uaAynVGbVzPDZf7Sq7o6YbfEQwdNxT7K6GT7H2MNId
	 gEhhuL4u2CUeLguoFXhVGeIiJIoouFLERelf04F/4Sw8X3DUIRLVAXvAjIBBNrUkWpYS2
	 kHHqFyzr7FqPRU5Z/eC1DaRZNZQlSJCDIQ+cTiYh/FJX19K3J6NKQl7VSXfliTvNX/f6U
	 j9pfOBgvDf8uzA6NDnXgHllSC1CetLmYxXw+Ws2fKn6yoNgxwQySkcRBVtzaNr+1vZk2a
	 GGyDD1xvhiZrl9nyk6cGAJnmMGw53F3O9Ht4wGa44b2+I7KmRzXmcu9erFy7HTv/pBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oh1sbX6U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E65660A2638;
	Mon,  2 Nov 2026 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oh1sbX6U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15C91F00A17;
	Mon,  2 Nov 2026 12:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793623386;
	bh=Fvicyg8Fd06ea9xOp3734mK6H6xlGiXlw0uR3rAzBzs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=oh1sbX6UxViCVjK652yjM3GQIfeNiU+flMgKM1OPDapbm0ytnUs0+VOt5++gcUkLy
	 znS3tBmZN1fzIl5llI5sqP5X25MhjNnlpufpHqIE2POVXnc0IzOQvFezmenf/03XJy
	 +hSZN5BY43sRw42IEZiW2NhIoKfVj3iKh3wA10OhH1iIuCugRvuLf4Dz7yzM+m4Gya
	 Vt5ZLtz3RNOFOJRhsoV0NeZt+GYG3e+PIwX4A7Ps5k+vPXBW0UkI7D2Iz3zW1QgyCg
	 3dodCtGVKSbm8GrtTs4X/9SdjAqNIaaKS5i70wKet/Sn5Z3MBxQUCpL5fQL8OBLTtR
	 8hvRqSWwTDzXw==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 1947D2310542;
	Mon, 02 Nov 2026 12:43:05 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Ninad Naik <ninadnaik07@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261026112033.36310-1-ninadnaik07@gmail.com>
References: <20261026112033.36310-1-ninadnaik07@gmail.com>
Subject: Re: [PATCH v2] spi: mtk-snfi: use min() in
 mtk_snand_read_page_cache()
Message-Id: <179357935036.1716893.15135482750759884888.b4-ty@b4>
Date: Mon, 02 Nov 2026 00:29:10 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=broonie@kernel.org;
 h=from:subject:message-id; bh=czJJa5KVgAzY89jIsO/TrpW8iHAFY+XUjsaRbcZfipc=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJetEbY7pjec3rKvBq/5lN2QdeE53fNk+bdvrLB4Htfg
 3H88RKHjlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAEykeS7D/3Jm7phmE69wWY9o
 fe2vGe8D5a6fm57vXpQXsXZhxUXrJYwMD2NL3vjdvu3w9YS4oqNneusy1krv5jd1as/1VerKK24
 yAwA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 26 Oct 2026 16:50:33 +0530, Ninad Naik wrote:
> spi: mtk-snfi: use min() in mtk_snand_read_page_cache()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: mtk-snfi: use min() in mtk_snand_read_page_cache()
      https://git.kernel.org/broonie/spi/c/44e7659f4618

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

