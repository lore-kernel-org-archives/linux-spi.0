Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477DB448D1C;
	Wed, 15 Jul 2026 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115355; cv=none; b=EpA8QJ8YjDnMxv0Y6+58FTlXAIUbr4Kn54NFKCA8qvDpPQWFKu0kn1eMY9aXxGxlyEy5meijUzAoXWNc+qFS3ToaUEOcBjzoVa7r/Be+sA++NIMp+lccRGhg+XbJ+hW0akMKqui8Z5Y24DRgE4RVBh/Et24xN92AWNZXdxc/u1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115355; c=relaxed/simple;
	bh=9nnuB1fqJSaQhxX9t366m0Ukz3gVMDVj7wyBMmrJHuQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MwnNH+KXhDjLXUO7LX/14CTp/yM0iE/MiYmEhkJ3ASryd0SK8rnxjcfiw4m6MAGGh63FC2tapj3phhKPG8bh+5c6WpqC8/8swOexY58aAmrDlINM0icYb5RmiC/BpdpOy2NxW2kBF8ulAeq/TA/nM+tnNR00jTcM85bJJd/skNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8gPhCu/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8gPhCu/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABF71F00A3A;
	Wed, 15 Jul 2026 11:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784115350;
	bh=GVPmOtiyGymaUHvGHWNJiVVfq8sCCje7jrMUD4Cur90=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=c8gPhCu/TKUqbcR0ylDm7VI+IHLGtfS11ZwKJtVLxoMSrXqMUN+1hIUZvlXsDfy6O
	 ViH4bGcpIU9AsjQTGa1A0JksaPBXMbmSvj25Cjn2202aQw5A6DsBjFFRaX7CKcX/Pe
	 mKSopDK5CEZSBHj/f0rrY+8SCuq3zPAFSqyqLE/MpTFG0pxBNjUX5zD61vr5d9IdfB
	 lqSOw7P1dKcAl66XE00PrXzoQd6LS7QHCvYWLcymEekNoKxmxZq256f3i571O/L3XA
	 KUfzbYaUAct6B7ikRrJJHXsbgRnHfMgwr/Q1ZXMPkcg8nrpbXtVIx5xOOf95g+dwS2
	 KaxTuLZ10zEGg==
From: Mark Brown <broonie@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260714164215.183809-1-colin.i.king@gmail.com>
References: <20260714164215.183809-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] spi: bcm2835: make read-only const array
 pinctrl_compats static
Message-Id: <178406403166.7661.9867975248660061132.b4-ty@b4>
Date: Tue, 14 Jul 2026 22:20:31 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1142; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9nnuB1fqJSaQhxX9t366m0Ukz3gVMDVj7wyBMmrJHuQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqV3CTMOwSqGeTDhkxx2Zr5CzjZcsf+CTWe3x4g
 CStB7IohQCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaldwkwAKCRAk1otyXVSH
 0BO4B/9cio96bw8Ib1mcHoju08NqAyYc6spD77PZS53l24iQr86lUU86LurrTiodnKcDTWpx1pD
 My9M4rPRlT/WRQPxSmasGxjZlADdqc/ZGnIvh0cRqTZ3cymKwnnmAZbCA7OxJ0uD5vIYWlK4PBs
 fgiIB5MUU7S8rOC6jTjxZJnJuvWn4lpbpG3kNxySCQOxktwSijUX1tQWAK4yESMYzlHQ7YnwY5F
 RrRMdAo7yLnYM+ghXEdT9dlophgrYbCBorAmLl16RAa3R2ohI20TzlGORgfw4SeYH4NHsFMw+Ev
 s+Kz7HnB2dQ7jkUpgrT4dVAVYMK2Up42KgK+xR/0R3etqTsK
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 14 Jul 2026 17:42:15 +0100, Colin Ian King wrote:
> spi: bcm2835: make read-only const array pinctrl_compats static

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: bcm2835: make read-only const array pinctrl_compats static
      https://git.kernel.org/broonie/spi/c/9c4a2dced735

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

