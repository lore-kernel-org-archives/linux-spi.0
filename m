Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05493DD855;
	Fri, 22 May 2026 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779445351; cv=none; b=onKqn7syxdD8iUrvIohHjkGeAOAhzjksYpI2S/ln4Tv0cCnYTgeOFMe/uIugTBDGfiXdobjjDmkcsS8if+X6tTpgHPlBrdl5F0qcYZF0Sd7Np9eHaw1YBe0Pkh73fcfvxpilDzyhIXd85s/aXrXviwpqUosjl3WKWQ5E/hPi7dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779445351; c=relaxed/simple;
	bh=ta1sVBr7RmToFKK8+HZmAYEVF2n6/EjtlYET7sKzcCw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nJcla6QHK6NxYOq8W17WYYD/8XmJXHrQBciOkGEEtMvRVeKRipJKXTDFLuAKsJcuZSz1AR+OEEPSsFgpoEKBqYpK3+4PfpKStAgM6+xz5zKiQdfE7NqonAQD98nRXtj9JxfGDBeXlEuC4muJfD5/F1CgZl8J02oM5cTv/UasbjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofmF39OP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofmF39OP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DE11F000E9;
	Fri, 22 May 2026 10:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779445350;
	bh=KKtDoz8qCZkBzyg13tyo2HMVf1uWZqHeRcoBKO7vH24=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ofmF39OPa8M2J6r9CCuSMXRYZy6GDpoxz7OE9Ab2+4slbw5jvyUh2v3I83UFnC5q9
	 e4qVPZqmWXAa/qtIgH9FaTcncbHnTSzM6Ktm08j5Q667GVRuoZaFeszccos9vd8Wd7
	 eX5Ut430SfIX6OvykPp+w0ZokWutV4h64zSC6apDQ/tuRlP9iCxSMFzrXymzJJfe93
	 0RmBvH0T/YlD/PxyMN3KRkMI+UzjfmYNddgtbRUzPBBanccKXpYUxEarvA+uLpRkn4
	 VDY/iCqhBr3bJm4WeU25nkRlq5jhIL8fWP027erKYrjauxzet/0GwG5lzsFNWjv6gR
	 5EYNpWqUP9kVA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20260519005614.628437-1-rosenp@gmail.com>
References: <20260519005614.628437-1-rosenp@gmail.com>
Subject: Re: [PATCH] spi: cadence-xspi: Add COMPILE_TEST support
Message-Id: <177928683361.56665.14448521617760516288.b4-ty@b4>
Date: Wed, 20 May 2026 15:20:33 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ta1sVBr7RmToFKK8+HZmAYEVF2n6/EjtlYET7sKzcCw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqEC5kcb8f7Ni5wgPL9LJKR4/CKf5sHpq67Uiur
 6hd4Qsn6uOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCahAuZAAKCRAk1otyXVSH
 0MrhB/9tkKE/++L9uBb+/Utr3FyB2+w16JtOkA334dKSp9OdPpQNmqcsbVxLRiC5NFHVNHZaW+s
 G4G5K8AskdimDVCNDrtys5p7A+0NVw+SSpLh3UH3Ldpc9tdBUeCh+Xb1ASkzOWTfyQ4CuDMeK1x
 CWiEaK8SY5vhmuuBDeNZ07EdoXOMLlwZv6PVwjqTUwPlBCAeJZOU2ApzMOwNO18nwfX4ueydXcD
 BNGyzv6wf3SWB+P2VYweuSz4ZAr3elLh6XznFgZoalU9f+9ziLAWQU+QzP1daftWQXiU30PUG6r
 wX+5Ev8mxauXZaLCCI8wOA0e0VZmPm3dYxCM/72J5x7J+NI+
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 18 May 2026 17:56:14 -0700, Rosen Penev wrote:
> spi: cadence-xspi: Add COMPILE_TEST support

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: cadence-xspi: Add COMPILE_TEST support
      https://git.kernel.org/broonie/spi/c/0c5b5c40dc31

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

