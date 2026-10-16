Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1473E3C4F;
	Fri, 16 Oct 2026 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792187227; cv=none; b=ZEk7mediZVBLbMpn1mS25tjub/ccuEx3ua1L90LprVoCWgOhg3G19Q/W66kD79Pv8CPjOILwZM0+QccAq+JQJ/mirdTqS41PMcCFVoYzTy7npJDxkx4T3453SN/BhNOKIkarlUZG6hGc4FMOL/LGSgo4O13i2C/q1EalZ2Np//4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792187227; c=relaxed/simple;
	bh=4nEnf66h6FKzoA+DQqMH+xfAoOybR1g0YLk3xiZwS/A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OckAYacPKK96MFv/bUtr4dIyHWev4JHdCowDiWrWcoed7U474a1GkzJi2Vf6IZPyFfVoNqj7/koYMoh7AWUuty6gmmJPX1fEASkV1lvFJHLiMqA69Sbqa0iC4J10jXzzpCTvb482XfVAwR2cCJu33Ye5Qkifn9RtPEJXu4SQr2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4aVe74H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4aVe74H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE54D1F000C4;
	Fri, 16 Oct 2026 21:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792187224;
	bh=U4IOThkWmNkipJIf55NBfSbBXN+Gk6WkefKa3VNLNfU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=e4aVe74HL2/NyjqNi+YNXkXuhMoKwPaGrISTNrzypjnMNTqhNaTlbWQQ1oLlfz+7Q
	 nJ3MCQ/pIgBxkGHjKSnUix5YFv9ZFCel6dZYxzkd7/0u/zz9QRCe+VAiqujx3V+G34
	 SKdmrlkEVYx5x+q+65aGIu4RYIo7T38EN+S2c0I4ewzqN5zUsRxEXR/IoZVA3nZDcA
	 OfFLn8mjzitzDjCOQ4gKuc6VGRXIgFmlYcv/tmB68wtPKvfy3M+SYzSLY1E0+kpyJo
	 DuY++NRBFJkJ067Dm2TPpRW0E2IaxK9WiYFVexPH8XCgL9WrwmMXXf5dUexWhhNPTW
	 xuzboLZysrSjQ==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, sadre Alam <quic_mdalam@quicinc.com>, 
 Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261016-ipq9650_spi_nand-v1-1-d341a76559b1@oss.qualcomm.com>
References: <20261016-ipq9650_spi_nand-v1-1-d341a76559b1@oss.qualcomm.com>
Subject: Re: [PATCH] spi: dt-bindings: spi-qpic-snand: Add IPQ9650
 compatible
Message-Id: <179217927349.3162228.2988082099851102104.b4-ty@b4>
Date: Fri, 16 Oct 2026 20:34:33 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4nEnf66h6FKzoA+DQqMH+xfAoOybR1g0YLk3xiZwS/A=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIuzQ6qfLgn7WJz+HEBg8yVQguXHZh1KsdM7KdeFo/Vs
 ipWccH6jlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAExkpxLDX4EZj5hiGmt0GbIr
 fk1Zf1doQ6rbomdZ8Ucbl8QKCDR942H4X2Rc1Sqkcasyskf/1Ald8/6LJqV/5se22tTpKeh3lx9
 kBgA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 16 Oct 2026 12:53:04 +0530, Kathiravan Thirumoorthy wrote:
> spi: dt-bindings: spi-qpic-snand: Add IPQ9650 compatible

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: dt-bindings: spi-qpic-snand: Add IPQ9650 compatible
      https://git.kernel.org/broonie/spi/c/6c59290d62e7

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

