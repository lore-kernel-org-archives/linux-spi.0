Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F091404BE9
	for <linux-spi@vger.kernel.org>; Tue, 13 Oct 2026 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903478; cv=none; b=S7zvUMeMiG78+NqYuF4g6Ms3Ud8xMNYej0QyqXZ0KMl0sgACsKiiMpXxXJAFUX1ELVdBsZmbVS1FUwJRnvimrkmfQKi/GgL7tcu5iy5QWjp5ni5wKk6Kyf2dRCxg4suH5RCPw46ry/SyX/h/nRFgb4RDZO8z6pz+BVTFdO1+NDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903478; c=relaxed/simple;
	bh=bD9I/uC9JZAk74XZwpxfOOqefzws3BQVQP3VlERFI84=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=nMZI8ZPXtm/Wsh3v6AvEgMxMSzeTf28XRwfCgTrWnWqp4SN7/wWGb/GtIB4NJqNvQBw6BkBHYwO4OFJVtR1D2pPSeb4PrBEerg85OF7/5NI7ql5KD6EqXKmtSgB/BHO1OB6uZjY+8+Qnx/RoOyFjIUns6Hd25uiZLuKYxULXMCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7a5xyDA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7a5xyDA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE901F000FF;
	Tue, 13 Oct 2026 14:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791903476;
	bh=3RoQb9nOwUjig5Lhmoqa2dE0YkCaPEB1NhoM2Gn6xoM=;
	h=Subject:From:Date:To;
	b=T7a5xyDANKjomCsc+EFnFlhxiG42PtKMigK8aUeOZsQWjqN7dU5RgR8GF/298dX1g
	 cvDW38F3mpT2LToWCxmeQDAr9h2R+rIKeq5z+8tJ5pjQyz/4sgG0F3xNfD7/+zi+AS
	 UZRDl/4CZjjcFmul3XZ338/N3xlPXK/Zx2lKYUpL4ayaAh6NslppYFPr181s6T6PzM
	 kz3Nqq6lL97yBKPlXXkPytEnbwzM2TgeOphGd0Rq5MKU+egrj1Iq1LGgY7lvT0f0w/
	 KGbuMohMeYchjsWBpwRUY7dwLTvA4VCsdKef6WyjDYFDWHtfjNtNlCVJGI6Ysd9DUt
	 y/eFi8yqGnjMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B447739D2678;
	Tue, 13 Oct 2026 14:57:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179190347536.359677.13783753975971858065.git-patchwork-housekeeping@kernel.org>
Date: Tue, 13 Oct 2026 14:57:55 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: Add support for panic mem writes (2026-10-13T14:13:43)
  Superseding: [v1] spi: Add support for panic mem writes (2026-10-05T08:11:35):
    [1/5] spi: spi-mem: Add support for panic mem writes
    [2/5] mtd: spi-nor: Add support for panic writes
    [3/5] spi: cadence-xspi: Add irq-less support
    [4/5] spi: cadence-xspi: Don't use infinite timeout in register poll
    [5/5] spi: cadence-xspi: Add support for panic writes

Checked 201 series in 3.36 seconds.
This project currently has 16755 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

