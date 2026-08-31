Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C833932EE
	for <linux-spi@vger.kernel.org>; Tue,  1 Sep 2026 21:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788296930; cv=none; b=TbwL1hygd+Hvem46k+jXuuSe3RhzAzaM03IF1/GdU+AxTnVqL2luE8edrsLGx6yKdYg/wP/X5uKiz1yVLebJQuvx3BNIxQ6+AbPuP+A76/seTxTzsEPxJhaEtIxZq8dZI4/9r/XF6987jAM/EZX74q/hxvK/In5SHhEdw7eqexY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788296930; c=relaxed/simple;
	bh=skmUQfsezNawlIyKeMuQ/Gk6kzJ9Eyloa/jTCVPNlHw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tC/bvklHi/G5OvBzGOT00GBnEJFX86i/IvECLnPvG7uVSNZcNsUqyQjfS8o68AkYGP2yglbMVhICVkvojfXJmGq9qrtf8JUo7ZUmNNZ1o2zqiVvNbY2T5oGNmBx6Fvt0kD74YQe3PLHMGtfZujWF5++qLyajZipeTJf+cT7XJzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOPPEvFX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOPPEvFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D381F000E9;
	Tue,  1 Sep 2026 21:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788296929;
	bh=d1oh83Bn+6ZCgpQ6h2dPpmmWZCF/huBbKCFBgJ05nFA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KOPPEvFXdTqZ3H7r8lYc4bfscuKMTVsjJBCglaVZvhcsn76HzlC56TwzGIY0b+AdB
	 ateTC9G6VQ7wGVHVn2MrU2CFysfKKTD6+N9n83m0ZxwWk3l5F2UbDZ2OcIkVQOx2px
	 Gy0kAa28eHvRuQ4OFiah7cPF+h+IYvPZ+wogh3ehv61t4gI+5L1be/4LGGl+5FKG2H
	 mce1mEDLjsFTa2mWCH8TEj0l33wJ8axYE6YsBqMBeZE4r4DuOFanOFXGyQEiohFX7P
	 12gaWVoin2xRSYwrAq2iwt/r10slRzYe3XWNM84jR5KeavW3qz9o8wUWcX62d6XHiv
	 ylZ742JsrTFpg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Andrew Gaylard <ag@ffroot.co.za>
Cc: lhjeff911@gmail.com, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260820125835.1584270-1-ag@ffroot.co.za>
References: <20260820125835.1584270-1-ag@ffroot.co.za>
Subject: Re: [PATCH] spi: sunplus: handle signal interruption in transfer
 wait
Message-Id: <178819862061.141190.17552395113826527731.b4-ty@b4>
Date: Mon, 31 Aug 2026 18:50:20 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130; i=broonie@kernel.org;
 h=from:subject:message-id; bh=skmUQfsezNawlIyKeMuQ/Gk6kzJ9Eyloa/jTCVPNlHw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqlz7dGsvzPAXOlBeuQwLVpS7UKpfHmjKYYw7+m
 KkkXD/fZhiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCapc+3QAKCRAk1otyXVSH
 0OcuB/9IDMSohzfHaCoFMDr7bFktqJ/V5vJwQ799PNxXwYgN4QJj7NKZP5FuSx4BhnW1w98oKor
 ZaslkRGjEVUsCN+CVxHQdlqiEFd6dy1IcK8yoBtore+TLse8bGDxOjrEvgdGgCGz+NNM06WXM8W
 C9v4n4Def4hSCbQpJN5Qv676H/QlzR0ldbo9qKldZgkGTvAQ3r24X2qrigHzTbGElTmSc3U0/2y
 XT8iA+jjZZ+vsraz52AqZUKg9/b6EZO49J21sqj5qe8AuxX2I0s5LyEUMMKYxOETZSxV+R73xLX
 jtT9CgowvRob6E5MebvCEBjy7xIe9n/5VQ2n9Z5f2EwFXLmZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 20 Aug 2026 14:58:35 +0200, Andrew Gaylard wrote:
> spi: sunplus: handle signal interruption in transfer wait

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: sunplus: handle signal interruption in transfer wait
      https://git.kernel.org/broonie/spi/c/7fe2098d612b

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

