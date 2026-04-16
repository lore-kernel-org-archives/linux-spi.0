Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEA412D21B;
	Thu, 16 Apr 2026 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776354371; cv=none; b=qyBT5t+3jdatBPD+ERPpdo+37mjCCTz6TglPVUrr8GUglBbJSZZ9CgPudvxCYfE5eWPcjJmv2CJdVUEkTVwoJUuww1E3XEG3QmpHb7hOR4E9yb3AT2V9KpLKilY8UP1V0EMXXloHzg5e8Rk8WTfzjUwVBx7QHxWqZPqpjRWr/88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776354371; c=relaxed/simple;
	bh=fZETXYu0oWCsWiHimS0OA/TAWz0pKdtdcNhYZKxuwdQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gO2p7U3iuoH42I0HJgsmN5ffLWP9wQfR40nCQjirsrcKrh8fmu67wJ62THUWXvp2+FYLgRCqur6qJhlHtuBOmSJ3aFoCF19Z9oXXRvhGPRKLHmEvEV2erkgqzQgacgtwBtt1O4uFALylwYWUML8zQunfNP95Rg5mgbueZvPNK2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ho9Truf9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ho9Truf9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16150C2BCAF;
	Thu, 16 Apr 2026 15:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776354370;
	bh=fZETXYu0oWCsWiHimS0OA/TAWz0pKdtdcNhYZKxuwdQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ho9Truf9ExiGsv2biQrqDWEdZ3vfKdwLsLgn6qcAq0yRfny/3O+OCgJfKh+RAetrx
	 Dhb9qdBUb/9bjbHdP9LmUY+NkuHR8Dm1JG+qCBLWRRctmPEIKxvM0WgY3oo1wYJ8QY
	 zVAhIfQchi930aM5q8WF34gDm7Ke3ecjmH3siJ7V12K7DuOpR1i3QxxU08/HDZ8HHo
	 050hHfMyQDux65WsVE0ZQoi8qR7lkVzu/92zM8NW66ktpXC+M5/xTo9wYy/FPXircA
	 InugFvlU3Lk0STI/an1ejUHhVMwbooR2juvR/b2Et+loAjvSLLYDM3GIO/2W0uJIqf
	 kyePIWT4ZHh4A==
From: Mark Brown <broonie@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Xiangsheng Hou <xiangsheng.hou@mediatek.com>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20260416-mtk-snfi-v2-1-3f487689dacb@gmail.com>
References: <20260416-mtk-snfi-v2-1-3f487689dacb@gmail.com>
Subject: Re: [PATCH v2] spi: mtk-snfi: fix memory leak in probe
Message-Id: <177635127007.43536.11128592640404935803.b4-ty@b4>
Date: Thu, 16 Apr 2026 15:54:30 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fZETXYu0oWCsWiHimS0OA/TAWz0pKdtdcNhYZKxuwdQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp4QRALDdqFpSWntj953+kCEe/VleFyxyWZA5MS
 nBVKNSokdKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaeEEQAAKCRAk1otyXVSH
 0FifB/9XMPkENhGcZcoP0IMp2qLmCOAxnJR28C+LRnrKISS01bhd/THZdf+sg08r/TC/SRM1dIl
 bnmrWNcHji0BDMZGNzGxqkjx7y7pFjenjr0duKNMpw2kIpyDIfcd81EPJ+p1jwMdLImels0Kc9q
 8OVODeNGdCRC33VgQfBId4erOzbwpGr1XisGMuvj9Qp9RSWkHfhBiGvcl2gUGn6lpl9ZxGairbL
 pnvy0yz4vscFJx3EW1PgNWOrF1ZQSSFtOtkXc2BcYrfsF9ionXHSofv3z8fs4aXz/B0KSNZhak8
 t3J6scRq8IcjCA5Pq6MlCo8X+x3EsbJoW7hX6HyPU9MKAWHY
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 16 Apr 2026 21:00:08 +0800, Felix Gu wrote:
> spi: mtk-snfi: fix memory leak in probe

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: mtk-snfi: fix memory leak in probe
      https://git.kernel.org/broonie/spi/c/51942b77f443

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

