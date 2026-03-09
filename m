Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52C721507F;
	Mon,  9 Mar 2026 23:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773098557; cv=none; b=SqCcLlB/9+VqZ+BfzxzhgA/tCrl/DjxQxVz9ViQfPuAs7aEIG5wphMxhXRXqDeMKDgm8uLN9L6OUQvr8HOgu612i7yE3VBmAIxlYzvPVe+MliLui/xhc4Nvw2DsR4QciMVzRPGJIAygHaZ3pk2WN1nGhAGi6dG1dWOzZz5bvW3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773098557; c=relaxed/simple;
	bh=0TgbHMXAeR4vf27hmcHH2wiJqapPz5uhcsC3p/ANjuw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UrhBGZUHnTm6ocW9IjtKHujXQVTNZDRoVyQtd24RGcMYE805fSn9WSjzu8MUYRu0QkvxFkA1w/x9iixNalG9748PwdS0QUSjxZ9Srnv+GuDQIVz4Bk9yhC6aPulf493emgWeq1T3z9TTU0mKT+JEZnUxI94zoUt4TUkENr1Or58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtUXrY2b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtUXrY2b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B66C4CEF7;
	Mon,  9 Mar 2026 23:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773098557;
	bh=0TgbHMXAeR4vf27hmcHH2wiJqapPz5uhcsC3p/ANjuw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JtUXrY2b9l9Cxdg1kuylzN8uciuDoG2sqDtQGFx1gJorl7gHTp9iT0jdYJJBjuleW
	 o1TxxXZ7cNvfSLZZ1WB1JU4hA7RMYOPtIcEp7VfcIvL9dU6UtgXbtYU5cwUqp3XMz3
	 9ijBaotIXvFsE2aIJU8b87SzTwHreQaC+Dd4Yo/Cq7NR88sdCqZ76uk43e4O9phCFO
	 NXxagCw6WtTRWFuSO4jJ3ujnh4xVjobAqYk9F14EJ2XW+hlnYfO09MMcV/4Nk+N9aa
	 XzgjM4qnO5DPUotJptq+pDz44m1GeCUacA9TXDgWXx5HiVaUcm8fBM1MOA+MDvIMe2
	 qE4rZi1x4fUEQ==
From: Mark Brown <broonie@kernel.org>
To: Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260304-spi-nxp-v2-0-cd7d7726a27e@gmail.com>
References: <20260304-spi-nxp-v2-0-cd7d7726a27e@gmail.com>
Subject: Re: [PATCH v2 0/3] spi: nxp: Use reinit_completion() for repeated
 operations
Message-Id: <177309855508.332379.13716109857910431455.b4-ty@kernel.org>
Date: Mon, 09 Mar 2026 23:22:35 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-83dbb

On Wed, 04 Mar 2026 20:47:18 +0800, Felix Gu wrote:
> 


Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: nxp-xspi: Use reinit_completion() for repeated operations
      commit: 40f9bc646db5aa89fb85f2cda1e55a2bf9d6a30c
[2/3] spi: nxp-fspi: Use reinit_completion() for repeated operations
      commit: 68c8c93fdb0de7e528dc3dfb1d17eb0f652259b8
[3/3] spi: fsl-qspi: Use reinit_completion() for repeated operations
      commit: 981b080a79724738882b0af1c5bb7ade30d94f24

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

