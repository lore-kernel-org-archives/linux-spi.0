Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6481FECCD;
	Thu,  7 May 2026 01:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778118440; cv=none; b=m82PXX8q/cE2Nc2vcnM1Qj0QPFHgLYwbJmNrkCWpqBqgyS+JbN8tQz9zfTbOp4Ql1itO7PlWI/0DOZercpIw/462qQh8+9iySgmI4bMwFfRzWvzVe+IfBj0aLo1VraClqRkdPDNqWe9BIxWyQZB+E6YtSZTvn/MH1RD8MohMkf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778118440; c=relaxed/simple;
	bh=6oPqUQeDpsE8w0JZIJK2Mlj2sXrItkxuCsWEs0mWd1c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iGwgYR3Hx2ySohxKqy+7Wdm7n8zYCW7gPBHoHu5CFHPTFWawaPDr4E+xBWI6o6a0tY4Wmzeth0g4hEPbEoTQ0x4lT2TuYXTk7TZWb9UZwhsxlwT+//iWAvL8scumVnpCQo3X2YgoDo7e/qa9IqzCT6SPyiYXFnU+xbNmD5lkp8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPeFV52b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPeFV52b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112AFC2BCB2;
	Thu,  7 May 2026 01:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778118439;
	bh=6oPqUQeDpsE8w0JZIJK2Mlj2sXrItkxuCsWEs0mWd1c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rPeFV52baWiWpN63e2cLNZ10CQskn6kxlWKTb9NHF9qpTHzI6lzIKjsv7b5LTZUIo
	 INdkNV5tu+qymTPW885yXsyQMI6EeCHNo5ug4jgnvTBrTSSZGpu0OOJBpWCMhNP6XW
	 +ukh199ecuoMjmzx3MqmzFH34KM1R8ZkRZ8xFnqWQYe6ZSDlxrevvVl3eso7B0+tWa
	 o1NGRAbjo3ekqz9b/HkthbCsyst6ihuaTSazFgE3kZUGMIuH3P7aZxrZW1qqcAClGz
	 t0Tol5HYs4rLgUkYH+X3omXMqJgCfn79rbco9IKRw5TsbkRc+wWSc0m9KdfKAMGWXq
	 6fCBV4fLKKRsA==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Andi Shyti <andi.shyti@kernel.org>, linux-spi@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260506175144.449364-1-rdunlap@infradead.org>
References: <20260506175144.449364-1-rdunlap@infradead.org>
Subject: Re: [PATCH v3] spi: s3c64xx: fix all kernel-doc warnings
Message-Id: <177811673301.749715.1643862335362913694.b4-ty@b4>
Date: Thu, 07 May 2026 10:18:53 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096; i=broonie@kernel.org;
 h=from:subject:message-id; bh=6oPqUQeDpsE8w0JZIJK2Mlj2sXrItkxuCsWEs0mWd1c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp++8l1LUVHXJo2w9BV3WOQuAI2XVKIGYbdB3tO
 zbrcdh3DNaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCafvvJQAKCRAk1otyXVSH
 0LTjB/9yTFNLkx8jEZ0VZ4qokDcNmeA5KRProQ3mNEjqpaks05CrEoBcza5CxtIkTqSAhnIfGTr
 nGP9cGdWtr/WtBBd5iIQYWg1sNhy08xtQgDYQX1GTlfbOK9stdmU86g/9EncYVQRLSj0co0I2AF
 cQyGZhGEJvWABz+tdRWXRN+82hRzYeZksJoazo+2W/2zV/cx9MLBcyKsLDO8qHHv3FhVd6pVM9y
 b4Xdviyl2SUy1Fvb0APUYLfemvBVkhiHAWns9IAnvVCI0Lo98z+szZABh6dAKxbT+WKodrZZdqd
 8N4hlB9JJ46j0v0bG6FY1faA6ky420vKZ2DvSq2E6YGGju+q
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 06 May 2026 10:51:44 -0700, Randy Dunlap wrote:
> spi: s3c64xx: fix all kernel-doc warnings

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: s3c64xx: fix all kernel-doc warnings
      https://git.kernel.org/broonie/spi/c/88f731e79629

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

