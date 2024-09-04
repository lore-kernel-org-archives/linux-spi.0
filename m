Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520084778C;
	Wed,  4 Sep 2024 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470391; cv=none; b=P/cy6koNa1IoWZZ3IHRFNdqcEHRkEZhBeI0/3yLS1l/kCG/LxlSEoiBXHA8LFfYCGTwa8n61N5Xi3j82EwyD1PXYxI4l4BHL94D88uwQyz2ZTfec0w0fdIxeHGk7rhGYbqOXk/4GVK5UeJcOYFpRzqQdbYAYgm40cI+yx3yBhng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470391; c=relaxed/simple;
	bh=wOzdk3zpB6bpNiigYzcDTuad8NUr9giNekiGtdXh9A4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DoxMzwoi9Ogu6CBt/lvJdbA1yXwV2Poz3aSfrG3OsGZ4j8S3uxsvclfmrvBnNLE909+Uuv3nerg9I+67Wn7ZMH/D9JpWZmVMC4QEWmNRGv0+tFfKX9ZugSaikt/flVyb9hRkhp2VtsV9SH9fXpHkuSyGP3hzPQ6hcmRr4unEd74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rb2ni+mg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rb2ni+mg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405AAC4CEC2;
	Wed,  4 Sep 2024 17:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725470390;
	bh=wOzdk3zpB6bpNiigYzcDTuad8NUr9giNekiGtdXh9A4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rb2ni+mgoKTiR1yiFOIMtx6bbyZyqin4kYtts8pX5m5y7He0sIdGG6AE0aNuYTwFc
	 vxSgyVgaAOI1aooeYUeVM3wFaMX65JZfMMvZ9dPvLUs3MDJGKqmyNP1i3gW2Zg9/Dt
	 kkuQ3cZnTKR2l3zFHS6tmI7O7V7xbXCWJw0FutZHJDdtnrHHslyOb6tM9KsjKxI68T
	 ZkMrESxr8YpNClWHW69rmXpiNsER54q5arNBNWm9RmzGus2or4d079f9Vofyhh84GJ
	 H4Oe1oPsvdZtIvP7Nv/IIq1XC9O5ykmELbMcV2ml6AoEzWCJdAYNbsA+stv98uKFTZ
	 xOHPlwVXe+g+A==
From: Mark Brown <broonie@kernel.org>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240904073550.103618-1-zhangjiao2@cmss.chinamobile.com>
References: <20240904073550.103618-1-zhangjiao2@cmss.chinamobile.com>
Subject: Re: [PATCH] spi: spidev_fdx: Fix the wrong format specifier
Message-Id: <172547038998.87411.11069641005405855462.b4-ty@kernel.org>
Date: Wed, 04 Sep 2024 18:19:49 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 04 Sep 2024 15:35:50 +0800, zhangjiao2 wrote:
> The unsigned int should use "%u" instead of "%d".
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spidev_fdx: Fix the wrong format specifier
      commit: dce35dd27684640508ff330b8235c4671159743e

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

