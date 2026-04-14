Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7486C3E6DC1;
	Tue, 14 Apr 2026 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174341; cv=none; b=ewwtjbbjID1NBRlKXVZAj2Q0nX8YptioT9mAFtJLKl3qk+6F62wI48fjUlWg+bbz3PcbXEUPbgRm2gZN1SHmwpTXqNqsR+oy/RKCBHGIm8FCkzsXyiG1nyXHaFo+4kpgIvYnsJnzzVYn3VRqMGF7nS9lEwZ85DxLE8xuslSj2aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174341; c=relaxed/simple;
	bh=nVVHoxUeXvRzhoTJlBKK/t9o4nFBK0alKrR7IwK40lI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZMLD2h2sSUBgE+8nTfI61r6u50Kfz16G7zZaH0yfcoARgETGE7n8J5sX+ScEav/AVr5bxlQh7BAR6tntra0YS/KSnJz2a5hkK6o+zPz4cb9zMgz154lmXQr/OQ4b7WuAmpDUgAWf23R+j/VT1ZlnlHUa7Aeut3V7LG4pORVqM88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRPRVPH9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRPRVPH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0993BC2BCB9;
	Tue, 14 Apr 2026 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776174341;
	bh=nVVHoxUeXvRzhoTJlBKK/t9o4nFBK0alKrR7IwK40lI=;
	h=From:To:Cc:Subject:Date:From;
	b=nRPRVPH91exm+L5PHGO2CYd5v0Z2q7SmZ68eRM1qKV1RAUZCw07TD1E6hfsQoA0Pm
	 9FsGjtvs0OWoDp/jIDqpaWcFVOivucgxpL/tFxM6h7WVFcASV8nJAgw8Cf1JKu6UVa
	 W8LX0Oz6WxoyHDoqDZGryCOaHPONW/uem7+7O27ZBzKfJud/PVtZl7/ycwlfOgTfPX
	 59TDhQhIm7IgOYWP3favb73e91eHV7/Q4MFgCHL1jtlAlrZScbUrVyJNDQmP2hhEXD
	 0Eu45Ii3+32dlhxKvImBOFgunsydSlHeYL5g0e+9VML7Orbdr7AOrcmRdTYsmHqUsx
	 IcwgsCtSSRCUA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wCe5C-000000046Vq-2oW7;
	Tue, 14 Apr 2026 15:45:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/8] spi: fix explicit controller deregistration 
Date: Tue, 14 Apr 2026 15:43:11 +0200
Message-ID: <20260414134319.978196-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turns out we have a few drivers that get the tear down ordering wrong
also when not using device managed registration (cf. [1] and [2]).

Fix this to avoid issues like system errors due to unclocked accesses,
NULL-pointer dereferences, hangs or failed I/O during during
deregistration (e.g. when powering down devices).

Johan


[1] https://lore.kernel.org/lkml/20260409120419.388546-2-johan@kernel.org/
[2] https://lore.kernel.org/lkml/20260410081757.503099-1-johan@kernel.org/


Johan Hovold (8):
  spi: cadence: fix controller deregistration
  spi: cadence-quadspi: fix controller deregistration
  spi: mpc52xx: fix controller deregistration
  spi: mpc52xx: fix use-after-free on unbind
  spi: mxic: fix controller deregistration
  spi: orion: fix controller deregistration
  spi: topcliff-pch: fix controller deregistration
  spi: topcliff-pch: fix use-after-free on unbind

 drivers/spi/spi-cadence-quadspi.c |  4 ++--
 drivers/spi/spi-cadence.c         |  6 +++++-
 drivers/spi/spi-mpc52xx.c         |  6 ++++--
 drivers/spi/spi-mxic.c            |  3 ++-
 drivers/spi/spi-orion.c           |  7 ++++++-
 drivers/spi/spi-topcliff-pch.c    | 11 ++++++++---
 6 files changed, 27 insertions(+), 10 deletions(-)

-- 
2.52.0

