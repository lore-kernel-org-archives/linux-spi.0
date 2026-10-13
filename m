Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3D951FCDA;
	Thu, 15 Oct 2026 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067967; cv=none; b=nvAklNF2KGckOifONEHM4Uk1U0BfTYyBWf+Iw3/KsL4C4GmrSsVydiqGRn8lNK/ymjG5PYsXZTuTZJfM5g8jBQWILvig6YK4f2rYvJlooZ4W3zsGRBgsWeRxtG0vMPbN9czPAjpprhLQFuQ6BPCb7DV/Ybwiu4sG9TMIeoore50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067967; c=relaxed/simple;
	bh=LDBwkxQtLdasR6nBZ90l2HkBjGzcX0YOg7gjUdypJq4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=atcN97st+Imh4dFYAVcE3zuj0YFx7Jd3tOmeuAj9lZT8Ox9V2dOu143p91ra8OxOFwDXYx4lO4myzWfycjuKOR4q+QzdbQ8L+/4SK96b7JPRy6ICTVgNWZ5xHoJ/Rf6yn3O2e8dAKE5IB8GjpfpubMK8Y2kWlZHmj2NdifspOUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAKn7WkR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAKn7WkR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5A21F000C4;
	Thu, 15 Oct 2026 12:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067965;
	bh=Y83yhECve1p2yl8vALSAYtMozaLJO7h/wNxCpys7L3k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=AAKn7WkRM7+oGX8OTfyps9QU4M88+VnmVUlobf7NaNKIhghy14Q3zL7RKTOcD1BQW
	 3XAg679Pb8458AWxhcG/AWyxCgy6lIaE6zea8WDROGxsxeop0WL/999Iyeec0l0IBq
	 XSJWV/+5/wt4Y3FQQIbUxjOSRNXQ3upzh1Cdrnish+Muy318RAC93GhB/lnQjCW36F
	 DwbkolZeRUUvm4Bc1xJqBIYxqhyQUEIfC6WsHcOe4y0HKmZbcs0CwEfvnetjH8LPUA
	 U9MExaRrFjkT2Qh5IuZYDXTkV+LHDIwo/yDalJ9eLsqBGjodMGJy3Y5CaFNeofixGr
	 7AJp0w0rAkICw==
From: Mark Brown <broonie@kernel.org>
To: Aayush Kumar <code@aayushk.dev>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261009132421.557758-1-code@aayushk.dev>
References: <20261009132421.557758-1-code@aayushk.dev>
Subject: Re: [PATCH 0/2] spi: use devm_platform_ioremap_resource() in
 sh-hspi and jcore
Message-Id: <179192102589.1606900.15922470872696683091.b4-ty@b4>
Date: Tue, 13 Oct 2026 20:50:25 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1503; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LDBwkxQtLdasR6nBZ90l2HkBjGzcX0YOg7gjUdypJq4=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIunKzmmXdOJ8D8UlYqc51MsdjCj1f7+7eeibiuXeGS7
 s4g4rq7o5SFQYyLQVZMkSUui/tlfcnrNXwHF7bBzGFlAhnCwMUpABO5u5Dhr2ihp2Hpq6SXq55G
 lNxbczlzZ/uz2FOe6/98aMlXP8rK5MrwP03txco12XyKLGW/5c6UHs7oLZh+TfPD/FNhsSn271V
 n8AAA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 09 Oct 2026 18:54:19 +0530, Aayush Kumar wrote:
> spi: use devm_platform_ioremap_resource() in sh-hspi and jcore
> 
> Convert these two SPI drivers to the devm_platform_ioremap_resource()
> helper to simplify the probe paths.
> 
> Aayush Kumar (2):
>   spi: sh-hspi: Use devm_platform_ioremap_resource()
>   spi: jcore: Use devm_platform_ioremap_resource()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/2] spi: sh-hspi: Use devm_platform_ioremap_resource()
      https://git.kernel.org/broonie/spi/c/e796a187fbe3
[2/2] spi: jcore: Use devm_platform_ioremap_resource()
      https://git.kernel.org/broonie/spi/c/a0b70663dddf

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

