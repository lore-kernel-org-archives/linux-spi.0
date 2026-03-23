Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3498217F33
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 01:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230880; cv=none; b=SgviUSeJcV47MjEAlG7zEHtic7o0siYxFpH1D9C9n9U76IpauHJSBSJXIrNQoLeHvpmHz2xH5WPB2XiZLtb0PZgm1b2MoRUT9DDWSccxdGygK+Oi9eZ4y22LTmCwKxqTOBtl64ihVQHsnPSzQyP29LB2mEBd1cW4YyTxhTn99VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230880; c=relaxed/simple;
	bh=JUqh9KjJr81PA08LAGWLpc/TnqC1KKCJHttSUso4Mis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qBQq2DX8Rr4h6JKR40DxzLSlPgNe4c33Go9/11nH/TTx/y286Zpb/0SxwghPmO7eHzAIJm4njoUTcnps+lTJeJrXlq86AnM/9qDffo27upvoJu88Nurg+iE5pDdx+yDyQsH0PwVl2Qp4lq9cA9qsYzEHHjZAM8txdFA0t3gW9WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZihrLDn; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZihrLDn"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c11c43aca0so882153eec.1
        for <linux-spi@vger.kernel.org>; Sun, 22 Mar 2026 18:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230878; x=1774835678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CFNqFKHYHzU+/IYMzEM9SYl6am5Pz+NCaLhPwszpQBw=;
        b=iZihrLDn3uemS80BJaK0ZbnZyZPK2nOhEbJEKP9Ll6ZnR//Egc8auBEu1gY8L7f5cE
         vGvkiZtql2gdyP16RHs2zH7kzoNOG7ofXC1iRXWSmSKsMyYNdGKTIolRt7xdondUtWAV
         BzjD/cMkNClaTXZfnu4Z4TliktptCHKPofnbghtnSwTPk+HJZnI8ZGovdU41MDyZqlGl
         ZhKPuG1YF0fHUflmZwL5ltOscujQ8xhH/ZXK+Qk6sMFvlSvfNudRUSFwNbCiOnkbxgQx
         XAVg0mXyudvTdU6egJD+nS/ZZstD/tcd7Pq3pSfv2CP+pCaS9NUQdfrM5BQmCjDdSSfg
         yuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230878; x=1774835678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFNqFKHYHzU+/IYMzEM9SYl6am5Pz+NCaLhPwszpQBw=;
        b=Hif2AiWtJi08ZuxnREMkGUFn7PAPDkHv3hSKNsDp59AgjEbicEhFSMPWJbGg5HY5Lv
         HLR3gxgfj+PW8+YsJRYHplH9PblVYCBX3iCNEnLAOCkYq86b5nvRYoWfsDAlzaDaNLWa
         wqrxT2fNN5sf/4YdGtjUtsjfzhIODH/NzFvvmvowMByjIv8ISqNr8PEfsJQBKm7vd83i
         kkb4kgrVRuo7fKXNRN2i+G78rr/T6dBGUahMKsrstTnzyUFG8fXiSB6TFa4gwRsck9vb
         F8liSxZLJPy7y5c2lNevLc+2A5QqbIeNCLSgkyo1kv9Yx3/W6pqk5yLrkTu5WOkOmS7j
         SLLw==
X-Forwarded-Encrypted: i=1; AJvYcCUkxHaPxMiAuw17cjx54JjUfInPd2ua9dtlGnekOtUMMkbl0BdtyLvQoLFOXMNt8uKMMzm8HTvOkKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjjV8397//MXrlYIPJCHFyzDul8FdAm3IwS5YyBIceexCwLXyI
	04lw/7Zt0kzQTFf+QvU8bweuQue4SM5m8ncg8eU4WW5k32lj6xRF7QIb
X-Gm-Gg: ATEYQzxfaOMUS49DXpzGgguGb9AgS0OqDapIMJESivbloGXt6m8tLiDd0YugPMfCCIf
	0+CoxoGQNsvTJhieqxnEx8tzgOB4vDAQgx3YfOfvElUh2yV8SCuh7zrTIM99EJVmo/Mz7fl9DuK
	EKEfRIugRpQW7r1IgK1BTRNH2vDEyIl/spOROnslOEwJ+AoU4fJpKG8j6Ait0thO7Ux85yHqB4I
	bkemnjn7JPiU8MqxdCa1Hy4u7B809IThy8OevotYblJDl6U/DrZ195hCEL1wdFEvoraSkV+901O
	HSw6z468c7VFuaOA9dqwEVB4Nl+bDbuEqAkzqvc1euZ5y4DpRglhfv32H3z0Yia+YHEdKeE2caR
	dI9Q98ic5CxRchAeAfkJ4u12Zut7aVwy7ZQJXEyAtYK3dn5afUKmtHRgO0N5xWpqabsr22FdGaa
	VZHV9hFw538XlC/xby7sdEuFas4EhmubhycmfSO4Wrw8FKnJRSO1oZHw92ru4Xf7b/OOBBcMMWA
	MgFchv69kLplbQ=
X-Received: by 2002:a05:7300:571e:b0:2ba:a1a6:c73 with SMTP id 5a478bee46e88-2c10974ccb6mr3875035eec.6.1774230877711;
        Sun, 22 Mar 2026 18:54:37 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:37 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Peter Rosin <peda@axentia.se>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: [PATCH 00/10] Remove class_find_device_by_of_node in favor of
 finding by firmware node
Date: Sun, 22 Mar 2026 18:54:18 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260220-remove-device-find-by-of-node-077784fa109c
X-Mailer: b4 0.15-dev-a6826
Content-Transfer-Encoding: quoted-printable

Firmware nodes are generalization of OF device nodes and generic APIs=0D
should offer only fwnode variants instead of providing firmware-specific=0D
handlers.=0D
=0D
This series switches all users of class_find_device_by_of_node() to=0D
class_find_device_by_fwnode() and removes the OF variant.=0D
=0D
I believe this can be applied through individual subsystems and then the=0D
last patch can go into the driver core.=0D
=0D
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>=0D
---=0D
Dmitry Torokhov (10):=0D
      net: wan: framer: switch to using class_find_device_by_fwnode()=0D
      phy: core: switch to using class_find_device_by_fwnode()=0D
      spi: switch to using class_find_device_by_fwnode()=0D
      regulator: of: switch to using class_find_device_by_fwnode()=0D
      leds: led-class: switch to using class_find_device_by_fwnode()=0D
      mux: switch to using class_find_device_by_fwnode()=0D
      net: phy: switch to using class_find_device_by_fwnode()=0D
      fpga: bridge: switch to using class_find_device_by_fwnode()=0D
      fpga: manager: switch to using class_find_device_by_fwnode()=0D
      driver core: class: remove class_find_device_by_of_node()=0D
=0D
 drivers/fpga/fpga-bridge.c           |  4 +++-=0D
 drivers/fpga/fpga-mgr.c              |  3 ++-=0D
 drivers/leds/led-class.c             |  2 +-=0D
 drivers/mux/core.c                   |  2 +-=0D
 drivers/net/phy/mdio_bus_provider.c  |  4 +++-=0D
 drivers/net/wan/framer/framer-core.c |  2 +-=0D
 drivers/phy/phy-core.c               |  3 ++-=0D
 drivers/regulator/of_regulator.c     |  2 +-=0D
 drivers/spi/spi.c                    |  6 ++++--=0D
 include/linux/device/class.h         | 12 ------------=0D
 10 files changed, 18 insertions(+), 22 deletions(-)=0D
---=0D
base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e=0D
change-id: 20260220-remove-device-find-by-of-node-077784fa109c=0D
=0D
Thanks.=0D
=0D
-- =0D
Dmitry=0D
=0D
