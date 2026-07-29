Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273DF45C709;
	Wed, 29 Jul 2026 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343057; cv=none; b=iRhrvehWXLhvSFZvH9cvRvbVwAdpcriahWGiVFDgSZXNF53im3VpocfcqiGafhhAuKYqMoYleRQwVZse/d1x7h01Z+01ftt3Bhz8RriKi2sUsE0xMVzPf9i080t8+EdvBelga54syRIdXnRb8Ars8MBS3zCLUDTxImhfBdSDorc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343057; c=relaxed/simple;
	bh=9Kwc7FsBZM3KR58b2xFxZXXK22a1jUsQ1HQSuFMLLzs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Jdubhw0QC6svnDVCcziC7G7/qm2i/3pxKNTyCghJH23azqB6bQrOCZw5j6sTzaEhTpkDenN8aw9qzKvFJurHC3UaviqV0xujOlPTzpSBTiSHVLljsgr2yT8/vRGl4X2Rnmf0nrdmq1lABa1Kg4aZ0suAZMoV2Acw/x9ustiMEOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEA8W2zt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEA8W2zt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF8E1F000E9;
	Wed, 29 Jul 2026 16:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785343056;
	bh=KOg9aJvhXUDZcrU98KWBo8WzVJQDl4WJbQPZemXzOF0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZEA8W2zt21R2SjPYx7wmHCxTYaKaSJnMHTRUAVHLCRWpWA4zI1MeYnTzZFzMcC986
	 oxymhIhWCYZGlpe8Nt3n0dX0YQWxiPaA2b2bMZUH7PeGj3h6qrnamrwso9gLRb1xeR
	 59dFRDemwf5wJKIIZBzAcQ5nM7DIVJ0PHa88vlsrmYhqP2gjgWk0oabS9oY0gy7Gk5
	 h3EQfqz9yMdqNU4QBDYshmH4Tm7EhwrUqdqPOzeaSS+S6qpO2BPvd3uO1b+pZ4Xvjl
	 Wqd4ipy6izkIOOVCazNMfEhzu3esGaJ+KGxuKVmryxqUJC3Y3OZiU0Ny4pTGBeAE01
	 X5cLIWLtKu4xA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20260719010014.3163356-2-fanwu01@zju.edu.cn>
References: <20260719010014.3163356-2-fanwu01@zju.edu.cn>
Subject: Re: [PATCH] spi: davinci: switch to managed controller allocation
Message-Id: <178533932169.172652.16622341862961533928.b4-ty@b4>
Date: Wed, 29 Jul 2026 16:35:21 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev

On Sun, 19 Jul 2026 01:00:14 +0000, Fan Wu wrote:
> spi: davinci: switch to managed controller allocation

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: davinci: switch to managed controller allocation
      https://git.kernel.org/broonie/spi/c/ea408a05dc8f

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

