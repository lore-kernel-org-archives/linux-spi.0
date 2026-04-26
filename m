Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668A2314D2D;
	Sun, 26 Apr 2026 23:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777245752; cv=none; b=sBsZGvJGjbOVWtjRYjWimdks+8AhDtEnVU3oS6rR8Tz/cEkLo1JspRmE3o6ozbbjTh7Qa04nVWTZ3ktG7CgMAwmJQtLZlamccOsXKhBiR3A7JUL4o+J5E/JslZAHvKlsk5GxQldnVSqlXuIHxcxi2UNma558O6ncobSUPDSKGXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777245752; c=relaxed/simple;
	bh=z3NUmp4KMnTJuKrlBUnal1ujvZ59+gcR/MKiJRU5g1E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h/aYd6nk4oWomTyXGy7t0ndQWb/PQBGm+1lBOanYzLJTvdVEF3CCU37tWqw12/597PVNCGo8l9+x+OBfV1sBE0Jc6ObcLD/msqRF7yXIOBBCJIUZXKa+Nv/V9DfT5A6GD2GDYUqCaoCpo8/vNFUBqqPdnBskxEuhkZtBm8dVO6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCDyHmZa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCDyHmZa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9140DC2BCAF;
	Sun, 26 Apr 2026 23:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777245752;
	bh=z3NUmp4KMnTJuKrlBUnal1ujvZ59+gcR/MKiJRU5g1E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MCDyHmZa4nG+9QIDcd0DWaDVSTwmg46y4HWgziYPkTlhkVPTs7/oyrcib+lK/czW3
	 LhBkkfSiFhORQSxql38DtGjwcsE0QEWGfrzF4c5TrZzRh06YXWxd0OKrDwQudE0VyF
	 r6son0ZkHsNE5wZTCboBPcg+ghPP/kfHFETnWAQ+nz0ao28mrNI7MPaD6nGFhK9Q54
	 tCGatslYfFyK9+FwHBlSRpg2GIvSoiiHT0sy/VXuagA2e/AwY5XdQ3UW7ASUtPZWrH
	 g3zihl6gx00uY0ibsiJxPOk8mARhCz2ebxwbfGoCaCYnp9i50Mf8ZYMILzH6apgRY1
	 S8xBfYQ3kXCxA==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260423075801.2252318-1-johan@kernel.org>
References: <20260423075801.2252318-1-johan@kernel.org>
Subject: Re: [PATCH] spi: mpc52xx: clean up interrupt handling
Message-Id: <177724023067.266775.11771150879960095629.b4-ty@b4>
Date: Mon, 27 Apr 2026 06:50:30 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096; i=broonie@kernel.org;
 h=from:subject:message-id; bh=z3NUmp4KMnTJuKrlBUnal1ujvZ59+gcR/MKiJRU5g1E=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp7p426LhfLP2t378yvPF+v+SR3F8evaG4YvXL0
 prc6F00XsCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCae6eNgAKCRAk1otyXVSH
 0I8IB/9eqsBOvo0bGSlEhy4dpArskKeOQlHsHcu/Nauya0Viet4qOEabFDHZl72bEee4nRyVxNS
 5RdMBnykVLyXU2F3N/GWSMGuRUimZ6US+2YjnZ9DKntnMnXYxzw/vOHj1JimzBLLE/+47Jv27vt
 G6Js5g5VVvEVYHHHtuMvZ5eA6SAndqw2Ib5sFOqWHyAPPgZHwutMXEeQAOM0lazOKAmdzmvDzMS
 /sL3T4zrnUNvDmOBkbIJ1BlUX1TYYuGj13dvRl5QmbD5kSX2+lKQ1d8Cum8E2AF8/u71X32dqI/
 ogYAbNN5N++fyDR3BOYfZ18lqVULsNlsMk/DaN5m0tZMu5Om
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 23 Apr 2026 09:58:01 +0200, Johan Hovold wrote:
> spi: mpc52xx: clean up interrupt handling

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: mpc52xx: clean up interrupt handling
      https://git.kernel.org/broonie/spi/c/76645c1fd682

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

