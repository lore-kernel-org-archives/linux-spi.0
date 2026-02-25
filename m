Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F5D3F0747;
	Wed, 25 Feb 2026 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772046472; cv=none; b=HeyD4x9T7K/uwCarGfn2QBQ38OUB7iL4E2lxsFSjXZqKuPzWoX1j7ICzUgbOo/OW62IFY06vqiP0ThBkJ8+ui9W2iSf2oHcXlPvHXRwB5aBx47BUeg2iiWnjYxjKbd4u+yN+KMQOawxjOQoHYLEOwcrLD/GL3MfrAKDpRqI6hZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772046472; c=relaxed/simple;
	bh=kuPZcC4xYX0NxDfKAgqQFbXlA8WTqevQDuVsHbHTpz4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GN3pCGa/Yk8qyrOxUgMu4Vd2QDGtJuVxFbZENMNAkuCtT0dAqzjPSq7EJHX4sL7fsDsq/3oUQQ5oRM2YQ28i8V7HgJfic2mztvbGXbD90vyRBDppJF8EHDz7IY9at5e++fv0NjzafCx0H0tsw3BnbYa8TR2Yi+Fsqj9EkwxgcOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnEm5fHg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnEm5fHg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060BEC19421;
	Wed, 25 Feb 2026 19:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772046472;
	bh=kuPZcC4xYX0NxDfKAgqQFbXlA8WTqevQDuVsHbHTpz4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mnEm5fHgBImgJ1VWWPPobRPL8HcgIvUiFME5vIi9ej99vmNd0WF8hNfi8luKp4hse
	 zKL/kzPQZxzW7zF4q9DvME4smMUukq4WNd7LQmq2akuGITsVkj0vWFwnW/iJnZPioU
	 ys3bFXHZnK9TH6q0mCq0NNgb7zeT8sy17ijcxWvKwPro+7xpVZ2KFF6PmVYUjS+oyt
	 mglkHYMBGRAiz6A9qsJnv+tyhRyRvRFCWpDXjR05ewFkF9ay2YXXKOBjS2AvoG2bn9
	 JZK4HWfbzYjx/XrL2uBqJPTDZ5G1L8DUPEd4KA1j0bMWFU6O+p56Va0P/tntScdrNC
	 wgswAIL4Eo4IA==
From: Mark Brown <broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>
In-Reply-To: <20260223153117.2838840-1-andriy.shevchenko@linux.intel.com>
References: <20260223153117.2838840-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] spi: pxa2xx: use min() instead of min_t()
Message-Id: <177204646977.169139.5577327712485866551.b4-ty@kernel.org>
Date: Wed, 25 Feb 2026 19:07:49 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Mon, 23 Feb 2026 16:30:54 +0100, Andy Shevchenko wrote:
> min_t(int, a, b) casts an 'u32' to 'int'. This might lead to
> the cases when big number is wrongly chosen. On the other hand,
> the SPI transfer speed rate is unsigned and driver uses signed type
> for an unknown reason. Change the type of the SPI transfer speed
> to be unsigned and convert to use min() instead of min_t().
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pxa2xx: use min() instead of min_t()
      commit: 507a071d9868cb60e4e76f8a06fc8eb014f59ae4

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

