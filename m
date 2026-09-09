Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F287D3DCD95;
	Thu, 10 Sep 2026 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037559; cv=none; b=JsF0cPSDTSsuCjFZxTmjMBs0nabSOj4HoZPxmrHBMm90jvYEork5HdQx1+XZDmpUkd0oyY++2rWyJDiLapje165CeKydyZZguNuQB7cNDMmh6SvLe1IexAXEvOrsfWTnnkautflroxMwVRVb3tldhKtXwRcAiUgNcXVZdJxRjnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037559; c=relaxed/simple;
	bh=gWyC1RooIVOqxZQ+/ACWD8MJUFBcBpF7Fxh1Lm+3OUo=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BMqYnXy/KefwA5F45GDGXPDMK/IkmwC/fZzw6nHTJuqdfojcfw7N+H8ZcFK/Z9khcr4c63gzqN/C6lVFYtlNLnWArhUZ0IWcV4OBxE6CIuiwZdEMOcYdsBpbeY6r8+X+Aj8yPy05xmOarhN6grg0auM+5iIA3UmwVzvi193BaTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+vGaeHl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+vGaeHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D741F000FF;
	Thu, 10 Sep 2026 10:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789037557;
	bh=/6bLEU8N8u5u4X1B/jW1e/oTDaB/QQhtr46eS9kTY1A=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=W+vGaeHlZSeR2FfCcoQFlCCbmjLh0zv0aHXJCDCXomWBO4VjNlIm1wDr53iT6PvG6
	 0iBG1IQ6LjbXsJ9SO5RxE0H1Qgtzm3wBdLbz4e/uihjsK2Gx8bEDpOqngWGz/bfhzT
	 bHfDYM7pN/jbiewpG6JPVF+CaWGadsi69EmROCBi88rbuko9vKQcN/Kh/7hYlI/oQo
	 zlEhWwnm1/lyjSrxukvjvyzE07wKAX01qctM0i9ZR8p2tyQ1uumNR4e09a0epDfy4I
	 N0/oeXwpWP5+YxKmjghkMIOj4zZQd7DFvR0CgwkckwhTVpgzqlSJqhv6wn4QisIua/
	 sDn86WEHusFKw==
From: Mark Brown <broonie@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Jiawen Liu <1298662399@qq.com>
In-Reply-To: <tencent_DD16C0EEDFEF4ACAFAB5A23EC8235D462707@qq.com>
References: <tencent_DD16C0EEDFEF4ACAFAB5A23EC8235D462707@qq.com>
Subject: Re: [PATCH] spi: rockchip-sfc: disable runtime PM in remove
Message-Id: <178896790450.151853.16995360553937973952.b4-ty@b4>
Date: Wed, 09 Sep 2026 16:31:44 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106; i=broonie@kernel.org;
 h=from:subject:message-id; bh=gWyC1RooIVOqxZQ+/ACWD8MJUFBcBpF7Fxh1Lm+3OUo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqoovydzWhB8EcVlc+rCytQ/FylKrTWHnZ2Qb/f
 79+pF/fQ8aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaqKL8gAKCRAk1otyXVSH
 0GOoB/0cE76ty2WLGTc9YNo/NSPeLHlkAEgOzZ0qJgKqDdjIWhg3JAMQQbrHTa3SerIMi0jbAdE
 LwQMxTQjYHLfy4FhU4gfNfb8LjCxMcexdrs9GikjjLjnya7zBG6taciGxWILTByOGwt7FoCLVuq
 WSylERmytm6+LzhkAlicaF/a9zDHDQYTbVCm+JHxBuy7WaKzWbsNlzTdMnuUr5Yigt1fh6cQpgP
 gIgoJCLST0OWA3MbWv5CAsqK/JuiZFuIxjKvcox3IRXTKQxj28nIhSVUWmr2v6gp7HPup6mbQnW
 gDdyleao2HxW61qrv/RO+60g1ZHxxVLeBTqhWQMb7j6E3suj
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 18 Aug 2026 17:05:50 +0400, Jiawen Liu wrote:
> spi: rockchip-sfc: disable runtime PM in remove

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: rockchip-sfc: disable runtime PM in remove
      https://git.kernel.org/broonie/spi/c/34e32e9ade58

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

