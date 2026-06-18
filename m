Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670F53B9DBB;
	Fri, 19 Jun 2026 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888703; cv=none; b=Ix98/6teal3WBT4yQgrXZs2+s5sbdVhsIaY4O/EOztGj17/5GnQufSpdx+kRLhf03FaMg5yuIqzxr9J7cjXMD8rzj3TwDGg1/AYjpPVLVy/inByNDWa9kkZQFxvIgtCCXk0jQteKI6c1pHFXrleoGSm/3XW5n9DWudU0DyTmbaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888703; c=relaxed/simple;
	bh=I+2t532ZrR3tSKHWvKwp51X+ayzP+jiU3EzT+XnFMC4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QSvX19d5qHaKi1gjKbzg5o1GOetpJy1j9rXwjGiJpNwnspMla/YbbY6fwjhfTaWOph6tcfdxvWOx4KZlWsl0TUEFx3QOL8UajeHKogLY+DXazrzQ+1rqfICiYPAY5JMQxR9nfsFwn4FXxU3xZBdBfsZbvOftDjsJDX3pHKGAwg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kwkx3Van; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kwkx3Van"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B211F000E9;
	Fri, 19 Jun 2026 17:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781888702;
	bh=zJX1LZbpNkNg/k4AzJPrwfSQQa5YP3+zYN5KX/BBMEw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Kwkx3VanrWh7+OFddqkZ8VQ2lPHN/cRP3Nk4hOV5PVv+q4NaGBBispejxe+IiBP4n
	 5e4ZbKQp5BYLs0LwhOFz1qEl0zPmShn6fGstxTTFG5rb8NRLdheytsP6PLjAHhTTcj
	 TwpeRqkjlAqU+sAg5O2w0KKo79sE/EAmEHVQyTFbnwE4WmPyYneeZi/MaNYyxeDOVS
	 /vdET136ZySSdr6/kBn3nHFPkjDW+a8f7v3uF698z52e7K+yG/39SFqlmrtZCjiCfw
	 luAbYvsJnxwioLCMAgoPTTiiPKx2n5vSuttNGM0xbdwr6gnP+yz3i8NIbfIOC0JPVl
	 xhTd8JOhzr/Iw==
From: Mark Brown <broonie@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Quang Nguyen <quang.nguyen.wx@renesas.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 linux-renesas-soc@vger.kernel.org
In-Reply-To: <20260618081932.172168-1-biju.das.jz@bp.renesas.com>
References: <20260618081932.172168-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] spi: rpc-if: Use correct device for hardware
 reinitialization on resume
Message-Id: <178180686113.62759.12100775429244612281.b4-ty@b4>
Date: Thu, 18 Jun 2026 19:21:01 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=broonie@kernel.org;
 h=from:subject:message-id; bh=I+2t532ZrR3tSKHWvKwp51X+ayzP+jiU3EzT+XnFMC4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqNXa7BDTby8jxXKIa+keee4aW383vEJyAlrSD1
 tOToWh1U/+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCajV2uwAKCRAk1otyXVSH
 0LGFB/9vxRLZilZQ2l5qG1PL7x1OkVFtFq9UFIpj7yGkshHPyyJqvTbBFGpCpJABxa8fZdMJQq9
 KCeE6kbRspfhe4MlPxBJ796d3NKJXV1U2nVE74O4PaCsjl4pdl6725nkPBJ2ay5cSSuhYIkUX/Z
 NQ+WtBr4TiBG/CoULLCivVFZpNKAJFDlW1BvYGcZ7+UPyAEiCg/T5NFoCzOHafkSz8IKqpfQzL2
 9fnfZ+F9cOiPM1aTVJ1UBQEexpj06McdkwHR5shH8UQ/qO1YpfMtxFoz4Ci0TGxrH5k2TU3nAAf
 bNiGEDUsti5Xu4/fCv5pYKMizJC0iwr3CNeVHs/2alR6WeF2
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 18 Jun 2026 09:19:30 +0100, Biju wrote:
> spi: rpc-if: Use correct device for hardware reinitialization on resume

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: rpc-if: Use correct device for hardware reinitialization on resume
      https://git.kernel.org/broonie/spi/c/7b25dbafa2fc

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

