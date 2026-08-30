Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0F7406261;
	Tue,  1 Sep 2026 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788296945; cv=none; b=aTKGqlPqtMGdI+ptSRipwE6rKJ9IDeQiG0qr9S8ohF7bIB9rIE/7j3ZJlixPB/xyOLC+UgUqZm60UullJvTCjtCuRo1vpXIz86WLm2/ME/cbH0yqQrl2/Ifz5LTTvR6E12SzNjVlRMaOeIek2ntRNCcLZ7WuorjHPVMNyOGKhpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788296945; c=relaxed/simple;
	bh=GLcklj6qLIp+nWJbUd6zXIgEsBhhkvooKqgSxHth9m8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZjXQzPGqiBlcQWdrFBDkj2RJqYXRHqQfO1gNIvnhNGDArORj+wttKrFQg4X3ClY4d0DcSzN1H5si6pcXWsl0bBGs3qszVEu4xIhVBTKYQkjS9Lmdd1QEhaXIlM4oVquDtXYd+5plYA8LPrpDprTwn21ODXeXOw69URZoDjmkqkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4GFMVTS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4GFMVTS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8C71F00A3D;
	Tue,  1 Sep 2026 21:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788296944;
	bh=eVjH9lat57y5/U8gDPOxhK4QGvgeHhJB3V8fRTXqB5w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=A4GFMVTScBTHngzyWwJq9TfqjuxxxpTQsOAy2X0WlSDCjYR2CaAWAUgWL8uHHA+Mo
	 lYEVKnw1BKf2XVFu6LGC5b/6nlqKMm6uWCKb9J6jPSaZhJPIwEBTwINrewVXy7/5rp
	 pnDtbl7KnXJHJtIXpj1e9ugGX10XxzMLnKUhFfKqtdySCiMFv3RmThyIjQwsQKyW3X
	 agoGMPY3CQf1SmYe65blir2dTdgN4F2HIq1uFI9oKPZP+Lhpml+w7+MjGAmXsOmr7q
	 HH/Fberr/MmdnqnuW6gj0Kc19jPP9GuIVGxANdWmeE/xzOyGLW4GKvOHOEZ0DHWTKX
	 vhAqzsqu5D8KQ==
From: Mark Brown <broonie@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260830140133.24156-1-pengpeng@iscas.ac.cn>
References: <20260830140133.24156-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH] spi: sh-msiof: propagate setup runtime-PM errors
Message-Id: <178813304450.13461.6050584362669723666.b4-ty@b4>
Date: Mon, 31 Aug 2026 00:37:24 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1110; i=broonie@kernel.org;
 h=from:subject:message-id; bh=GLcklj6qLIp+nWJbUd6zXIgEsBhhkvooKqgSxHth9m8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqlz7tCANLpKGP0BVhwcMzj7f42l6xbSrB8qQmG
 3944Nawp9iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCapc+7QAKCRAk1otyXVSH
 0PoEB/9k5fbcZ9UeBiIU3k1n8LMb/Fvm67xBT0QK05WPnA5QDpxfsLkeaaYs/2lgQ7ipjw4o2eA
 JmUDzd8fj3nTAmPB2La+YoX78tl/t1MFAj1poEx9oAfop2+54paeJDMTbU3cbIhdyg16MjIgPfa
 i2FMgFGlh4r/OxFXQjgjnnf6dcfna1xWJ++NIT3IesYo6DnI5JBAEPSuEKx0v6FrTgr3ePNOLQW
 /BaaiRfya6Cp4yLoZ6dg+e9oWfw60w6cR1di3Y3pPqkxShW1SesbRND1Mt44j2sbzsvATEED7+x
 X70XRMtvsKI/+T9gskHA2oUx9jZvib1PwdIuSqlWchR+lwGO
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 30 Aug 2026 22:01:33 +0800, Pengpeng Hou wrote:
> spi: sh-msiof: propagate setup runtime-PM errors

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: sh-msiof: propagate setup runtime-PM errors
      https://git.kernel.org/broonie/spi/c/152867998da9

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

