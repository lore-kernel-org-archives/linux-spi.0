Received: from Atcsqr.andestech.com (exmail.andestech.com [60.248.187.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0F03EBF3C;
	Mon, 23 Feb 2026 06:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.187.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771828623; cv=none; b=toigY6ku76VS3kx+LONozOGcwQ6KwndoxzYwueDcYAdVMtKuIpZd/yYww+6rBpHY7frWBO9TvCSjx28+CiRU3Mzb2IafRIPLBB6Ap9g4Zjz58E1bOCca+IYvRaMYdXlNHFvzTO8DclJdX/iCAvQgM/+UIO9dGisECjtMM0TTyPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771828623; c=relaxed/simple;
	bh=EJMFu9JqXA18OD7O5ZPzXSx9812b5lJSgjRtXJ/gQxU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGphonGI1MNINDW8TAF5NeBe6k2dygX/3piCUqKNgIUvPKDyFOoooV7P1RUlwd41WJMC2nbunbPv+KlFrwa9IVYXEZicOYAO9iEZYcSfzZwlLIYfEXnWwYlexglBFA1ajXuPqNPQnszUrzgG1dEeEt3XXKAbmLuv3fpjGhD1sqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.187.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTP id 61N6aawA087033;
	Mon, 23 Feb 2026 14:36:36 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Feb
 2026 14:36:36 +0800
Date: Mon, 23 Feb 2026 14:36:32 +0800
From: CL Wang <cl634@andestech.com>
To: <xiaopeitux@foxmail.com>
CC: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Pei Xiao <xiaopei01@kylinos.cn>,
        "kernel test
 robot" <lkp@intel.com>, <cl634@andestech.com>
Subject: Re: [PATCH] spi: atcspi200: validate data buswidth to fix FIELD_PREP
 build error
Message-ID: <aZv1cB0ATB66E5hO@swlinux02>
References: <tencent_E59C90CD95B9DE440871635139437A79410A@qq.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <tencent_E59C90CD95B9DE440871635139437A79410A@qq.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 61N6aawA087033

Hi Pei,

Thanks for the patch to address the GCC compiler warning.

While I understand that the SPI framework theoretically guarantees
op->data.buswidth won't produce an out-of-bounds value here, I have
some concerns regarding the proposed error handling.

Using a direct return; inside atcspi_set_trans_ctl() creates a silent failure.
Since the function returns void, the callers (atcspi_prepare_trans and
atcspi_exec_mem_op) remain completely unaware of the error. They will blindly
proceed with the transfer, leaving the hardware in an unconfigured or unknown
state. Additionally, using a forced bitwise truncation could also lead to
uncontrollable hardware behavior.

A safer approach would be to either modify the function signatures to propagate
the error (e.g., returning -EINVAL), or at least fall back to a safe default
(like forcing width_code = 0 for standard 1-bit mode) along with
a WARN_ON_ONCE().

Since this requires a bit more structural adjustment in the driver, would you
mind if I take this over and submit a proper fix? I will make sure to add a
Suggested-by tag to acknowledge your effort in bringing this up.

Thanks again for catching this!

Best regards,
CL
> 
