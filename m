Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D82D3F20FE;
	Wed, 22 Apr 2026 19:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776887887; cv=none; b=azpR75q2zo3UXkuv0BD7jELFkaJKL6rAhqJ7vZzPoRp9rxf/LrXQEhvjGEHVM+o1weo/4lal6npC914fKZ9p6z98QRuWMyt/vmwcW82+JKNJ69rU8UFXs1zSR9AUvNUdFFI5oos+UaShNsKLQXS5Y7jP7CiYpwIdN4NKbpYWkrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776887887; c=relaxed/simple;
	bh=g9n2RgQXS8Q2QvweeXyi7Enkagygf++uiZgF6NwM1hY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JTF4db4KVxeyWKCs4YY1Mg1ImL9C/RlSsuS6EaSC7s8htRn7hJFM2XDRsNQRR3eLz1JZo5aqC2/8d3sVjo3dDOgoAyyekiqkgzFZhxxsm33D1urreuyUyN7FAy4bNtrMRyReYRYGH4YudIQrWavA1n5u8UAk9vwqu5WG2DCmWrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mugctKCS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mugctKCS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A35C2BCB3;
	Wed, 22 Apr 2026 19:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776887886;
	bh=g9n2RgQXS8Q2QvweeXyi7Enkagygf++uiZgF6NwM1hY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mugctKCSW5iprpD1vaeJgMDmTqyRRTpxKuHDzjjhgpp3KUkkVgFZtizpco1IKH8rW
	 kSfY4Y0srMk2YDNZuae6WbQnsFdvui803MKSCanobuaJwhXKTyjua43BvLr9CU2RQY
	 OAuK1Eif7bSv73O8wNHl+QT9hneu3ZeZ2IO6QzoiRgHuJTZeJdrToezIZFj21SnE/p
	 m7JSPXgCUSVrEF+jneC8ed9f4ObWr10x0EEYO1fYfLfFh/HFh6d7s3qepVxyfle6f6
	 ZXp3wdSmxsqI/GcRJvRDfinCVkbFkTOpb/KdNzsOaPSrt6DD++Rc31SogQxpNIkArF
	 3jXMjOxVb0yjw==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20260421125800.1537361-1-johan@kernel.org>
References: <20260421125800.1537361-1-johan@kernel.org>
Subject: Re: [PATCH] spi: mpc52xx: fix use-after-free on registration
 failure
Message-Id: <177686180674.36226.15735198170058850286.b4-ty@b4>
Date: Wed, 22 Apr 2026 13:43:26 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126; i=broonie@kernel.org;
 h=from:subject:message-id; bh=g9n2RgQXS8Q2QvweeXyi7Enkagygf++uiZgF6NwM1hY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp6ShMt81gU62ZZAuks/z6jd5BLvkZqre03IA/r
 vlnkdzGHhCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaekoTAAKCRAk1otyXVSH
 0E5eB/0dAtMMxxs/3bDTMhXJlfCimKYYRoCo41TWTk5JrBrDC5atfFHN4QfcYO4WQzHdGQcNaRp
 xusimteI+7/uefNx0PvdPjOfAbSpj7qE8wceVrns2HDbZZaNN5/65NwKnYqWY7PnM2DQpauwHyR
 dXSbg9MDMp1UpXh1ebzl1HBdxO7GQI+o4ip1Xo1cT2OnngFxDBjPtquqDIn0SlZD96f2YsJsSdk
 danghdGhhYaqe0WW38ZbOeT2a5D/YgZgwPgDTayVDFT6Yd69E7wG/+Ia1vY1luytJnl01bGgX41
 oHgt8hWlQW54ALfIsY+sJwYkqxJ8QmSdrFwfrThuEL4npocG
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 21 Apr 2026 14:58:00 +0200, Johan Hovold wrote:
> spi: mpc52xx: fix use-after-free on registration failure

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: mpc52xx: fix use-after-free on registration failure
      https://git.kernel.org/broonie/spi/c/f62c060272b9

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

