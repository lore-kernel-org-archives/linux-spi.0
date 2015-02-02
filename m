From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 1/2] spi: tegra20-sflash: cleanup wait_for_completion
 return handling
Date: Mon, 2 Feb 2015 14:30:53 +0530
Message-ID: <54CF3CC5.6030204@nvidia.com>
References: <1422795604-29004-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
To: Nicholas Mc Guire <hofrat@osadl.org>,
	Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422795604-29004-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sunday 01 February 2015 06:30 PM, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int, this
> patch adds an appropriate variable and fixes up the assignment.
> As the string in dev_err already states "timeout" there
> is little point in printing the 0 here.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Looks good to me. Thanks for fixing this.
I think it is good if we fix the typo here also.

Acked-by: Laxman Dewangan <ldewangan@nvidia.com>

>
> +		if (WARN_ON(dma_timeout == 0)) {
>   			dev_err(tsd->dev,
> -				"spi trasfer timeout, err %d\n", ret);
> +				"spi trasfer timeout\n");

trasfer -> transfer.
