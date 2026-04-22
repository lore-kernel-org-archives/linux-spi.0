Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3863F1647;
	Wed, 22 Apr 2026 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776887878; cv=none; b=i0TA6tbm0RO9YGvUgAulr/hKC9WM5dJp58rYsUrZZekjxRbJoXKPBXlqWfntfAoYq5g2r9LK/pxd7yfKyq+3f97SGKlr5M76S08lPGH1Ub9zm1MTt0T2l/4pGGvZczw3r5v9IPsMMSHnZPKv8+qtqZHp5yyovkZn4fb42hR14qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776887878; c=relaxed/simple;
	bh=w2ge953S1KrRQjFuGNDy1T65ySuoL2104Pr2E58NWD0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BGwQCBEwjBlnun1+HWNNXXmcqSdQk5k8hcj/pDzenY5zDX0klbSFm40dqgz3vS1mYYrnNFwjoSAhIf9tSj8BmjQjDpcQ901TMh4Lsx+IjNtxcu59MYhZchKup6bWjVg626Cz4A9NmzJ8i0rW84Nrd57vhjCScdpdtvZ5sa8NVfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMjCq/Y4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMjCq/Y4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00FCC19425;
	Wed, 22 Apr 2026 19:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776887878;
	bh=w2ge953S1KrRQjFuGNDy1T65ySuoL2104Pr2E58NWD0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XMjCq/Y4dj1zVRNf5LbReZlROGMOCLPKSKxmz5oPhd6mz29faUzUJukhWev1ax2B5
	 +65aQLXG4Ldx0Pn+NLVORe5kpEnKeBN92Q17LegGVARatDcst5SlAiVGZaont9wi2U
	 r6itzyT+qVM8x52XJ7XzV3peDVwVMQ2lpjbBWfRuKiBFr16afJyyI4IHfgsG40Mu/1
	 XpCnr1nDsmthXASOizg+/2imJzInvwy04sQ1r5CrHxnvpxxg1XhIueNg0TCVxx5bmT
	 P4ZlT/z6jum5YAObh2NVjLRass2MCOYWK0vQbdXRhboKJdvxtvXhB8q66Xp/4aKO3r
	 Rwc29YaZJlGYg==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Vladimir Moravcevic <vmoravcevic@axiado.com>, 
 Tzu-Hao Wei <twei@axiado.com>, Swark Yang <syang@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, Harshit Shah <hshah@axiado.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260421143925.1551781-1-johan@kernel.org>
References: <20260421143925.1551781-1-johan@kernel.org>
Subject: Re: [PATCH 0/3] spi: axiado: spi: axiado: fix runtime pm imbalance
 on probe failure
Message-Id: <177686676872.36226.15954409053503523899.b4-ty@b4>
Date: Wed, 22 Apr 2026 15:06:08 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1500; i=broonie@kernel.org;
 h=from:subject:message-id; bh=w2ge953S1KrRQjFuGNDy1T65ySuoL2104Pr2E58NWD0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp6ShDAymYVq7Z2kCwzgXexgGF41sNm4XgDNzR3
 beba+guEAeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaekoQwAKCRAk1otyXVSH
 0A/nB/wJhot4y1YoxCvHvDz+0I3ztGjOwv8cxLkH0k5SC25Orsf41MoDcTYYe6I6prc3qHT3KKw
 1g2wwIdXu6qTu2420B0GaNOWUsnfDEBCdmJbEcLK4ilIirOqgIocI2MXol0BZDxAMtZqTclNgRg
 tJpG9PQUIBayG5+fD52BYr0bUOh2A3YoL7cXYlhBR9+qNz1L3KmQPpd8Qdm9rWPU7MFK/V6ZnkN
 JoAtDXTYg7dNoGCptyTOWRe4Mb7xrLceTb74eSSEOxdIjQqq0VpaJksO53QYEK/e1XuJDhvpecS
 sv63WumVEPynqXNs3fBY6bF6ZNUXuQIQf9U6TyFEaNCm2mug
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 21 Apr 2026 16:39:22 +0200, Johan Hovold wrote:
> spi: axiado: spi: axiado: fix runtime pm imbalance on probe failure
> 
> The series fixes some runtime PM related issues in the axiado driver.
> 
> Included is also a couple of related cleanups.
> 
> Johan
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/3] spi: axiado: fix runtime pm imbalance on probe failure
      https://git.kernel.org/broonie/spi/c/cde1a784e4d5
[2/3] spi: axiado: rename probe error labels
      https://git.kernel.org/broonie/spi/c/821f0951b208
[3/3] spi: axiado: clean up probe return value
      https://git.kernel.org/broonie/spi/c/2b20e6742442

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

