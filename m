Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AEA3E63BB;
	Fri, 22 May 2026 10:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779445396; cv=none; b=QH5i0oh/EnmYgOggxxHL/KUiUaaJgU14f8QTFzSjnmBDlBCZqPyJN4h2/6/tHOkeZKfohcFscwBW49EZbQzFGFURlN6WKLLzgX+ajK+MsGRR+bmUXGctU5661zbO0eGVLGH2kaRvrfxqwINYbEDONwMUV+/j+hA/XHzWqV4YAns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779445396; c=relaxed/simple;
	bh=M30MQAYJTh41yAKcTB09gBmSyuqEQ75eQMX8gVU5RZw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RS+goToEzkF2UaNjuqocdWOgS4/vIi+2joHHys4AHFrGmG0jmtfZLwvQo0ZmwZYQd9lPLaJIabhynxAywrZIlno3R5AjAjgTM28/Css1VbkKRd9H+RlvQuL3QOIww4O3D0kFPa108J6lPJhth/LC8EGiam1DSX012AjunXXJllQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3oxMe6U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3oxMe6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88ACF1F00A3D;
	Fri, 22 May 2026 10:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779445395;
	bh=LyeUchKIQI4SJnszdKEbnlVUimRbWYcc6UVZ5KbQJyM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=i3oxMe6URzR/dk59FezJistOaD793EhxQB3k2svWsFYKZwHBS73BELeJJMl2ZI9eX
	 oEvGK+V9r1wgC9D9OHr3XUpKz4FfS+YsunOL3MTQdSOsAseta0RfEzK5H/STJ6wMh+
	 UZgpV1OiU0ACEBofW4TtZUZNjPfwbpTHfmNG6mNbb1rVg8U/SbWg/D5F39/2nYQDBK
	 BLgxXarIHIumK0L0axik5xWH7sAMxpuYSFYDXDSkMK+FCI7WCIRzARLtr68BGQVzxc
	 wFllXVjykUzdlKB1IqJeRS7FyYpxgpNoWmiNmLZKgkD+yGeEj1a8JE0FWd47fysc6O
	 4hOyx1b/v9N6w==
From: Mark Brown <broonie@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260520091342.68029-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260520091342.68029-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] spi: Drop redundant 'cs' variable declaration in
 __spi_add_device()
Message-Id: <177937959580.58022.8648721880810106781.b4-ty@b4>
Date: Thu, 21 May 2026 17:06:35 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; i=broonie@kernel.org;
 h=from:subject:message-id; bh=M30MQAYJTh41yAKcTB09gBmSyuqEQ75eQMX8gVU5RZw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqEC6RZZQCrJvEzmZQiy6UipB2RaRUq3XAwrGqa
 2gJEpSOowuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCahAukQAKCRAk1otyXVSH
 0LZNB/wOZLJaZ/RQ8VvMl+6P79UPXV1LfM4NN7Yq/rcDpgdM78Y/bnRidUtrx0c1HFNCosMTg+4
 PUgwxMOrFZiQqojMcmfxSkakgj/NTXG1ESxWheZADnk0zzFrKjA/53aVfAxBa+F9z8pTtoU88z0
 FNpJubLJ88cWZeqoI0oKOYFu+rqvMgMq8FMZxiEZhKCA0lmypuPBuh5pEpKyuWMd/FmzsQqUlEV
 bvU/vukDwDZ1rvUrPebovxgK9zjSzKLbO2aG4wT6KqaNhqswqqvnlllJAtCiOAjJzQux7bH0Ns0
 zM77ZEjY43pxGJn6aiPllSqSpTZ95AxG+dUwk4Rzf0zOzn3c
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 20 May 2026 10:13:42 +0100, Prabhakar wrote:
> spi: Drop redundant 'cs' variable declaration in __spi_add_device()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: Drop redundant 'cs' variable declaration in __spi_add_device()
      https://git.kernel.org/broonie/spi/c/90330ae4e0d8

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

