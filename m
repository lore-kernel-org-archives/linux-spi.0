Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9FD51EE00;
	Thu, 15 Oct 2026 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067960; cv=none; b=TSGZBCoRxZ+ZcUw4GzC83oezL9pee119OY/2rikeo/7IC0O5gkikgsaYBrc8FHaQuUFb8axPUF88iTprzyUqBILtlPBezYzpozvZpcCSGlWgMCCEutA6ewWl7ylz9EPmstro2+YDMgLM+pfIabjxbBUuN9TraDT88nM/+3tLSww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067960; c=relaxed/simple;
	bh=oU+aflSH8ieUXdoa4wTiNkL+faVHwEFgPlXfrXSVKMU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RGyuzMJmTx3DTITLY1RhpJdk1zBlYItu42ZU3yaPNYuWFhH/BJ8W2XIzjrGRJqaPsMEWaaqu7EOc3ymFNcoEw6bQ+kQfljGGyHrADDaZjGj4cdrDjSBqn5zdT5jFiGTwMZhZyUZxMMH4xmRZAWHnKwep+5J/uF4/5cbtUFagLGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y45KVJ0d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y45KVJ0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433BF1F000C4;
	Thu, 15 Oct 2026 12:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067959;
	bh=lBq4SZEcwNj1I/SZaHaY4ubXn6ev37pFFkaWpeQhOVU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Y45KVJ0dmr/B5PkXwhasr0fP3fd/QUyN4JPjsKxxqeZlERH+rLc1lOkvysz1c5vdq
	 AUIZeKz1BsFhnIXwUJVpwpate/sKttVq2HyHOFb60wV1vVj8iApvAJ4Zp2wiZhVyG5
	 HFdtNFhDiwytCXy2YKD+H31gsf/NLqz5DyxkJlBWNM3E69ZXEYx3xW9gFnn83Cd0W4
	 H16iXDPiV9JcVVkTQ+ntsdOQWO+qxCsfRd9dQbVB0dVZPfx+NY0/tRcA4OWG8CSmDl
	 PEnbzvhU5fzAXJJRxpUKQYAQARjXwTASDly/qCTZXhmTPa4qgM3/Inx1ULtvJPV9d5
	 LLtYLa1AuP9Hg==
From: Mark Brown <broonie@kernel.org>
To: neil.armstrong@linaro.org, khilman@baylibre.com, 
 Hongjian Dai <daihongjian@kylinsec.com.cn>
Cc: jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, 
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 xianwei.zhao@amlogic.com
In-Reply-To: <35143466F2F5166F+20261008124704.87708-1-daihongjian@kylinsec.com.cn>
References: <35143466F2F5166F+20261008124704.87708-1-daihongjian@kylinsec.com.cn>
Subject: Re: [PATCH] spi: meson-spicc: fix invalid DMA unmap on mapping
 failure
Message-Id: <179192404716.1606900.7933098605518290477.b4-ty@b4>
Date: Tue, 13 Oct 2026 21:40:47 +0100
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
 h=from:subject:message-id; bh=oU+aflSH8ieUXdoa4wTiNkL+faVHwEFgPlXfrXSVKMU=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIunCwutjhRFrGLs+urCfstZd+pwgXPXj1SX5MqwXfgz
 AR7tfPLO0pZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCRDAGG/6lCmpZbVdU8Suz7
 jdffbvwtsa/UvbCOVa+n55x5jWryMoZ/mrxqcQnrN4pI790z4Xhg+2q3QOPmS3fEXVbM+sd5Wju
 IEwA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 08 Oct 2026 20:47:04 +0800, Hongjian Dai wrote:
> spi: meson-spicc: fix invalid DMA unmap on mapping failure

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: meson-spicc: fix invalid DMA unmap on mapping failure
      https://git.kernel.org/broonie/spi/c/9d71f9fe5b5d

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

