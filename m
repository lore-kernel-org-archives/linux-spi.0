Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620207;
	b=SZkEaZOu2YLtROVsXX+eLzEjlnFhVQP7eajnOm7jHc1dyY1/jw1K+LJ39WfTQFrzXqDZ
	 TjF3Lh0ZpB9WIgCDzh7UUgbq/z5HR2BE44FF1/TGmMFdmmxw0GK+ixeYcaN83SyyEodOD
	 AO/AWir/RYLbrsMdEoMx98Z7RoGxvVK33jgJaSxZMCfMtvgF86Q8Zkqsvqkk5zR7FVE/M
	 ahjTSYSSHk1eqnuiQygTW73u9r2XYeM0zF4TVxwZ0SavAckjZQ01lfVDa5XChEgCzlCIV
	 AfShxG0nYtnXJrV7rtv7FCpG6lkGFZ3SIRQTzsax+GhY8yUflN868kpJpSSK2dRmZ8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620207;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=r1YBU1+iu0l8tYan4eL+nnBIwd8k/sp8BHpQeT/rA0c=;
	b=LgS9wa15/BCC0bQmN9I/e1M9xCfSnRlA0gkv+0Qb2PetuQ4p01bTk3dyGGMeLYbS5TFK
	 abfKz5PjVSIrQjFa1Tq3XwFGLfCyC6ntd07GiKCu1/CWIfdwzxek36IuMEuPpdgWbvnik
	 p/gTFw6EHztwTlqHV+vD0aYCpmI1Ra07fm/BnUqubrmqVI/5dGW/aOlABCPC8L4yArxGu
	 YHPVOCg0m5nNC2s7xLojw5mJyiQq/YKbKMgtslCXdiEpOAKzJGCWPS8AXmvAZprzODhCZ
	 YY0d5/n0nrFRPO0hKCvGh03F2/V7xSpaxm+oOE7Nv2tCZ1pYZjdB56h1G2RSnkA/AVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpgBxqxi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81110606A330
	for <linux-spi@vger.kernel.org>; Wed, 25 Nov 2026 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpgBxqxi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A331F000EE;
	Wed, 25 Nov 2026 15:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795620207;
	bh=r1YBU1+iu0l8tYan4eL+nnBIwd8k/sp8BHpQeT/rA0c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gpgBxqxicrO5O90kzGS0aGhEdhJE5GFoa3+tkdFb2DDMQ+Q9kOgDqIBcPkTU/r7xw
	 0nbU/MLN1ZUfVGNzkb1Gh7O2aeJKQVyAqXDtWH92H3f6WpNOIFQpQjOnGdwhFmg5ce
	 qLJ22e4EbDvaMO5VLPsH4LN43qeR70OtZDt9tJ347YTlWm3ZLH1AXGRMwi06bb3tem
	 AJbcWmlxq5bobjc9WFV9+sOTI34IymvaBJlNgjkhjOGy40o9QXlUzzNeuMPPv0MMco
	 EmMGm03t03W9RgVC2cepLgKHmXzDfl8zgSoEAMzTCMuzSEgOdGQFsmumCHNToujNsp
	 SMOExO1qHCZlA==
From: Mark Brown <broonie@kernel.org>
To: Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org
In-Reply-To: <20261121-synquacer-v1-1-9e14702ce84b@gmail.com>
References: <20261121-synquacer-v1-1-9e14702ce84b@gmail.com>
Subject: Re: [PATCH] spi: synquacer: drop redundant IRQ zero checks
Message-Id: <179554634841.947306.11844924678046939156.b4-ty@b4>
Date: Tue, 24 Nov 2026 18:52:28 +0000
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=broonie@kernel.org;
 h=from:subject:message-id; bh=i/2XsnwNM745NAjfzJjT3wN9xylVnevqiU7hKI5wr3o=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLZ/uaozHEofnsm1SFq+t/GPbm7N1icKpuX1sO0Kjx/6
 /6TuneedJSyMIhxMciKKbLEZXG/rC95vYbv4MI2mDmsTCBDGLg4BWAi/d0Mf3imtMY8XZji7B0S
 PInr/Mqao2LB82ovlG+d8VR+U6Zuhzkjw6lDdon56d1yvzk/+/578To8aWP5g+1q6yZZ+MsEfzg
 mzwoA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 21 Nov 2026 00:13:26 +0800, Felix Gu wrote:
> spi: synquacer: drop redundant IRQ zero checks

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: synquacer: drop redundant IRQ zero checks
      https://git.kernel.org/broonie/spi/c/c55a06351b84

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

