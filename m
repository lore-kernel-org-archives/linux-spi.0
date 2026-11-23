Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454867;
	b=L5H+bQbOoyvDxLxWKJDemzYJBg+zE1tDapgB3TAuKw0u99ynhbgc354triccp88ZMsxz
	 1sPFg9oQXamyEymOQaNOfnM5xNkbwR+hOqtMZmUli1ecwe6MltfgjcOzLXAUAgQTg4uOJ
	 oMuWjiuYe9MJbWYHd4IMCJTE6zCVQy8jn0h5Y76TXo+iSuKcvvUEqIQ4PZ/RaxuzSigvK
	 ObVqcuy0n5ly32vLI6gBPwqs54OZiuqw4hJj3Bcc4K/IKtdrsNsR0mXrh8s1HTB09gQop
	 Jgv22zWUYOAQnqFsP5Z9bXR5OnHzvKB4G26Iv+W90l9POXlC12k70ZMUki2xl5PGjjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454867;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=BGorJs6MAne/EhbfWhhLdgvrIugkfOpSJMie/q8kNWI=;
	b=OxNwdHsctn0mX4qKHkctcLXVeOCmH3pr8tFxtFtO1tSR7Uvx4WBOlws0aAdAS8JP2Ab/
	 CfZynS9LIUbMTw4oUdCkC8bthYaGQYmA5/FA1yYYI23OhUrGpG4CFJHB2RQT1gtR9zQTx
	 H8/XU2WI1AZVkoYwnffpG8QI96kdT2EsaDPCRjiEyOc2YuAWBxCW9LTtWaLayqdN5DEVS
	 G7ynUlkChaMmysjHSzfFXky9jUeGmAaUkwBLXgrcjUBroWYyaNnGFVJeufp79zqYBiAXK
	 zNYjffpTF84AG9IuKJAicMXPsnpj2sZw7gMB7DCMKKGjgVRwQfnHxsKOlp/hjOHsqQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eSbP3CbG;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C288606A31E;
	Mon, 23 Nov 2026 17:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C288606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eSbP3CbG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795454866; x=1826990866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BTSVDrbAJDTCXRKEQem0cmfMprjd3jaaHHt/48c53dI=;
  b=eSbP3CbGHAnQHZFYGJLFyMshITGP5K/OCFtxZ5o6PUvkcVebZM5Sf4I+
   gwE37CngAzVuwRK81pTywUbAtVwe5h5KZOalByCIvKUuqTYoSxgshkH96
   UPiYRIQTInpd5rPZoqdniuBdRzWEZejPGg35nNhL8FOyszzyqqeCwOpg/
   V5jMIiTGJpBMtp0XVbPCPsCV6Q1+vfmb50Xll9Wxf/tBJHVjNR48Il18j
   n3vpMpxfwim9PUqqGFzhEmD8t0feXcxCotf5kNlrUFTI5EOrPpjI89dE3
   gJDrkcMkgZPzvBIrmMRd2wcfh7/fn0aVOHhyZJ7TlwbpZkhkAR4WuwxSE
   g==;
X-CSE-ConnectionGUID: i07d+L4SQR6+vw8KNYfDSw==
X-CSE-MsgGUID: ShDOCOK9Tn2poofhNAmPlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4160034"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4160034"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 09:27:45 -0800
X-CSE-ConnectionGUID: EJOu3Ye0QOiLP7SCRiYRsA==
X-CSE-MsgGUID: Udz6c8q8TN+hoMFsvXLt0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11714619"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 09:27:42 -0800
Date: Mon, 23 Nov 2026 19:27:40 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: imx@lists.linux.dev, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Johan Hovold <johan@kernel.org>, Mark Brown <broonie@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH] spi: imx: Use devm_clk_get_enabled() calls in
 spi_imx_probe()
Message-ID: <awR3jGcH97PrYNqc@ashevche-desk.local>
References: <895d50a6-3a42-44d2-8625-3b8cba8fbfff@web.de>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <895d50a6-3a42-44d2-8625-3b8cba8fbfff@web.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 05:23:12PM +0100, Markus Elfring wrote:
> 
> * Reuse existing functionality from devm_clk_get_enabled() instead of
>   keeping duplicate source code.
> 
> * Delete clk_disable_unprepare() calls on error handling paths.
> 
> * Omit the label “out_put_per”.
> 
> This issue was detected by using the Coccinelle software.

This now messes up with the PM callbacks at remove stage.
It's not trivial how to make it correct.

-- 
With Best Regards,
Andy Shevchenko


