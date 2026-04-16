Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C4923E358
	for <linux-spi@vger.kernel.org>; Thu, 16 Apr 2026 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776356881; cv=none; b=VxhnplqUCaWumy1TN+4ZwIG8HZIw7zEayZfQIQzD84MLelIHLeguZzIqVDceixk3bBGC6B6wXFOvcAX/3/q70AeOZB+//Xr1Ay3xn9heItWas1X09U2JqCcTAWUZ7zaegr0c+B6kHrq2zT5+sYlR8dCB0P0CMgTnSYzaRFkYvPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776356881; c=relaxed/simple;
	bh=YMl73aH4KCWmcZhzy1kNt6OhMQrRrKxu8btA1SYb2zc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=luUyHhE+njd0HAW9sCqdhkywrpNGtZvk7TnLVXRPARkGsLJlG66i+ILMxxM9bq8OhLGaO3eIRwBTCBNR+DstIhmXiUt9Ye0hrsci8h8kXxMwCJOOV4aFaAp7nMIiuCp9rBTDzsuGbHK2GOwMVayal82C+MM1S059rjEKZEavme8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeYtxBLj; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeYtxBLj"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c7971d0d97dso194495a12.1
        for <linux-spi@vger.kernel.org>; Thu, 16 Apr 2026 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776356880; x=1776961680; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f4HQgdx0gxOhMyCh3gLFtRCjGaeHqrtqFB7gzbBjsAo=;
        b=aeYtxBLjwPguEyQVH+1kXikiQe0qIlH9vY3VmK4dGQ0W7kgeeqfEeHU9h1e6uXXwGH
         ukvrwN0E5+tXWzm4PXUF6OF1qJhfrwxxPK+wq3tW1Ir7Wp4eHn3M+95uJjhPq1HHUTOp
         1qizs6oWBMkZrwAqllmLZyfbvF2sPyc2L1TH8fLYOfXXHZjIJkuy2nC2BQcw5DPGVACp
         n2yzrc8/0rQoRUxkL0Z+g43yk/Z1HKyZKQtpQPnGYvnTRyBHetCLWZvr59um7nii0F19
         R1y5SgMxMMA3stKd1oj8ne78RLhptGn3YjpuMjkw6zSAOCdM6fbVzwU7nxmKzbv53Be9
         Uy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776356880; x=1776961680;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4HQgdx0gxOhMyCh3gLFtRCjGaeHqrtqFB7gzbBjsAo=;
        b=NxX/aBhJqWktfR89QJcLJIXD8XZt+xkRvJ2r+cX68KxIqD0GdglaaMJ7yFd2XvaRoQ
         4WGhcdVG08hsN7Par0lLe2/0T9vxy51T4JZ0qDgiaXHlsjR8EXtmL75NfByHi/briaXN
         Bt7HPXS9dIxTlV1JpUOIbzeFbsjK2wnqulZoStdQgq64FtWbLmqJutTUBVgCrPsG0bK/
         upvneyBag8HT1W91XU558Bl1nxwdklTTquQsVkbZTgaNS6m1xsvIWr5QTU0sEG78BTeA
         X5ts1D5QUOH3jKB34Timzbciu5ejXvdxzc8nWAfcgPboUPzrqfe3V9N7RJb6eVsaoxST
         NKZg==
X-Gm-Message-State: AOJu0Ywu3MI33lfQNnlruOSUaTbv6k2tvSjB2uTcHpID/QqxYX7XVY6E
	giFEhiytWVbPZLTfOGJl6vsanPwxxAZ9J+IAHb5YBwtBINs/vq3oPrEW
X-Gm-Gg: AeBDiesdlqBkXM4C2zwpeXlEBxOsTmzLrje7HytKBIMixcJYlXS070zqvjikbWJJxp6
	5vojm9FVXo/ZgzEyFyNNSbd6RpodQBymTcCMPVO0zaTiiZSQaHfQupr/5sTi9T2+fbxDv9BJm89
	5s/jKHyO+RswoKr+lskCy4AbVDn/lK3rq0FSOhDvGXpO/sJ62TvGt/UI6JGHbSS3etF6wnTwrqb
	4GubLEe40SpjZ2oinkpw8Hm0c92vu4MDDllAyIgG/1+dr5E00z04ivG636sj5JY/dAEefWkMn/7
	WWdQi2azX4lQwSRIWf5q/ErNI27JW19nCNM1zwmDsBXBPdRkuxvfmZ7QrQjX/jlSEBqAvTqJQSO
	jJKd3Y1JmZ42MUNIVRCMcSZWbE65NN+i3hE/A5mWOHYmkzHnYIJgdJuQbpFe4OIOd5JbtsuI4f5
	YLwU30n8zpaBjnu5Mi5pjTA218ju2ry0mWZNKtMQ0gdag+0L7btiJ4KtsvPUnxpCuZ3lcbTJPRK
	zoHcDjDfxuWbxGzG785bhxAGXCF0zwQOeEyOlt7TQ==
X-Received: by 2002:a05:6a20:72a8:b0:398:6ea8:21d8 with SMTP id adf61e73a8af0-39fe3d484c7mr31523448637.15.1776356880060;
        Thu, 16 Apr 2026 09:28:00 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.125])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7957ed03f1sm4899852a12.3.2026.04.16.09.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:27:59 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Subject: [PATCH 0/2] spi: atcspi200: two cleanup
Date: Fri, 17 Apr 2026 00:27:53 +0800
Message-Id: <20260417-atcspi-v1-0-854831667d63@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAkO4WkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0Mz3cSS5OKCTF1LM3MLkzSLNKNEUzMloOKCotS0zAqwQdGxtbUAf7A
 2ilgAAAA=
X-Change-ID: 20260416-atcspi-96784f8f2a56
To: CL Wang <cl634@andestech.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776356879; l=445;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=YMl73aH4KCWmcZhzy1kNt6OhMQrRrKxu8btA1SYb2zc=;
 b=KiTS1TLgGdPcZcFsqc+4YEbOohvhEcv4oM0TUvoRcIzFJ7Sx+ug+rM9ZqooyPrCi+U71v5a8G
 4TxuNDEB9HrAduVb31GkSKdzEsiVuiFqs/ji/F3hWoW4XhygguPYEvh
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Felix Gu (2):
      spi: atcspi200: fix use-after-free when driver unbind
      spi: atcspi200: switch to devm functions

 drivers/spi/spi-atcspi200.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)
---
base-commit: 936c21068d7ade00325e40d82bfd2f3f29d9f659
change-id: 20260416-atcspi-96784f8f2a56

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

