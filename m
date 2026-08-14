Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E4331E846;
	Fri, 14 Aug 2026 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786732926; cv=none; b=nMKr3CYtxp2edoL2NeqXRiPKg0u61aGzUzmLKQ+OMP0+7N5MybtkPrDVpoKyoadrUKVtx6A0K4zK9G9NvB7UfalG3utcP26HgBCR2n+38nYyChCEnFIHpw8ieF961hD6lpsKvTFV1eSP8IICPgEk4yaZl+Oy6nhzhSdQdZrGWsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786732926; c=relaxed/simple;
	bh=e7xP7BECBuQ+n59ZD1iBjie83h5pBaVQ2QJQNdA0jKw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=taTU4u1jSKwaKWYvOBF2tROqMREl9mbf2ehbG6cpQvQ5hO4iZ4ad/yVUULTNWz2ToUwGegvpRHqcHNI9Vp05Hs1z8QDMJYTr34zEyf5RdHMg4K2pz5VQS8fMvknzJ6FfM7CHcCloqP1RoIBodToLr/3MLPHB5irVeFTpO8mpNas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWGAb5j1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWGAb5j1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93811F000E9;
	Fri, 14 Aug 2026 18:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786732924;
	bh=peK6dqWnWstG3EUPdqHJ4Bp63cX5cTuukmk/rW6J7rc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YWGAb5j1+Bsl9n3QpjaxNMFkcx9jKxshAtmXlBDadaR7NBKxA5jgGq+eWFEXw7Nkk
	 tRCpKJBNxLbeIg9J0baKC4okCrFUGDc7HXV9EEpVancwNVsv+4Po9X1laDVFV/patM
	 GDki7/NO2U6kQGfpH++fg+Dt6hA6mO+tlYRyxRWIhUiAjw8FKqvODWxucCj9PXMO/c
	 3ZXPMbs3GnI10BxFbeoX9s3FfCuHf2hTCyKXGHdWpGiTEBbe0w6UaY+oSU31AzD3zR
	 8XxseCu3BtbFvk/TacDKCxlnxOOlbkJiC+BBXnlSbqR8qgZh9FKnFB7qgIoB+MoSjr
	 n0CACUVpJvUNg==
From: Mark Brown <broonie@kernel.org>
To: Honghui Jiang <jiang_hh2019@163.com>
Cc: Andy Shevchenko <andy@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Serge Semin <fancer.lancer@gmail.com>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com
In-Reply-To: <20260814031419.43378-1-jiang_hh2019@163.com>
References: <20260814031419.43378-1-jiang_hh2019@163.com>
Subject: Re: [PATCH v2 0/4] spi: Fix DMA mapping ownership on partial map
 failure
Message-Id: <178672257942.152149.10524273679854692291.b4-ty@b4>
Date: Fri, 14 Aug 2026 16:49:39 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744; i=broonie@kernel.org;
 h=from:subject:message-id; bh=e7xP7BECBuQ+n59ZD1iBjie83h5pBaVQ2QJQNdA0jKw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqf2F3em7c7s4Y8NgkjP/0aOE5+Tg5+O9w1VxqS
 dgLq8vFvgyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCan9hdwAKCRAk1otyXVSH
 0KcjB/9SmIBIxv+vlJj2HBHsQ5loPmE8Jybl3CI7H6GpVEtto0lqSVJ0joUH6MtOMg8riYTw2AJ
 Qi7G7E07OTd2IzE2KIstBFEbXRFissR2w+P+AkhKrSLzIzEft9K82RNCBz6XdLB3oUFwIHcxHmM
 63cP7MqRn+CdkvzX4t/Ukb9aytvDwhCqptFiL6gg4yalXg/UwKgwrE+yZewQoM/bOF6foa82QTL
 A/FLNrXyZX831tZh+1B0rldznR3TjUEqL/b+VvMAcwC8qnUwRsHgvHhd83fd6MyT6+UhlYSBoUq
 4BUuoOXYY/aM9y56onP90sy2WGsPVQaI6VfTkbBRCswygfzm
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 14 Aug 2026 11:14:14 +0800, Honghui Jiang wrote:
> spi: Fix DMA mapping ownership on partial map failure
> 
> A partial DMA mapping failure can leave per-transfer mapping flags set
> while cur_{tx,rx}_dma_dev are NULL or still refer to the devices used
> for an earlier message. The subsequent cleanup may then unmap a
> transfer with a NULL or stale device.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/4] spi: Fix DMA mapping ownership on partial map failure
      https://git.kernel.org/broonie/spi/c/367cea239fc9
[2/4] spi: Move __spi_unmap_msg() before __spi_map_msg()
      https://git.kernel.org/broonie/spi/c/b82b2dfc93d3
[3/4] spi: Clear current DMA devices when unmapping a message
      https://git.kernel.org/broonie/spi/c/af6aaacd42f7
[4/4] spi: Add KUnit coverage for DMA mapping error paths
      https://git.kernel.org/broonie/spi/c/9b81a87c5244

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

