Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26FD3F58F7;
	Wed, 17 Jun 2026 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703525; cv=none; b=Q2N50xTOymf+9dpyzAjH5lUJ3elWGn0UbKl2qDPfK8UKvyyo7ciuSX3B/EJhFLiC7jxWGcxawR2Zb7cJF9+fssL4lESWFJo/aPM8EV0GIst037DFClals5DbC0EkaOERVTJIKSBsOQnP4yDZ0SU8mYbLI72ZSFJWXsJGnmo8SjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703525; c=relaxed/simple;
	bh=mbHoVUZwoYxrcW6r7JOqsFU7j5zIb7/PGuCh39Ly3Ts=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Wdq9Ui927XXzWKRSQel8lKrI86iOWgXpm+6YRRf6CTXbWjXxEQxBhQSl8G0boa4bfE/bSZLs4DIJYyP9an3tl3FZxlecHdCxMJSlfyIloKZso8YZ2RmGcMKR5LYGrBWMl3D2GJAybr8c2UyWlvD93DwMirOpQH7ZQTUQmk7XeVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1j6Ga+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1j6Ga+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DAC1F000E9;
	Wed, 17 Jun 2026 13:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781703522;
	bh=tZqhpIkjs8tV5Xkd43J7ptqZ7m0RoZ3gG6HwEDJdqHo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=U1j6Ga+xMSQxzkOfUodskMgXvfB8kMrX1zohRkrHL1BpRkifW6X0UUOiX4JTndItP
	 H2tuvCLnNMB2TfJzlSSjOP41gi9t4mHldf/qsR9YB/2HF494BUjqCO7X2tfszR/bbi
	 hk10qp1IZaBwFufDojrYjYxxsmzr17inD5uMQh/5DMm2HOeXoZr4rQAUgs8b3XngMR
	 xu1uLiD3uUqhKicAZxGHavw9puQSTEKbZuBFQAcZI7uWPt9QUIQjer0PBU2lZgDDGe
	 lDUyy1OAVrWh+prIKc74i0EPPl+vXZ+jLVs8dIu/g1HscKxNnoW2uNYq54Zb4bAGEX
	 Ix7fqFzqqAVlg==
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260612002835.5240-1-jszhang@kernel.org>
References: <20260612002835.5240-1-jszhang@kernel.org>
Subject: Re: [PATCH] spi: dw: fix wrong BAUDR setting after resume
Message-Id: <178164263871.683454.17672554090207096698.b4-ty@b4>
Date: Tue, 16 Jun 2026 21:43:58 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105; i=broonie@kernel.org;
 h=from:subject:message-id; bh=mbHoVUZwoYxrcW6r7JOqsFU7j5zIb7/PGuCh39Ly3Ts=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqMqNgZ78a4Ir8OYni1AMt8GLYFo7sbGHMS3Kzm
 okMkQ5FOeGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCajKjYAAKCRAk1otyXVSH
 0KX3B/97X64WCnzQpgFjpaQ6njf5YK1OREsAXBmMoXdjmgZUo2lcKYXwTJ2ifpLSs2+Lhhiqq1L
 M3gtK/iCO2eY8/Uzmif0a4E6UMR4/uU6dUqkgVOJb6KrV4IVsuRy2vy474b1beT1zpKmqW5Lq2G
 S1SKfR672D2tIRfuq09kknUH846L2aGLqSIF0P/DTw4H5q/S61mFFw6DxIviJiNnJOX5AxuJpK0
 iZnOvSekPMn/3IWmthzkOFOZIpVz73uuZ6aAA0fuGzNEuH8J4vUcsrcUZrQEQ5UHsc39tBY7CkY
 hg4JzEkyMRsizBrcwB1OXo6b8bbGfbQV4XhurjDzpq2HBsmB
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 12 Jun 2026 08:28:35 +0800, Jisheng Zhang wrote:
> spi: dw: fix wrong BAUDR setting after resume

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: dw: fix wrong BAUDR setting after resume
      https://git.kernel.org/broonie/spi/c/66b6605bcea7

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

