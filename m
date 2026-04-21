Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2AD3D47B8;
	Tue, 21 Apr 2026 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782380; cv=none; b=GpKiZUvIVIqxL6G7C5sIGbvNFRBThM5qpdasc5XWASVSjzTliXrJFSrW1Bjsg5iT7YVZmX/LosKLIsyH1+RzK8Tlf6WogKpH+i/gZJ8iEtUkyEZd2sLgZw1xDkyyYpJCSPtn29EslPKVHbIupwm6litiF7XxqkYpzWwkyknyOEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782380; c=relaxed/simple;
	bh=FKFQen0ejTteZoiYk79WLYge9E72CVbs9krdenRQiVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e5a3MXPZvFZDMrE4y7rAOwpJ/rgkU2vS9AUJmLHkvQc5HBZv1tcexkjCe2WnkdhzpLFOLBxuEEuMR7nnL3HSNTF4D0E+P1nMbF/GNFY9nbZPKdbgkLsLOkevKMeu/Sr+Alh2Z6anEwJyCJBLsfhWyIejuark491jr+0OrGfrd2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBjXZgOY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBjXZgOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE96C2BCB3;
	Tue, 21 Apr 2026 14:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776782380;
	bh=FKFQen0ejTteZoiYk79WLYge9E72CVbs9krdenRQiVI=;
	h=From:To:Cc:Subject:Date:From;
	b=gBjXZgOYbtHtQ2r5i4ggyzAleJBVtnJjm8Jo+pTJEN61ed0n5smAW7kXUvnfaHgJ0
	 AanLE91XrFsVAcN8zTsQbCrJywZQ1In/h1brMOd+DMB2ITCEj6lM2DCSF86McgQ06z
	 QH/u/qThrpttcC5vKn1KetkbhRBzGEwA8JEbyqpCzr4f9j2h85b8sEAqJaJVbp6j3q
	 2jvBMIQo0N9o+WJTQyXSVn1B6qb3BWqGpgIfFLNCL0EZ43WscAQpV8SDjcGNoWyygQ
	 Jva6JzwtaMlSCXj3C5yKRnWptvId/oUmpWJQrT14A8vkbvGe7O6GX4mqfgcum3P5Gt
	 SrXUZa+yEgt6w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFCGI-00000006VhE-12Zo;
	Tue, 21 Apr 2026 16:39:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Vladimir Moravcevic <vmoravcevic@axiado.com>,
	Tzu-Hao Wei <twei@axiado.com>,
	Swark Yang <syang@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Harshit Shah <hshah@axiado.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] spi: axiado: spi: axiado: fix runtime pm imbalance on probe failure
Date: Tue, 21 Apr 2026 16:39:22 +0200
Message-ID: <20260421143925.1551781-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series fixes some runtime PM related issues in the axiado driver.

Included is also a couple of related cleanups.

Johan


Johan Hovold (3):
  spi: axiado: fix runtime pm imbalance on probe failure
  spi: axiado: rename probe error labels
  spi: axiado: clean up probe return value

 drivers/spi/spi-axiado.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

-- 
2.52.0

