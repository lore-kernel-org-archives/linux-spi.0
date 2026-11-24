Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532296;
	b=0b6SCFoCfizzj7i7jd3bGPiIrGpd0NPXv1jsgtExtfgrgP0znpafMaUuj9LMYq7cyiP2
	 yw763LxMnGSG7zCzQUIZbmWEkwxsy5wIc7nxShBhQKVUnSLfwYbpJa4N/8zWIs+cK+5MA
	 MDxNSyPyXRsllMtEj2wxN4MFmvJfZKBlHNPBxeCNRHCRmet98pXN1vbFbG/6au/aeodP2
	 RQ0Dp4pfySIPrqkYG/OoU5//qQwhmOtR0dckz1yYlKeZjtZuxQJb4WsoW4fnj+ebOnV7q
	 MhQXir3lGSe/6L97N3BWbN89GPssX0ri9+mvn4vgSHSE9TJtJVnvVrXk3ZW+99P6CXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532296;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=F8SpfrgJljBpYXkJktGSC0CUtlMz1/0LwBAT+/bgL50=;
	b=LOoxtlCYaQvpV5y+LDSoUECFBs6bW7v9KfeVLAUp27t8fQlgobvH+cLVE7PgO/uR6OCi
	 nyv6CIDKldnwvdZBNAglmMNHU43sAl95fhQGD587TrycCFIL3hr79dXZ7QLk4t2Kulsfd
	 HQ4VTudwNZMYY0dEImtRHyofJr9bxIcroLY2C5A8/Smp+1q8rnn2M8BRcYGFE3D0BoM4O
	 p6/o94CDnsyGXrUEefO0D2QBotVPj0vkRWbyfPjUJ4RH8ZbDDFwtP7hlLko58nrbKWPES
	 Fm64wOK2ylZ3Fjg40HeUm1uuVQthj2jcF8fx1jncizXERWA1zWLJ6MseXluXcf/KVhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TngDvwFV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21433606A31E
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TngDvwFV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456A61F000C6;
	Tue, 24 Nov 2026 14:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795532295;
	bh=F8SpfrgJljBpYXkJktGSC0CUtlMz1/0LwBAT+/bgL50=;
	h=Subject:From:Date:To;
	b=TngDvwFV1j7sClJjjFYevUPzKxK4Aibu8PsB9c8jajpswokmzN7ur2Tsy7iKgJ/06
	 GYhuHZFupI65Jzg/Wh4BvXXjPSLdZ5UsJTdCsN2iRBnkGv8PRmOofSww8dCdTs3hwB
	 rW/LYDaTkzHJdFXoSKOYzhq51UJNFWt+KHw6tCFFo+NTjeE6v06I/jlVgym0UW6RXB
	 HXmyzefWh6GdeI2B+CAjAw1oWDX8Wr7B2pwrTWnrfyLCx0jv6ZyNQcxrZojAXtcyMj
	 /yQlABFKJqUme7WssclBDfer5FyZ6TmA6995FjV6S/67LqPzDA4mE3PPdM9B4sQ0OI
	 JsSf3J+x7rVLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3373931128;
	Tue, 24 Nov 2026 14:58:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179553229375.3584200.13770732310560477677.git-patchwork-housekeeping@kernel.org>
Date: Tue, 24 Nov 2026 14:58:13 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] mtd/spi-mem: Enable DQS control (2026-11-24T14:43:01)
  Superseding: [v4] mtd/spi-mem: Enable DQS control (2026-11-20T17:14:26):
    [v4,01/11] spi: spi-mem: Rename the DQS setter and pin field
    [v4,02/11] spi: spi-mem: Clarify the conditions upon which DQS is usable
    [v4,03/11] dt-bindings: spi: Document the spi-dqs-not-wired property
    [v4,04/11] spi: spi-mem: Take the DQS wiring into account
    [v4,05/11] spi: spi-mem: Take the controller DQS support into account
    [v4,06/11] spi: cadence-quadspi: Advertise DQS support
    [v4,07/11] spi: cadence-quadspi: Decouple the read capture bypass from DQS
    [v4,08/11] spi: cadence-quadspi: Check DQS usability before enabling DQS capture
    [v4,09/11] mtd: spi-nor: Advertise DQS support for octal DTR flashes
    [v4,10/11] mtd: spi-nand: Set the DQS spi-mem capability if available
    [v4,11/11] mtd: spi-nand: winbond: Enable the DQS pin on W35N**JW series

Checked 231 series in 3.44 seconds.
This project currently has 17174 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

