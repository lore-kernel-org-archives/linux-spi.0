Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DD247668D;
	Thu, 30 Jul 2026 23:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785453663; cv=none; b=n5EsL2+IQSzVj/e8mCqQe+XC+MEvL4QarRpK26wDJrHE4sL05G3cw0SwAByl5UX+mIPLDLmHQ4xMukF2WkYkJ6LXP45XnmePIqgEbtLWNe5c+sUBE+dDGQm7fiU9sJ08P5VGPACaIEpOd/EvSGd8siPSDPnPsSGipYldAQF5uDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785453663; c=relaxed/simple;
	bh=lTjeIJODihPxNOoRr/EdCPLcL8sS6bLrlCy20+SH4QM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kTl6IZIy07PXhCDm579ldP/4Jhmks7eM1GQAA1XWJZS0dZFoYH2CvXIVQS4lFd83xBc/ADmBEQlBLkG7i1LC6Yasuy7AFaV6E6KIwQ/kdyDcHbXyaqdNy+SqUW+wb68cDgIJjGngKieNbGQBpWXhzGTq7y2SlxlLZSgY0Ehg/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiNhH6IZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiNhH6IZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999D21F000E9;
	Thu, 30 Jul 2026 23:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785453662;
	bh=HOyCA8LYiRhLswBVvOVh3aPRMqRhfdQlRRUJCJz3lhg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MiNhH6IZuaY5fpm8eEhDahDNNgXzCSlZNTI0ags3V9a30jo9lexyIuTnhwkRZmAbM
	 ZsjbV3v4W6toJ0ePY7XiaLIszozCnCWSVdVILcprFtN3/ME3Yneu9HZ/ZQNHpjUs+v
	 fO69TxYX5r1ShY6+LqqacMAC5X9fooxm5HnL8w0dHrHMPfDA77FKd9G3lckyCsjgbm
	 dXHWcqim6iNNydjjoc5sO/Ty6yBVNgBvoHIdHgVpQ3EBatPVB80GK8o98+fu5fOawR
	 ZF/NDafW4+UczVHNyN3GjFxV0HdVMdnJkojRZP8F7nQMaf2zXYboRt7Oz/BB3Hn4C5
	 TjvEWt+OIptMA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20260728202932.16207-1-rosenp@gmail.com>
References: <20260728202932.16207-1-rosenp@gmail.com>
Subject: Re: [PATCH] spi: ppc4xx: use of_property_read_u32 for clock
 frequency
Message-Id: <178543704938.343356.2011559351597517269.b4-ty@b4>
Date: Thu, 30 Jul 2026 19:44:09 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev

On Tue, 28 Jul 2026 13:29:32 -0700, Rosen Penev wrote:
> spi: ppc4xx: use of_property_read_u32 for clock frequency

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: ppc4xx: use of_property_read_u32 for clock frequency
      https://git.kernel.org/broonie/spi/c/26bbeaa8b3b9

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

