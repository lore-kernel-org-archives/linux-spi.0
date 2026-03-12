Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E078385507;
	Thu, 12 Mar 2026 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328886; cv=none; b=dKx73chFNH/YymATVnZKpp65hcW4i9lmszFBL0AInmukqnQSmiSAejhikb5nUvpe7C9d/eEJqWQvrsa6dHiDykZ6mPUppNXpz8vIvmvFDBQC7OoLqv5e+Oij+CTJdlvPHXh2pTHXJEEQ+mlJlNitg/8EcYhP7UT6ZZiwtMTu0Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328886; c=relaxed/simple;
	bh=TZ47/QNw+DjhsmT6n6nZ0k6edT084QuzVNQ1+tBuMYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uwoTs0fZ6G7PG36EUMVyoqlxZyhlGsk++VsbiuuoyOryANcm8NDLMqcbR7vXfE77agdAIKM7Oag8saY2hf+oZTRJ/VhXmE9uQq6NJwYMiuQMF9i4zYswXVFqc94cLB6d3uMIc4y8aHwNGrWPH7fgrEFJabnRbRzyMOBJ+d+QJJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpO+Naw/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpO+Naw/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A68C4CEF7;
	Thu, 12 Mar 2026 15:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773328886;
	bh=TZ47/QNw+DjhsmT6n6nZ0k6edT084QuzVNQ1+tBuMYc=;
	h=From:To:Cc:Subject:Date:From;
	b=RpO+Naw/E144laaG8PPGrz0xGuEJLe8ZY7eNl5Rzkb6yCWhZifXZpRrtyy6lsMsfv
	 pHyYOHz7aK4SUdM/tA8i7oGfJpUD0mpA4QT7MpQP55fnZl7xfmAJWy+zWmX6mSBuZ5
	 Whr6jwQY/UKHP0/2tfU/fywwK08/OZQU4BwA7LUV4N4soOG7yoE0XLmPwybeVGjawc
	 BhHEXmqSLlKDJEiTGOgUiqxQkkdBjoSm5Wflr8fC9tZcni+uS5h+xHBNtlY2Xp/IE+
	 VJG93WgVJC4x3aJf5L47XE4DOY1akhyhX+hv6j8kn1+mmAtPVLlYuWPHM4VVIxgYEC
	 uxGgz3jcnag4Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w0hql-000000008PU-3Quu;
	Thu, 12 Mar 2026 16:21:23 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/5] spi: controller registration fixes
Date: Thu, 12 Mar 2026 16:18:12 +0100
Message-ID: <20260312151817.32100-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a few issues related to controller registration found
through inspection.

Johan


Johan Hovold (5):
  spi: fix use-after-free on controller registration failure
  spi: fix statistics allocation
  spi: drop unused devres statistics allocation
  spi: fix misleading controller registration kernel-doc
  spi: fix misleading controller deregistration kernel-doc

 drivers/spi/spi.c | 60 +++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

-- 
2.52.0

