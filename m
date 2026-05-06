Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2EB239E7F;
	Thu,  7 May 2026 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778118435; cv=none; b=YLI1EZP2+goLT7+CMGOCPEw81O1ZE9uF1XlVcfIIb0MoJxVNi8dm5FUSa5o+bBMZXhI2tHURSLA9EaFhIMc2MgYeF32S70IrJBzIN3F7NQfYJcMyhRYllCqVPBf+vXwPMUVuH3lcVywIKMwf6exVldhyvcSfEY7Jwf0gHDk/h0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778118435; c=relaxed/simple;
	bh=BJKpc+GyMBOXMlVcy8ychYrnsXF3uPompomYqrj7eA8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q76L7AjR6SMXY6ig7tlJ8Os8V/zWBN/PPegCzB1F6XD1A6tZF51CkQvmqgn84P/g3onssJx0xyjCzYnT/N7ELIrpWNSsBer8kZXWHbPAavOb/w9QnfR/z8NFUCdajKrBcVu1IfnB9fzhAKS5PVRfhLjTAvDCp6TxchecmefQt7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGQMQboC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGQMQboC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EDEC2BCB0;
	Thu,  7 May 2026 01:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778118435;
	bh=BJKpc+GyMBOXMlVcy8ychYrnsXF3uPompomYqrj7eA8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vGQMQboCpWhaxha++sz8MzOllWy9Vp5la9YlkKC78NIM+5jm7q4fBD2TaPpvB3MHp
	 WjkeJqnn3L8GExQovd6p6zFTKMP7dJEpcG/GuthxBpwVGE0eF8P2ra21Fz4H+7N/W3
	 nl9tvHpApY1+cOpfhEqVyTRK6RveLPd4it6QrgsL08S0m1fTHsyHT/1Oqs3tVNrK9+
	 Gdb3nflFq/f1ewwPd+6lstdDGYQWjHJsPy+qxBushOPX2nSbRHQZy4VmaeypvVMVlJ
	 LB0rf3WDsi5Ux/Mq2tMQlzXvcSnrbH7RRRVcaDRVVXA0WrqNkY4OczNee+rRrDFQSi
	 fkDCaJ7I7nwbQ==
From: Mark Brown <broonie@kernel.org>
To: Jiawei Liu <ljw@wch.cn>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260506062412.371034-1-ljw@wch.cn>
References: <20260506062412.371034-1-ljw@wch.cn>
Subject: Re: [PATCH] spi: ch341: correct company name in MODULE_DESCRIPTION
Message-Id: <177807657797.624351.4004439512384924660.b4-ty@b4>
Date: Wed, 06 May 2026 23:09:37 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BJKpc+GyMBOXMlVcy8ychYrnsXF3uPompomYqrj7eA8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp++8h2XenqEp18Nwdkvs43WQSPZI4VtRzyNCc6
 3vXCMAiVHyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCafvvIQAKCRAk1otyXVSH
 0OH/B/0eCanI06hgZJ9DmJ+nT4ePBFWwtjJGu6HYpAfJTmOUP6DTgdJvlCjCVr02Ne7gFVOdSMC
 Sz+XPhI9Pb4Vm0N5F8MVDdfKOd5Zfbkc8HN2908CPvGN6rt4LworVVLxdRBE4IBUN5o0ujmZtQg
 CxjcKbrtX6j9z5JayBEq4zmmcGEJEWvt2r09KlM46UaBd6DKAfjF6snpcbUZ9tj/TCyvxopKUhx
 En312k17gfbqjIypTQ6v3MrtoaZIlIgZpocGqUP4UY7/d6/8viD48K+S69JJU2LT78DvEqw+biH
 z6oaaozBvxQCtSJlVAZlD9qvmgWj1R53oKuRP28OsM5snHH1
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 06 May 2026 14:24:12 +0800, Jiawei Liu wrote:
> spi: ch341: correct company name in MODULE_DESCRIPTION

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: ch341: correct company name in MODULE_DESCRIPTION
      https://git.kernel.org/broonie/spi/c/4bacec231752

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

