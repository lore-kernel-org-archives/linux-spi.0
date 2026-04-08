Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E7728850C
	for <linux-spi@vger.kernel.org>; Wed,  8 Apr 2026 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775638466; cv=none; b=ti+iELn1gPrUmaj6mUr8fUFQQCdQM7g43ceCV4lBUSfEnM0QVc93suwuFvvlUeQY583c8sZcCXzs1C3NWBhl1LDzlUQgxXigHDzJLBt/MCh5TWIOVfCI/SD1gXUIuleluoRAGVa6H/Zidqql//Akk6jt11u11Ya9ho8LDRnYf08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775638466; c=relaxed/simple;
	bh=EJoIKdPOFttSrswQ0GhOBa78hx20inKvrF1KVKuuER4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D+QFpcwZ9Z7zMJ+9Aso02TfikGhMInAZNXeAzTr6cR45ta54fHEyGIYg6iu05GXUKNAb5vR+o+pbePOuh4pGREaEyxNOD/k/MYY5P65jDvWA4tIU38pmFZuf2qO2qxSvdawxQ+3NY/vn+9DMqnFXQi7WObBADRnIAYBVttbMIgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbqaqLI7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbqaqLI7"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so47364265e9.2
        for <linux-spi@vger.kernel.org>; Wed, 08 Apr 2026 01:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775638462; x=1776243262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=npVCOnxTjrbDOE2h2othHyWsXIp2uhsqGskjgUSWuQE=;
        b=hbqaqLI7NiMtlzaftxNdS/iakAotRc2d1XNqo//drautVFTJ5CwKo6591GpqceUoL8
         1IfQZEhCPOx1XXBE8uSIuIVvo9Qb6ebgM2vmPN3E6/zFV3K3sO7Cpp2r+/NTRUccFB3P
         /7g7jCvbgRGv+g2918cbUr+wyPcGMPmOb58IGvDfu0UGhW0Dkj6XQozAJhVYrYn91rfT
         +RtJ7DgJ5GzpxdVl9zlfwtSGiFEREq0ubJozJ7pgJ/tgucjPPYsgDieXj2lsQ2ZVSD0J
         hQO3EUnbmS1ho968Dfn0blct0Ggh8QKoPrjjjRjwU6Zl8O6XYlG+/EVwlc3QZo5E1NxR
         WCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775638462; x=1776243262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npVCOnxTjrbDOE2h2othHyWsXIp2uhsqGskjgUSWuQE=;
        b=fBTzXZaofaJ+KtTuCwQpQHFaAASJRxC/fY1SZY6EMoXU4CC4v/on4t2MAOeN09afRi
         1gYSorvckt1EMgP5DTRmo3ILU6nxw1HmUVu8gmh61SvqibfR9nPNZmwJgux4JOF37SlO
         P3V08sNjLUe9do/RMqQF64+Hy9hpljQ9ujnYQ/KqQ/L/o3gbAhY8nJozEW1viM/lr77X
         YvK7NLRhnTQaHanPSPTNQi3YMsDvekzJpaNS2o9x+F+qqxePjjWDtoDOCzjo6+kV3B0M
         UgLJAe36BARr7/2BoALaXW3SFaANT6if7QcZZRuhq0FAD7wFqJKtasHVcvOtqY+yAW9H
         5+Og==
X-Forwarded-Encrypted: i=1; AJvYcCWru5Uxy5PqPgiJkkM6vrXf5WF5iHMy7ZJuslehO0XEh7hP9hqbfhzdUxo5Dfuul+m77KwIcqAJcCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNZwdUOn1KFNGb7284GuvWb3oWpa7T3yAdzNPd2J2Yhf2+TLzp
	qkU8zN9VBBanzaM8ZHfyy5LVnrVU8RpoY0e9PhqG4hloc1YLeJKyvMW8
X-Gm-Gg: AeBDiesMZrpMmS1D4GBDn67yiqZFstZHVtLT1mu9mDP1/npLuAgxbAR3mXu5jKGAOxY
	t4VkFqeal5yzA2W3MsL+c1nwiQHAeiYD/UyKANS4lMxzKOAfYp1cano8vMhbmoBz8JOcp/XyenH
	uy8WE+96XcSn2czyA8jrovISf1Ztiivh+ilyaA5RHGiLR18VrxAJklXx/ib7oHzleMZnPtqjp5S
	p7x6BeuPp45Ly4J0iov0uTT2YZuIdTRulKPgY0fqboMM5BF1Gij48Ud0EwSf6BcRkSlZGgh/K3f
	dIoTw6Ur5Z/rjuGBjr9zZP0y+9Au+RP0YicQ8palBgyO05RbRsK3XRbZP6e8XPhxvh0OZ+F98mz
	gJgEi90oJIWgcH1d9WAXaaPDcQtL33iMo6oU2c5WOU/B8h6kvUcS/y0/XbGbX3qdeYrfqsvS+27
	rsZE0szOwIYE/Yp68N+vKWQMTau+q+U7mgfeqoMaVd+mmWKIk=
X-Received: by 2002:a05:6000:4201:b0:43c:f28b:8863 with SMTP id ffacd0b85a97d-43d29295e1bmr29241260f8f.13.1775638461548;
        Wed, 08 Apr 2026 01:54:21 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:f65c:8080:131a:202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c50a7sm56437678f8f.15.2026.04.08.01.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 01:54:21 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v4 0/2] Add Renesas RZ/G3L RSPI support
Date: Wed,  8 Apr 2026 09:54:13 +0100
Message-ID: <20260408085418.18770-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

This patch series adds binding and driver support for RSPI IP found on the
RZ/G3L SoC. The RSPI is compatible with RZ/V2H RSPI, but has 2 clocks
compared to 3 on RZ/V2H.

v3->v4:
 * Added a blank line before the dmas property in bindings.
 * Collected tags for binding patch.
v2->v3:
 * Added ordered DMA names for the dma-names property.
 * Dropped the tag from bindings as there is a change related to dma-names
   property.
v1->v2:
 * Rebased to next
 * Collected tags

Biju Das (2):
  dt-bindings: spi: renesas,rzv2h-rspi: Document RZ/G3L SoC
  spi: rzv2h-rspi: Add support for RZ/G3L (R9A08G046)

 .../bindings/spi/renesas,rzv2h-rspi.yaml      | 29 +++++++++++++++++++
 drivers/spi/spi-rzv2h-rspi.c                  |  8 +++++
 2 files changed, 37 insertions(+)

-- 
2.43.0

