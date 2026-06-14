Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D36039A7EF;
	Sun, 14 Jun 2026 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781433199; cv=none; b=sN8aVAUizjSRp9EU0zH+YSrQPXlJJwJIhfC+n1y/ALH1Eqz4LxSaCYp9ExBSN8NqIg9OZZA27GORCdHiw224FQswkMbpDeTfJEORHZ1UN5HnOfj78jd0K6rrhggcpIcvef116qh1imMyDfAZWL+UTenkU6ckbeT5c/WJ9BlGodw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781433199; c=relaxed/simple;
	bh=qgot8dCpWRXRb8Wa8QW2WyFHUGAl+iy4WLQWdVhVH/0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cCXP+bvPFHlO0IdoVRNdO9ONhBIfJPQBtZXcTJ10K0R07PwGWU6WsuaoUcl5SZ20m0I13Gvg6hxUxDIIw+a9ueE0alxZDwt+IB/uKFkB7DaNeiHZOCa5OFAMF4QJinCqSbedB/pHt3S7tJDl9Ss6tLfB4TUZg5pd9NEgPvsk4cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DflaNlBK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DflaNlBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1C31F000E9;
	Sun, 14 Jun 2026 10:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781433197;
	bh=wE09GDJMjxTe2qWijVxNSlM1GqatZ07Qla8YuiEoHm4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DflaNlBKqeEdY3qt602vj3xmyawFEHBJT+NNeveAm/hG/OIkz2x1B21v2CpE8NXbw
	 MBtSGYbiwZb7qsDgn2WstifyCnpohjKZeG+rROt9uZ01hHogwWU344gGyKKihtcUJx
	 kWp0mu2Zv177BVXTogmWRHkS7SxVD5iAUAZMxYkKpCANjmQbu1viSqe4BZ7WWIipTo
	 zbH0Fhgyw5FFJPUexMfFVKz/yz2/TcKxfGbW+/luwx//m6HVU9nPeIGinCiccudGF+
	 s+oqNfoNfzdnl+sGX0Jb0A3oSoMxVzsKJXza0BTQwOHV1fh/99hEFGCivbM7eU5nr0
	 QF9+BoZVtPDTA==
From: Mark Brown <broonie@kernel.org>
To: Yang Shen <shenyang39@huawei.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260612215017.1884893-1-robh@kernel.org>
References: <20260612215017.1884893-1-robh@kernel.org>
Subject: Re: [PATCH] spi: Fix mismatched DT property access types
Message-Id: <178139631307.17453.15390047364993641851.b4-ty@b4>
Date: Sun, 14 Jun 2026 01:18:33 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1107; i=broonie@kernel.org;
 h=from:subject:message-id; bh=qgot8dCpWRXRb8Wa8QW2WyFHUGAl+iy4WLQWdVhVH/0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqLoNqfEITN/LZzfvcd3V4NRW4txzxTFN/kTdzN
 Mzf52FStqWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCai6DagAKCRAk1otyXVSH
 0DrSB/9+ipoI7D0RIU9AnLdY7yiyyklq5CJLkX8p4/RQ9f2TTXRyqIZnaYDJTDqvi0gR3N6MMif
 MdBmb9ViLlSfnzVHtkR24HsqLfJYAQPhFlbHvER5YO3t4BdMqQSUVxrltCqIrKr+5OGjZCzcIhg
 Jd6VLds+G1w843RzqocfK3lN8kD68hl2x7KsphR4gus55BD0Li8SsC4fzkyUQaC72mpjvlPYV5v
 T17Z6UCFwI+MlY2ju8O+rJmHrnsr31qkuSpJv7W95st3LpWDwPizj71+W6fNbvzZwM/dtarKZDw
 E1dnRyMlWPrwU5zkkXpJxcocV2fxAUJOxxMuBKXP7v56SWHC
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 12 Jun 2026 16:50:17 -0500, Rob Herring (Arm) wrote:
> spi: Fix mismatched DT property access types

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: Fix mismatched DT property access types
      https://git.kernel.org/broonie/spi/c/f846d6899214

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

