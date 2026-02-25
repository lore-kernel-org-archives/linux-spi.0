Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B333EFD1C;
	Wed, 25 Feb 2026 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772046466; cv=none; b=QpzfJomz2nsvBd1sv+VdCAgYXw8Asq7pZTe8/suDGt6s6MOI8C9fx84xOpBKsiT8o5qQ1xOQuZqop8aIEsZaYSvkZOFAR30t6YZY6UV1wQWxXDnAoD2KdTqbaIp+BgwarCTpToPGGKvccPoiOkLaIuFXecki3prwq/tmvexOcHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772046466; c=relaxed/simple;
	bh=NlzHSOnUk9c8rbvQ5YPcEaErRc0oE9Zi9vfJT9liX+Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZjgInxB8fWazMJJMePxfKS5U3LU9KWlO1QYZpt6yqrSI9n9PoZnzpVg6VKJe2OwFwH4PQJ506vF2B84OICzEXtL4GVYFHcTPsfknMTVy/AdclBl65NTp13M4OvAB0QUcdd83/z5LBnyB1bYG3pIDuEIpyo6MD9S6i4bU3lFuQ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcMzGJcL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcMzGJcL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968CEC2BCAF;
	Wed, 25 Feb 2026 19:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772046466;
	bh=NlzHSOnUk9c8rbvQ5YPcEaErRc0oE9Zi9vfJT9liX+Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XcMzGJcLOwZvuJq9b9NUR8zfvh2JgiFVU71xfm4pg1OBoNmXC4XyLOHA7zgE4kQmO
	 MPGD4V9eZb4mS9Pf/IZg+sQ5B0r0Sje2nyD6D5AYw0uTQ+aktX/MEhjRQFqlLi92eK
	 RTzk1XbE8Nslq6yfI+ORwFqI4oqpYLtqO6KkoK7Cv5dXg772kaske72xDwASA6EJRR
	 Lep5QItqFozowPTL53clyh1Yu/vVNbxtLsOvn8qA18jYbokAHLIzHfqqssoC1+O7HI
	 /VYmTwfjb6IVdxF9nBFHsnqwWUv99MiOlx5a4iZuvtP6DnH4rkU01455DzBgqgUKfk
	 HiQ+EHjj3fxIA==
From: Mark Brown <broonie@kernel.org>
To: cl634@andestech.com, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, xiaopeitux@foxmail.com
Cc: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <tencent_65C9C09CBD2B68C400F7145521A4B217E606@qq.com>
References: <tencent_65C9C09CBD2B68C400F7145521A4B217E606@qq.com>
Subject: Re: [PATCH] spi: atcspi200: Remove redundant assignment to .owner
Message-Id: <177204646536.169139.3769749599119720671.b4-ty@kernel.org>
Date: Wed, 25 Feb 2026 19:07:45 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Fri, 20 Feb 2026 10:44:25 +0800, xiaopeitux@foxmail.com wrote:
> The coccicheck tool reports the following warning for this driver:
> 
> ./spi-atcspi200.c:670:3-8: No need to set .owner here. The core will do it.
> 
> The manual assignment of .owner = THIS_MODULE; in the platform_driver
> struct is redundant. The platform_driver_register() function, which is
> called to register the driver, is a macro that automatically sets the
> driver's owner to THIS_MODULE.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atcspi200: Remove redundant assignment to .owner
      commit: fed6e5084894373d76270cad4a32eb6479ad8247

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

