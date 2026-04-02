Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECB030E84B
	for <linux-spi@vger.kernel.org>; Thu,  2 Apr 2026 02:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775098633; cv=none; b=UA9f4lPU+0pNiRiPBmkiGpUxLfFSmQ5AXlrZlPkcIgVjKdEinwm73QQoy5bK38zqhKG+fWNb1dsov6Bv2Y09Yd/1rlLYIgfrfFr6mIwwPhUyk7iZC9N7L9o5jXg48oHR3HI89T5oFuy69Ps2Cwro5WZM8bpjqTXuwFm0MZhRj2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775098633; c=relaxed/simple;
	bh=pxocpPvJp3j9bND4rRo/dGbTkUNsN7WL5S2yZec7/3Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=BNmKpBJ2JNsIp3R8B1QHIdBqOhYeA42O4IXsEWgoZq6EXY2MapgUHoVqYtwt/SvKqACfnowcxGacrTtS9zjJ4U4ln7i5OzFS5OFDen4nNWG+mvfoIbMUw+NuoqyV/d5t+mgD9EuqzEhnCqHr6iVI9E/9AqdHUFkljVOI/l1RR+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5xdKQ1p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5xdKQ1p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B3BC4CEF7;
	Thu,  2 Apr 2026 02:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775098633;
	bh=pxocpPvJp3j9bND4rRo/dGbTkUNsN7WL5S2yZec7/3Q=;
	h=Subject:From:Date:To:From;
	b=f5xdKQ1pZFcypcO/5FYAawlEulF6w8MKkWtHxt02h9AH12zqzvQ/SG01iFYH8CTQ8
	 SjmCKLDaN/uhwKvi+Tq7GAP8M2RGAK7NMtV6a1kTdpcC3JDVpmfrEbcrqu1aikfHdK
	 v44T7Wx9gn7s6DSlBR3ONXYgFY02KXH1Mmf6742JoigTrxJlrsMvKpFfgdrMID3RAu
	 6GNwgy4zTYGCq+kbaJgjlYONeVhC4pQ30t2xH7Wk4+Qd5ONaIsVUh0Xpg/l5kNW9Ql
	 1XrPmQ+niJSvByDxRjpe56WiUgD+2YZ/7eu3/LsLrv7Xjgq0N/10fzVtZEya9mz7eq
	 la/tF1bl5AK9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE0C3808203;
	Thu,  2 Apr 2026 02:56:57 +0000 (UTC)
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
 <177509861584.3965335.999222477927589181.git-patchwork-housekeeping@kernel.org>
Date: Thu, 02 Apr 2026 02:56:55 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Add spi-hid transport driver (2026-04-02T01:59:37)
  Superseding: [v2] Add spi-hid transport driver (2026-03-24T06:39:33):
    [v2,01/11] Documentation: Correction in HID output_report callback description.
    [v2,02/11] HID: Add BUS_SPI support and define HID_SPI_DEVICE macro
    [v2,03/11] HID: spi-hid: add transport driver skeleton for HID over SPI bus
    [v2,04/11] HID: spi-hid: add spi-hid driver HID layer
    [v2,05/11] HID: spi-hid: add HID SPI protocol implementation
    [v2,06/11] HID: spi_hid: add spi_hid traces
    [v2,07/11] HID: spi_hid: add ACPI support for SPI over HID
    [v2,08/11] HID: spi_hid: add device tree support for SPI over HID
    [v2,09/11] dt-bindings: input: Document hid-over-spi DT schema
    [v2,10/11] HID: spi-hid: add power management implementation
    [v2,11/11] HID: spi-hid: add panel follower support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

