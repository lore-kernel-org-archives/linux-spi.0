From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 1/2] spi: tegra20-sflash: cleanup wait_for_completion
 return handling
Date: Mon, 2 Feb 2015 14:45:28 +0530
Message-ID: <54CF4030.5080407@nvidia.com>
References: <1422795604-29004-1-git-send-email-hofrat@osadl.org> <54CF3CC5.6030204@nvidia.com> <20150202090809.GB19706@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicholas Mc Guire <hofrat@osadl.org>,
	Mark Brown <broonie@kernel.org>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150202090809.GB19706@opentech.at>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Monday 02 February 2015 02:38 PM, Nicholas Mc Guire wrote:
> On Mon, 02 Feb 2015, Laxman Dewangan wrote:
>
>>
>>> +		if (WARN_ON(dma_timeout == 0)) {
>>>    			dev_err(tsd->dev,
>>> -				"spi trasfer timeout, err %d\n", ret);
>>> +				"spi trasfer timeout\n");
>> trasfer -> transfer.
>>
>>
> overlooked that - sorry - will fix it up and resubmit.
>
Thanks, And possibly we will be able to merge two lines into single one 
i.e. single line error message.
