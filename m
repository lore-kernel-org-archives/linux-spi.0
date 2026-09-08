Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20E459574B;
	Tue,  8 Sep 2026 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888525; cv=none; b=Chx8oInIO6PMo1AyidbdNkWSw/QF3UJ6sM81OKp/wjM+esn7uWOo/DfUqJyfRN0f+bs9NJhj2dLeYXrUccluI/MWqOBQRgR6VPDIGiABrnodrhul2lBNhJPD+iGD7k7/rgiE2Xpg8HOb3knQvSt0Q6jsOTiev8uv5NQIjoNBY9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888525; c=relaxed/simple;
	bh=W3hzj8oB3ePWpYI5c7GaqPtx1oy0K7Y6c++d37ZKzgM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uYqxkDaaaIyW1n51HABq9eP4pReilrrnYUxDdXaaAgu6RrtB+Da54IyD2HjQXUw6XBPYzuqfuGwSQ2xJYcIff9ffzDCksbf17gMkfUNX9nWXPT7JhDdRKhf8psDGXJ3+P1b79oa13huAM6k7rncPNFVovndssUYFJW4U71MfE1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfwSFTyh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfwSFTyh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05811F00A3A;
	Tue,  8 Sep 2026 17:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788888524;
	bh=+8z7dv1KmyqiFQxMtaMilq7bGrwlHcJ+/Ub4jbMFMko=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FfwSFTyhI6KRypNUO0CJhBSFTTnDbvlkiBUbwjGV4NlDNyH3DuZtSNMh/kaTBoPCh
	 e97loE+itcap1hXhWDT5eOxtc+fUnljC9G06qPyJg3VPFmc3SYxhiBkB+R7opp/s9a
	 0oDL1RWDrIX4dHAdOFI2VtciJbYE4NXLYduOiuBqFQrfD+aj1IEw9qyIfFJ2pYP/h8
	 tuC20frkTqbXlccOnL3+UNGVVydhb0DFh5aaY9l6VVp6EQpKI+Ixodyi8Ive+G8U39
	 brM0jkxQ6yPWfkvXl0QxxW5QTafzz+FDUHqzyzx80fc3TKRG0o+lT2ahEqgVhWmeDg
	 DLqMzB/QxDLOQ==
From: Mark Brown <broonie@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260907-ar934x-v1-1-71327eb482bc@gmail.com>
References: <20260907-ar934x-v1-1-71327eb482bc@gmail.com>
Subject: Re: [PATCH] spi: ar934x: Convert to devm_spi_register_controller()
Message-Id: <178888061038.78527.15160926774913219283.b4-ty@b4>
Date: Tue, 08 Sep 2026 16:16:50 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1118; i=broonie@kernel.org;
 h=from:subject:message-id; bh=W3hzj8oB3ePWpYI5c7GaqPtx1oy0K7Y6c++d37ZKzgM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqoEXJeegtyEwaTIwmYxzcLX9RIUrG4aZosNFKl
 M6+IWT7/xmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaqBFyQAKCRAk1otyXVSH
 0JceB/0Rn96ad3rKjwiTrqMF15ogaIkvUv6snHRDLQEiWhQ73b6ARIkFKFaAGHt3H9WFM71LyYB
 xunMZs1birCl6Ve+SnfgrsyATls87/ljLrOlc+7/C9CWiQz75/0vYH3exmm8wf8KwKOJrGjEaOh
 hwRsUBxJbDLcHuJnQi6aXhVPwdxF1mC86q6TkExW4/REPXCbVFIkAZEVUvxUJCLVitd4t8EXGp7
 m5h8eMP46r5x8tIaBOQekPlN6S7hIZ0Jzg5auhetlbiZoQs4MeweXLjZak8btIOiRVtXHUyIr7G
 unAyPMseJRBOFJqHegqeEJCgrCsIUqfG3Y191WyLcE44QO7Y
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 07 Sep 2026 20:35:45 +0800, Felix Gu wrote:
> spi: ar934x: Convert to devm_spi_register_controller()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: ar934x: Convert to devm_spi_register_controller()
      https://git.kernel.org/broonie/spi/c/e95dac34dd57

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

