Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C081B391E6A;
	Mon, 30 Mar 2026 22:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774910534; cv=none; b=p5on7Zf7VHVwNFpDWdVggpF4rZYhJNZz0ZCaBT9UBEZ+R2epvt90P7YvMLkX3sVSmwnXGxXFRW+iN6AiICLuwB+4ppJMc5xzcSgydF823Hdo4qWLDgCJfPA3NzLWpodGrjN8yttoFAfSO1ua2bAk3Axhud1PbKKiyM47Px1Y/mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774910534; c=relaxed/simple;
	bh=MiUdjd1ElIy6O+EmAN5j9TphnhlN1KKDDIGXOr0wtvo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R3x2rTVd2/xT0yZuTDimt55aT795a8SviQJjNX4Mce1pEO7FZacaT/bWnMduwBA6c/xwgUfHB3Ok4VeTC0IpOxG83LERBv0/z3KCHo4yk4sfqFoVHNbsqWLtL43cRtteVYu+EbXMD+PLfELF0mz4z4y4DEi5CiSSEZ8ytNx4AF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hk9jcoi0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk9jcoi0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1684C4CEF7;
	Mon, 30 Mar 2026 22:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774910534;
	bh=MiUdjd1ElIy6O+EmAN5j9TphnhlN1KKDDIGXOr0wtvo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hk9jcoi0C5zFsVz3zow84mFzcKyBLWJ7Hl+PD++Y+8aBg/i1hEPnwl70BERuT3GjE
	 sfUA/QRrW1OmGtjP1MinUn6LFZef8u+dou/UNmn1LuyK3qaBuoMS/grxPSTGwtqcOP
	 dZ16pYk7+YRPockoQ0dzWLY8NJBJQwJen5k7O94OVMx1qjbsZom9c/4nWouOOgcpdZ
	 JN3OOvjuYgKVFwqTMTCzcpijOIpKlBpVXdGZOrWTDQaWZnWvTXrgxjVmIyJbh84GWt
	 JD49jvX8GhK/fXrAsxOq2MZoao2Y1Y+Siz22/ahMV9KatvxGU7J0aI5VvrOE6U2Unv
	 oNcW6N/6GQNZg==
From: Mark Brown <broonie@kernel.org>
To: Liang Yang <liang.yang@amlogic.com>, Feng Chen <feng.chen@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260322-spifc-a4-v1-1-2dc5ebcbe0a9@gmail.com>
References: <20260322-spifc-a4-v1-1-2dc5ebcbe0a9@gmail.com>
Subject: Re: [PATCH] spi: amlogic: spifc-a4: unregister ECC engine on probe
 failure and remove() callback
Message-Id: <177489325833.222960.6647008477014034465.b4-ty@b4>
Date: Mon, 30 Mar 2026 18:54:18 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-3ac6c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1178; i=broonie@kernel.org;
 h=from:subject:message-id; bh=MiUdjd1ElIy6O+EmAN5j9TphnhlN1KKDDIGXOr0wtvo=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhsxTf5wZ5kwzcFLmv2a9Rmp5TKJbhcKC5sL/jhOO/La4x
 5Zp67uuk9GYhYGRi0FWTJFl7bOMVenhElvnP5r/CmYQKxPYFC5OAZhIkS77f6dmfZ23HC1h554G
 1v1Ps/0qcdN64hYR4+Zn5wRNNex/KzVwP1/pJ9dw327S9Sd1fXXn1E+53zrpv6gx2+7l1WV/OxJ
 X6ZiffKN6pJ3dqtuxY7m5Z/PlP/ujjxrsEZvyy1v822TRhdYnRbnyOK1v1/qyGyk+vWJu7M8fd7
 uicPX5XC77xcfPs+23yjl+/GDWId+ZUgdne0YbPFbnM2s1T5pgVt5iHdvzR9Jj9Qr5Pgf76sWG1
 pOlQucrRbPPtzoqzDSLfQe/tLHrP83pSdLntp684p8dtjtc0uAtl41c4AFP3iUyM84Kf/ZLeenn
 O22K6d1VthsfqpyyWvPWj+PA+03OTMufNkh9/bfOlOsEAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 22 Mar 2026 22:28:45 +0800, Felix Gu wrote:
> spi: amlogic: spifc-a4: unregister ECC engine on probe failure and remove() callback

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.0

Thanks!

[1/1] spi: amlogic: spifc-a4: unregister ECC engine on probe failure and remove() callback
      https://git.kernel.org/broonie/spi/c/b0dc7e7c5657

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

