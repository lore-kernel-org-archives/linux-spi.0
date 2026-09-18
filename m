Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CDB3128CC;
	Fri, 18 Sep 2026 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789769500; cv=none; b=lD9DOUFjuPd34bnYUZa37Lv1a620qOI2fXmyH1aVmX2E8c2A3132vMAvUp8VEN3DqA9GPOKFn4EU2mdJaUqV1OQVzDIqiQUy1I8LL9fY94AWLqAvGTLU/AyyQox8NxoJA//GVdCPp+ZJ4lvFYL7F73dWTb6+YCy3KEaiYS52EYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789769500; c=relaxed/simple;
	bh=7kxXDaDEQZmUvt4br+G/yqf8kHQq75vJKnHcpEfiD7Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HbU0o55ZBcqimoFW/+zkRyT/fokd/hXUbLN7ntdiVpGnONZPcyPNFqFoXdjAycQ+M7L4QaUvR1xrNQWbfTHylt+5U2O0uzNUXXzroUVUEgjo1V05M4EnHLMw0Oz2WJ0KxW01bggG4DRZTQYTrPEZWWSA2MWAXYIijyUjihizqbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/lhkJl4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/lhkJl4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB011F000FF;
	Fri, 18 Sep 2026 22:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789769499;
	bh=W1Bk/s7i2e23Sgy/3SD02POTTRVtctg17RCEIcoufPo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=f/lhkJl44olVyTCOWDbwpFX/ZQRQS7jW0yuCMiRxUllrxrXLh+sWYyDitr8khPbVl
	 5pOIf47Z+MUcv0hwfx+SnfFbkxSGSqGyhRtdnP7ZVnEM/DQ/s64pAbmFWM1Xii1bPg
	 YoCjIrYJq7Dft1QbmxVtdsmlLr2LeGyBRTTEZgDUqkcJnV8f9EqdH9T1nYaKuWgyYK
	 x2DlSpvNW8bNlUSTQ5au8B1vQbf3at9F3fv5di2fNW7ZxJlhYKqQ54r9QdOIg5KDVr
	 CvlS7CWQIqOvONHdiAGnNh3Ocgf28HQsSNf4SQE+hVe2N0MRtqgbUlZtUqZ57FHDT/
	 YtqTxgdAzcZNQ==
From: Mark Brown <broonie@kernel.org>
To: Boris Brezillon <bbrezillon@kernel.org>, 
 Mason Yang <masonccyang@mxic.com.tw>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260902-mxic-v1-1-76806325826d@gmail.com>
References: <20260902-mxic-v1-1-76806325826d@gmail.com>
Subject: Re: [PATCH] spi: mxic: fix ps_clk leak in runtime resume
Message-Id: <178975478399.1812520.7433537791322074523.b4-ty@b4>
Date: Fri, 18 Sep 2026 19:06:23 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1098; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7kxXDaDEQZmUvt4br+G/yqf8kHQq75vJKnHcpEfiD7Y=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqrbcXQVHLtB2QB1/lM2Hll+F52MAbF8RMsLKNV
 mEX2MOU6Y2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaq23FwAKCRAk1otyXVSH
 0JNrB/4taduKNnR+nmCjRhU6IXPQ7/HG+WbaSLJ0SkHusw7w8Z6odr7bYI96V+JiUDvWPfp9qOK
 7Vvm0H7dxH7OspyX5TsNjUyYRfoDQoBnTQfhV+bDdL1SUF7Clw//n0tp4O+3bW3ta2teRaYHj8/
 4XxxJ+ey2toxuSi98prDptpupxZn9ctvnGqooo0XThkOHvK1pNjCQzbcm3ST3p4vGcPNmaem3kB
 Uk0Nno2rAK+zgid9J/Zv1Xk/WZi4B7fsi5BWrm6pQXtkBIm3jM6lmPRp9cGI601/LYb3QTbtNrW
 8d4MJ0xYLc1wiQ0I0ZQ68NpoyHtvrnYkmV0LZM90dYqCI8kl
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 02 Sep 2026 22:48:09 +0800, Felix Gu wrote:
> spi: mxic: fix ps_clk leak in runtime resume

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: mxic: fix ps_clk leak in runtime resume
      https://git.kernel.org/broonie/spi/c/648e3c436032

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

