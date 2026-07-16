Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6EFFBE1;
	Sat, 18 Jul 2026 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784334205; cv=none; b=pA4LgSeG3scd7qoYlACmBqOa+lvLlBcGnjYvQ8fwIKqDBtKY2dydvtMGUgBT7RMzC1YZFx+PL+sKyTkSLQe4HgdYcf/zP58diV45oEMOTOUP04LNlOEBUB42cl1Aje95g7BEBAs1vouCFQe36gi7EdNH+wueYsVkBqwmogShAkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784334205; c=relaxed/simple;
	bh=ZLifpG7icI9PqEEut6ouhRKp6wmS6CvhjoNbhSSnV2o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gsz25AuZjMIeyUn097R4qt1Hhgd1XTmleoFVIawROmiviFvCr4uGY0eBReNQszZUGSdKdgxu85ivVbRi6A+B+s6gRmS18g6fvVKqlmYBJpzzIfRCeijQ8qhi7e/DpzuX/VmNjiNl4LS7qbhg655AaiXcRKy7mTxxqdSJWFIJYoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7wdkFMP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7wdkFMP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA161F000E9;
	Sat, 18 Jul 2026 00:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784334203;
	bh=KWd1tvmgv0UYrgt/pYkzyfFYKRvzyH/ABVaUgoO59CI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=C7wdkFMPxCj3t74nAY6WOvUaxLw+BQR7Wwe4gYHgPAqWuXfZVYBxOx9uDZm5OygLi
	 KmifjgiS3aaveDtAGwpVFRH70kDluwPrIK5ZKIbTfsAJSxjEhe7EojFiAQfzIEdhKX
	 OefcXNCCadUr52RAmZxxLB1V77gQf6HnX/r+6Q9ikytW8RfzR4PhThQLjJpAeLuxkm
	 RpHS1iwqEda5HS/P0GX2J/QHh/LyjUBZqr9IN9/QE7ll9RRs9uHk46qfA7BwfRW1VE
	 gLdN83I3x7f2CKFFNHR+kZxJqBBQ7vCBca2qL9lT4uMBeiU9kWcB3oy+WQe2Ji1xY9
	 lSVbcSb2EFJNQ==
From: Mark Brown <broonie@kernel.org>
To: Bert Vermeulen <bert@biot.com>, Birger Koblitz <mail@birger-koblitz.de>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rustam Adilov <adilov@disroot.org>
Cc: Carlo Szelinsky <github@szelinsky.de>
In-Reply-To: <20260711083411.45836-1-adilov@disroot.org>
References: <20260711083411.45836-1-adilov@disroot.org>
Subject: Re: [PATCH] spi: realtek-rtl: change to __raw reads and writes
Message-Id: <178420684300.63368.10149032349840537073.b4-ty@b4>
Date: Thu, 16 Jul 2026 14:00:43 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1115; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZLifpG7icI9PqEEut6ouhRKp6wmS6CvhjoNbhSSnV2o=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqWsd5TjaOzT57HcIqjKTINkoiJouljnfSTxhLm
 r3PUbirqHqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCalrHeQAKCRAk1otyXVSH
 0GR6B/9MgLDmLfdL1a5CfD1xqBoxlEsmXLMSwyoIEFDz1L9Ox43CL29AUXDd2TpQL6GN76tOPIi
 fZevsTQS6+bFo9PKs8PU50e94NAYmlPIF3+rayuAkPPb2qpJzLv3o6WRvJ+9ezqGvN3VuypAAvC
 z+X8iD9XbG08JHwDQ2b16MgbB0lOn6lBkpaaQ9KD2/78nB7kr6u9XQ26D+YxMaKeTdcYlcrGGxk
 4z4psGHTgghhMTA2k7bHwlsYzj2aOkvj0R4UPtury8EQB/BI3fu9esIveUyDnuOftAwC9cszgQ5
 sIjrTKhvPJT+mN9RJRTZTEbk0bcTWsVH/CE7EfKCVY+qkjPQ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 11 Jul 2026 13:34:11 +0500, Rustam Adilov wrote:
> spi: realtek-rtl: change to __raw reads and writes

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: realtek-rtl: change to __raw reads and writes
      https://git.kernel.org/broonie/spi/c/4bc5a274edab

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

