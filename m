Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7E466B6E;
	Tue, 30 Jun 2026 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834517; cv=none; b=OqamwNHJk7WV/iIyQ3JOpCUPIxi8K8+twp4vaEp4SQNqfgO6H3Pa+ealwIqaxRQLSDqe4xY6RjLBqMW+DQWuPT4f8TurJ2mjq5aePsxuit3tMU9n74uRtPU5Q5k4OxSdLll6fqHoXqjdZbZDOqp7KtHOqdjYTD+VcwQl76eUtgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834517; c=relaxed/simple;
	bh=3aT6CxRg123m2reAq5WHrVZnVtYMLxc+eKx+bwlOyv0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ayZOYofK74bX7nzBTn1c4zD8nWGYZHkKVlanFf0+wvWPPlJ3DZqm8ncxOMf/LdPDQeFmIMJ0XXc6IyPEna6jOjBlO2K3A+T3xw/Xnqt/GcguIoBlvrvL6p+PDdrR/iH1iD5QpdfQJQaqcbZ6kqSN9v/tfDOhqGAUUsgQ2tvS2I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6S3xUgf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6S3xUgf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660E81F000E9;
	Tue, 30 Jun 2026 15:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782834516;
	bh=kBZEp1JFxrH/4OTzag8TPsknqgwJ7BFgp8gDsVB7jmU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=I6S3xUgfLWgtD/1WNCeojQbewX/lB8YneJcPSxuul6xb+FCzhDQ2o8t0l/Chl7tt8
	 zc/tSkvtUI1DH0omkpWyNwxRffWGQTJzH2J5u8cOlX5jxc/EJVUxEtdEFGlfyaLnRA
	 K+kgVo6l63dcQ1HZ8UmtHHJfLLbgxPOotG8SBoKN836QZpY2/PdKd17ME+hC5aERZy
	 B3AUeOpW9V8BS9DCj169mLwhxs2xg4n/4WmpFcydwPX3hb+FKBC37+0ei6MBlfFIgs
	 xPjnr35yP1muyBZrZRnf6UOXAvR8bZ1UFjIUw8uJs5j6QPTttYMaH4Fn36MPH714Z6
	 vfLaxO9+xemGQ==
From: Mark Brown <broonie@kernel.org>
To: andrew@codeconstruct.com.au, Tomer Maimon <tmaimon77@gmail.com>
Cc: openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, avifishman70@gmail.com, tali.perry1@gmail.com, 
 venture@google.com, yuenn@google.com, benjaminfair@google.com
In-Reply-To: <20260609071458.2692482-1-tmaimon77@gmail.com>
References: <20260609071458.2692482-1-tmaimon77@gmail.com>
Subject: Re: [PATCH v1] spi: npcm-fiu: support dual and quad UMA writes
Message-Id: <178281884964.79320.1074539689471418305.b4-ty@b4>
Date: Tue, 30 Jun 2026 12:27:29 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3aT6CxRg123m2reAq5WHrVZnVtYMLxc+eKx+bwlOyv0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqQ+VRWpZb2kjWue0V0lyE0OjAH3ImoIn1Sg0g8
 LKQ+JtUNjSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCakPlUQAKCRAk1otyXVSH
 0CBtB/9u8MLuDpmoFlcJ8j6sseelqY4nWeIAaQ8WaiJg0cfVCLlDp0kfqVta/cj5QrCWfEnfQyx
 hgMOWzoFuGc9BeVQCRJfDkhZQwGTdG/9PiUdFCvb/M2J+RFeW3A+dJ3MmiPqJaqr93bCZtvLMml
 wGwqFW7FUWioOOBCA8McimvnwBFc+GCm7hn9h0ykbZWs6Bw+g6ZD287l7KjYBcby2G14AOsSkrv
 B732j1ik9658Fk6YmuoGEUHLJOSJ+Ikrjfks8NBAS6xDGn413r3zdPX3KjTy9XaVFNRBrf1AL0v
 VOLrrXc4OwVFvcV8ABEkKQbne3Rp9RONcDDEcOgwxGTpNabR
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 09 Jun 2026 10:14:58 +0300, Tomer Maimon wrote:
> spi: npcm-fiu: support dual and quad UMA writes

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: npcm-fiu: support dual and quad UMA writes
      https://git.kernel.org/broonie/spi/c/06f2005b9421

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

