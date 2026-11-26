Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665495;
	b=YQwS3hmuZaGe+qJstf6nwGhiRbeaAtI7G/u4bEVUqc7/cDny0Uqxh42s+FyhtmW8qE9q
	 inlx1ouWO1wBq5aPeEMQXJL+iWR9i3VNVrAMY6yttqo8fgChECaf3zLTCGq0kOw8G4Vbf
	 r2aoHzQ23cYf4Ip8gLrCaSudwUs0BFkTHOCQWOBghOP9ShjDViMB37I0fKHTOAvKXA44D
	 vei4qtZx2VhKYilw782xbVMe/JtzIidFAK/iU192TqVJwSnkiBe8eLqfnuGPWaiMyT60n
	 x+dZnq0tYHqqaK/xKyTx0owPg5vRH9YAVXex3pOVigImPX0XsJJ1HN2EAfbL+kZ3Z0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665495;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=8Uvfp3kAMVPps3l8uCkPP9SwwKiOjA7r7AJUGrR9jAk=;
	b=UqUgPIP4pEQV9WY4hGdb+8L0QDQ44t7jwgkLWUWbjf+c5J3nyvYBvc2AQCtIX6SgVyoV
	 Pc8YzQxfM21QeY3zFYfVoTT+ofCsDnBOTPNgt4TYPVb82Wo4E6eVUCfpP8oed54JX/CEV
	 cAD1lYWM1k1pURRteohJLKQrm67z94efcvCk4wUz/4zhueVl8hWYINOb/qp3iLGCNiRqE
	 hpvUFCMLqAr28bW9W/I5VqYtCa6BgiZR3gm58XpUvWkwU7Tor42M4HSZ+RjxyquVGEhrR
	 c3uv4kRciyHbTaRDHDUTp4KeE4LJ/z36pYD+E/v49eP+tPLPpjG079t2R54k7rd2ESQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzZvlwT3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4CC606A31C
	for <linux-spi@vger.kernel.org>; Thu, 26 Nov 2026 03:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzZvlwT3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B7C1F000C0;
	Thu, 26 Nov 2026 03:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795665494;
	bh=8Uvfp3kAMVPps3l8uCkPP9SwwKiOjA7r7AJUGrR9jAk=;
	h=Subject:From:Date:To;
	b=hzZvlwT36s50p9bSNfnYs8eYJ7tpkTAQ5Kha/Gzzy/Wz8fW9n5RwFzv0x0Zm4B3dE
	 XwfDuhu3DuB10JRrafTw/qMeMzBVMyxtd9Hsbo5JYmTaBNlIaWMWQX1F0h8AibmUcm
	 EQY5r6Xukb65e15EkN3OtM93NJ4hGDr5e4EyB5LrEhu7NVvWti96VIjr2F1NhOu1y3
	 N7hBCg8wz5Pr1LORYvrPLffsef44Fy2J+Jen4hVFi3HM7sRcd1cPxkJwGV22Vo5lyX
	 U380SOMm7SkOADepde5qRjr201kscYRHyVRHlVDsgxG8dxPGO+1ohhR0uHKc4Y59Xw
	 Ypvbl5+FNyJEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774083809A24;
	Thu, 26 Nov 2026 03:58:14 +0000 (UTC)
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
 <179566549311.1485712.17983325446895309652.git-patchwork-housekeeping@kernel.org>
Date: Thu, 26 Nov 2026 03:58:13 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] soc/spi: mediatek: Add MT6789 PMIC wrapper and SPI support (2026-11-26T03:10:02)
  Superseding: [v2] soc/spi: mediatek: Add MT6789 PMIC wrapper and SPI support (2026-11-26T00:07:13):
    [v2,1/3] dt-bindings: soc: mediatek: pwrap: Add compatible for MT6789
    [v2,2/3] soc: mediatek: mtk-pmic-pwrap: Add MT6789 support
    [v2,3/3] dt-bindings: spi: mediatek,spi-mt65xx: Add compatible for MT6789

Checked 236 series in 2.71 seconds.
This project currently has 17200 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

