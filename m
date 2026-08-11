Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DCC2D738F;
	Tue, 11 Aug 2026 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466821; cv=none; b=ZULAnN3wxLV7fA0YMe57CIudu1U6lSF0ky79abwydtrrv/JKzSnIIYLipuF3aFip13zgNCBAN5gGtR+QxxNXQTUPQuJ1skDJ183qOQglybX3ypOejFPXbxJFLMmltdYpo8Xi9Dt6WSnGoZdmAn5dHCFfhQ0c4oNNSI5JqI3x4Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466821; c=relaxed/simple;
	bh=WgEZp65/Aq+Qs/bU0hsfNuDYFpw6UM9MrnyhaFHW7IA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kXPpl7+Z2HDjsUtMrCJP4xYGYCmu5UPyW7xD4UWRMmwaPInE5Oye0PctpvVv9XTo+8YimLGysvh57Ns/UcfbWGvZG+82wkMAjqZb6l65bFm7IaB1zeLh1hiEzIkY5cLwBzfuyAajHf+4rktbmLAbSYCm3VF04I1vVp5z/vFEvEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nuf2FUUX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nuf2FUUX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8DF1F000E9;
	Tue, 11 Aug 2026 16:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786466819;
	bh=5loluarRHhd6s0aGv81jNCl757EA455ecsKX5mYOtXs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Nuf2FUUXFAFzMnuFEaCJZJbgNeb14l58QIVmMuZn8pUHrYd4mUKSYU6VJsLH6ovtn
	 DLR2HATX5PtqdEGOH7i1S/1YWNKdYbVwj1G/l61MhXBUIUdYjnvztI/BGx17uoulXd
	 435zGOXgBjkjtKBSNgUDVMjeHqe7Xrw+3LFARnWLW9lKkW/48DUyoirhoe1g3lOI07
	 4y8mEu7jgxhWB8IHwJlun1fWHEyE047BPR7reMmrvkPaO3eUWwFJu012/GLFSBO3xq
	 i87k5n0p45M+CAopJNzHoj9hBNz/n8MQ5EDRpvQfmYKpYph7OBYx+maJioPF+0Wldf
	 atuV1q0bauFxg==
From: Mark Brown <broonie@kernel.org>
To: Babanpreet Singh <bbnpreetsingh@gmail.com>
Cc: Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260729053543.7-1-bbnpreetsingh@gmail.com>
References: <20260729053543.7-1-bbnpreetsingh@gmail.com>
Subject: Re: [PATCH v2] spi: sprd-adi: Fix probe succeeding without
 registering the controller
Message-Id: <178645702678.119683.3017738796459227750.b4-ty@b4>
Date: Tue, 11 Aug 2026 15:03:46 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1158; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WgEZp65/Aq+Qs/bU0hsfNuDYFpw6UM9MrnyhaFHW7IA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqe1IB+PdDvzH/vlIZoIehEaH+EpypPfbzrZr/3
 7/xDRM+ijKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCantSAQAKCRAk1otyXVSH
 0DdDB/0dX6plkMvsFxp4/Kb596PU/ahPLIbrxEfaQhlB0IDjPzXnocYb+BxPECkf0KXWkLxXARR
 Q/FT4/qMLVptTYk9xnZJX2jsFFD8dHlTjNtfNIcGZm+cp8cKHexCKJPWdHweQEraCmfreEfN1ku
 MqufcaBgDxDvTGsjeFxnyJLN4KkfJ2wmXsnlOvR5feBzlQ87/xWD+jHqCJUlRs0V+Y/ALtWAc7X
 md0dW4q03rX7vh4thf/BW5c1uO+XTzBBtn8d7UkJpjxOij7md1UipznJ5UicRuo/vHpctHUwXbi
 6itu06uLpS5RVJtuX9T21QEkY9gOD1agvh7XlpEDDkDvcqlx
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 29 Jul 2026 05:35:43 +0000, Babanpreet Singh wrote:
> spi: sprd-adi: Fix probe succeeding without registering the controller

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: sprd-adi: Fix probe succeeding without registering the controller
      https://git.kernel.org/broonie/spi/c/f092e1c93501

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

