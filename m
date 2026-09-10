Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ADB446BF8;
	Fri, 11 Sep 2026 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125533; cv=none; b=W+1vSopZegWpF6oOFAyT5fwkQwK4LekvwbKgOIDeEUrDMqIGh++x3Yc7B7JOMxFyi68UN8LY+n6GIJtIOoQFgvMimBEMKSOwhYZMGLPo3Qou+EzU2reDngG0bvFtb9oDyfcMroMjceEys/PyZqLq8rPCWXbDtAsqp0Ym4GTfx0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125533; c=relaxed/simple;
	bh=HHonxb5QYOrYSkxg6TUvqj9BK7ocQJJuS0im2hhiSA4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cQC9iQgbIugnlc38pVzGs74j09K7JUZwIh2u0fnIg1JmV36k756PaYr7nxy4cp3RrTOgMYU2Iex1UTp7wzZwURSp0LIMT2/e0a8lkUo/1CsTvKl0e5ZEZY32K9IRlMTcfL/uncQfelwIBoMQf6slxAaedCVk3diicQAunsXO19w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+6TCLSn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+6TCLSn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970641F000FF;
	Fri, 11 Sep 2026 11:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125524;
	bh=QJlUxYHcjaKHTGKfBDkdNnOkAULZJLpbGkRJOx2TNs4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=L+6TCLSnPtXfFhV2ujHqNUac1n4Tm9LNmGCBaqZ/E3HXrjS8xYDz/ywGcLNZna7wS
	 e9XkF3zRJeFvk3Ht3e4aeoQP2LglvNiFvgDZvWU0IeTVa+hasqKNe5ORqWVbdDALtM
	 082Z24fCzVstr1AtIFJIPW5snwQfM6LEVSsNH+BLtR8pgi5e7fyIAbhOHP8ADHgIFO
	 TqkdNGGJuKvpwQLc86pBIsXbhnZz+XSwXoYyUhol1bmun/nbYDvIlCF3CcKtf20tLD
	 PYqIBGeTklXakq71VBfd+1ye1gcKxvC2gBYj5z+CpNOKuPJXoIR3/D+dEz4ZtxSeHE
	 299XHjcRKgm0Q==
From: Mark Brown <broonie@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
In-Reply-To: <20260910033219.15996-1-kmehltretter@gmail.com>
References: <20260910033219.15996-1-kmehltretter@gmail.com>
Subject: Re: [PATCH] spi: docs: Use the multi-lane mode constants in
 examples
Message-Id: <178905193649.87467.3677779396896911161.b4-ty@b4>
Date: Thu, 10 Sep 2026 15:52:16 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev

On Thu, 10 Sep 2026 05:32:19 +0200, Karl Mehltretter wrote:
> spi: docs: Use the multi-lane mode constants in examples

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: docs: Use the multi-lane mode constants in examples
      https://git.kernel.org/broonie/spi/c/6ca4474f5a36

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

