Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D2130595B;
	Mon, 27 Apr 2026 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777285263; cv=none; b=dQaI5YFEiOo4W2JhdBY4JlEs3hcXPiDeA6JhxLcOrfRJ5Me29jmmaCyzK20XpiDQ5R1m8Gv3CY6WGkK1MnIk2kM0ROs0iHLkMfdcrPfXPOqtTDmIzy16vTsafNivKF3WjvN/kf4k8Otp4F64DgtplyJHDRrvblQX6d7ZT8BFAvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777285263; c=relaxed/simple;
	bh=Ogr1PTDBRIdHZU8xG3KeHSsS5riULQm/Hak7Uy97XrE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nNxjx6lIfwwaH5SqfZm9MQq+kIjBnYiUFh+7/gkDvkQ47GJnlZ/hkm8axOKAwE6m70qgWSxaB4G1H0KBNO4qBQ6iPW6AZlp/2jDnZnbT5HLIG5uxaGLiyqYowa6gKr8xc7LEMmTH8CBn+AWQjyzWMr0z2VGWzqrnIOqxkbb/GcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1v4kwH+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1v4kwH+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E58C19425;
	Mon, 27 Apr 2026 10:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777285263;
	bh=Ogr1PTDBRIdHZU8xG3KeHSsS5riULQm/Hak7Uy97XrE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=U1v4kwH++i/cSiSKN83OOmvUBZJqfOnyqozcWNpxpYnQIsb7sVjm85nhXKr7CPIq7
	 0SkCJZJxd7OOZuHrsvQvebBwEtbol4xFoK3+26UzS/oNZri6vSIP79X+43if0ZKYy0
	 40HKkOuoE3YLWbPqsK6pcm8ctcCnM2OYCf1uQ9cauZFh6qiDPZh7H7TMuKsDpGau0p
	 oBZls+9KgXxJzYfX8Ublmi/a64CtTlMgAjiQwf3db+D+mFMj5ChEnDI9vOWiQuZNLH
	 qmRBcTweaQNNj0lctwvpG/vMZs5SuD2iL3rFadhAk32AgcoRoLqlmdZqI2vTl07ftn
	 XyHpb0wZ0V6AA==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Anurag Dutta <a-dutta@ti.com>, Apurva Nandan <a-nandan@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260421125354.1534871-1-johan@kernel.org>
References: <20260421125354.1534871-1-johan@kernel.org>
Subject: Re: [PATCH 0/6] spi: cadence-quadspi: runtime PM fixes
Message-Id: <177724600487.266775.12198743851871697679.b4-ty@b4>
Date: Mon, 27 Apr 2026 08:26:44 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1890; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Ogr1PTDBRIdHZU8xG3KeHSsS5riULQm/Hak7Uy97XrE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp7ziMTnGAUWyBeO1Btt0bxvbkjdbkRYJ6TUbIg
 Wi4K/zmhxyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCae84jAAKCRAk1otyXVSH
 0E/wB/9As0cZZ1TbYqD7FPV4Ig3h/w87GjNGvD+KBvfeYmVCcVP2ytf03AvvCb4r5igfAxK0B6u
 WkiwaVm0p0QYryZjU4WyMCAojF5uK2e1E7wQPq83KEL/8wWHlkWXRsygc3pyaUJMiZEMAv8s/zm
 KXnNiHwHw4sjkGhS1nKVgh3t7Ypbdc8C/vahmMpRkVmyb4IEH6JkXGT3A5Nl+rGIZnFBpT0Ox9G
 L7lMRcj3yDasxTDe01yiZjk+pC1WuLUe1S4ba9rRQwzN+/sULkjHB9tyx8Cx9SmlClFUAlpFPT0
 XOhtc0UrIG9RTNaMR6GcNbxHI0d6xJl449CkHhSpMm5lyIkN
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 21 Apr 2026 14:53:48 +0200, Johan Hovold wrote:
> spi: cadence-quadspi: runtime PM fixes
> 
> This series fixes some runtime PM related issues in the cadence-quadspi
> driver.
> 
> Included is also a couple of related cleanups.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/6] spi: cadence-quadspi: fix runtime pm disable imbalance on probe failure
      https://git.kernel.org/broonie/spi/c/5ff4d5d1af0c
[2/6] spi: cadence-quadspi: fix clock imbalance on probe failure
      https://git.kernel.org/broonie/spi/c/cba53fe20c18
[3/6] spi: cadence-quadspi: fix unclocked access on unbind
      https://git.kernel.org/broonie/spi/c/233db2cb14db
[4/6] spi: cadence-quadspi: fix runtime pm and clock imbalance on unbind
      https://git.kernel.org/broonie/spi/c/5e8bb0cc72f1
[5/6] spi: cadence-quadspi: clean up disable runtime pm quirk
      https://git.kernel.org/broonie/spi/c/edbaae583ead
[6/6] spi: cadence-quadspi: drop redundant match data lookup
      https://git.kernel.org/broonie/spi/c/37c9dfa385db

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

