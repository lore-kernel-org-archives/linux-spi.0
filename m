Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647AC313E36;
	Tue, 24 Mar 2026 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381463; cv=none; b=Jg+u4Lbac9yvEPvcXWwGhYJqgGBjVIvrsAOo30WNgswgUqQ39LOajdvQO+/3k4qhFZjdEw4tYWe6bT2Ufj2j3/rVj9JC5l/P7wlZ+yPXB4YpFu9IvR1io6qAJY89WRJgqVaGkl+Fi57OOruxzEUTi8aijy8SEk9czmiLfiwk3No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381463; c=relaxed/simple;
	bh=5tElmthyh7guY2n/zgyFREJ0b6uLFAD8C/W1bPdJL1s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j+QVQ09zV3Xgot/0sdbyOmjxOZRhXOpGEjbChPAyTc49y6fvmsAh4FPUTarCTc2Tx+jBUleYkUdRw6Eits5TGEYAPdJQCZ3KjAVTyNiqb5gnWQKQvD6yY9r4BhdSZohD33W15sk//r4CpcgKw6uUhNpV7gTsdHNscjUwtMZet6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0w/C7m1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0w/C7m1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02FEC19424;
	Tue, 24 Mar 2026 19:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774381463;
	bh=5tElmthyh7guY2n/zgyFREJ0b6uLFAD8C/W1bPdJL1s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=l0w/C7m1R0VjeFeC/Gp8F9wBxQCtD21k3wkwqyOEM69xkGTJ2awSaD/rCQzc1UT1L
	 il9JG8cA2gywr6Mc/rgy5EU3grZkJ2EN7UPZuXu13XKfSuqkslwc98Ihy569SRZLK8
	 QPEB47i7tnrsMPV+Lh639wu8gZXSjQjHySsr3wUiA//zEOMHTSjPh1jr2vg8yNstTQ
	 ldE12eR/trL2QrcUEhkNZJRLTVP1OkwHV9QAaJrKW+bTyd4fZLnZSilnbYEF/CvnJP
	 L2cPoGIhtaRdTtNRqjOf0SmkVJIfdgdbVozNVuE58UBoNIpheaF3wyeQ5zPpbHK+cj
	 q/+aqSMKAS7BQ==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Heiko Stuebner <heiko@sntech.de>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260324082326.901043-1-johan@kernel.org>
References: <20260324082326.901043-1-johan@kernel.org>
Subject: Re: [PATCH v2 0/5] spi: imx: fix use-after-free on unbind
Message-Id: <177436238254.98682.5701412106490840740.b4-ty@b4>
Date: Tue, 24 Mar 2026 14:26:22 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-6cc06
X-Developer-Signature: v=1; a=openpgp-sha256; l=1848; i=broonie@kernel.org;
 h=from:subject:message-id; bh=5tElmthyh7guY2n/zgyFREJ0b6uLFAD8C/W1bPdJL1s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpwumUuGJsX67TIOVB5QD4GG3z5iMjD8lfiM/fP
 k9fQqy2eVyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCacLplAAKCRAk1otyXVSH
 0HOqB/9eGhehwQZuV3jyFF70oO9GAYnkHOGg9xgeGKmpkqP55aQWTUE86niJS8gO9XnfKhyQmi1
 dqPWYRwo9FVRBe1MvdD6nvImIyuMr7U0dR/QrScgtk5P3P225+bo2jRGRChekUio0nqFxvLPwQw
 +t5AEh/+bnHKdprgWBl3jFACWwm3+h9OLKv4Z+VOkEIeCrwUZHhMM/CRu2Xik4soCaLXS/0r1u4
 rCiTbXndJxxsSTRmFKj8Et32eGFPnxnk4p19nhAqdYPeB97zV9OoBws7ZtjOpJnxlhbqdW2SLhm
 tSPOdyrSfqrtLfTop74/hgG7LTl3MwU/oOc0zEdAFCSeJJYy
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 24 Mar 2026 09:23:21 +0100, Johan Hovold wrote:
> spi: imx: fix use-after-free on unbind
> 
> The SPI subsystem frees the controller and any subsystem allocated
> driver data as part of deregistration (unless the allocation is device
> managed).
> 
> This series fixes the IMX driver that got this wrong and then converts
> it to use device managed allocation.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/5] spi: imx: fix use-after-free on unbind
      https://git.kernel.org/broonie/spi/c/1c78c2002380
[2/5] spi: rockchip: fix controller deregistration
      https://git.kernel.org/broonie/spi/c/53e7a16070fe
[3/5] spi: imx: switch to managed controller allocation
      https://git.kernel.org/broonie/spi/c/9c0180650654
[4/5] spi: tegra20-slink: switch to managed controller allocation
      https://git.kernel.org/broonie/spi/c/4ba75403fb4d
[5/5] spi: rockchip: switch to managed controller allocation
      https://git.kernel.org/broonie/spi/c/7f3eb70516c7

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

