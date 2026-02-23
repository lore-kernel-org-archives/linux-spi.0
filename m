Received: from Atcsqr.andestech.com (exmail.andestech.com [60.248.187.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF06146588;
	Mon, 23 Feb 2026 02:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.187.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771813500; cv=none; b=mq3Bve9Jsb1NfFXbyAGpvAaTu/GIbntTFhiH+NWmM9VsPylqCS78ErmBP8297nJLxxsgdYHAxt503UjIORyFHJsZ/F1tHwMecHRDd9En40GrohPCfJ5SBBGIrP3cxok50haWqQkwoJtMGAzJWAfxFdh3mXgMVFIzVreIl2FUkJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771813500; c=relaxed/simple;
	bh=LN9dTCxSPqW5Q2xEhH/QKBvUpu9pnqQt7yTqdf6bgUc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVk/ElliM0Ti7CbgOByN0uDa9ZW9dbh+wVTGSJYMPqGZsSxBs+FG/5EysoJfAev1Es1Z0sYQ9cAxqVI35Rnhw2Jz3o1qbyMSpIPL0dNDjIfELKSzqMEEAEowFKOpR2lZKbFWjKxeMNMIRoAcEQFLqGNICaFrWZa/k4qK5MIq9Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.187.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTP id 61N2OSeF001972;
	Mon, 23 Feb 2026 10:24:28 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Feb
 2026 10:24:28 +0800
Date: Mon, 23 Feb 2026 10:24:27 +0800
From: CL Wang <cl634@andestech.com>
To: <xiaopeitux@foxmail.com>
CC: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Pei Xiao <xiaopei01@kylinos.cn>,
        <cl634@andestech.com>
Subject: Re: [PATCH] spi: atcspi200: Remove redundant assignment to .owner
Message-ID: <aZu5_JjLtET11PBo@swlinux02>
References: <tencent_65C9C09CBD2B68C400F7145521A4B217E606@qq.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <tencent_65C9C09CBD2B68C400F7145521A4B217E606@qq.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 61N2OSeF001972

Hi Pei,

Thanks for the patch. It looks good to me.

Acked-by: CL Wang <cl634@andestech.com>
