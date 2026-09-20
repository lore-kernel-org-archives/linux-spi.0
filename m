Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EECA2BEFEB;
	Sun, 20 Sep 2026 03:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789873685; cv=none; b=gqJQKIuzT1QeLRrFtGDCE44rvY/W2pfQGnlDR88HFYBToOOZAqjADZ6NrrBhwBNQyJ3QVxNQbQvBsqs4vk2bPpru1BTf2Re0qz0cnuZcFIBCc1V5HJ4prlNmP0kFUJUMmVzsZ1np4MKnX1bOj2KH9Ud0u6aH4JD7PiIzRHAGSLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789873685; c=relaxed/simple;
	bh=GbbStNisx5MN/XpaV/2yCe9bX3eW2oO41P/jpQ6XAq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuEYbAqJcdFmzaLUF9F3o8fOXfX+gXtODCpGOfHpoRkJZ3MVe5VCki3WCwHT8/yKSGCC7aNN8fiYvfejzUBXjQOG9pyxMwnYgt9e4ykh4oUJ/42CAQUTjzcefjJYMEKLlElhRKQhFUtd4lNBc+PMChxZhrcAcuHk/A2PGXKt3c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Cxy9D7rN; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Cxy9D7rN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Gb
	bStNisx5MN/XpaV/2yCe9bX3eW2oO41P/jpQ6XAq0=; b=Cxy9D7rNiycPplCBYl
	zWekRSO2xDBX9OfDvrQAk47PhhvS6fsfJ5kG+jONTAyc5CKxUEMTxb00ya+wdezO
	D/9j/niS5HfSNajujDDxuOGjJvbjL6Mw5Fo7gqIAjVvd2Q2Ag3DOmmKwlXgEyNmt
	g024BAsMw6Lr0ygQfP+KgH+0w=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3n40ATq9qZYxrAQ--.5143S2;
	Sun, 20 Sep 2026 11:07:45 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: geert@linux-m68k.org
Cc: broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hppiscas@163.com
Subject: Re: [PATCH] spi: sh-msiof: propagate setup runtime-PM errors
Date: Sun, 20 Sep 2026 11:07:42 +0800
Message-ID: <20260920030742.97089-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAMuHMdWaf7hYoQPCUBJmyErujLMth-_FAwPqZ=2dF9wkN5kc4w@mail.gmail.com>
References: <CAMuHMdWaf7hYoQPCUBJmyErujLMth-_FAwPqZ=2dF9wkN5kc4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgD3n40ATq9qZYxrAQ--.5143S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRFoGBUUUUU
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7QEa4mqvTgHxvgAA3R

Hi Geert, Mark,

Following the code before the move confirms that the unchecked runtime-PM
get was introduced by:

Fixes: 015760563ec7 ("spi: sh-msiof: Add runtime PM lock in initializing")

7ff0b53c4051 moved that operation rather than introducing it. Please use
the tag above for the applied fix if the metadata has not already been
corrected.

Thanks,
Pengpeng

