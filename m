Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5DC49218D;
	Thu, 11 Jun 2026 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781204352; cv=none; b=k6KP4DU8vcW4L7a+8MUQlDC9F1AnSD8LOgxReYQfUtRbqnFJnD1afBZllhW5oecg4OYWZL9RLoyCKF1u+KdrzfgP8vHaz8+JbqQ/IA2u8xxUQ33nc21C+8vPOhnlq5AHdxh2zgDLrfVxJOUU9eZfdYAUzOsP53BYYLgHr9OmaXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781204352; c=relaxed/simple;
	bh=xXx1jucA/9s5kzhCVKi8XcrAGjZlbqnwFgFQ0ueHREg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Is6u+W/TGb7zCwhrdzBHVOAqgsArS/i1U1BB/dxwtWcaTwQ6fPbWaqLMVgCzqhYpedc+LZget2ENN6kci5X/QmxRI7b62qAmoSQy5rt5zCL+2ASFe3yOhLaJjS7dtibOIN1yZFTTBWohn3UmOIl5fSdSLk76C5cSWe/rN9SourQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHN8CpDH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHN8CpDH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92051F000E9;
	Thu, 11 Jun 2026 18:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781204351;
	bh=6ePKOTEBr3Zye33oBfPPCqMMmmGHBNbLgrW8NCTLnyE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KHN8CpDHe+Ej5FzosN8LT+67neziPAUPiC5yusdGcnIyC+ffzU3aMdxgz/I95N+X+
	 TxjukzNkQM3/V8hrrJ46lSf33IZN94ME6oaItqH3LD+07kzzzTW/md6qgFvF/p1/nr
	 1nyoRcQdTOOSPl26AL0hsUq+s5qouSwv2X9r0guvuJAChdFzV6N3CtuqxG8qvhV5rP
	 7n7cgwZikPwdspeWNeSR54KXpUp1HjxCcfeD9xeajctzOyeX2LrCMh027xT0YP9z3c
	 5CPvW3yvIYbJFpKbun6/hwwj9Flj3xDSai/0cmEMxY0BUGXnRyRbWIhHktzJLexAWh
	 MadKP2ABbh1hQ==
From: Mark Brown <broonie@kernel.org>
To: andrew@codeconstruct.com.au, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Cc: openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com, 
 yuenn@google.com, benjaminfair@google.com
In-Reply-To: <20260609163919.3321228-1-tmaimon77@gmail.com>
References: <20260609163919.3321228-1-tmaimon77@gmail.com>
Subject: Re: (subset) [PATCH v4 0/3] Nuvoton NPCM FIU DTS fixes and binding
 conversion
Message-Id: <178120421867.467928.992304316732142101.b4-ty@b4>
Date: Thu, 11 Jun 2026 19:56:58 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424; i=broonie@kernel.org;
 h=from:subject:message-id; bh=xXx1jucA/9s5kzhCVKi8XcrAGjZlbqnwFgFQ0ueHREg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqKwU935LBj9sJj9JbwPjU75Lf4E7AcC6iMIjxw
 GKO/U/RBweJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaisFPQAKCRAk1otyXVSH
 0FsEB/wJ+NDrOPaCKpYs5fpCZe7iE/Ff/1x2rOiJqSWMRu/Uqa5P3lcFSXqUGsIyBiK3/9QhX4M
 oos2AEmxBEBJzOfXD4dc/0SwoyDcXf0VPk44pDXZt5les6kyrKPB6q6Sd94SGDbM0fe1+6NFsvD
 a0sedlR9vjZ0fW0WzXgAuW7D5D6fYCLA8LCSCK6fXGhI6fudlvU1dueMbG6D0zHI2+YEtkfJq/e
 cQjlMeGnV/0FmPCbG1kJctft1AE/b/ArdlvX1RCGVC2yumNwajQQedw8fAsxhKTeg4/08ravZ7x
 VzCkYCwwTRaIMFQ/QSusc3ihpAwCyIgSXSMl+8/ZEMmIQ6BO
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 09 Jun 2026 19:39:16 +0300, Tomer Maimon wrote:
> Nuvoton NPCM FIU DTS fixes and binding conversion
> 
> This series fixes the in-tree NPCM7xx FIU controller nodes so their
> resources match what the DTS actually describes, and converts the legacy
> Nuvoton NPCM FIU binding to YAML DT schema.
> 
> Patch 1 drops the bogus "memory" entry from reg-names on the NPCM7xx FIU
> nodes.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[3/3] spi: dt-bindings: nuvoton,npcm750-fiu: Convert to DT schema
      https://git.kernel.org/broonie/misc/c/3da90b29241d

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

