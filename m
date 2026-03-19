Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D48E3E8C53
	for <linux-spi@vger.kernel.org>; Thu, 19 Mar 2026 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935468; cv=none; b=aurJSBDLjPMHUwDMf7uTlAqjDY7rc2aJC2CdB4CmeWZMzAZRqrnpGW+ieCDW60tprom1iH7GdS6jZgY8o4Ia3iq9Sl14fbReKk0VbUdW+mj/oKzL04J5HLkegw3T9OH6s8roSBpNKD/akwoUVlfpK9qVrRKjAUmN7bTnYPtFWnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935468; c=relaxed/simple;
	bh=htbKaCcPsqzgp0/d0xa0hAnmfuRE6MBP7rNT/fVsEJA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=F6AQP2SNgT4iU2Y6Q7zLBbAIYXeXrQmXxSH52uHc05J8AvmGlsmvxgP4i1LJZ3uWiEnXOoRqJoD0wLvBYeQR9iIr6wt2BnqqWkk1IJ/rxgjgWsPM6eKzqFiu27lSJEi3dNSBj3Zsdzls6tPojaf1LealNy6Jw2gXwgGQDfuMVKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tpVtFitg; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tpVtFitg"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-66847de014aso1616030a12.2
        for <linux-spi@vger.kernel.org>; Thu, 19 Mar 2026 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773935465; x=1774540265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xF1PTk3vkRprEYqnuXa/M55cUPdQPeSRT5BOEVfLuaM=;
        b=tpVtFitgUcZSxDhtjADajQeOZRyahtjtEbxJv/fjQCOC4bCziyO6GJZl+xcioqO+wi
         nkdx2Bulsom51QfCWhlDn5jixnr/Q+hMk/GkPRt6lNVsJXjsjgWLloOhicdHQ2m2zJXJ
         Q9v2d8oafUQlnHMl1fXKoUX6bXsDkosrpDzhrE0O3QFwnFgoDstwbidHw3TO82jcvmjY
         JkkrBvqDPD1XcgpAIdWEPKlELHLpWpXyQJjbSumfPTgK55bfCWBWAR1Rx2BsoPl1WZq7
         0Ut6tDGGiDlA29NuGza98P11rOKhqvBZzHLLGPQCxmiRxmMhWqKwedfUAbRJo105XS6p
         zXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773935465; x=1774540265;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xF1PTk3vkRprEYqnuXa/M55cUPdQPeSRT5BOEVfLuaM=;
        b=j0TJvDjnYe2sZD92gYs/m8k266zdaCyhKm7u74lc+q+ZNMQDUfMEpW/7Yoh1f8WKm2
         lcT0KKgoOlWwALmEGSi8WWX31Gkzcy0XhMfWlyCb/lVScM20zD1RK9pbtwtxK9U4OVDN
         gXnE3EtcOkuXRg3TuLlRFffj2O6o+zF/CqF1ilA9gIv5cTlhXsXPA3cEgMR183xW1Xrb
         yMCcQEZyAFZX8Et+S6yh2g3u0CHkw3xkYwzJU4+tdWaFSfs60byAIDTQ70XnN/aV1IAJ
         Mi4rnyzsla4ezezLat/s5at7+XnCkJ5jeFpYcs5sQCUfYH8dtPgOX7An6v6L5bp7IzFH
         V9Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVx6p68+aj4W4yQT6EIHxwj6ljz/rJSLhu0JU66f+AiZdIp721kGQHpAgFzuoO17eid0OLHs6WFiBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBmUYHBoQCnfWQQ1L20XIQJPBrbQd7D0njAECv/Hq64AflnZF6
	sjb1hHlWXcN22gnpt+FhJ9Y6bntCguyW8hiJfJeOwn2SQjs6iFPvtU4S/mOtCuW5dr0=
X-Gm-Gg: ATEYQzwlV9J7bq/qcoCRBESf91Hv2FZYABmOeTML+Nfr5iJ5169MbZQu5SYiiD67vUu
	+aWnBSkmj+k5axdEbe2nRk+W67qBixIuxAEIMX5VOYVebifIFE2dQe/VKQbZXNsEt3En35iSIM+
	rZUhueVB8bls+T1tr3gL8keVa+YWJewuhfr7u/Oqy3rG3HFUIzmpNTVL8htCnQ+MneAlCIoFMzY
	HciLdkn23EdiQ2U18c2yZFzWEa9RTzm23tO4R/RC59todydfNdv2DSyAKZU1YvegfVbnuv7TldC
	MxAmitLXMeFpw+KTYdV049PlO2UbKtM35tLm0bsTbgkaC1tQhbgjObaUPj3o2C8q/cqrcUUvSv1
	T56d6xSJ/+q6r3+vj04hNXuisHOz/Bf4JC9PQZ+Mp2c2bSrdh5fvsgBzALITj4e2GdRI6wDvl4u
	BjPCDhzg9+21Kf/ISBYaQwqF4I0Qwh
X-Received: by 2002:a05:6402:51c8:b0:662:ac7e:aac9 with SMTP id 4fb4d7f45d1cf-667b30fa581mr4994027a12.20.1773935464564;
        Thu, 19 Mar 2026 08:51:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-668621dde0esm1353353a12.24.2026.03.19.08.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:51:03 -0700 (PDT)
Date: Thu, 19 Mar 2026 18:50:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Pei Xiao <xiaopei01@kylinos.cn>,
	shenyang39@huawei.com, broonie@kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Pei Xiao <xiaopei01@kylinos.cn>
Subject: Re: [PATCH] spi: hisi-kunpeng: prevent infinite while() loop in
 hisi_spi_flush_fifo
Message-ID: <202603192159.S0PIjhlg-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d50f1f46b2ee2bba05de9e2d4199353b545194e3.1773820898.git.xiaopei01@kylinos.cn>

Hi Pei,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pei-Xiao/spi-hisi-kunpeng-prevent-infinite-while-loop-in-hisi_spi_flush_fifo/20260318-211321
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/d50f1f46b2ee2bba05de9e2d4199353b545194e3.1773820898.git.xiaopei01%40kylinos.cn
patch subject: [PATCH] spi: hisi-kunpeng: prevent infinite while() loop in hisi_spi_flush_fifo
config: s390-randconfig-r072-20260319 (https://download.01.org/0day-ci/archive/20260319/202603192159.S0PIjhlg-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 4abb927bacf37f18f6359a41639a6d1b3bffffb5)
smatch: v0.5.0-9004-gb810ac53

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202603192159.S0PIjhlg-lkp@intel.com/

smatch warnings:
drivers/spi/spi-hisi-kunpeng.c:206 hisi_spi_flush_fifo() warn: should this be 'inner_limit == -1'

vim +206 drivers/spi/spi-hisi-kunpeng.c

c770d8631e1810 Jay Fang 2021-03-27  193  
c770d8631e1810 Jay Fang 2021-03-27  194  static void hisi_spi_flush_fifo(struct hisi_spi *hs)
c770d8631e1810 Jay Fang 2021-03-27  195  {
c770d8631e1810 Jay Fang 2021-03-27  196  	unsigned long limit = loops_per_jiffy << 1;
c770d8631e1810 Jay Fang 2021-03-27  197  
c770d8631e1810 Jay Fang 2021-03-27  198  	do {
e8821f559fed86 Pei Xiao 2026-03-18  199  		unsigned long inner_limit = loops_per_jiffy;
e8821f559fed86 Pei Xiao 2026-03-18  200  
e8821f559fed86 Pei Xiao 2026-03-18  201  		while (hisi_spi_rx_not_empty(hs) && inner_limit--) {
c770d8631e1810 Jay Fang 2021-03-27  202  			readl(hs->regs + HISI_SPI_DOUT);
e8821f559fed86 Pei Xiao 2026-03-18  203  			cpu_relax();
e8821f559fed86 Pei Xiao 2026-03-18  204  		}
e8821f559fed86 Pei Xiao 2026-03-18  205  
e8821f559fed86 Pei Xiao 2026-03-18 @206  		if (!inner_limit) {

This test is wrong.  Maybe change inner_limit-- to
--inner_limit.

e8821f559fed86 Pei Xiao 2026-03-18  207  			dev_warn_ratelimited(hs->dev, "RX FIFO flush timeout\n");
e8821f559fed86 Pei Xiao 2026-03-18  208  			break;
e8821f559fed86 Pei Xiao 2026-03-18  209  		}
e8821f559fed86 Pei Xiao 2026-03-18  210  
c770d8631e1810 Jay Fang 2021-03-27  211  	} while (hisi_spi_busy(hs) && limit--);
e8821f559fed86 Pei Xiao 2026-03-18  212  
e8821f559fed86 Pei Xiao 2026-03-18  213  	if (!limit)
e8821f559fed86 Pei Xiao 2026-03-18  214  		dev_warn_ratelimited(hs->dev, "SPI busy timeout\n");
c770d8631e1810 Jay Fang 2021-03-27  215  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

