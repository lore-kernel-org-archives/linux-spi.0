Received: from mail-m1973172.qiye.163.com (mail-m1973172.qiye.163.com [220.197.31.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4667363087;
	Tue, 21 Apr 2026 03:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740635; cv=none; b=XiwhPfQAKfD0S0v99aYuuVUHOl23Wazy6mMonm5kpI1RFu479UjExferZk1s1wvFVeWMHxmGaumHO2JnNoS6ILpk2fR6PhlTT8UvMkItWUjvcIutoSv/d9FOQQ9R7CodLtKy1hPwnFWj4yeTgXfaSdDxNcDnhbH5f+5/d7CYVy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740635; c=relaxed/simple;
	bh=xABC7NlNpz7vf1ZJxUkC/SLhl0E7A1uSNQbITjwzm4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HImB47Ub5jM2t3V18JbrNHUonCP6LXnd3LCcHGDuKFOHCw7OP6pZypvL2zumcmSWRN95zgtFE53b6VtWne708V+Ox57jadE9KyrAn5m/0Ps9Yz1dkkIXnTDHvZnJfYUe90GgZafGV4CnI+GoVEYriozBqgExnzstmV9pyRWxBLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn; spf=pass smtp.mailfrom=cqsoftware.com.cn; dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b=Tm4FpOBe; arc=none smtp.client-ip=220.197.31.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b="Tm4FpOBe"
Received: from localhost.localdomain (unknown [123.149.2.191])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3b7d8837d;
	Tue, 21 Apr 2026 10:58:28 +0800 (GMT+08:00)
From: Dewei Meng <mengdewei@cqsoftware.com.cn>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	olteanv@gmail.com,
	Dewei Meng <mengdewei@cqsoftware.com.cn>
Subject: [PATCH] spi: Fix the error description in the `ptp_sts_word_post` comment
Date: Tue, 21 Apr 2026 10:58:08 +0800
Message-ID: <20260421025808.6572-1-mengdewei@cqsoftware.com.cn>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9dadf9973c03abkunm17de137070ec1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGE1KVkpNGR5KT0JPHUMaGFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSUhVSk9CVUlVSkJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=Tm4FpOBeb7uwq9FRYR6LbopjJ+hJ07yeQlzK6zLhzEte9AKIHRAMy2LLkIVth6KpCxCKuaYE4syP0ijSLRsGh9uZnR2AivW8woOHh22XwoXkNQAC/TVwmSoc2vLXnv4dpZfsNP+hVXycLnykyRuhcK9v12cgsrd8NawDQIhTEyU=; c=relaxed/relaxed; s=default; d=cqsoftware.com.cn; v=1;
	bh=FAtCE5MXbsit9oAI6z4B1N0ULox7o/NRnCgplboNCmk=;
	h=date:mime-version:subject:message-id:from;

Based on the comment information, the description within the
`ptp_sts_word_post` section should be changed to "See @ptp_sts_word_pre".

Signed-off-by: Dewei Meng <mengdewei@cqsoftware.com.cn>
---
 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7587b1c5d7ec..82682dd9961d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1019,7 +1019,7 @@ struct spi_res {
  *	this value may have changed compared to what was requested, depending
  *	on the available snapshotting resolution (DMA transfer,
  *	@ptp_sts_supported is false, etc).
- * @ptp_sts_word_post: See @ptp_sts_word_post. The two can be equal (meaning
+ * @ptp_sts_word_post: See @ptp_sts_word_pre. The two can be equal (meaning
  *	that a single byte should be snapshotted).
  *	If the core takes care of the timestamp (if @ptp_sts_supported is false
  *	for this controller), it will set @ptp_sts_word_pre to 0, and
-- 
2.43.7

