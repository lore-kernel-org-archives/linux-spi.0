Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0533CB55D;
	Mon, 27 Jul 2026 22:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192914; cv=none; b=mnupteYkmbVTNa26a7QXpzjvWjzhz4VsXIPJ4UsZv+wZj2K1Qb6k42yDyNkSInu4arxAmdjnJGOrj+ZIe1VbNATq5s7jKWCrA3j6CLY/2k8HSDO19s+BAXe4frNZmIRFTHD+J+FArklbqPeSEZBeeVaSlP/im/hjHbBJuUvabBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192914; c=relaxed/simple;
	bh=FZ9hE8FtC0j3PoZXjQfRP8zgLbvU40x+/vguTrjjLIQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GdHb4VSf8LD6N6sb88tZYFTQ21Z7yKkCY5n6gJRnvurBUCyMtKZdVG+IPkWqUPkl2iVtMOXS/5lUJjKAqlRK2DLm07BstwVcKeWfzsv2HToNKv9k1KnUSq5ychIBQ3bcwWPh5RObhhED5BVp8Dr2zLBy06/9fgymIKii63YqCSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLBROwFc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLBROwFc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442ED1F00A3A;
	Mon, 27 Jul 2026 22:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785192912;
	bh=swHBgptXNCT4nfNAZr2Kj/5tNU5tfCl6vLTLoHQLVk0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MLBROwFcSCdd94pmQvV7yPRs9/1TIdH5tK8Op5ucjCVE541pFkSlcgZCwhZVz0QA5
	 4pyYtSSvtxpBAUGH3/0rUjdk9TtjakGZP1CLNzXlVaiBb/Ga2wAQE9zSuLiUt1lylC
	 DKHaVrgtPgsail5m6+6LADB0QV9Dq+xpg5Vm+VImeFMe5P1amDjFFIWSPtOIiaIP+/
	 TgHAgozTkPAH9QkVJn+HG5t28pofPj8AlUWtJwj3fjhiVQtl7hnScruDP5RLvxm7R3
	 0UGr+w0ZzL02dFthkbE/xybKDWw3kWpYcBWhfigkFA4ckckhCLtZHZ7lprKh28iH32
	 nCd+NKAwKifGw==
From: Mark Brown <broonie@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Praveen Talari <praveen.talari@oss.qualcomm.com>, linux-spi@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260714120226.1788391-1-shengchao.guo@oss.qualcomm.com>
References: <20260714120226.1788391-1-shengchao.guo@oss.qualcomm.com>
Subject: Re: [PATCH] spi: dt-bindings: qcom,sa8255p-geni-spi: Add
 compatible for Nord SA8797P
Message-Id: <178517287171.50339.14273544886035165596.b4-ty@b4>
Date: Mon, 27 Jul 2026 18:21:11 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FZ9hE8FtC0j3PoZXjQfRP8zgLbvU40x+/vguTrjjLIQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqZ+HOAHSmEl1HMZybbYwY7OoYAGCoyCfsXaMj4
 B0FOsgGom+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCamfhzgAKCRAk1otyXVSH
 0GxMB/sFi303lTbquEyoAVnEFZyptCSMykkNG8kNku/laV/ncDdQ1sHmo7CSJhCeQ57eCRD8pPN
 iUrNWuCNojOKpNPk1/df9+217g6m9UCkwkJ/6fWMjcSD1FL4cfQfOOF79aIDLXzJQcaVOOnTcBq
 R37tS/Eh+e78eUQkLM+WANuMXgL1q+kx6oR2SueAdvraGVDdiHV1bsd+yAKcYNiAKoEZR36iLi0
 fk1M1j0wKpQBxM3Tp6cFbB2pNpReu5np/ekcAO2TypSwDHR5SNdc9R0MHqCeAQiq7QX/NTDfU/Z
 Vokfy1QmO/4sdofVTwOFbB3h+4hpPJ+bWvAWqURlttuLqHcg
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 14 Jul 2026 20:02:26 +0800, Shawn Guo wrote:
> spi: dt-bindings: qcom,sa8255p-geni-spi: Add compatible for Nord SA8797P

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: dt-bindings: qcom,sa8255p-geni-spi: Add compatible for Nord SA8797P
      https://git.kernel.org/broonie/spi/c/a44a020465e3

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

